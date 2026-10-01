PackageExported[CochainComplexWithPairing]
PackageExported[DegenerateSubspace]
PackageExported[HodgeTypeQ]
PackageExported[HodgeTypeReport]
PackageExported[NondegenerateQuotient]
PackageExported[PoincareDualityAlgebra]
PackageExported[FindHarmonicSubspace]
PackageExported[FindPreHodgeDecomposition]
PackageExported[FindHodgeDecomposition]
PackageExported[PreHodgeDecomposition]
PackageExported[HodgeDecomposition]
PackageExported[SpecialPropagator]
PackageExported[HarmonicProjection]
PackageExported[HodgeExtension]

CochainComplexWithPairing::usage = "CochainComplexWithPairing[degrees, differential, pairing] is a finite-dimensional cochain complex with a graded symmetric pairing, given by the degrees of the basis elements, the differential on the basis and the values of the pairing.\nCochainComplexWithPairing[degrees, differential, product, orientation] is a differential graded algebra with the pairing <x, y> = O(x y), given by the products of pairs of basis elements and an orientation O.\nCochainComplexWithPairing[model] is the finite quotient of a SullivanModel that agrees with it up to degree n+1 and has its Poincare duality and Hodge type.\nCochainComplexWithPairing[algebra] is a PoincareDualityAlgebra as a complex.";

DegenerateSubspace::usage = "DegenerateSubspace[model, k] gives a basis of the degree-k part of the degenerate subspace of a SullivanModel, the elements that pair to zero with everything.\nDegenerateSubspace[complex, k] gives a basis of the degree-k part of the degenerate subspace of a CochainComplexWithPairing.";

HodgeTypeQ::usage = "HodgeTypeQ[model] tests whether a SullivanModel is of Hodge type.\nHodgeTypeQ[complex] tests whether a CochainComplexWithPairing is of Hodge type.\nThe option \"MaxDegree\" -> d, with d at least n, tests a model in the degrees 0 to d instead of 0 to n+1.";

HodgeTypeQ::duality = "The pairing on cohomology is not perfect, so the criterion for Hodge type does not apply.";

HodgeTypeReport::usage = "HodgeTypeReport[model] gives a Dataset with one row per degree of a SullivanModel: the dimensions of the space, of its cohomology, of the degenerate subspace, of the cohomology of the degenerate subspace and of the nondegenerate quotient.\nHodgeTypeReport[complex] gives the same Dataset for a CochainComplexWithPairing, over all of its degrees.\nThe option \"MaxDegree\" -> d, with d at least n, sets the last degree shown for a model.";

NondegenerateQuotient::usage = "NondegenerateQuotient[model] gives the quotient of a SullivanModel by its degenerate subspace, as a PoincareDualityAlgebra.\nNondegenerateQuotient[complex] gives the quotient of a CochainComplexWithPairing by its degenerate subspace, as a CochainComplexWithPairing with a perfect pairing.";

PoincareDualityAlgebra::usage = "PoincareDualityAlgebra[complex] gives the finite-dimensional Poincare duality algebra of a CochainComplexWithPairing that carries a product and has a perfect pairing.\nPoincareDualityAlgebra[data] is a finite-dimensional Poincare duality algebra given by an Association data of its basis, degrees, Gram matrix, differential and triple products, the object NondegenerateQuotient gives.";

Options[HodgeTypeQ] = {"MaxDegree" -> Automatic};

Options[HodgeTypeReport] = {"MaxDegree" -> Automatic};

CochainComplexWithPairing[degrees_Association, differential_Association, pairing_Association] /; And[
		AllTrue[degrees, IntegerQ],
		SubsetQ[Keys[degrees], Keys[differential]],
		AllTrue[Keys[pairing], pair |-> MatchQ[pair, {_, _}] && SubsetQ[Keys[degrees], pair]],
		AllTrue[pairing, NumericQ]] := With[
	{values = DeleteCases[pairing, 0]},
	{complex = CochainComplexWithPairing[<|
		"Degrees" -> degrees,
		"Differential" -> AssociationMap[b |-> Expand[Lookup[differential, b, 0]], Keys[degrees]],
		"Pairing" -> Join[
			Association[KeyValueMap[{pair, value} |-> Reverse[pair] -> (-1)^(Times @@ Lookup[degrees, pair]) value, values]],
			values],
		"Degree" -> If[values === <||>, None, Total[Lookup[degrees, First[Keys[values]]]]]|>]},
	If[TrueQ[RelationsQ[complex]], complex,
		Failure["CochainComplexWithPairing", <|"MessageTemplate" ->
			"The data do not satisfy the axioms of a cochain complex with a pairing."|>]]]

CochainComplexWithPairing[degrees_Association, differential_Association, product_Association,
	orientation : Except[_Association]] := CochainComplexWithPairing[degrees, differential, product, <|orientation -> 1|>]

CochainComplexWithPairing[degrees_Association, differential_Association, product_Association, orientation_Association] /; And[
		AllTrue[degrees, IntegerQ],
		SubsetQ[Keys[degrees], Keys[differential]],
		AllTrue[Keys[product], pair |-> MatchQ[pair, {_, _}] && SubsetQ[Keys[degrees], pair]],
		AllTrue[orientation, NumericQ]] := With[
	{values = DeleteCases[orientation, 0], variables = Variables[Keys[degrees]],
		multiplication = DeleteCases[Map[Expand, Join[
			If[MemberQ[Keys[degrees], 1], Association[Catenate[Map[b |-> {{1, b} -> b, {b, 1} -> b}, Keys[degrees]]]], <||>],
			Association[KeyValueMap[{pair, value} |-> Reverse[pair] -> (-1)^(Times @@ Lookup[degrees, pair]) value, product]],
			product]], 0]},
	{n = Lookup[degrees, First[Keys[values], None], None]},
	{complex = CochainComplexWithPairing[<|
		"Degrees" -> degrees,
		"Differential" -> AssociationMap[b |-> Expand[Lookup[differential, b, 0]], Keys[degrees]],
		"Pairing" -> DeleteCases[Association[Map[
			pair |-> pair -> Total[Map[rule |-> Last[rule] Lookup[values, Times @@ (variables^First[rule]), 0],
				CoefficientRules[Lookup[multiplication, Key[pair], 0], variables]]],
			Select[Tuples[Keys[degrees], 2], pair |-> Total[Lookup[degrees, pair]] === n]]], 0],
		"Degree" -> n,
		"Product" -> multiplication|>]},
	Which[
		! OrientationQ[values, complex],
			Failure["CochainComplexWithPairing", <|"MessageTemplate" -> "The values do not define an orientation."|>],
		! TrueQ[RelationsQ[complex]],
			Failure["CochainComplexWithPairing", <|"MessageTemplate" ->
				"The data do not satisfy the axioms of a cochain complex with a pairing."|>],
		True, complex]]

CochainComplexWithPairing[model_SullivanModel] := With[
	{n = model["Degree"], generators = Keys[model["Generators"]], weights = Values[model["Generators"]]},
	{top = SullivanModelBasis[model, n + 2],
		images = Map[p |-> SullivanModelDifferential[p, model], SullivanModelBasis[model, n + 1]]},
	{pivots = If[top === {} || images === {}, {},
		With[{matrix = Map[image |-> Map[m |-> Coefficient[image, m], top], images]},
			top[[Fold[
				{chosen, column} |-> If[MatrixRank[matrix[[All, Append[chosen, column]]]] > Length[chosen],
					Append[chosen, column], chosen],
				{}, Range[Length[top]]]]]]]},
	{labels = Join[Catenate[Map[k |-> SullivanModelBasis[model, k], Range[0, n + 1]]], pivots],
		reduce = e |-> Expand[Total[Map[
			rule |-> If[First[rule] . weights > n + 1 && ! MemberQ[pivots, Times @@ (generators^First[rule])], 0,
				Last[rule] Times @@ (generators^First[rule])],
			CoefficientRules[e, generators]]]]},
	{degrees = AssociationMap[b |-> Exponent[b, generators] . weights, labels]},
	CochainComplexWithPairing[<|
		"Degrees" -> degrees,
		"Differential" -> AssociationMap[b |-> reduce[SullivanModelDifferential[b, model]], labels],
		"Pairing" -> DeleteCases[Association[Map[
			pair |-> pair -> SullivanModelPairing[First[pair], Last[pair], model],
			Select[Tuples[labels, 2], pair |-> Total[Lookup[degrees, pair]] === n]]], 0],
		"Degree" -> n,
		"Product" -> DeleteCases[Association[Map[
			pair |-> pair -> reduce[SullivanModelProduct[First[pair], Last[pair], model]],
			Select[Tuples[labels, 2], pair |-> Total[Lookup[degrees, pair]] <= n + 2]]], 0]|>]]

