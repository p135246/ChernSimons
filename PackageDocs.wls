#!/usr/bin/env wolframscript
(* Packages the paclet from a scratch copy and checks that every page with a Markdown source
   ships, resolves and renders. The scratch copy is <$TemporaryDirectory>/ChernSimons-package;
   PacletBuild writes the built paclet, published pages and search index included, to its build/
   directory, and that built copy is what PublishDocs.wls deploys and Publish.wls archives.
   1. copy the paclet to the scratch directory without build/, docs/ and the scripts, then PacletBuild
      it (PacletBuild's staging is additive: a stale build/ would ship pages whose source is gone);
   2. the archive must hold a notebook for every docs/{Symbols,Guides,Tutorials}/*.md source and
      exactly as many reference pages as docs/Symbols sources;
   3. with the built paclet loaded, every guide and tutorial URI must ResolveLink into it;
   4. each guide and tutorial is rendered to static HTML under <scratch>/html, so a page can be
      opened in a browser before any deploy.
   Usage: PackageDocs.wls                 render every guide and tutorial
          PackageDocs.wls ChernSimons …   render only the named guides and tutorials
   Exit 1 on any failed check. Changes nothing in the repository. *)

$pacletDirectory = DirectoryName[ $InputFileName ];

$name = "ChernSimons";

$scratch = FileNameJoin[ { $TemporaryDirectory, $name <> "-package" } ];

$package = FileNameJoin[ { $scratch, $name } ];

$built = FileNameJoin[ { $package, "build", $name } ];

$html = FileNameJoin[ { $scratch, "html" } ];

$unpackaged = { "build", "docs", "BuildDocs.wls", "PackageDocs.wls", "PublishDocs.wls", "Publish.wls" };

$kinds = <|
  "Symbols" -> { { "ReferencePages", "Symbols" }, "ref" },
  "Guides" -> { { "Guides" }, "guide" },
  "Tutorials" -> { { "Tutorials" }, "tutorial" }
|>;

PackageDocs[ arguments_List ] :=
  Module[ { archive, failures },
    Print[ "scratch: ", $scratch ];
    archive = Build[ ];
    failures = Join[ ArchiveFailures[ archive ], ResolveFailures[ ], RenderFailures[ arguments ] ];
    Print[ "" ];
    Print[ If[ failures === { }, "ok", "FAILED" ] ];
    Scan[ failure |-> Print[ "  !! ", failure ], failures ];
    Exit[ Boole[ failures =!= { } ] ]
  ]

Build[ ] :=
  Module[ { start, result, archive },
    Quiet @ DeleteDirectory[ $scratch, DeleteContents -> True ];
    CreateDirectory[ $scratch, CreateIntermediateDirectories -> True ];
    CopyDirectory[ $pacletDirectory, $package ];
    Scan[ item |->
      With[ { path = FileNameJoin[ { $package, item } ] },
        Quiet @ Which[
          DirectoryQ[ path ], DeleteDirectory[ path, DeleteContents -> True ],
          FileExistsQ[ path ], DeleteFile[ path ] ] ],
      $unpackaged ];
    Needs[ "PacletTools`" ];
    start = AbsoluteTime[ ];
    result = PacletTools`PacletBuild[ $package ];
    archive = First[ FileNames[ "*.paclet", FileNameJoin[ { $package, "build" } ] ], None ];
    Print[ "PacletBuild: ", Round[ AbsoluteTime[ ] - start ], " s -> ", archive ];
    If[ archive === None, Print[ "  !! no archive: ", Short[ result, 2 ] ]; Exit[ 1 ] ];
    Print[ "archive: ", Round[ FileByteCount[ archive ] / 1024 ], " kB" ];
    archive
  ]

ArchiveFailures[ archive_String ] :=
  With[ { notebooks = Select[ Import[ archive, "FileNames" ], StringEndsQ[ ".nb" ] ] },
    Join @@ KeyValueMap[
      { kind, spec } |->
        With[ { wanted = Sources[ kind ] },
          With[ { shipped = FileBaseName /@ Select[ notebooks, StringContainsQ[ "English/" <> FileNameJoin[ First @ spec ] <> "/" ] ] },
            Print[ "archive ", kind, ": ", Length[ wanted ], " sources, ", Length[ shipped ], " pages" ];
            Join[
              Map[ name |-> kind <> "/" <> name <> " has a source but is not in the archive", Complement[ wanted, shipped ] ],
              If[ kind === "Symbols" && Length[ shipped ] =!= Length[ wanted ],
                { "reference page count " <> ToString @ Length[ shipped ] <> " differs from the " <> ToString @ Length[ wanted ] <>
                  " sources: " <> ToString @ Complement[ shipped, wanted ] },
                { } ] ] ] ],
      $kinds ] ]

ResolveFailures[ ] :=
  (
    If[ ! DirectoryQ[ $built ], Print[ "  !! no built paclet at ", $built ]; Exit[ 1 ] ];
    PacletDirectoryLoad[ $built ];
    Print[ "resolve" ];
    Select[
      Map[ page |->
        With[ { uri = "paclet:" <> $name <> "/" <> $kinds[ First @ page ][[ 2 ]] <> "/" <> Last @ page },
          With[ { resolved = Documentation`ResolveLink[ uri ] },
            If[ StringQ[ resolved ] && StringStartsQ[ resolved, $built ], Print[ "  ", uri ]; None,
              uri <> " resolves to " <> ToString[ resolved ] ] ] ],
        Pages[ { "Guides", "Tutorials" } ] ],
      StringQ ]
  )

RenderFailures[ arguments_List ] :=
  With[ { pages = Select[ Pages[ { "Guides", "Tutorials" } ], page |-> arguments === { } || MemberQ[ arguments, Last @ page ] ] },
    Needs[ "DocumentationBuild`" ];
    Print[ "render -> ", $html ];
    Select[
      Map[ page |->
        With[ { notebook = FileNameJoin[ { $package, "Documentation", "English", First @ page, Last @ page <> ".nb" } ],
            output = FileNameJoin[ { $html, $kinds[ First @ page ][[ 2 ]], Last @ page <> ".html" } ] },
          With[ { result = TimeConstrained[
              UsingFrontEnd @ DocumentationBuild`DocumentationBuildHTML[ FileNameJoin[ { $package, "Documentation" } ], $html,
                "SingleFile" -> notebook, "CompleteHTMLQ" -> True, "LinkBase" -> $name ], 300, $TimedOut ] },
            If[ FileExistsQ[ output ], Print[ "  ", output ]; None,
              Last[ page ] <> ": no HTML (" <> ToString[ Short[ result, 1 ] ] <> ")" ] ] ],
        pages ],
      StringQ ] ]

Pages[ kinds_List ] :=
  Join @@ Map[ kind |-> Map[ name |-> { kind, name }, Sources[ kind ] ], kinds ]

Sources[ kind_String ] :=
  Sort[ FileBaseName /@ FileNames[ "*.md", FileNameJoin[ { $pacletDirectory, "docs", kind } ] ] ]

(* DocumentationBuild's RewriteHyperlinkString takes the last character of a possibly empty
   hyperlink segment; the message is noise and the output is right. *)
Off[ StringTake::take ];

PackageDocs[ Drop[ $ScriptCommandLine, UpTo[ 1 ] ] ]
