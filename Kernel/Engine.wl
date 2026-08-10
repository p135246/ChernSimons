BeginPackage["IBLInfinity`Engine`"];

$KernelDirectory = FileNameJoin[{ParentDirectory[DirectoryName[$InputFileName]], "Engine"}];

Scan[m |-> Get[FileNameJoin[{$KernelDirectory, m}]],
	{"Signs.wl", "CyclicWords.wl", "Products.wl", "DIBL.wl", "BV.wl", "AInfinity.wl", "Gauge.wl"}]

EndPackage[];