CochainComplexWithPairing[algebra_PoincareDualityAlgebra] := With[
	{basis = algebra["Basis"], inverse = Inverse[algebra["Pairing"]]},
	CochainComplexWithPairing[<|
		"Degrees" -> AssociationThread[basis -> algebra["Degrees"]],
		"Differential" -> AssociationThread[basis -> Expand[algebra["Differential"] . basis]],
		"Pairing" -> DeleteCases[Association[Map[
			pair |-> basis[[pair]] -> algebra["Pairing"][[First[pair], Last[pair]]],
			Tuples[Range[Length[basis]], 2]]], 0],
		"Degree" -> algebra["Degree"],
		"Product" -> DeleteCases[Association[Map[
			pair |-> basis[[pair]] -> Expand[
				Map[m |-> Lookup[algebra["Triple"], Key[Append[pair, m]], 0], Range[Length[basis]]] . inverse . basis],
			Tuples[Range[Length[basis]], 2]]], 0]|>]]

PoincareDualityAlgebra[complex_CochainComplexWithPairing] /; KeyExistsQ[complex, "Product"] := With[
	{basis = Keys[complex["Degrees"]], n = complex["Degree"], pairing = complex["Pairing"],
		variables = Variables[Keys[complex["Degrees"]]]},
	{degrees = Lookup[complex["Degrees"], basis],
		value = {e, b} |-> Total[Map[
			rule |-> Last[rule] Lookup[pairing, Key[{Times @@ (variables^First[rule]), b}], 0],
			CoefficientRules[e, variables]]]},
	If[! PerfectPairingQ[complex],
		Failure["PoincareDualityAlgebra", <|"MessageTemplate" -> "The pairing is not perfect."|>],
		PoincareDualityAlgebra[<|
			"Degree" -> n,
			"Basis" -> basis,
			"Degrees" -> degrees,
			"Pairing" -> Outer[{p, q} |-> Lookup[pairing, Key[{p, q}], 0], basis, basis, 1],
			"DifferentialPairing" -> DeleteCases[Association[Map[
				pair |-> pair -> value[complex["Differential"][basis[[First[pair]]]], basis[[Last[pair]]]],
				Select[Tuples[Range[Length[basis]], 2], pair |-> Total[degrees[[pair]]] === n - 1]]], 0],
			"Differential" -> Map[
				p |-> Lookup[Association[Map[
						rule |-> Times @@ (variables^First[rule]) -> Last[rule],
						CoefficientRules[complex["Differential"][p], variables]]], basis, 0],
				basis],
			"Triple" -> DeleteCases[Association[Map[
				triple |-> triple -> value[Lookup[complex["Product"], Key[basis[[Take[triple, 2]]]], 0], basis[[Last[triple]]]],
				Select[Tuples[Range[Length[basis]], 3], triple |-> Total[degrees[[triple]]] === n]]], 0]|>]]]

DegenerateSubspace[model_SullivanModel, k_Integer] := With[
	{basis = SullivanModelBasis[model, k], dual = SullivanModelBasis[model, model["Degree"] - k]},
	Which[
		basis === {}, {},
		dual === {}, basis,
		True, Map[v |-> v . basis, NullSpace[Map[q |-> Map[p |-> SullivanModelPairing[p, q, model], basis], dual]]]]]

DegenerateSubspace[complex_CochainComplexWithPairing, k_Integer] := With[
	{basis = Keys[Select[complex["Degrees"], EqualTo[k]]],
		dual = Keys[Select[complex["Degrees"], EqualTo[complex["Degree"] - k]]]},
	Which[
		basis === {}, {},
		dual === {}, basis,
		True, Map[v |-> v . basis,
			NullSpace[Map[q |-> Map[p |-> Lookup[complex["Pairing"], Key[{p, q}], 0], basis], dual]]]]]

HodgeTypeQ[model_SullivanModel, opts : OptionsPattern[]] /;
	MatchQ[OptionValue[HodgeTypeQ, {opts}, "MaxDegree"], Automatic | _Integer?(d |-> d >= model["Degree"])] &&
	If[PoincareDualityQ[model, "MaxDegree" -> OptionValue[HodgeTypeQ, {opts}, "MaxDegree"]], True,
		Message[HodgeTypeQ::duality]; False] := AllTrue[
	Range[0, Replace[OptionValue["MaxDegree"], Automatic -> model["Degree"] + 1]],
	k |-> With[
		{rank = j |-> With[{degenerate = DegenerateSubspace[model, j], above = SullivanModelBasis[model, j + 1]},
			If[degenerate === {} || above === {}, 0, MatrixRank[Map[
				v |-> Map[q |-> Coefficient[SullivanModelDifferential[v, model], q], above], degenerate]]]]},
		Length[DegenerateSubspace[model, k]] - rank[k] - rank[k - 1] === 0]]

HodgeTypeQ[complex_CochainComplexWithPairing] /;
	If[PoincareDualityQ[complex], True, Message[HodgeTypeQ::duality]; False] := With[
	{variables = Variables[Keys[complex["Degrees"]]]},
	{expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
		CoefficientRules[e, variables]]]},
	{rank = j |-> With[
		{degenerate = DegenerateSubspace[complex, j], above = Keys[Select[complex["Degrees"], EqualTo[j + 1]]]},
		If[degenerate === {} || above === {}, 0, MatrixRank[Map[
			v |-> Lookup[expansion[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[v]]]], above, 0],
			degenerate]]]]},
	AllTrue[Union[Values[complex["Degrees"]]], k |-> Length[DegenerateSubspace[complex, k]] - rank[k] - rank[k - 1] === 0]]

HodgeTypeReport[model_SullivanModel, opts : OptionsPattern[]] /;
	MatchQ[OptionValue[HodgeTypeReport, {opts}, "MaxDegree"], Automatic | _Integer?(d |-> d >= model["Degree"])] := Dataset[AssociationMap[
	k |-> With[
		{rank = {j, space} |-> With[{above = SullivanModelBasis[model, j + 1]},
			If[space === {} || above === {}, 0, MatrixRank[Map[
				v |-> Map[q |-> Coefficient[SullivanModelDifferential[v, model], q], above], space]]]]},
		{dimension = Length[SullivanModelBasis[model, k]], degenerate = Length[DegenerateSubspace[model, k]]},
		<|"Dimension" -> dimension,
			"Cohomology" -> dimension - rank[k, SullivanModelBasis[model, k]] -
				rank[k - 1, SullivanModelBasis[model, k - 1]],
			"Degenerate" -> degenerate,
			"DegenerateCohomology" -> degenerate - rank[k, DegenerateSubspace[model, k]] -
				rank[k - 1, DegenerateSubspace[model, k - 1]],
			"Quotient" -> dimension - degenerate|>],
	Range[0, Replace[OptionValue["MaxDegree"], Automatic -> model["Degree"] + 3]]]]

