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

CanonicalLieBialgebra /: MakeBoxes[object : CanonicalLieBialgebra[data : KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ],
	form : StandardForm | TraditionalForm] :=
	With[{pairing = data["Pairing"]},
		BoxForm`ArrangeSummaryBox[CanonicalLieBialgebra, object, $algebraIcon,
			{BoxForm`SummaryItem[{"alphabet: ", Row[Keys[pairing["Degrees"]], ", "]}],
				BoxForm`SummaryItem[{"empty word: ", data["EmptyWord"]}]},
			{BoxForm`SummaryItem[{"convention: ", pairing["Convention"]}],
				BoxForm`SummaryItem[{"degree: ", pairing["Degree"]}],
				BoxForm`SummaryItem[{"degrees: ", degreeRow[pairing["Degrees"]]}]},
			form]]

MaurerCartanElement /: MakeBoxes[object : MaurerCartanElement[data_Association], form : StandardForm | TraditionalForm] /;
	AssociationQ[data["Parts"]] && MatchQ[data["Pairing"], _GradedPairing] :=
	BoxForm`ArrangeSummaryBox[MaurerCartanElement, object, $elementIcon,
		{BoxForm`SummaryItem[{"parts: ", If[data["Parts"] === <||>, None,
				Row[Map[key |-> Subscript["m", Row[key, ","]], Keys[data["Parts"]]], ", "]]}],
			BoxForm`SummaryItem[{"alphabet: ", Row[Keys[data["Pairing"]["Degrees"]], ", "]}]},
		Join[{BoxForm`SummaryItem[{"convention: ", data["Pairing"]["Convention"]}]},
			KeyValueMap[{key, part} |-> BoxForm`SummaryItem[{Row[{Subscript["m", Row[key, ","]], ": "}], part}],
				data["Parts"]]],
		form]

letterBoxes[letter_, form_] := If[AtomQ[letter] || MatchQ[letter, Power[_?AtomQ, _?AtomQ]],
	MakeBoxes[letter, form],
	RowBox[{"(", MakeBoxes[letter, form], ")"}]]

degreeRow[degrees_Association] :=
	Row[KeyValueMap[{letter, degree} |-> Row[{letter, ": ", degree}], degrees], ", "]

$iconStyle = {GrayLevel[0.35], AbsoluteThickness[1.1], CapForm["Round"]}

$pairingIcon = Graphics[{$iconStyle, Circle[{0, 0}, 1],
		Line[{{-0.809, 0.588}, {0.809, -0.588}}], Line[{{-0.951, -0.309}, {0.309, 0.951}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.2, Background -> None]

$algebraIcon = Graphics[{$iconStyle, Circle[{-0.55, 0}, 0.45], Circle[{0.55, 0}, 0.45],
		Line[{{-0.1, 0}, {0.1, 0}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.2, Background -> None]

$elementIcon = Graphics[{$iconStyle, Circle[{0, 0}, 1],
		Line[{{0, 0.62}, {-0.54, -0.31}, {0.54, -0.31}, {0, 0.62}}],
		Disk[{0, 0.62}, 0.13], Disk[{-0.54, -0.31}, 0.13], Disk[{0.54, -0.31}, 0.13]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.2, Background -> None]
