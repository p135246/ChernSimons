#!/usr/bin/env wolframscript
(* Builds the paclet's Documentation tree one-way from docs/ with the pinned MarkdownToNotebook
   clone in Resources/. Three kinds, one directory each:
     docs/Symbols/<Name>.md    -> Documentation/English/ReferencePages/Symbols/<Name>.nb
     docs/Guides/<Name>.md     -> Documentation/English/Guides/<Name>.nb
     docs/Tutorials/<Name>.md  -> Documentation/English/Tutorials/<Name>.nb
   The paclet is directory-loaded so the Needs["ChernSimons`"] the templates emit resolves while
   the example cells evaluate.
   Usage: BuildDocs.wls                 builds every page whose source is newer than its notebook
          BuildDocs.wls Pairing …       builds the named pages, in whichever kind they live
          BuildDocs.wls --symbols       every symbol page; likewise --guides, --tutorials
          BuildDocs.wls --all           everything *)

$pacletDirectory = DirectoryName[ $InputFileName ];

$repository = ParentDirectory[ ParentDirectory[ $pacletDirectory ] ];

$converter = FileNameJoin[ { $repository, "Resources", "MarkdownToNotebook", "MarkdownToNotebook.wl" } ];

(* the third entry is the "EvaluateSeparator" mode: a reference page resets the evaluation
   context at every heading, which is right when each section reads as a self-contained block; a
   tutorial threads one computation through its sections, so it must not. *)

$kinds = <|
  "Symbols" -> { "Symbols", { "ReferencePages", "Symbols" }, Automatic },
  "Guides" -> { "Guides", { "Guides" }, Automatic },
  "Tutorials" -> { "Tutorials", { "Tutorials" }, None }
|>;

BuildDocs[ arguments_List ] :=
  Module[ { requested },
    If[ ! FileExistsQ[ $converter ],
      Print[ "Missing ", $converter, " — recover it per Wiki/Resources/MarkdownToNotebook.md" ]; Exit[ 1 ] ];
    PacletDirectoryLoad[ ParentDirectory[ $pacletDirectory ] ];
    Needs[ "ChernSimons`" ];
    Get[ $converter ];
    requested = Requested[ arguments ];
    If[ requested === { }, Print[ "Up to date: ", Length @ AllPages[ ], " pages" ]; Exit[ 0 ] ];
    Print[ Length @ requested, " page", If[ Length @ requested === 1, "", "s" ], " to build" ];
    Scan[ BuildPage, requested ];
    Scan[ kind |-> Print[ "  ", kind, ": ", Length @ FileNames[ "*.nb", TargetDirectory[ kind ] ], " built" ],
      Keys[ $kinds ] ]
  ]

Requested[ arguments_List ] :=
  Which[
    MemberQ[ arguments, "--all" ], AllPages[ ],
    MemberQ[ arguments, "--symbols" ], KindPages[ "Symbols" ],
    MemberQ[ arguments, "--guides" ], KindPages[ "Guides" ],
    MemberQ[ arguments, "--tutorials" ], KindPages[ "Tutorials" ],
    arguments === { }, Select[ AllPages[ ], StaleQ ],
    True, Select[ AllPages[ ], page |-> MemberQ[ arguments, Last[ page ] ] ]
  ]

AllPages[ ] := Catenate[ Map[ KindPages, Keys[ $kinds ] ] ]

KindPages[ kind_String ] :=
  Map[ name |-> { kind, name }, Sort[ FileBaseName /@ FileNames[ "*.md", SourceDirectory[ kind ] ] ] ]

SourceDirectory[ kind_String ] :=
  FileNameJoin[ { $pacletDirectory, "docs", First @ $kinds[ kind ] } ]

TargetDirectory[ kind_String ] :=
  FileNameJoin[ Prepend[ $kinds[ kind ][[ 2 ]], FileNameJoin[ { $pacletDirectory, "Documentation", "English" } ] ] ]

SourcePath[ { kind_String, name_String } ] :=
  FileNameJoin[ { SourceDirectory[ kind ], name <> ".md" } ]

TargetPath[ { kind_String, name_String } ] :=
  FileNameJoin[ { TargetDirectory[ kind ], name <> ".nb" } ]

StaleQ[ page_List ] :=
  ! FileExistsQ[ TargetPath[ page ] ] || FileDate[ SourcePath[ page ] ] > FileDate[ TargetPath[ page ] ]

BuildPage[ page_List ] :=
  Module[ { target = TargetPath[ page ], result },
    result = MarkdownToNotebook[ SourcePath[ page ], target,
      "EvaluateSeparator" -> $kinds[ First @ page ][[ 3 ]] ];
    Print[ If[ FileExistsQ[ target ], "  built  ", "  FAILED " ], First[ page ], "/", Last[ page ],
      If[ FileExistsQ[ target ], " (" <> ToString @ Round[ FileByteCount[ target ] / 1024 ] <> " kB)", "" ] ];
    If[ ! FileExistsQ[ target ], Print[ "    ", Short[ result, 4 ] ] ]
  ]

Scan[ kind |-> If[ ! DirectoryQ[ TargetDirectory[ kind ] ],
    CreateDirectory[ TargetDirectory[ kind ], CreateIntermediateDirectories -> True ] ], Keys[ $kinds ] ]

BuildDocs[ Rest[ $ScriptCommandLine ] ]