HodgeTypeReport[complex_CochainComplexWithPairing] := With[
	{variables = Variables[Keys[complex["Degrees"]]]},
	{expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
		CoefficientRules[e, variables]]],
		labels = k |-> Keys[Select[complex["Degrees"], EqualTo[k]]]},
	{rank = {j, space} |-> If[space === {} || labels[j + 1] === {}, 0, MatrixRank[Map[
		v |-> Lookup[expansion[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[v]]]], labels[j + 1], 0],
		space]]]},
	Dataset[AssociationMap[
		k |-> With[{dimension = Length[labels[k]], degenerate = Length[DegenerateSubspace[complex, k]]},
			<|"Dimension" -> dimension,
				"Cohomology" -> dimension - rank[k, labels[k]] - rank[k - 1, labels[k - 1]],
				"Degenerate" -> degenerate,
				"DegenerateCohomology" -> degenerate - rank[k, DegenerateSubspace[complex, k]] -
					rank[k - 1, DegenerateSubspace[complex, k - 1]],
				"Quotient" -> dimension - degenerate|>],
		Range[Min[Values[complex["Degrees"]]], Max[Values[complex["Degrees"]]]]]]]

NondegenerateQuotient[model_SullivanModel] := With[
	{basis = Catenate[Table[
		With[{monomials = SullivanModelBasis[model, k], dual = SullivanModelBasis[model, model["Degree"] - k]},
			{pairing = Map[p |-> Map[q |-> SullivanModelPairing[p, q, model], dual], monomials]},
			monomials[[Fold[
				{chosen, row} |-> If[MatrixRank[pairing[[Append[chosen, row]]]] > Length[chosen], Append[chosen, row], chosen],
				{}, Range[Length[monomials]]]]]],
		{k, 0, model["Degree"]}]]},
	{degrees = Map[b |-> Exponent[b, Keys[model["Generators"]]] . Values[model["Generators"]], basis],
		gram = Map[p |-> Map[q |-> SullivanModelPairing[p, q, model], basis], basis]},
	{differential = DeleteCases[Association[Map[
		pair |-> pair -> SullivanModelPairing[SullivanModelDifferential[basis[[First[pair]]], model],
			basis[[Last[pair]]], model],
		Select[Tuples[Range[Length[basis]], 2], pair |-> Total[degrees[[pair]]] === model["Degree"] - 1]]], 0]},
	PoincareDualityAlgebra[<|
		"Degree" -> model["Degree"],
		"Basis" -> basis,
		"Degrees" -> degrees,
		"Pairing" -> gram,
		"DifferentialPairing" -> differential,
		"Differential" -> If[basis === {}, {},
			Normal[SparseArray[Normal[differential], {Length[basis], Length[basis]}, 0]] . Inverse[gram]],
		"Triple" -> DeleteCases[Association[Map[
			triple |-> triple -> SullivanModelOrientation[SullivanModelProduct @@ Append[basis[[triple]], model], model],
			Select[Tuples[Range[Length[basis]], 3], triple |-> Total[degrees[[triple]]] === model["Degree"]]]], 0],
		"Model" -> model|>]]

NondegenerateQuotient[complex_CochainComplexWithPairing] := With[
	{degrees = complex["Degrees"], n = complex["Degree"], pairing = complex["Pairing"],
		variables = Variables[Keys[complex["Degrees"]]]},
	{labels = k |-> Keys[Select[degrees, EqualTo[k]]],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]]},
	{basis = Catenate[Map[
		k |-> If[labels[n - k] === {}, {},
			With[{gram = Map[p |-> Map[q |-> Lookup[pairing, Key[{p, q}], 0], labels[n - k]], labels[k]]},
				labels[k][[Fold[
					{chosen, row} |-> If[MatrixRank[gram[[Append[chosen, row]]]] > Length[chosen], Append[chosen, row], chosen],
					{}, Range[Length[labels[k]]]]]]]],
		Union[Values[degrees]]]]},
	{inverse = Inverse[Map[p |-> Map[q |-> Lookup[pairing, Key[{p, q}], 0], basis], basis]]},
	{class = e |-> Expand[Map[
		b |-> Total[KeyValueMap[{p, c} |-> c Lookup[pairing, Key[{p, b}], 0], expansion[e]]], basis] . inverse . basis]},
	CochainComplexWithPairing[Join[
		<|"Degrees" -> KeyTake[degrees, basis],
			"Differential" -> AssociationMap[b |-> class[complex["Differential"][b]], basis],
			"Pairing" -> KeyTake[pairing, Tuples[basis, 2]],
			"Degree" -> n|>,
		If[KeyExistsQ[complex, "Product"],
			<|"Product" -> DeleteCases[Association[Map[
				pair |-> pair -> class[Lookup[complex["Product"], Key[pair], 0]], Tuples[basis, 2]]], 0]|>,
			<||>]]]]

Relations[CochainComplexWithPairing[data_Association]] /;
		SubsetQ[Keys[data], {"Degrees", "Differential", "Pairing", "Degree"}] := Join[
	<|"DifferentialDegree" -> 1, "DifferentialSquare" -> 1, "PairingDegree" -> 2, "GradedSymmetry" -> 2,
		"Compatibility" -> 2|>,
	If[KeyExistsQ[data, "Product"],
		Join[<|"ProductDegree" -> 2, "GradedCommutativity" -> 2, "Associativity" -> 3|>,
			If[KeyExistsQ[data["Degrees"], 1], <|"Unit" -> 1|>, <||>],
			<|"Leibniz" -> 2, "Invariance" -> 3|>],
		<||>]]

Obstruction[complex : CochainComplexWithPairing[_Association], relation_String, arguments_List] /; And[
		KeyExistsQ[Relations[complex], relation],
		Length[arguments] === Relations[complex][relation],
		AllTrue[arguments, e |-> PolynomialQ[e, Variables[Keys[complex["Degrees"]]]]]] := With[
	{degrees = complex["Degrees"], n = complex["Degree"], pairing = complex["Pairing"],
		product = Lookup[complex, "Product", <||>], variables = Variables[Keys[complex["Degrees"]]]},
	{expansion = e |-> Which[
		e === 0, <||>,
		KeyExistsQ[degrees, e], <|e -> 1|>,
		True, Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[e, variables]]]]},
	{coordinates = Map[e |-> Normal[expansion[e]], arguments],
		differential = e |-> Expand[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[e]]]],
		times = {e, f} |-> Expand[Total[KeyValueMap[
			{p, c} |-> c Total[KeyValueMap[{q, c2} |-> c2 Lookup[product, Key[{p, q}], 0], expansion[f]]],
			expansion[e]]]],
		value = {e, f} |-> Total[KeyValueMap[
			{p, c} |-> c Total[KeyValueMap[{q, c2} |-> c2 Lookup[pairing, Key[{p, q}], 0], expansion[f]]],
			expansion[e]]],
		outside = {e, k} |-> Expand[Total[KeyValueMap[{p, c} |-> If[Lookup[degrees, Key[p]] === k, 0, c p], expansion[e]]]]},
	{identity = <|
		"DifferentialDegree" -> ({u} |-> outside[differential[u], degrees[u] + 1]),
		"DifferentialSquare" -> ({u} |-> differential[differential[u]]),
		"PairingDegree" -> ({u, v} |-> If[degrees[u] + degrees[v] === n, 0, value[u, v]]),
		"GradedSymmetry" -> ({u, v} |-> value[u, v] - (-1)^(degrees[u] degrees[v]) value[v, u]),
		"Compatibility" -> ({u, v} |-> value[differential[u], v] - (-1)^(degrees[u] + 1) value[u, differential[v]]),
		"ProductDegree" -> ({u, v} |-> outside[times[u, v], degrees[u] + degrees[v]]),
		"GradedCommutativity" -> ({u, v} |-> times[u, v] - (-1)^(degrees[u] degrees[v]) times[v, u]),
		"Associativity" -> ({u, v, w} |-> times[times[u, v], w] - times[u, times[v, w]]),
		"Unit" -> ({u} |-> times[1, u] - u),
		"Leibniz" -> ({u, v} |->
			differential[times[u, v]] - times[differential[u], v] - (-1)^degrees[u] times[u, differential[v]]),
		"Invariance" -> ({u, v, w} |-> value[times[u, v], w] - value[u, times[v, w]])|>},
	Expand[Total[Map[
		tuple |-> Times[Times @@ Values[tuple], identity[relation] @@ Keys[tuple]],
		Tuples[coordinates]]]] /; SubsetQ[Keys[degrees], Keys[Catenate[coordinates]]]]

