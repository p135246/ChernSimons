AInfinityAlgebra /: MakeBoxes[object : AInfinityAlgebra[data_Association], form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[AInfinityAlgebra, object, $ainfinityIcon,
		{BoxForm`SummaryItem[{"basis: ", Row[data["Basis"], ", "]}],
			BoxForm`SummaryItem[{"degrees: ", degreeRow[data["Degrees"]]}]},
		{BoxForm`SummaryItem[{"products: ", data["Products"]}]},
		form]

AInfinityMorphism /: MakeBoxes[object : AInfinityMorphism[data_Association], form : StandardForm | TraditionalForm] /;
	MatchQ[data["Source"], AInfinityAlgebra[_Association]] && MatchQ[data["Target"], AInfinityAlgebra[_Association]] :=
	BoxForm`ArrangeSummaryBox[AInfinityMorphism, object, $morphismIcon,
		{BoxForm`SummaryItem[{"source: ", Row[data["Source"]["Basis"], ", "]}],
			BoxForm`SummaryItem[{"target: ", Row[data["Target"]["Basis"], ", "]}]},
		{BoxForm`SummaryItem[{"source degrees: ", degreeRow[data["Source"]["Degrees"]]}],
			BoxForm`SummaryItem[{"target degrees: ", degreeRow[data["Target"]["Degrees"]]}],
			BoxForm`SummaryItem[{"components: ", data["Components"]}]},
		form]

degreeRow[degrees_Association] :=
	Row[KeyValueMap[{letter, degree} |-> Row[{letter, ": ", degree}], degrees], ", "]

$iconStyle = {GrayLevel[0.35], AbsoluteThickness[1.1], CapForm["Round"]}

$ainfinityIcon = Graphics[{$iconStyle, Line[{{0, 0}, {0, -1.2}}],
		Map[tip |-> Line[{{0, 0}, tip}], {{-1, 1}, {-0.35, 1.2}, {0.35, 1.2}, {1, 1}}], Disk[{0, 0}, 0.13]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]

$morphismIcon = Graphics[{$iconStyle, Circle[{-0.7, 0}, 0.35], Circle[{0.7, 0}, 0.35],
		Line[{{-0.3, 0}, {0.3, 0}}], Line[{{0.12, 0.17}, {0.3, 0}, {0.12, -0.17}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.2, Background -> None]
