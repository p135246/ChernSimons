#!/usr/bin/env wolframscript
(* Uploads the built paclet archive to the public cloud object the README and the certification
   notebooks install from. The archive is the one PackageDocs.wls built in its scratch directory,
   with the published documentation pages and the search index inside, so ?Symbol works after a
   plain PacletInstall of it; run that script first. The paclet is deliberately not installed
   locally: a directory-loaded working copy and an installed one of the same version resolve
   ambiguously, and T12 pins that the suite runs the working copy. The copy is read back and its
   byte count compared, because CloudPut of a File stores a stub rather than the binary. *)

$pacletDirectory = DirectoryName[ $InputFileName ];

$name = "ChernSimons";

$buildDirectory = FileNameJoin[ { $TemporaryDirectory, $name <> "-package", $name, "build" } ];

$cloudPath = "s1paper/ChernSimons.paclet";

PublishPaclet[ ] :=
  Module[ { archive, object, copy },
    archive = First[ FileNames[ "*.paclet", $buildDirectory ], None ];
    If[ archive === None, Print[ "  !! no archive in ", $buildDirectory, ": run PackageDocs.wls first" ]; Exit[ 1 ] ];
    object = CloudObject[ $cloudPath, Permissions -> "Public" ];
    CopyFile[ archive, object, OverwriteTarget -> True ];
    copy = FileNameJoin[ { $TemporaryDirectory, "ChernSimons-readback.paclet" } ];
    CopyFile[ object, copy, OverwriteTarget -> True ];
    If[ FileByteCount[ copy ] =!= FileByteCount[ archive ], Print[ "  !! the cloud copy has ", FileByteCount[ copy ], " bytes, the archive ", FileByteCount[ archive ] ]; Exit[ 1 ] ];
    Print[ "version ", PacletObject[ File[ archive ] ][ "Version" ], ", ", Round[ FileByteCount[ archive ] / 1024 ], " kB, ",
      Length[ Import[ archive, "FileNames" ] ], " files" ];
    Print[ "PACLET_URL: ", First[ object ] ];
    First[ object ]
  ]

$ProgressReporting = False;

PublishPaclet[ ]