RelationsQ[complex : CochainComplexWithPairing[data_Association]] /; And[
		SubsetQ[Keys[data], {"Degrees", "Differential", "Pairing", "Degree"}],
		AssociationQ[data["Degrees"]] && AssociationQ[data["Differential"]] && AssociationQ[data["Pairing"]],
		IntegerQ[data["Degree"]] && AllTrue[data["Degrees"], IntegerQ],
		AllTrue[Keys[data["Degrees"]], label |-> MatchQ[CoefficientRules[label, Variables[label]], {_ -> 1}]],
		ContainsExactly[Keys[data["Differential"]], Keys[data["Degrees"]]],
		AllTrue[Keys[data["Pairing"]], pair |-> MatchQ[pair, {_, _}] && SubsetQ[Keys[data["Degrees"]], pair]],
		AllTrue[data["Pairing"], NumericQ],
		! KeyExistsQ[data, "Product"] || AssociationQ[data["Product"]] &&
			AllTrue[Keys[data["Product"]], pair |-> MatchQ[pair, {_, _}] && SubsetQ[Keys[data["Degrees"]], pair]]] :=
	AllTrue[Normal[Relations[complex]], relation |->
		AllTrue[Tuples[Keys[data["Degrees"]], Last[relation]], tuple |-> Obstruction[complex, First[relation], tuple] === 0]]

FindHarmonicSubspace::usage = "FindHarmonicSubspace[space] finds a harmonic subspace of a SullivanModel or a CochainComplexWithPairing, a complement of the image of the differential in the cocycles, as an Association from degrees to bases.\nFindHarmonicSubspace[space, k] gives the basis of degree k of that subspace.\nThe option Method -> \"Adjoint\" takes the intersection of the kernels of the differential and of its transpose in place of the default \"BasisOrder\", the first cocycles in the order of the basis.";

FindPreHodgeDecomposition::usage = "FindPreHodgeDecomposition[space] finds a pre-Hodge decomposition V = H + im d + C of a SullivanModel or a CochainComplexWithPairing, with the harmonic subspace H given by FindHarmonicSubspace[space].\nFindPreHodgeDecomposition[space, harmonic] finds one with the given harmonic subspace, an Association from degrees to bases.";

FindHodgeDecomposition::usage = "FindHodgeDecomposition[space] finds a Hodge decomposition V = H + im d + C, with C perpendicular to C + H, of a SullivanModel or a CochainComplexWithPairing, with the harmonic subspace H given by FindHarmonicSubspace[space].\nFindHodgeDecomposition[space, harmonic] finds one with the given harmonic subspace, an Association from degrees to bases.\nFindHodgeDecomposition[propagator] gives the Hodge decomposition of a SpecialPropagator P, with harmonic subspace the image of Id + d P + P d and coexact part the image of P.";

PreHodgeDecomposition::usage = "PreHodgeDecomposition[data] is a pre-Hodge decomposition V = H + im d + C of a CochainComplexWithPairing, with the keys \"Harmonic\", \"Coexact\" and \"Complex\", the result of FindPreHodgeDecomposition.";

HodgeDecomposition::usage = "HodgeDecomposition[data] is a Hodge decomposition V = H + im d + C of a CochainComplexWithPairing, a pre-Hodge decomposition with C perpendicular to C, the result of FindHodgeDecomposition.";

Options[FindHarmonicSubspace] = {Method -> "BasisOrder"};

FindHarmonicSubspace[model_SullivanModel, opts : OptionsPattern[]] :=
	FindHarmonicSubspace[CochainComplexWithPairing[model], opts]

FindHarmonicSubspace[model_SullivanModel, k_Integer, opts : OptionsPattern[]] :=
	FindHarmonicSubspace[CochainComplexWithPairing[model], k, opts]

FindHarmonicSubspace[complex_CochainComplexWithPairing, opts : OptionsPattern[]] /;
		MemberQ[{"BasisOrder", "Adjoint"}, OptionValue[FindHarmonicSubspace, {opts}, Method]] :=
	AssociationMap[k |-> FindHarmonicSubspace[complex, k, opts], Union[Values[complex["Degrees"]]]]

FindHarmonicSubspace[complex_CochainComplexWithPairing, k_Integer, opts : OptionsPattern[]] /;
		OptionValue[FindHarmonicSubspace, {opts}, Method] === "BasisOrder" := With[
	{variables = Variables[Keys[complex["Degrees"]]], basis = Keys[Select[complex["Degrees"], EqualTo[k]]],
		below = Keys[Select[complex["Degrees"], EqualTo[k - 1]]], above = Keys[Select[complex["Degrees"], EqualTo[k + 1]]]},
	{coordinates = {e, labels} |-> Lookup[Association[Map[
		rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[e, variables]]], labels, 0]},
	If[basis === {}, {}, With[
		{boundaries = Map[p |-> coordinates[complex["Differential"][p], basis], below],
			cocycles = If[above === {}, IdentityMatrix[Length[basis]],
				NullSpace[Transpose[Map[p |-> coordinates[complex["Differential"][p], above], basis]]]]},
		{rank = If[boundaries === {}, 0, MatrixRank[boundaries]]},
		Map[v |-> v . basis, Fold[
			{chosen, candidate} |-> If[MatrixRank[Join[boundaries, chosen, {candidate}]] > rank + Length[chosen],
				Append[chosen, candidate], chosen],
			{},
			Join[Pick[IdentityMatrix[Length[basis]], Map[p |-> complex["Differential"][p] === 0, basis]], cocycles]]]]]]

FindHarmonicSubspace[complex_CochainComplexWithPairing, k_Integer, opts : OptionsPattern[]] /;
		OptionValue[FindHarmonicSubspace, {opts}, Method] === "Adjoint" := With[
	{variables = Variables[Keys[complex["Degrees"]]], basis = Keys[Select[complex["Degrees"], EqualTo[k]]],
		below = Keys[Select[complex["Degrees"], EqualTo[k - 1]]], above = Keys[Select[complex["Degrees"], EqualTo[k + 1]]]},
	{coordinates = {e, labels} |-> Lookup[Association[Map[
		rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[e, variables]]], labels, 0]},
	{constraints = Join[
		Transpose[Map[p |-> coordinates[complex["Differential"][p], above], basis]],
		Map[p |-> coordinates[complex["Differential"][p], basis], below]]},
	Which[
		basis === {}, {},
		constraints === {}, basis,
		True, Map[v |-> v . basis, NullSpace[constraints]]]]

FindPreHodgeDecomposition[model_SullivanModel] := FindPreHodgeDecomposition[CochainComplexWithPairing[model]]

FindPreHodgeDecomposition[model_SullivanModel, harmonic_Association] :=
	FindPreHodgeDecomposition[CochainComplexWithPairing[model], harmonic]

FindPreHodgeDecomposition[complex_CochainComplexWithPairing] :=
	FindPreHodgeDecomposition[complex, FindHarmonicSubspace[complex]]

