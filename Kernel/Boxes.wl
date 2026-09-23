CyclicWord /: MakeBoxes[word : CyclicWord[letters_List], form : StandardForm | TraditionalForm] :=
	With[{boxes = If[letters === {}, "\[CurlyEpsilon]",
			RowBox[{"(", RowBox[Riffle[Map[letter |-> letterBoxes[letter, form], letters], "\[ThinSpace]"]], ")"}]]},
		InterpretationBox[boxes, word, Editable -> False]]

ExteriorProduct /: MakeBoxes[product : ExteriorProduct[factors__CyclicWord], form : StandardForm | TraditionalForm] :=
	With[{boxes = RowBox[Riffle[Map[factor |-> MakeBoxes[factor, form], {factors}], "\[Wedge]"]]},
		InterpretationBox[boxes, product, Editable -> False]]

SymmetricProduct /: MakeBoxes[product : SymmetricProduct[factors__CyclicWord], form : StandardForm | TraditionalForm] :=
	With[{boxes = RowBox[Riffle[Map[factor |-> MakeBoxes[factor, form], {factors}], "\[CircleDot]"]]},
		InterpretationBox[boxes, product, Editable -> False]]

HBar /: MakeBoxes[HBar, form : StandardForm | TraditionalForm] :=
	InterpretationBox["\[HBar]", HBar, Editable -> False]

GradedPairing /: MakeBoxes[object : GradedPairing[data_Association], form : StandardForm | TraditionalForm] :=
	With[{alphabet = Keys[data["Degrees"]], dual = Lookup[data, "Dual", None], algebra = Lookup[data, "Algebra", None]},
		BoxForm`ArrangeSummaryBox[GradedPairing, object, $pairingIcon,
			{BoxForm`SummaryItem[{"alphabet: ", Row[alphabet, ", "]}],
				BoxForm`SummaryItem[{"degree: ", data["Degree"]}],
				BoxForm`SummaryItem[{"convention: ", Lookup[data, "Convention", "Symmetric"]}]},
			{BoxForm`SummaryItem[{"degrees: ", degreeRow[data["Degrees"]]}],
				BoxForm`SummaryItem[{"values: ",
					MatrixForm[Outer[{p, q} |-> Lookup[data["Values"], Key[{p, q}], 0], alphabet, alphabet, 1]]}],
				BoxForm`SummaryItem[{"dual: ", If[dual === None, None, degreeRow[dual["Degrees"]]]}],
				BoxForm`SummaryItem[{"algebra: ", If[algebra === None, None, PoincareDualityAlgebra[algebra]]}]},
			form]]

SullivanModel /: MakeBoxes[object : SullivanModel[data_Association], form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[SullivanModel, object, $modelIcon,
		{BoxForm`SummaryItem[{"generators: ", degreeRow[data["Generators"]]}],
			BoxForm`SummaryItem[{"degree: ", data["Degree"]}]},
		{BoxForm`SummaryItem[{"differential: ", differentialRow[data["Differential"]]}],
			BoxForm`SummaryItem[{"volume: ", monomialExpression[data["Volume"]]}],
			BoxForm`SummaryItem[{"truncation: ", data["Truncation"]}]},
		form]

PoincareDualityAlgebra /: MakeBoxes[object : PoincareDualityAlgebra[data_Association],
	form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[PoincareDualityAlgebra, object, $algebraIcon,
		{BoxForm`SummaryItem[{"basis: ", Row[data["Basis"], ", "]}],
			BoxForm`SummaryItem[{"degree: ", data["Degree"]}]},
		{BoxForm`SummaryItem[{"degrees: ", Row[data["Degrees"], ", "]}],
			BoxForm`SummaryItem[{"pairing: ", MatrixForm[data["Pairing"]]}],
			BoxForm`SummaryItem[{"differential: ", matrixOrZero[data["Differential"]]}],
			BoxForm`SummaryItem[{"model: ", SullivanModel[data["Model"]]}]},
		form]

AInfinityAlgebra /: MakeBoxes[object : AInfinityAlgebra[data_Association], form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[AInfinityAlgebra, object, $ainfinityIcon,
		{BoxForm`SummaryItem[{"basis: ", Row[data["Basis"], ", "]}],
			BoxForm`SummaryItem[{"degrees: ", degreeRow[data["Degrees"]]}]},
		{BoxForm`SummaryItem[{"products: ", data["Products"]}]},
		form]

letterBoxes[letter_, form_] := If[AtomQ[letter] || MatchQ[letter, Power[_?AtomQ, _?AtomQ]],
	MakeBoxes[letter, form],
	RowBox[{"(", MakeBoxes[letter, form], ")"}]]

degreeRow[degrees_Association] :=
	Row[KeyValueMap[{letter, degree} |-> Row[{letter, ": ", degree}], degrees], ", "]

differentialRow[differential_Association] := With[{images = DeleteCases[Map[modelExpression, differential], 0]},
	If[images === <||>, 0,
		Row[KeyValueMap[{generator, image} |-> Row[{"d", generator, " = ", image}], images], ", "]]]

matrixOrZero[matrix_List] := If[Union[Flatten[matrix]] === {0}, 0, MatrixForm[matrix]]

$iconStyle = {GrayLevel[0.35], AbsoluteThickness[1.1], CapForm["Round"]}

$pairingIcon = Graphics[{$iconStyle, Circle[{0, 0}, 1],
		Line[{{-0.809, 0.588}, {0.809, -0.588}}], Line[{{-0.951, -0.309}, {0.309, 0.951}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.2, Background -> None]

$modelIcon = Graphics[{$iconStyle, Line[{{-1, -1}, {0, 1}, {1, -1}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]

$algebraIcon = Graphics[{$iconStyle, Circle[{0, 0}, 0.85], Line[{{0, -1.25}, {0, 1.25}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]

$ainfinityIcon = Graphics[{$iconStyle, Line[{{0, 0}, {0, -1.2}}],
		Map[tip |-> Line[{{0, 0}, tip}], {{-1, 1}, {-0.35, 1.2}, {0.35, 1.2}, {1, 1}}], Disk[{0, 0}, 0.13]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]
