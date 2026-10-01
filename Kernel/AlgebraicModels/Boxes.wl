SullivanModel /: MakeBoxes[object : SullivanModel[data_Association], form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[SullivanModel, object, $modelIcon,
		{BoxForm`SummaryItem[{"generators: ", degreeRow[data["Generators"]]}],
			BoxForm`SummaryItem[{"degree: ", data["Degree"]}]},
		{BoxForm`SummaryItem[{"differential: ", differentialRow[data["Differential"]]}],
			BoxForm`SummaryItem[{"orientation: ",
				Row[KeyValueMap[{monomial, value} |-> Row[{"O(", monomial, ") = ", value}], data["Orientation"]], ", "]}],
			BoxForm`SummaryItem[{"truncation: ", If[data["Truncation"] === <||>, None,
				Row[KeyValueMap[{group, top} |-> Row[{Row[group, " "], " above ", top}], data["Truncation"]], ", "]]}]},
		form]

PoincareDualityAlgebra /: MakeBoxes[object : PoincareDualityAlgebra[data_Association],
	form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[PoincareDualityAlgebra, object, $algebraIcon,
		{BoxForm`SummaryItem[{"basis: ", Row[data["Basis"], ", "]}],
			BoxForm`SummaryItem[{"degree: ", data["Degree"]}]},
		{BoxForm`SummaryItem[{"degrees: ", Row[data["Degrees"], ", "]}],
			BoxForm`SummaryItem[{"pairing: ", MatrixForm[data["Pairing"]]}],
			BoxForm`SummaryItem[{"differential: ", matrixOrZero[data["Differential"]]}],
			BoxForm`SummaryItem[{"model: ", Lookup[data, "Model", None]}]},
		form]

CochainComplexWithPairing /: MakeBoxes[object : CochainComplexWithPairing[data_Association],
	form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[CochainComplexWithPairing, object, $complexIcon,
		{BoxForm`SummaryItem[{"dimensions: ",
				Row[KeyValueMap[{k, count} |-> Row[{k, ": ", count}], KeySort[Counts[Values[data["Degrees"]]]]], ", "]}],
			BoxForm`SummaryItem[{"degree: ", data["Degree"]}]},
		{BoxForm`SummaryItem[{"basis: ", degreeRow[data["Degrees"]]}],
			BoxForm`SummaryItem[{"differential: ", differentialRow[data["Differential"]]}],
			BoxForm`SummaryItem[{"pairing: ", Row[KeyValueMap[
				{pair, value} |-> Row[{"\[LeftAngleBracket]", First[pair], ", ", Last[pair], "\[RightAngleBracket] = ", value}],
				KeySelect[data["Pairing"], OrderedQ]], ", "]}],
			BoxForm`SummaryItem[{"product: ", If[KeyExistsQ[data, "Product"],
				Row[KeyValueMap[{pair, value} |-> Row[{First[pair], "\[CenterDot]", Last[pair], " = ", value}],
					KeySelect[data["Product"], pair |-> OrderedQ[pair] && FreeQ[pair, 1, {1}]]], ", "], None]}]},
		form]

PreHodgeDecomposition /: MakeBoxes[object : PreHodgeDecomposition[data_Association],
	form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[PreHodgeDecomposition, object, $decompositionIcon,
		{BoxForm`SummaryItem[{"harmonic: ", dimensionRow[data["Harmonic"]]}],
			BoxForm`SummaryItem[{"coexact: ", dimensionRow[data["Coexact"]]}]},
		{BoxForm`SummaryItem[{"harmonic basis: ", basisColumn[data["Harmonic"]]}],
			BoxForm`SummaryItem[{"coexact basis: ", basisColumn[data["Coexact"]]}],
			BoxForm`SummaryItem[{"complex: ", data["Complex"]}]},
		form]

HodgeDecomposition /: MakeBoxes[object : HodgeDecomposition[data_Association],
	form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[HodgeDecomposition, object, $decompositionIcon,
		{BoxForm`SummaryItem[{"harmonic: ", dimensionRow[data["Harmonic"]]}],
			BoxForm`SummaryItem[{"coexact: ", dimensionRow[data["Coexact"]]}]},
		{BoxForm`SummaryItem[{"harmonic basis: ", basisColumn[data["Harmonic"]]}],
			BoxForm`SummaryItem[{"coexact basis: ", basisColumn[data["Coexact"]]}],
			BoxForm`SummaryItem[{"complex: ", data["Complex"]}]},
		form]

SpecialPropagator /: MakeBoxes[object : SpecialPropagator[data : KeyValuePattern[{"Images" -> _Association, "Decomposition" -> _}]?AssociationQ],
	form : StandardForm | TraditionalForm] :=
	BoxForm`ArrangeSummaryBox[SpecialPropagator, object, $propagatorIcon,
		{BoxForm`SummaryItem[{"nonzero images: ", dimensionRow[Map[row |-> Keys[DeleteCases[row, 0]], data["Images"]]]}]},
		{BoxForm`SummaryItem[{"images: ", With[{images = DeleteCases[Association[Values[data["Images"]]], 0]},
				If[images === <||>, None, Column[KeyValueMap[{e, image} |-> Row[{"P(", e, ") = ", image}], images]]]]}],
			BoxForm`SummaryItem[{"decomposition: ", data["Decomposition"]}]},
		form]

degreeRow[degrees_Association] :=
	Row[KeyValueMap[{letter, degree} |-> Row[{letter, ": ", degree}], degrees], ", "]

differentialRow[differential_Association] := With[{images = DeleteCases[differential, 0]},
	If[images === <||>, 0,
		Row[KeyValueMap[{generator, image} |-> Row[{"d", generator, " = ", image}], images], ", "]]]

matrixOrZero[matrix_List] := If[Union[Flatten[matrix]] === {0}, 0, MatrixForm[matrix]]

dimensionRow[bases_Association] := With[{present = Select[bases, basis |-> basis =!= {}]},
	If[present === <||>, 0, Row[KeyValueMap[{k, basis} |-> Row[{k, ": ", Length[basis]}], present], ", "]]]

basisColumn[bases_Association] := With[{present = Select[bases, basis |-> basis =!= {}]},
	If[present === <||>, None, Column[KeyValueMap[{k, basis} |-> Row[{k, ": ", Row[basis, ", "]}], present]]]]

$iconStyle = {GrayLevel[0.35], AbsoluteThickness[1.1], CapForm["Round"]}

$modelIcon = Graphics[{$iconStyle, Line[{{-1, -1}, {0, 1}, {1, -1}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]

$algebraIcon = Graphics[{$iconStyle, Circle[{0, 0}, 0.85], Line[{{0, -1.25}, {0, 1.25}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]

$complexIcon = Graphics[{$iconStyle, Disk[{-1, 0}, 0.13], Disk[{0, 0}, 0.13], Disk[{1, 0}, 0.13],
		Arrow[{{-0.8, 0}, {-0.2, 0}}], Arrow[{{0.2, 0}, {0.8, 0}}]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]

$decompositionIcon = Graphics[{$iconStyle, Line[{{-1, 0.8}, {1, 0.8}}], Line[{{-1, 0}, {1, 0}}],
		Line[{{-1, -0.8}, {1, -0.8}}], Disk[{-0.6, 0.8}, 0.13], Disk[{0, 0}, 0.13], Disk[{0.6, -0.8}, 0.13]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]

$propagatorIcon = Graphics[{$iconStyle, Disk[{-0.9, -0.5}, 0.13], Disk[{0.9, -0.5}, 0.13],
		Arrow[BezierCurve[{{0.75, -0.25}, {0, 1.1}, {-0.75, -0.25}}]]},
	ImageSize -> {Automatic, 22}, PlotRange -> 1.3, Background -> None]