FindPreHodgeDecomposition[complex_CochainComplexWithPairing, harmonic_Association] /;
		AllTrue[Keys[harmonic], IntegerQ] && AllTrue[harmonic, ListQ] := With[
	{degrees = complex["Degrees"], n = complex["Degree"], pairing = complex["Pairing"],
		variables = Variables[Keys[complex["Degrees"]]]},
	{labels = k |-> Keys[Select[degrees, EqualTo[k]]],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]]},
	{coordinates = {e, k} |-> Lookup[expansion[e], labels[k], 0],
		value = {e, f} |-> Total[KeyValueMap[
			{p, c} |-> c Total[KeyValueMap[{q, c2} |-> c2 Lookup[pairing, Key[{p, q}], 0], expansion[f]]],
			expansion[e]]]},
	{cocycles = k |-> Which[
			labels[k] === {}, {},
			labels[k + 1] === {}, IdentityMatrix[Length[labels[k]]],
			True, NullSpace[Transpose[Map[p |-> coordinates[complex["Differential"][p], k + 1], labels[k]]]]],
		boundaries = k |-> Map[p |-> coordinates[complex["Differential"][p], k], labels[k - 1]]},
	{coexact = AssociationMap[
		k |-> With[{basis = labels[k], closed = cocycles[k], dual = Lookup[harmonic, n - k, {}]},
			If[basis === {}, {}, With[
				{gram = Map[p |-> Map[h |-> value[p, h], dual], basis]},
				{perpendicular = If[dual === {}, IdentityMatrix[Length[basis]], NullSpace[Transpose[gram]]],
					rank = If[closed === {}, 0, MatrixRank[closed]]},
				Map[v |-> v . basis, Fold[
					{chosen, candidate} |-> If[MatrixRank[Join[closed, chosen, {candidate}]] > rank + Length[chosen],
						Append[chosen, candidate], chosen],
					{}, Join[Pick[IdentityMatrix[Length[basis]], Map[MatchQ[{0 ...}], gram]], perpendicular]]]]]],
		Union[Values[degrees]]]},
	{short = Select[Union[Values[degrees]],
		k |-> Length[coexact[k]] < Length[labels[k]] - Length[cocycles[k]]]},
	Which[
		! And[
			SubsetQ[Union[Values[degrees]], Keys[Select[harmonic, basis |-> basis =!= {}]]],
			AllTrue[Union[Values[degrees]], k |-> With[
				{given = Lookup[harmonic, k, {}], exact = boundaries[k]},
				{rows = Map[h |-> coordinates[h, k], given]},
				And[
					AllTrue[given, h |-> With[{terms = expansion[h]},
						AllTrue[terms, NumericQ] && SubsetQ[labels[k], Keys[terms]]]],
					AllTrue[given, h |-> Expand[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[h]]]] === 0],
					If[exact === {}, 0, MatrixRank[exact]] + Length[given] === Length[cocycles[k]],
					Join[exact, rows] === {} || MatrixRank[Join[exact, rows]] === Length[cocycles[k]]]]]],
			Failure["FindPreHodgeDecomposition", <|"MessageTemplate" ->
				"The harmonic subspace is not a complement of the image of the differential in the cocycles."|>],
		short =!= {},
			Failure["FindPreHodgeDecomposition", <|"MessageTemplate" ->
				"No complement of the cocycles is perpendicular to the harmonic subspace in degrees " <> ToString[short] <> ".",
				"Degrees" -> short|>],
		True, PreHodgeDecomposition[<|"Harmonic" -> KeyTake[harmonic, Union[Values[degrees]]],
			"Coexact" -> coexact, "Complex" -> complex|>]]]

FindHodgeDecomposition[model_SullivanModel] := FindHodgeDecomposition[CochainComplexWithPairing[model]]

FindHodgeDecomposition[model_SullivanModel, harmonic_Association] :=
	FindHodgeDecomposition[CochainComplexWithPairing[model], harmonic]

FindHodgeDecomposition[complex_CochainComplexWithPairing] := FindHodgeDecomposition[complex, FindHarmonicSubspace[complex]]

FindHodgeDecomposition[complex_CochainComplexWithPairing, harmonic_Association] /;
		AllTrue[Keys[harmonic], IntegerQ] && AllTrue[harmonic, ListQ] := With[
	{pre = FindPreHodgeDecomposition[complex, harmonic]},
	If[FailureQ[pre], pre, With[{twist = hodgeTwist[pre]},
		If[FailureQ[twist], twist,
			HodgeDecomposition[<|"Harmonic" -> pre["Harmonic"],
				"Coexact" -> Map[basis |-> Map[c |-> Expand[c + Lookup[twist, Key[c], 0]], basis], pre["Coexact"]],
				"Complex" -> complex|>]]]]]

Relations[PreHodgeDecomposition[data_Association]] /; And[
		SubsetQ[Keys[data], {"Harmonic", "Coexact", "Complex"}],
		AssociationQ[data["Harmonic"]] && AssociationQ[data["Coexact"]],
		AllTrue[Join[Values[data["Harmonic"]], Values[data["Coexact"]]], ListQ],
		AssociationQ[Relations[data["Complex"]]]] :=
	Join[Relations[data["Complex"]], <|"Harmonic" -> 0, "Coexact" -> 0, "Perpendicular" -> 0|>]

Relations[HodgeDecomposition[data_Association]] /; AssociationQ[Relations[PreHodgeDecomposition[data]]] :=
	Append[Relations[PreHodgeDecomposition[data]], "Isotropic" -> 0]

Obstruction[decomposition : (PreHodgeDecomposition | HodgeDecomposition)[_Association], relation_String,
		arguments_List] /; AssociationQ[Relations[decomposition]] && KeyExistsQ[Relations[decomposition["Complex"]], relation] :=
	With[{obstruction = Obstruction[decomposition["Complex"], relation, arguments]},
		obstruction /; Head[obstruction] =!= Obstruction]

Obstruction[decomposition : (PreHodgeDecomposition | HodgeDecomposition)[data_Association],
		relation : "Harmonic" | "Coexact" | "Perpendicular" | "Isotropic", {}] /;
		KeyExistsQ[Relations[decomposition], relation] := With[
	{complex = data["Complex"]},
	{degrees = complex["Degrees"], n = complex["Degree"], pairing = complex["Pairing"],
		variables = Variables[Keys[complex["Degrees"]]]},
	{labels = k |-> Keys[Select[degrees, EqualTo[k]]],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]],
		part = {key, k} |-> Lookup[data[key], k, {}]},
	{coordinates = {e, k} |-> Lookup[expansion[e], labels[k], 0],
		differential = e |-> Expand[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[e]]]],
		value = {e, f} |-> Total[KeyValueMap[
			{p, c} |-> c Total[KeyValueMap[{q, c2} |-> c2 Lookup[pairing, Key[{p, q}], 0], expansion[f]]],
			expansion[e]]],
		homogeneous = {e, k} |-> With[{terms = expansion[e]}, AllTrue[terms, NumericQ] && SubsetQ[labels[k], Keys[terms]]],
		rank = rows |-> If[rows === {} || First[rows] === {}, 0, MatrixRank[rows]]},
	{cocycles = k |-> Length[labels[k]] - rank[Map[p |-> coordinates[complex["Differential"][p], k + 1], labels[k]]]},
	{holds = k |-> Switch[relation,
		"Harmonic", With[
			{exact = Map[p |-> coordinates[complex["Differential"][p], k], labels[k - 1]], harmonic = part["Harmonic", k]},
			And[
				AllTrue[harmonic, h |-> homogeneous[h, k] && differential[h] === 0],
				rank[exact] + Length[harmonic] === cocycles[k],
				rank[Join[exact, Map[h |-> coordinates[h, k], harmonic]]] === cocycles[k]]],
		"Coexact", With[{coexact = part["Coexact", k]},
			And[
				AllTrue[coexact, c |-> homogeneous[c, k]],
				Length[coexact] === Length[labels[k]] - cocycles[k],
				rank[Map[c |-> coordinates[differential[c], k + 1], coexact]] === Length[coexact]]],
		"Perpendicular", AllTrue[Tuples[{part["Coexact", k], part["Harmonic", n - k]}], pair |-> value @@ pair == 0],
		"Isotropic", AllTrue[Tuples[{part["Coexact", k], part["Coexact", n - k]}], pair |-> value @@ pair == 0]]},
	{failed = Select[
		Union[Values[degrees], Keys[Select[data[If[relation === "Harmonic", "Harmonic", "Coexact"]], basis |-> basis =!= {}]]],
		k |-> ! holds[k]]},
	If[failed === {}, 0, failed]]

