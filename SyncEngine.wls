#!/usr/bin/env wolframscript
(* Copies Verification/Kernel/*.wl into the paclet. Kernel/ is the single source of truth;
   the paclet carries a copy so that it works once installed or published.
   T12/paclet-engine-copy-in-sync fails if the two drift. *)

pacletDirectory = DirectoryName[$InputFileName];

kernelDirectory = FileNameJoin[{ParentDirectory[ParentDirectory[pacletDirectory]], "Verification", "Kernel"}];

modules = {"Signs.wl", "CyclicWords.wl", "Products.wl", "DIBL.wl", "BV.wl", "AInfinity.wl", "Gauge.wl", "Models.wl"};

Scan[m |-> CopyFile[FileNameJoin[{kernelDirectory, m}], FileNameJoin[{pacletDirectory, "Engine", m}],
	OverwriteTarget -> True], modules]

Print["synced ", Length[modules], " modules into ", FileNameJoin[{pacletDirectory, "Engine"}]];
