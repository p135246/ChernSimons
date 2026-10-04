PackageExported[GradedPairing]
PackageExported[CyclicWord]
PackageExported[GenerateCyclicWords]
PackageExported[ElementDegree]
PackageExported[KoszulSign]
PackageExported[ExteriorProduct]
PackageExported[SymmetricProduct]

GradedPairing::usage = "GradedPairing[degrees, spec] gives the pairing object of the graded alphabet with the Association degrees of letters to their degrees and the pairing values spec, a function of two letters or an Association of some of the values.\nGradedPairing[degrees, spec, dual, evaluation] also carries the dual alphabet, the Association dual of dual letters to their degrees and the Association evaluation of the values of letters on dual letters.\nGradedPairing[algebra] gives the pairing object of the PoincareDualityAlgebra algebra, with its basis monomials as letters.\nGradedPairing[algebra, letters] gives the pairing object of algebra, with the list letters naming its basis.";

CyclicWord::usage = "CyclicWord[w] is the cyclic word whose letters are the list w.\nCyclicWord[w, pairing] gives the canonical rotation of w times its Koszul sign, or 0 when a rotation sends w to minus itself.\nThe option \"EmptyWord\" -> True makes CyclicWord[{}, pairing] the empty word rather than 0.";

GenerateCyclicWords::usage = "GenerateCyclicWords[n, pairing] gives the nonzero cyclic words of length n over the alphabet of pairing, each in its canonical rotation.\nThe option \"UpTo\" -> True gives every length up to n, and the option \"EmptyWord\" -> True counts the empty word as the word of length 0.";

ElementDegree::usage = "ElementDegree[x, pairing, \"Bar\"] gives the bar degree of x, the sum of the degrees of its letters.\nElementDegree[x, pairing, \"Exterior\"] gives the exterior degree of x, the bar degree plus the degree of the pairing, the grading of ExteriorProduct.\nElementDegree[x, pairing, \"Symmetric\"] gives the symmetric degree of x, the exterior degree minus 1, the grading of SymmetricProduct.";

KoszulSign::usage = "KoszulSign[perm, degrees, parity] gives the sign of bringing objects of the given degrees into the order perm, each pair that crosses contributing the product of their degrees plus parity to the exponent of -1.";

ExteriorProduct::usage = "ExteriorProduct[u, v, ..., pairing] gives the graded exterior product of the cyclic words u, v, ..., in canonical order with the Koszul sign of the exterior grading.";

SymmetricProduct::usage = "SymmetricProduct[u, v, ..., pairing] gives the graded symmetric product of the cyclic words u, v, ..., in canonical order with the Koszul sign of the symmetric grading.";

Options[CyclicWord] = {"EmptyWord" -> False}

Options[GenerateCyclicWords] = {"UpTo" -> False, "EmptyWord" -> False}

GradedPairing[degrees_Association, spec_Association] := With[
	{values = Association[Map[
		pair |-> pair -> Which[
			KeyExistsQ[spec, pair], spec[pair],
			KeyExistsQ[spec, Reverse[pair]], (-1)^(1 + Times @@ Lookup[degrees, pair]) spec[Reverse[pair]],
			True, 0],
		Tuples[Keys[degrees], 2]]]},
	{pairingDegrees = DeleteDuplicates[Map[pair |-> Total[Lookup[degrees, pair]], Keys[DeleteCases[values, 0]]]]},
	If[Length[pairingDegrees] === 1,
		GradedPairing[<|"Degrees" -> degrees, "Values" -> values, "Degree" -> First[pairingDegrees],
			"Convention" -> "Symmetric"|>],
		Failure["GradedPairing", <|"MessageTemplate" -> "The pairing has no well-defined degree.",
			"Degrees" -> pairingDegrees|>]]]

GradedPairing[degrees_Association, spec_] /; ! AssociationQ[spec] :=
	GradedPairing[degrees, Association[Map[pair |-> pair -> spec @@ pair, Tuples[Keys[degrees], 2]]]]

GradedPairing[degrees_Association, spec_, dualDegrees_Association, evaluation_Association] := With[
	{pairing = GradedPairing[degrees, spec]},
	Append[pairing, "Dual" -> <|"Degrees" -> dualDegrees, "Values" -> evaluation|>] /; MatchQ[pairing, _GradedPairing]]

GradedPairing[algebra_PoincareDualityAlgebra] /; ListQ[algebra["Basis"]] := GradedPairing[algebra, algebra["Basis"]]