RelationsQ[decomposition : (PreHodgeDecomposition | HodgeDecomposition)[_Association]] /;
		AssociationQ[Relations[decomposition]] := With[
	{complex = RelationsQ[decomposition["Complex"]]},
	TrueQ[complex] && AllTrue[Keys[KeyDrop[Relations[decomposition], Keys[Relations[decomposition["Complex"]]]]],
		relation |-> Obstruction[decomposition, relation, {}] === 0] /; BooleanQ[complex]]

SpecialPropagator::usage = "SpecialPropagator[decomposition] gives the special propagator P of a HodgeDecomposition V = H + im d + C, with P(d c) = -c for c in C and P = 0 on H + C.\nSpecialPropagator[data] is a special propagator given by an Association data with the keys \"Images\" and \"Decomposition\".";

HarmonicProjection::usage = "HarmonicProjection[decomposition] gives the projection onto the harmonic subspace H of a HodgeDecomposition or a PreHodgeDecomposition V = H + im d + C along im d + C, as an Association from degrees to Associations from basis elements to their images.\nHarmonicProjection[propagator] gives the harmonic projection Id + d P + P d of a SpecialPropagator P.\nHarmonicProjection[e, decomposition] gives the harmonic projection of the element e.\nHarmonicProjection[e, propagator] gives the harmonic projection of the element e.";

SpecialPropagator[decomposition : HodgeDecomposition[data_Association]] /; AssociationQ[Relations[decomposition]] := With[
	{complex = data["Complex"]},
	{degrees = complex["Degrees"], variables = Variables[Keys[complex["Degrees"]]]},
	{labels = k |-> Keys[Select[degrees, EqualTo[k]]],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]],
		part = {key, k} |-> Lookup[data[key], k, {}]},
	{differential = e |-> Expand[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[e]]]]},
	{frames = AssociationMap[
		k |-> Join[part["Harmonic", k], Map[differential, part["Coexact", k - 1]], part["Coexact", k]],
		Union[Values[degrees]]]},
	{matrices = AssociationMap[k |-> Map[e |-> Lookup[expansion[e], labels[k], 0], frames[k]], Keys[frames]]},
	SpecialPropagator[<|
		"Images" -> AssociationMap[
			k |-> AssociationThread[labels[k], Expand[Inverse[matrices[k]] . Join[
				ConstantArray[0, Length[part["Harmonic", k]]], -part["Coexact", k - 1], ConstantArray[0, Length[part["Coexact", k]]]]]],
			Keys[frames]],
		"Decomposition" -> decomposition|>] /; AllTrue[Keys[frames], k |-> And[
			Length[frames[k]] === Length[labels[k]],
			AllTrue[frames[k], e |-> PolynomialQ[e, variables] && Expand[Lookup[expansion[e], labels[k], 0] . labels[k] - e] === 0],
			MatrixRank[matrices[k]] === Length[labels[k]]]]]

SpecialPropagator[data_Association][e : Except[_String]] /;
		AssociationQ[Relations[SpecialPropagator[data]]] && PolynomialQ[e, Variables[Keys[Association[Values[data["Images"]]]]]] := With[
	{images = Association[Values[data["Images"]]]},
	{variables = Variables[Keys[images]]},
	{expansion = Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[e, variables]]]},
	Expand[Total[KeyValueMap[{p, c} |-> c images[p], expansion]]] /; SubsetQ[Keys[images], Keys[expansion]]]

Relations[SpecialPropagator[data_Association]] /; And[
		SubsetQ[Keys[data], {"Images", "Decomposition"}],
		AssociationQ[data["Images"]] && AllTrue[data["Images"], AssociationQ],
		AssociationQ[Relations[data["Decomposition"]]]] := With[
	{degrees = data["Decomposition"]["Complex"]["Degrees"]},
	{variables = Variables[Keys[degrees]]},
	Join[<|"Chain" -> 0, "Projector" -> 0, "Square" -> 0, "Symmetry" -> 0|>, Relations[data["Decomposition"]]] /; And[
		Sort[Keys[Association[Values[data["Images"]]]]] === Sort[Keys[degrees]],
		AllTrue[Normal[data["Images"]], row |-> AllTrue[Normal[Last[row]], image |-> And[
			Lookup[degrees, Key[First[image]]] === First[row],
			PolynomialQ[Last[image], variables],
			AllTrue[CoefficientRules[Last[image], variables],
				rule |-> Lookup[degrees, Key[Times @@ (variables^First[rule])]] === First[row] - 1]]]]]]

Obstruction[propagator : SpecialPropagator[_Association], relation_String, arguments_List] /;
		AssociationQ[Relations[propagator]] && KeyExistsQ[Relations[propagator["Decomposition"]], relation] :=
	With[{obstruction = Obstruction[propagator["Decomposition"], relation, arguments]},
		obstruction /; Head[obstruction] =!= Obstruction]

Obstruction[propagator : SpecialPropagator[data_Association], relation : "Chain" | "Projector" | "Square" | "Symmetry", {}] /;
		AssociationQ[Relations[propagator]] := With[
	{complex = data["Decomposition"]["Complex"], images = Association[Values[data["Images"]]]},
	{degrees = complex["Degrees"], pairing = complex["Pairing"], variables = Variables[Keys[complex["Degrees"]]]},
	{expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
		CoefficientRules[e, variables]]]},
	{apply = e |-> Expand[Total[KeyValueMap[{p, c} |-> c images[p], expansion[e]]]],
		differential = e |-> Expand[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[e]]]],
		value = {e, f} |-> Total[KeyValueMap[
			{p, c} |-> c Total[KeyValueMap[{q, c2} |-> c2 Lookup[pairing, Key[{p, q}], 0], expansion[f]]],
			expansion[e]]]},
	{holds = v |-> Switch[relation,
		"Chain", Expand[differential[apply[differential[v]]] + differential[v]] === 0,
		"Projector", Expand[apply[differential[apply[v]]] + apply[v]] === 0,
		"Square", apply[apply[v]] === 0,
		"Symmetry", AllTrue[Keys[degrees], w |-> Expand[value[apply[v], w] - (-1)^degrees[v] value[v, apply[w]]] === 0]]},
	{failed = Union[Map[v |-> degrees[v], Select[Keys[degrees], v |-> ! holds[v]]]]},
	If[failed === {}, 0, failed]]

RelationsQ[propagator : SpecialPropagator[_Association]] /; AssociationQ[Relations[propagator]] := With[
	{decomposition = RelationsQ[propagator["Decomposition"]]},
	TrueQ[decomposition] && AllTrue[{"Chain", "Projector", "Square", "Symmetry"},
		relation |-> Obstruction[propagator, relation, {}] === 0] /; BooleanQ[decomposition]]

FindHodgeDecomposition[propagator : SpecialPropagator[data_Association]] /; AssociationQ[Relations[propagator]] := With[
	{complex = data["Decomposition"]["Complex"], projection = HarmonicProjection[propagator]},
	{degrees = complex["Degrees"], variables = Variables[Keys[complex["Degrees"]]]},
	{labels = k |-> Keys[Select[degrees, EqualTo[k]]],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]]},
	{independent = {elements, k} |-> elements[[Fold[
		{chosen, i} |-> If[MatrixRank[Map[e |-> Lookup[expansion[e], labels[k], 0], elements[[Append[chosen, i]]]]] > Length[chosen],
			Append[chosen, i], chosen],
		{}, Range[Length[elements]]]]]},
	HodgeDecomposition[<|
		"Harmonic" -> AssociationMap[k |-> independent[Values[Lookup[projection, k, <||>]], k], Union[Values[degrees]]],
		"Coexact" -> AssociationMap[k |-> independent[Expand[-Values[Lookup[data["Images"], k + 1, <||>]]], k], Union[Values[degrees]]],
		"Complex" -> complex|>]]

