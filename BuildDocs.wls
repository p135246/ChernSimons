#!/usr/bin/env wolframscript
(* Builds Documentation/English/ReferencePages/Symbols/<Name>.nb one-way from docs/Symbols/<Name>.md
   with the pinned MarkdownToNotebook clone at the repository root. The paclet is directory-loaded so
   the Needs["IBLInfinity`"] the Symbol template emits resolves while the example cells evaluate.
   Usage: BuildDocs.wls            builds every page whose source is newer than its notebook
          BuildDocs.wls Pairing …  builds the named pages
          BuildDocs.wls --all      rebuilds every page *)

$pacletDirectory = DirectoryName[ $InputFileName ];

$repository = ParentDirectory[ ParentDirectory[ $pacletDirectory ] ];

$converter = FileNameJoin[ { $repository, "MarkdownToNotebook", "MarkdownToNotebook.wl" } ];

$sourceDirectory = FileNameJoin[ { $pacletDirectory, "docs", "Symbols" } ];

$targetDirectory = FileNameJoin[ { $pacletDirectory, "Documentation", "English", "ReferencePages", "Symbols" } ];

BuildDocs[ arguments_List ] :=
  Module[ { names },
    If[ ! FileExistsQ[ $converter ],
      Print[ "Missing ", $converter, " — recover it per Wiki/Resources/MarkdownToNotebook.md" ]; Exit[ 1 ] ];
    PacletDirectoryLoad[ ParentDirectory[ $pacletDirectory ] ];
    Needs[ "IBLInfinity`" ];
    Get[ $converter ];
    names = Which[
      MemberQ[ arguments, "--all" ], SourceNames[ ],
      arguments === { }, Select[ SourceNames[ ], StaleQ ],
      True, arguments ];
    If[ names === { }, Print[ "Up to date: ", Length @ SourceNames[ ], " pages" ]; Exit[ 0 ] ];
    Print[ Length @ names, " page", If[ Length @ names === 1, "", "s" ], " to build" ];
    Scan[ BuildPage, names ];
    Print[ "Documentation/ holds ", Length @ FileNames[ "*.nb", $targetDirectory ], " reference pages" ]
  ]

BuildPage[ name_String ] :=
  Module[ { source = SourcePath[ name ], target = TargetPath[ name ], result },
    result = MarkdownToNotebook[ source, target ];
    Print[ If[ FileExistsQ[ target ], "  built  ", "  FAILED " ], name,
      If[ FileExistsQ[ target ], " (" <> ToString @ Round[ FileByteCount[ target ] / 1024 ] <> " kB)", "" ] ];
    If[ ! FileExistsQ[ target ], Print[ "    ", Short[ result, 4 ] ] ]
  ]

SourceNames[ ] :=
  Sort[ FileBaseName /@ FileNames[ "*.md", $sourceDirectory ] ]

SourcePath[ name_String ] :=
  FileNameJoin[ { $sourceDirectory, name <> ".md" } ]

TargetPath[ name_String ] :=
  FileNameJoin[ { $targetDirectory, name <> ".nb" } ]

StaleQ[ name_String ] :=
  ! FileExistsQ[ TargetPath[ name ] ] || FileDate[ SourcePath[ name ] ] > FileDate[ TargetPath[ name ] ]

If[ ! DirectoryQ[ $targetDirectory ], CreateDirectory[ $targetDirectory, CreateIntermediateDirectories -> True ] ];

BuildDocs[ Rest[ $ScriptCommandLine ] ]
