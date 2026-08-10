#!/usr/bin/env wolframscript
(* Builds the paclet archive from a staged copy — PacletInfo.wl, Kernel/, Engine/, nothing else —
   and uploads it to the public cloud object the certification notebooks install from.
   The paclet is deliberately not installed locally: a directory-loaded working copy and an
   installed one of the same version resolve ambiguously, and T12 pins that the suite runs the
   working copy. *)

$pacletDirectory = DirectoryName[ $InputFileName ];

$staged = { "PacletInfo.wl", "Kernel", "Engine" };

$cloudPath = "s1paper/IBLInfinity.paclet";

PublishPaclet[ ] :=
  Module[ { stage, archive, object },
    stage = FileNameJoin[ { CreateDirectory[ ], "IBLInfinity" } ];
    CreateDirectory[ stage ];
    Scan[ item |-> CopyItem[ FileNameJoin[ { $pacletDirectory, item } ], FileNameJoin[ { stage, item } ] ], $staged ];
    archive = CreatePacletArchive[ stage ];
    object = CloudObject[ $cloudPath, Permissions -> "Public" ];
    CopyFile[ archive, object, OverwriteTarget -> True ];
    Print[ "version ", PacletObject[ File[ archive ] ][ "Version" ],
      ", ", Round[ FileByteCount[ archive ] / 1024 ], " kB, ",
      Length[ FileNames[ "*", stage, Infinity ] ], " files" ];
    Print[ "PACLET_URL: ", First[ object ] ];
    First[ object ]
  ]

CopyItem[ source_String, target_String ] :=
  If[ DirectoryQ[ source ], CopyDirectory[ source, target ], CopyFile[ source, target ] ]

PublishPaclet[ ]