HarmonicProjection[decomposition : (PreHodgeDecomposition | HodgeDecomposition)[data_Association]] /;
		AssociationQ[Relations[decomposition]] := With[
	{complex = data["Complex"]},
	{degrees = complex["Degrees"], variables = Variables[Keys[complex["Degrees"]]]},
	{labels = k |-> Keys[Select[degrees, EqualTo[k]]],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]],
		part = {key, k} |-> Lookup[data[key], k, {}]},
	{differential = e |-> Expand[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[e]]]]},
	{frames = AssociationMap[
		k |-> Join[part["Harmonic", k], Map[differential, part["Coexact", k - 1]], part["Coexact", k]],
		Union[Values[degrees]]]},
	{matrices = AssociationMap[k |-> Map[e |-> Lookup[expansion[e], labels[k], 0], frames[k]], Keys[frames]]},
	AssociationMap[
		k |-> AssociationThread[labels[k], Expand[Inverse[matrices[k]] . Join[
			part["Harmonic", k], ConstantArray[0, Length[part["Coexact", k - 1]] + Length[part["Coexact", k]]]]]],
		Keys[frames]] /; AllTrue[Keys[frames], k |-> And[
			Length[frames[k]] === Length[labels[k]],
			AllTrue[frames[k], e |-> PolynomialQ[e, variables] && Expand[Lookup[expansion[e], labels[k], 0] . labels[k] - e] === 0],
			MatrixRank[matrices[k]] === Length[labels[k]]]]]

HarmonicProjection[propagator : SpecialPropagator[data_Association]] /; AssociationQ[Relations[propagator]] := With[
	{complex = data["Decomposition"]["Complex"], images = Association[Values[data["Images"]]]},
	{variables = Variables[Keys[complex["Degrees"]]]},
	{expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
		CoefficientRules[e, variables]]]},
	{apply = e |-> Expand[Total[KeyValueMap[{p, c} |-> c images[p], expansion[e]]]],
		differential = e |-> Expand[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[e]]]]},
	Map[row |-> Association[KeyValueMap[{e, image} |-> e -> Expand[e + differential[image] + apply[complex["Differential"][e]]], row]],
		data["Images"]]]

HarmonicProjection[e_, structure : (PreHodgeDecomposition | HodgeDecomposition | SpecialPropagator)[_Association]] := With[
	{projection = HarmonicProjection[structure]},
	{images = If[AssociationQ[projection], Association[Values[projection]], <||>]},
	{variables = Variables[Keys[images]]},
	{expansion = If[PolynomialQ[e, variables],
		Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[e, variables]]], None]},
	Expand[Total[KeyValueMap[{p, c} |-> c images[p], expansion]]] /;
		AssociationQ[projection] && AssociationQ[expansion] && SubsetQ[Keys[images], Keys[expansion]]]

HodgeExtension::usage = "HodgeExtension[space, k] gives the extension of a SullivanModel or a CochainComplexWithPairing of degree n by an acyclic pair x, y = d x of degrees k-1 and k for each basis element c of its coexact part of degree n-k, with <y, c> = 1, which retracts onto space.\nHodgeExtension[space] gives an extension of Hodge type that retracts onto space: the step in the middle degree when n is even and that degree has no Hodge decomposition, then the steps in the degrees Floor[n/2] + 1 to n - 1.";