GradedPairing[algebra_PoincareDualityAlgebra, letters_List] /; And[
		ListQ[algebra["Basis"]], VectorQ[algebra["Degrees"], IntegerQ], MatrixQ[algebra["Pairing"]],
		Length[letters] === Length[algebra["Basis"]] === Length[algebra["Degrees"]] === Length[algebra["Pairing"]]] := With[
	{pairing = GradedPairing[
		AssociationThread[letters -> algebra["Degrees"] - 1],
		Association[Catenate[Table[
			{letters[[i]], letters[[j]]} -> (-1)^algebra["Degrees"][[i]] algebra["Pairing"][[i, j]],
			{i, Length[letters]}, {j, Length[letters]}]]]]},
	Append[pairing, "Algebra" -> Normal[algebra]] /; MatchQ[pairing, _GradedPairing]]

CyclicWord[w_List, data : _GradedPairing | _Association, opts : OptionsPattern[]] := With[
	{rotations = NestList[
		Apply[{sign, u} |-> {(-1)^(ElementDegree[Take[u, 1], data, "Bar"] ElementDegree[Drop[u, 1], data, "Bar"]) sign, RotateLeft[u]}],
		{1, w}, Length[w]]},
	Which[
		w === {}, If[TrueQ[OptionValue[CyclicWord, {opts}, "EmptyWord"]], CyclicWord[{}], 0],
		First[SelectFirst[Rest[rotations], rotation |-> Last[rotation] === w]] === -1, 0,
		True, With[{canonical = First[SortBy[Most[rotations], Last]]},
			First[canonical] CyclicWord[Last[canonical]]]]]

GenerateCyclicWords[n_Integer, data : _GradedPairing | _Association, opts : OptionsPattern[]] /;
	TrueQ[OptionValue[GenerateCyclicWords, {opts}, "UpTo"]] :=
	Join @@ Table[GenerateCyclicWords[k, data, "UpTo" -> False, opts], {k, 0, n}]

GenerateCyclicWords[n_Integer?NonNegative, data : _GradedPairing | _Association, opts : OptionsPattern[]] := DeleteCases[
	DeleteDuplicates[Map[
		w |-> Replace[CyclicWord[w, data, FilterRules[{opts}, Options[CyclicWord]]], Times[sign_., u_CyclicWord] :> u],
		Tuples[Keys[If[MatchQ[data, _GradedPairing], data["Degrees"], data]], n]]],
	0]

ElementDegree[w_List, pairing_GradedPairing, grading : "Bar" | "Exterior" | "Symmetric"] := With[
	{degrees = Lookup[Join[pairing["Degrees"], Lookup[Lookup[pairing, "Dual", <||>], "Degrees", <||>]], w]},
	Total[degrees] + Switch[grading, "Bar", 0, "Exterior", pairing["Degree"], "Symmetric", pairing["Degree"] - 1] /;
		FreeQ[degrees, _Missing]]

ElementDegree[w_List, degrees_Association, "Bar"] := With[{particleDegrees = Lookup[degrees, w]},
	Total[particleDegrees] /; FreeQ[particleDegrees, _Missing]]

ElementDegree[p_, data : _GradedPairing | _Association, grading : "Bar" | "Exterior" | "Symmetric"] /; KeyExistsQ[
	If[AssociationQ[data], data, Join[data["Degrees"], Lookup[Lookup[data, "Dual", <||>], "Degrees", <||>]]], p] := With[
	{degree = ElementDegree[{p}, data, grading]},
	degree /; ! MatchQ[degree, _ElementDegree]]

ElementDegree[CyclicWord[w_List], data : _GradedPairing | _Association, grading : "Bar" | "Exterior" | "Symmetric"] := With[
	{degree = ElementDegree[w, data, grading]},
	degree /; ! MatchQ[degree, _ElementDegree]]

ElementDegree[(ExteriorProduct | SymmetricProduct)[factors__CyclicWord], data : _GradedPairing | _Association,
	grading : "Bar" | "Exterior" | "Symmetric"] := With[
	{degrees = Map[f |-> ElementDegree[f, data, grading], {factors}]},
	Total[degrees] /; FreeQ[degrees, ElementDegree]]

ElementDegree[HBar, pairing_GradedPairing, "Symmetric"] := 2 (pairing["Degree"] - 1)

ElementDegree[HBar^g_Integer, pairing_GradedPairing, "Symmetric"] := 2 g (pairing["Degree"] - 1)

ElementDegree[Times[h : HBar | HBar^_Integer, e_], pairing_GradedPairing, "Symmetric"] /; FreeQ[e, HBar] := With[
	{degree = ElementDegree[e, pairing, "Symmetric"]},
	ElementDegree[h, pairing, "Symmetric"] + degree /; ! MatchQ[degree, _ElementDegree]]

