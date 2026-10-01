#!/usr/bin/env wolframscript
(* Deploys the built paclet as a public paclet resource in the Wolfram Cloud, the way the
   InfraGeometry and PureMath paclets are deployed. The resource bundles the built Documentation/
   tree, the cloud resolves every paclet: link into the bundled pages, so the typed links the pages
   carry work without rewriting, every page serves at
     <target>/Documentation/ChernSimons/<guide|ref|tutorial>/<Name>.html
   and the resource root is the landing page, whose main guide the definition names.
   1. the built paclet PackageDocs.wls left in its scratch directory is the paclet the resource
      bundles; run that script first;
   2. docs/ResourceDefinition.md -> <built>/ResourceDefinition.nb by MarkdownToNotebook's Paclet
      template, and the built PacletInfo.wl gets the exported symbols as its "Symbols" list, which
      the resource scraper wants declared; the tracked PacletInfo.wl is not touched;
   3. the cloud account is checked against the target: the location the resource system computes
      for this account must be the expected one, so a cached login for someone else cannot deploy
      elsewhere;
   4. headless scrape of the definition notebook and CloudDeploy with Permissions -> "Public",
      what the definition notebook's "Deploy -> Publicly in the cloud" button does;
   5. HTTP check: the resource root and every page of the built tree must answer 200.
   Usage: PublishDocs.wls          deploy, then check
          PublishDocs.wls check    only the HTTP check against the target
   Exit 1 on any failed stage. The archive at obj/hajek_pavel/s1paper/ChernSimons.paclet is
   Publish.wls's business and is never touched here; no version is bumped. *)

$pacletDirectory = DirectoryName[ $InputFileName ];

$repository = ParentDirectory[ ParentDirectory[ $pacletDirectory ] ];

$converter = FileNameJoin[ { $repository, "Resources", "MarkdownToNotebook", "MarkdownToNotebook.wl" } ];

$name = "ChernSimons";

$context = "ChernSimons`";

$built = FileNameJoin[ { $TemporaryDirectory, $name <> "-package", $name, "build", $name } ];

$definitionSource = FileNameJoin[ { $pacletDirectory, "docs", "ResourceDefinition.md" } ];

$definition = FileNameJoin[ { $built, "ResourceDefinition.nb" } ];

$target = "https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/" <> $name;

$deployTimeout = 3600;

$kinds = { { { "Guides" }, "guide" }, { { "Tutorials" }, "tutorial" }, { { "ReferencePages", "Symbols" }, "ref" } };

PublishDocs[ { "check" } ] :=
  (
    If[ ! DirectoryQ[ DocumentationRoot[ ] ], FailStage[ "no built paclet at ", $built, ": run PackageDocs.wls first" ] ];
    Exit[ Boole[ ! HTTPCheck[ ] ] ]
  )

PublishDocs[ { } ] :=
  Module[ { symbols, location, url },
    Print[ "built: ", $built ];
    Print[ "target: ", $target ];
    If[ ! ( DirectoryQ[ $built ] && FileExistsQ[ FileNameJoin[ { $built, "PacletInfo.wl" } ] ] && Pages[ ] =!= { } ),
      FailStage[ "no built paclet with pages at ", $built, ": run PackageDocs.wls first" ] ];
    If[ ! FileExistsQ[ $definitionSource ], FailStage[ "no resource definition source at ", $definitionSource ] ];
    If[ ! FileExistsQ[ $converter ], FailStage[ "no converter at ", $converter, ": recover it per Wiki/Resources/MarkdownToNotebook.md" ] ];
    Print[ "pages: ", StringRiffle[ Map[ kind |-> ToString @ Count[ Pages[ ], { Last @ kind, _ } ] <> " " <> Last @ kind, $kinds ], ", " ] ];
    PacletDirectoryLoad[ $built ];
    Needs[ "PacletResource`" ];
    Needs[ "PacletTools`" ];
    Needs[ "DefinitionNotebookClient`" ];
    Needs[ "PacletResource`DefinitionNotebook`" ];
    Quiet @ Needs[ $context ];
    symbols = DeclareSymbols[ ];
    Get[ $converter ];
    Print[ "definition: ", $definitionSource, " -> ", $definition ];
    MarkdownToNotebook[ $definitionSource, $definition ];
    If[ ! FileExistsQ[ $definition ], FailStage[ "MarkdownToNotebook wrote no definition notebook" ] ];
    location = ConnectAndLocate[ ];
    PatchVendor[ symbols ];
    url = ScrapeAndDeploy[ location ];
    Print[ "" ];
    Exit[ Boole[ ! HTTPCheck[ ] ] ]
  ]

DocumentationRoot[ ] := FileNameJoin[ { $built, "Documentation", "English" } ]

Pages[ ] :=
  Join @@ Map[ kind |-> Map[ file |-> { Last @ kind, FileBaseName @ file },
    FileNames[ "*.nb", FileNameJoin[ Prepend[ First @ kind, DocumentationRoot[ ] ] ] ] ], $kinds ]

PageURL[ { segment_String, name_String } ] := $target <> "/Documentation/" <> $name <> "/" <> segment <> "/" <> name <> ".html"

FailStage[ message__ ] := ( Print[ "  !! ", message ]; Exit[ 1 ] )

HTTPCheck[ ] :=
  Module[ { start = AbsoluteTime[ ], status, bad },
    Print[ "http check: ", Length @ Pages[ ], " pages and the resource root" ];
    status[ url_String ] := Replace[ Quiet @ TimeConstrained[ URLRead[ url, "StatusCode" ], 60, $TimedOut ], Except[ _Integer ] -> 0 ];
    bad = Select[ Map[ url |-> { url, status[ url ] }, Prepend[ PageURL /@ Pages[ ], $target ] ], Last[ # ] =!= 200 & ];
    Print[ "  ", Length @ Pages[ ] + 1 - Length[ bad ], " ok, ", Length[ bad ], " failed, ", Round[ AbsoluteTime[ ] - start ], " s" ];
    Scan[ entry |-> Print[ "  !! ", Last @ entry, "  ", First @ entry ], bad ];
    Print[ If[ bad === { }, "ok", "FAILED" ] ];
    bad === { }
  ]

(* the scraper reads the Kernel extension's "Symbols"; they are declared in the built PacletInfo.wl
   only, and the tracked file stays as it is *)
DeclareSymbols[ ] :=
  Module[ { symbols, file, info },
    symbols = Sort[ Map[ name |-> $context <> Last @ StringSplit[ name, "`" ],
      Select[ Names[ $context <> "*" ], StringFreeQ[ "`Private`" ] ] ] ];
    If[ symbols === { }, FailStage[ "no symbols in ", $context, ": the built paclet did not load" ] ];
    With[ { undocumented = Complement[ Map[ $context <> Last[ # ] &, Cases[ Pages[ ], { "ref", _ } ] ], symbols ] },
      If[ undocumented =!= { },
        Print[ "  !! ", Length[ undocumented ], " reference pages for symbols the paclet does not export: ",
          StringRiffle[ Take[ undocumented, UpTo[ 5 ] ], ", " ] ] ] ];
    Print[ "symbols: ", Length[ symbols ], " exported, ", Count[ Pages[ ], { "ref", _ } ], " documented" ];
    file = FileNameJoin[ { $built, "PacletInfo.wl" } ];
    info = Get[ file ];
    If[ ! ( Head[ info ] === PacletObject && AssociationQ[ First @ info ] ), FailStage[ "cannot read ", file ] ];
    Put[ PacletObject[ MapAt[
        Replace[ #, { "Kernel", rest___ } :> { "Kernel", Sequence @@ DeleteCases[ { rest }, "Symbols" -> _ ], "Symbols" -> symbols }, { 1 } ] &,
        First @ info, "Extensions" ] ], file ];
    Print[ "built PacletInfo.wl: Symbols declared" ];
    symbols
  ]

ConnectAndLocate[ ] :=
  Module[ { location },
    If[ ! $CloudConnected, CloudConnect[ ] ];
    If[ ! $CloudConnected, FailStage[ "no Wolfram Cloud connection" ] ];
    Print[ "cloud: ", $WolframID ];
    ResourceSystemClient`Private`loadDeployResourceShingle[ ];
    location = DeployedResourceShingle`Private`defaultCloudObjectLocation[ "Paclet", $name ];
    If[ ! MatchQ[ location, _CloudObject ], FailStage[ "the resource system computed no deploy location: ", location ] ];
    If[ First[ location ] =!= $target,
      FailStage[ "this account deploys to ", First[ location ], ", not the expected ", $target,
        ": CloudDisconnect[] and connect as the right account" ] ];
    Print[ "location: ", First[ location ] ];
    location
  ]

(* Every patch below was root-caused against PacletResource's Deploy.m, Notebooks.m and
   Utilities.m for the InfraGeometry deploy and is carried over as it stands. *)
PatchVendor[ symbols_List ] :=
  (
    (* the scrape lints the .wl sources with CodeInspector as an aside; that is the test suite's
       business, and a false Error there would block the deploy *)
    Quiet[
      Unprotect[ DefinitionNotebookClient`Inspectors`PackagePrivate`codeInspectFileQ ];
      DownValues[ DefinitionNotebookClient`Inspectors`PackagePrivate`codeInspectFileQ ] =
        { HoldPattern[ DefinitionNotebookClient`Inspectors`PackagePrivate`codeInspectFileQ[ _ ] ] :> False } ];
    (* DeployedResourceShingle's processshingleData calls htmlFragmentExport, defined nowhere; the
       Details section is already an HTML fragment *)
    If[ DownValues[ DeployedResourceShingle`Private`htmlFragmentExport ] === { } &&
        OwnValues[ DeployedResourceShingle`Private`htmlFragmentExport ] === { },
      DeployedResourceShingle`Private`htmlFragmentExport[ s_String ] := s ];
    (* prefetchURL's throwaway URLRead warm-up prints URLRead::invhttp on a slow fetch *)
    If[ DownValues[ PacletResource`Private`prefetchURL ] =!= { },
      Quiet @ Unprotect[ PacletResource`Private`prefetchURL ];
      PacletResource`Private`prefetchURL[ url_ ] := URLBuild @ URLParse @ url ];
    (* the vendor's progress events only set a notebook-UI variable; print them too *)
    If[ DownValues[ PacletResource`Private`setDNCProgress ] =!= { },
      Unprotect[ PacletResource`Private`setDNCProgress ];
      PacletResource`Private`setDNCProgress[ expr_ ] := ( Print[ "deploy: ", expr ]; DefinitionNotebookClient`$StripeProgressDisplay = expr ) ];
    (* pacletDeclaredSymbols re-resolves the paclet by name, and on a machine with another copy
       registered may read that one's PacletInfo, without Symbols: pin the list being deployed *)
    If[ DownValues[ PacletResource`Private`pacletDeclaredSymbols ] =!= { },
      Quiet @ Unprotect[ PacletResource`Private`pacletDeclaredSymbols ];
      PrependTo[ DownValues[ PacletResource`Private`pacletDeclaredSymbols ],
        HoldPattern[ PacletResource`Private`pacletDeclaredSymbols[ $name ] ] :> symbols ];
      PrependTo[ DownValues[ PacletResource`Private`pacletDeclaredSymbols ],
        HoldPattern[ PacletResource`Private`pacletDeclaredSymbols[ KeyValuePattern[ "Name" -> $name ] ] ] :> symbols ] ];
  )

ReportBlockers[ notebook_NotebookObject ][ result_ ] :=
  (
    If[ ! MatchQ[ result, _ResourceObject ],
      Print[ "deploy: the scrape was blocked; definition notebook issues:" ];
      Scan[ issue |-> Print[ "  [", Lookup[ issue, "Level", "?" ], "] ", Lookup[ issue, "Tag", "?" ] ],
        Replace[ Quiet @ Check[ Normal @ DefinitionNotebookClient`CheckDefinitionNotebook[ notebook ], { } ], Except[ _List ] -> { } ] ] ];
    result
  )

ScrapeAndDeploy[ location_CloudObject ] :=
  Module[ { start = AbsoluteTime[ ], result, url },
    Print[ "" ];
    Print[ "scrape and deploy (", $deployTimeout, " s window)" ];
    result = UsingFrontEnd @ TimeConstrained[
      Enclose @ Module[ { notebook },
        notebook = ConfirmMatch[ NotebookOpen[ $definition, Visible -> False ], _NotebookObject, "opening the definition notebook failed" ];
        (* warm up: the definition notebook resolves its paclet relative to its own directory, and
           a freshly opened one misses until these have each run once *)
        PacletObject[ $name ];
        Quiet[ PacletResource`DefinitionNotebook`ScrapePacletDirectory[ notebook ] ];
        WithCleanup[
          Module[ { resource },
            resource = ConfirmMatch[
              ReportBlockers[ notebook ] @ DefinitionNotebookClient`ScrapeResource[ "Paclet", notebook, Interactive -> False, "FailureCondition" -> "Error" ],
              _ResourceObject, "scraping the resource from the definition notebook failed" ];
            Print[ "deploy: scraped ", resource[ "Name" ], " in ", Round[ AbsoluteTime[ ] - start ], " s" ];
            With[ { object = CloudDeploy[ resource, location, Permissions -> "Public" ] },
              ResourceRegister[ resource, "Cloud", "StoreContent" -> False ];
              object ] ],
          NotebookClose[ notebook ] ] ],
      $deployTimeout, $TimedOut ];
    url = FirstCase[ { result }, c_CloudObject :> First[ c ], Missing[ ], Infinity ];
    If[ MissingQ[ url ],
      Which[
        result === $TimedOut, FailStage[ "deploy timed out after ", $deployTimeout, " s" ],
        FailureQ[ result ], FailStage[ "deploy failed: ", result[ "Message" ] ],
        True, FailStage[ "deploy returned no URL: ", Short[ result, 3 ] ] ] ];
    Print[ "deployed: ", url, " (", Round[ AbsoluteTime[ ] - start ], " s)" ];
    url
  ]

(* wolframscript otherwise prints a progress line per tick of every cloud call *)
$ProgressReporting = False;

(* DocumentationBuild's RewriteHyperlinkString takes the last character of a possibly empty
   hyperlink segment; the message is noise and the output is right. *)
Off[ StringTake::take ];

PublishDocs[ Drop[ $ScriptCommandLine, UpTo[ 1 ] ] ]