HodgeExtension[space : _SullivanModel | _CochainComplexWithPairing, k_Integer] /; And[
		IntegerQ[space["Degree"]], 2 <= k <= space["Degree"] <= 2 k,
		Head[space] === SullivanModel || ! KeyExistsQ[space, "Product"] || KeyExistsQ[space["Degrees"], 1]] := With[
	{n = space["Degree"], pre = FindPreHodgeDecomposition[space]},
	{twist = If[FailureQ[pre] || 2 k =!= n + 2, <||>,
		hodgeTwist[PreHodgeDecomposition[Append[Normal[pre], "Coexact" -> KeyTake[pre["Coexact"], {k - 1}]]]]]},
	Which[
		FailureQ[pre], pre,
		FailureQ[twist], twist,
		True, With[
			{complex = pre["Complex"]},
			{degrees = complex["Degrees"], pairing = complex["Pairing"], product = Lookup[complex, "Product", None],
				variables = Variables[Keys[complex["Degrees"]]]},
			{labels = j |-> Keys[Select[degrees, EqualTo[j]]],
				expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
					CoefficientRules[e, variables]]]},
			{coordinates = {e, j} |-> Lookup[expansion[e], labels[j], 0],
				differential = e |-> Expand[Total[KeyValueMap[{p, c} |-> c complex["Differential"][p], expansion[e]]]],
				value = {e, f} |-> Total[KeyValueMap[
					{p, c} |-> c Total[KeyValueMap[{q, c2} |-> c2 Lookup[pairing, Key[{p, q}], 0], expansion[f]]],
					expansion[e]]],
				times = {e, f} |-> Expand[Total[KeyValueMap[
					{p, c} |-> c Total[KeyValueMap[{q, c2} |-> c2 Lookup[product, Key[{p, q}], 0], expansion[f]]],
					expansion[e]]]]},
			{independent = elements |-> Fold[
				{chosen, e} |-> If[labels[k + 2] =!= {} &&
						MatrixRank[Map[c |-> coordinates[differential[c], k + 2], Append[chosen, e]]] > Length[chosen],
					Append[chosen, e], chosen],
				{}, elements],
				adjoined = If[2 k =!= n || product === None, {},
					DeleteCases[Expand[Flatten[Outer[times, labels[1], pre["Harmonic", k]]]], 0]]},
			{span = If[adjoined === {}, {},
				Map[z |-> z . labels[k + 1], DeleteCases[RowReduce[Map[e |-> coordinates[e, k + 1], adjoined]], {0 ...}]]]},
			{coexact = j |-> Which[
					2 k === n + 2 && j === k - 1, Map[c |-> Expand[c + Lookup[twist, Key[c], 0]], pre["Coexact", j]],
					2 k === n && j === k + 1, independent[Join[span, pre["Coexact", j]]],
					True, pre["Coexact", j]],
				count = Length[pre["Coexact", n - k]],
				offset = Max[0, Cases[variables, (\[FormalX] | \[FormalY])[j_Integer] :> j]]},
			{frame = j |-> Join[pre["Harmonic", j], Map[differential, coexact[j - 1]], coexact[j]],
				xs = Map[j |-> \[FormalX][offset + j], Range[count]],
				ys = Map[j |-> \[FormalY][offset + j], Range[count]]},
			{upper = If[labels[n - k + 1] === {}, {},
					(-1)^k Inverse[Map[e |-> coordinates[e, n - k + 1], frame[n - k + 1]]][[All,
						Length[pre["Harmonic", n - k + 1]] + Range[count]]]],
				lower = If[labels[n - k] === {}, {},
					Inverse[Map[e |-> coordinates[e, n - k], frame[n - k]]][[All,
						Length[pre["Harmonic", n - k]] + Length[coexact[n - k - 1]] + Range[count]]]],
				generators = Association[Catenate[Map[j |-> {xs[[j]] -> k - 1, ys[[j]] -> k}, Range[count]]]],
				pairs = Association[Catenate[Map[j |-> {xs[[j]] -> ys[[j]], ys[[j]] -> 0}, Range[count]]]]},
			{values = Association[Catenate[Map[
				j |-> Join[
					MapThread[{v, o} |-> {xs[[j]], v} -> o, {labels[n - k + 1], If[upper === {}, {}, upper[[All, j]]]}],
					MapThread[{v, o} |-> {ys[[j]], v} -> o, {labels[n - k], If[lower === {}, {}, lower[[All, j]]]}]],
				Range[count]]]]},
			Which[
				Length[span] =!= Length[independent[span]] ||
						! AllTrue[Tuples[{span, pre["Harmonic", k - 1]}], pair |-> value @@ pair === 0],
					Failure["HodgeExtension", <|"MessageTemplate" -> "No coexact part of degree " <> ToString[k + 1] <>
						" contains the products of the elements of degree 1 with the harmonic subspace of degree " <>
						ToString[k] <> ", so the extension in the middle degree does not apply.", "Degrees" -> {k}|>],
				count === 0, space,
				Head[space] === SullivanModel, SullivanModel[<|
					"Generators" -> Join[space["Generators"], generators],
					"Differential" -> Join[space["Differential"], pairs],
					"Orientation" -> DeleteCases[Join[space["Orientation"], Association[KeyValueMap[
						{pair, o} |-> Times @@ pair -> (-1)^(generators[First[pair]] degrees[Last[pair]]) o, values]]], 0],
					"Degree" -> n,
					"Truncation" -> space["Truncation"]|>],
				product === None, CochainComplexWithPairing[Join[degrees, generators], Join[complex["Differential"], pairs],
					Join[pairing, values]],
				True, With[
					{lambda = SullivanModel[<|"Generators" -> generators, "Differential" -> pairs, "Orientation" -> <||>,
						"Degree" -> n, "Truncation" -> <||>|>],
						all = Join[variables, Keys[generators]]},
					{weight = g |-> Exponent[g, Keys[generators]] . Values[generators]},
					{pieces = Association[Catenate[Map[
						j |-> Catenate[Map[e |-> Map[g |-> e g -> {e, g}, SullivanModelBasis[lambda, j - degrees[e]]], Keys[degrees]]],
						Range[0, n + 2]]]]},
					{grade = Map[piece |-> degrees[First[piece]] + weight[Last[piece]], pieces],
						split = e |-> Association[Map[rule |-> Times @@ (all^First[rule]) -> Last[rule], CoefficientRules[e, all]]]},
					{tensorTimes = {u, w} |-> Expand[(-1)^(weight[Last[pieces[u]]] degrees[First[pieces[w]]]) Times[
							Lookup[product, Key[{First[pieces[u]], First[pieces[w]]}], 0],
							SullivanModelProduct[Last[pieces[u]], Last[pieces[w]], lambda]]],
						tensorDifferential = u |-> Expand[complex["Differential"][First[pieces[u]]] Last[pieces[u]] +
							(-1)^degrees[First[pieces[u]]] First[pieces[u]] SullivanModelDifferential[Last[pieces[u]], lambda]],
						top = Keys[Select[grade, EqualTo[n + 2]]]},
					{images = Map[u |-> Lookup[split[tensorDifferential[u]], top, 0], Keys[Select[grade, EqualTo[n + 1]]]]},
					{kept = Join[Keys[Select[grade, g |-> g <= n + 1]], If[top === {} || images === {}, {},
						top[[Fold[
							{chosen, column} |-> If[MatrixRank[images[[All, Append[chosen, column]]]] > Length[chosen],
								Append[chosen, column], chosen],
							{}, Range[Length[top]]]]]]]},
					{reduce = e |-> Expand[Total[KeyValueMap[{u, c} |-> If[MemberQ[kept, u], c u, 0], split[e]]]],
						orientation = u |-> With[{e = First[pieces[u]], g = Last[pieces[u]]},
							Which[
								g === 1, Lookup[pairing, Key[{1, e}], 0],
								KeyExistsQ[generators, g], (-1)^(generators[g] degrees[e]) Lookup[values, Key[{g, e}], 0],
								True, 0]]},
					CochainComplexWithPairing[<|
						"Degrees" -> KeyTake[grade, kept],
						"Differential" -> AssociationMap[u |-> reduce[tensorDifferential[u]], kept],
						"Pairing" -> DeleteCases[Association[Map[
							pair |-> pair -> Total[KeyValueMap[{u, c} |-> c orientation[u], split[tensorTimes @@ pair]]],
							Select[Tuples[kept, 2], pair |-> Total[Lookup[grade, pair]] === n]]], 0],
						"Degree" -> n,
						"Product" -> DeleteCases[Association[Map[
							pair |-> pair -> reduce[tensorTimes @@ pair],
							Select[Tuples[kept, 2], pair |-> Total[Lookup[grade, pair]] <= n + 2]]], 0]|>]]]]]]

HodgeExtension[space : _SullivanModel | _CochainComplexWithPairing] /; IntegerQ[space["Degree"]] := With[
	{n = space["Degree"], pre = FindPreHodgeDecomposition[space]},
	{middle = If[FailureQ[pre] || OddQ[n], <||>,
		hodgeTwist[PreHodgeDecomposition[Append[Normal[pre], "Coexact" -> KeyTake[pre["Coexact"], {n/2}]]]]]},
	Which[
		FailureQ[pre], pre,
		FailureQ[middle] && n < 4, middle,
		True, Fold[
			{extension, k} |-> If[FailureQ[extension], extension, HodgeExtension[extension, k]],
			If[FailureQ[middle], HodgeExtension[space, n/2], space],
			Range[Floor[n/2] + 1, n - 1]]]]

hodgeTwist[pre_PreHodgeDecomposition] := With[
	{complex = pre["Complex"], coexact = pre["Coexact"]},
	{degrees = complex["Degrees"], n = complex["Degree"], pairing = complex["Pairing"],
		variables = Variables[Keys[complex["Degrees"]]]},
	{labels = j |-> Keys[Select[degrees, EqualTo[j]]],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]]},
	{value = {e, f} |-> Total[KeyValueMap[
			{p, c} |-> c Total[KeyValueMap[{q, c2} |-> c2 Lookup[pairing, Key[{p, q}], 0], expansion[f]]],
			expansion[e]]],
		exact = j |-> With[{basis = labels[j], images = DeleteCases[Map[p |-> complex["Differential"][p], labels[j - 1]], 0]},
			If[images === {}, {}, Map[v |-> v . basis,
				DeleteCases[RowReduce[Map[e |-> Lookup[expansion[e], basis, 0], images]], {0 ...}]]]]},
	{solutions = Map[
		i |-> With[{c = coexact[i], dual = Lookup[coexact, n - i, {}], b = exact[i]},
			{p = Map[e |-> Map[f |-> value[e, f], dual], b], q = Map[e |-> Map[f |-> value[e, f], dual], c],
				pt = Map[e |-> Map[f |-> value[e, f], b], c]},
			{twist = If[2 i === n, r |-> r . p + Transpose[r . Transpose[pt]], r |-> r . p]},
			Which[
				dual === {}, {},
				b === {}, If[Union[Flatten[q]] === {0}, {}, {n - i, i}],
				True, With[
					{matrix = Transpose[Map[unit |-> Flatten[twist[ArrayReshape[unit, {Length[c], Length[b]}]]],
						IdentityMatrix[Length[c] Length[b]]]], rhs = -Flatten[q]},
					If[MatrixRank[matrix] =!= MatrixRank[Append[Transpose[matrix], rhs]], {n - i, i},
						Thread[c -> Expand[ArrayReshape[LinearSolve[matrix, rhs], {Length[c], Length[b]}] . b]]]]]],
		Select[Range[Ceiling[n/2], n], i |-> Lookup[coexact, i, {}] =!= {}]]},
	{failed = Union[Flatten[Cases[solutions, {_Integer, _Integer}]]]},
	If[failed =!= {},
		Failure["FindHodgeDecomposition", <|"MessageTemplate" ->
			"The twist condition has no solution in degrees " <> ToString[failed] <>
				", so there is no Hodge decomposition with this harmonic subspace.",
			"Degrees" -> failed|>],
		DeleteCases[Association[Catenate[solutions]], 0]]]