ElementDegree[Times[scalar_, e : _CyclicWord | _ExteriorProduct | _SymmetricProduct | HBar | HBar^_Integer],
	data : _GradedPairing | _Association, grading : "Bar" | "Exterior" | "Symmetric"] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct | HBar] := With[
	{degree = ElementDegree[e, data, grading]},
	degree /; ! MatchQ[degree, _ElementDegree]]

ElementDegree[Times[scalar_, p_], data : _GradedPairing | _Association, grading : "Bar" | "Exterior" | "Symmetric"] /; With[
	{degrees = If[AssociationQ[data], data, Join[data["Degrees"], Lookup[Lookup[data, "Dual", <||>], "Degrees", <||>]]]},
	KeyExistsQ[degrees, p] && FreeQ[scalar, Alternatives @@ Join[{CyclicWord, ExteriorProduct, SymmetricProduct, HBar}, Keys[degrees]]]] := With[
	{degree = ElementDegree[p, data, grading]},
	degree /; ! MatchQ[degree, _ElementDegree]]

ElementDegree[sum_Plus, data : _GradedPairing | _Association, grading : "Bar" | "Exterior" | "Symmetric"] := With[
	{degrees = Map[term |-> ElementDegree[term, data, grading], List @@ sum]},
	First[degrees] /; FreeQ[degrees, ElementDegree] && SameQ @@ degrees]

KoszulSign[perm_List, degrees_List, parity_Integer] := (-1)^Total[Map[
	pair |-> parity + degrees[[perm[[First[pair]]]]] degrees[[perm[[Last[pair]]]]],
	Select[Subsets[Range[Length[perm]], {2}], pair |-> perm[[First[pair]]] > perm[[Last[pair]]]]]]

ExteriorProduct[before___, 0, after___, pairing_GradedPairing] := 0

ExteriorProduct[before___, sum_Plus, after___, pairing_GradedPairing] :=
	Map[term |-> ExteriorProduct[before, term, after, pairing], sum]

ExteriorProduct[before___, Times[scalar_, e_], after___, pairing_GradedPairing] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar ExteriorProduct[before, e, after, pairing]

ExteriorProduct[before___, w_List, after___, pairing_GradedPairing] :=
	ExteriorProduct[before, CyclicWord[w, pairing, "EmptyWord" -> True], after, pairing]

ExteriorProduct[before___, ExteriorProduct[inner__], after___, pairing_GradedPairing] :=
	ExteriorProduct[before, inner, after, pairing]

ExteriorProduct[factors__CyclicWord, pairing_GradedPairing] := With[
	{canonical = Map[f |-> CyclicWord[First[f], pairing, "EmptyWord" -> True], {factors}]},
	ExteriorProduct[Sequence @@ canonical, pairing] /; canonical =!= {factors}]

ExteriorProduct[factors__CyclicWord, pairing_GradedPairing] := With[
	{degrees = Map[f |-> ElementDegree[f, pairing, "Exterior"], {factors}]},
	{ordering = Ordering[{factors}]},
	Which[
		! DuplicateFreeQ[Pick[{factors}, EvenQ /@ degrees]], 0,
		Length[{factors}] === 1, First[{factors}],
		True, KoszulSign[ordering, degrees, 1] ExteriorProduct @@ {factors}[[ordering]]]]

SymmetricProduct[before___, 0, after___, pairing_GradedPairing] := 0

SymmetricProduct[before___, sum_Plus, after___, pairing_GradedPairing] :=
	Map[term |-> SymmetricProduct[before, term, after, pairing], sum]

SymmetricProduct[before___, Times[scalar_, e_], after___, pairing_GradedPairing] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar SymmetricProduct[before, e, after, pairing]

SymmetricProduct[before___, w_List, after___, pairing_GradedPairing] :=
	SymmetricProduct[before, CyclicWord[w, pairing, "EmptyWord" -> True], after, pairing]

SymmetricProduct[before___, SymmetricProduct[inner__], after___, pairing_GradedPairing] :=
	SymmetricProduct[before, inner, after, pairing]

SymmetricProduct[factors__CyclicWord, pairing_GradedPairing] := With[
	{canonical = Map[f |-> CyclicWord[First[f], pairing, "EmptyWord" -> True], {factors}]},
	SymmetricProduct[Sequence @@ canonical, pairing] /; canonical =!= {factors}]

SymmetricProduct[factors__CyclicWord, pairing_GradedPairing] := With[
	{degrees = Map[f |-> ElementDegree[f, pairing, "Symmetric"], {factors}]},
	{ordering = Ordering[{factors}]},
	Which[
		! DuplicateFreeQ[Pick[{factors}, OddQ /@ degrees]], 0,
		Length[{factors}] === 1, First[{factors}],
		True, KoszulSign[ordering, degrees, 0] SymmetricProduct @@ {factors}[[ordering]]]]
