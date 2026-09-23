GradedPairing::usage = "GradedPairing[degrees, spec] builds the pairing object of a graded alphabet. degrees is an Association from particles to their degrees; spec is either a function of two particles or an Association giving some of the values, which are completed by graded antisymmetry. The object carries the keys \"Degrees\", \"Values\", \"Degree\" (the degree of the pairing, n - 2 for a Poincare duality algebra of degree n) and \"Convention\" (\"Symmetric\" by default, \"Exterior\" to work in the exterior picture); Append[pairing, \"Convention\" -> \"Exterior\"] switches it. GradedPairing[degrees, spec, dualDegrees, evaluation] also carries a dual alphabet under the key \"Dual\", which DualPairing and ProductPairing need. GradedPairing[algebra] builds the alphabet of a PoincareDualityAlgebra.";

CyclicWord::usage = "CyclicWord[w] is a cyclic word, w being the list of its particles; CyclicWord[{}] is the empty word. CyclicWord[w, pairing] returns the canonical rotation of the word with its Koszul sign, or 0 if a rotation sends the word to minus itself; pairing may also be an Association from particles to degrees. CyclicWord[{}, pairing] is 0 in the positive-length convention of the paper, and the empty word with the option \"EmptyWord\" -> True.";

CyclicWords::usage = "CyclicWords[n, pairing] lists the nonzero cyclic words of length n over the alphabet of pairing, each in its canonical rotation; pairing may also be an Association from particles to degrees. CyclicWords[n, pairing, \"UpTo\" -> True] gives every length up to n. With \"EmptyWord\" -> True the empty word counts as the one word of length 0.";

WordDegree::usage = "WordDegree[w, pairing] is the degree of a cyclic word, the sum of the degrees of its particles; w is a CyclicWord or the list of its particles, and pairing may also be an Association from particles to degrees. WordDegree[w, pairing, \"Exterior\"] adds the degree of the pairing and is the grading of ExteriorProduct; WordDegree[w, pairing, \"Symmetric\"] subtracts a further 1 and is the grading of SymmetricProduct. The empty word has degree 0.";

KoszulSign::usage = "KoszulSign[perm, degrees, parity] is the sign of bringing a list of graded objects into the order perm: every pair of objects that crosses contributes the product of their degrees plus parity to the exponent of -1. Parity 0 is the graded symmetric sign, parity 1 the graded antisymmetric one.";

ExteriorProduct::usage = "ExteriorProduct[u, v, ..., pairing] is the graded exterior product of cyclic words, graded by WordDegree[w, pairing, \"Exterior\"]. The factors are brought into canonical rotation and canonical order with the Koszul signs of that grading, a repeated factor of even degree gives 0, and a single factor is the word itself. The result ExteriorProduct[u, v, ...] carries only its factors. The product is linear in every factor, and a factor may be given as the list of its particles.";

SymmetricProduct::usage = "SymmetricProduct[u, v, ..., pairing] is the graded symmetric product of cyclic words, graded by WordDegree[w, pairing, \"Symmetric\"]. The factors are brought into canonical rotation and canonical order with the Koszul signs of that grading, a repeated factor of odd degree gives 0, and a single factor is the word itself. The result SymmetricProduct[u, v, ...] carries only its factors. The product is linear in every factor, and a factor may be given as the list of its particles.";

Options[CyclicWord] = {"EmptyWord" -> False}

Options[CyclicWords] = {"UpTo" -> False, "EmptyWord" -> False}

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

CyclicWord[w_List, data : _GradedPairing | _Association, opts : OptionsPattern[]] := With[
	{rotations = NestList[
		Apply[{sign, u} |-> {(-1)^(WordDegree[Take[u, 1], data] WordDegree[Drop[u, 1], data]) sign, RotateLeft[u]}],
		{1, w}, Length[w]]},
	Which[
		w === {}, If[TrueQ[OptionValue[CyclicWord, {opts}, "EmptyWord"]], CyclicWord[{}], 0],
		First[SelectFirst[Rest[rotations], rotation |-> Last[rotation] === w]] === -1, 0,
		True, With[{canonical = First[SortBy[Most[rotations], Last]]},
			First[canonical] CyclicWord[Last[canonical]]]]]

CyclicWords[n_Integer, data : _GradedPairing | _Association, opts : OptionsPattern[]] /;
	TrueQ[OptionValue[CyclicWords, {opts}, "UpTo"]] :=
	Join @@ Table[CyclicWords[k, data, "UpTo" -> False, opts], {k, 0, n}]

CyclicWords[n_Integer?NonNegative, data : _GradedPairing | _Association, opts : OptionsPattern[]] := DeleteCases[
	DeleteDuplicates[Map[
		w |-> Replace[CyclicWord[w, data, FilterRules[{opts}, Options[CyclicWord]]], Times[sign_., u_CyclicWord] :> u],
		Tuples[Keys[If[MatchQ[data, _GradedPairing], data["Degrees"], data]], n]]],
	0]

WordDegree[CyclicWord[w_List], data : _GradedPairing | _Association, rest___] := WordDegree[w, data, rest]

WordDegree[w_List, pairing_GradedPairing] := With[
	{degrees = Lookup[Join[pairing["Degrees"], Lookup[Lookup[pairing, "Dual", <||>], "Degrees", <||>]], w]},
	Total[degrees] /; FreeQ[degrees, _Missing]]

WordDegree[w_List, degrees_Association] := With[{letterDegrees = Lookup[degrees, w]},
	Total[letterDegrees] /; FreeQ[letterDegrees, _Missing]]

WordDegree[w_List, pairing_GradedPairing, "Exterior"] := WordDegree[w, pairing] + pairing["Degree"]

WordDegree[w_List, pairing_GradedPairing, "Symmetric"] := WordDegree[w, pairing] + pairing["Degree"] - 1

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
	{degrees = Map[f |-> WordDegree[f, pairing, "Exterior"], {factors}]},
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
	{degrees = Map[f |-> WordDegree[f, pairing, "Symmetric"], {factors}]},
	{ordering = Ordering[{factors}]},
	Which[
		! DuplicateFreeQ[Pick[{factors}, OddQ /@ degrees]], 0,
		Length[{factors}] === 1, First[{factors}],
		True, KoszulSign[ordering, degrees, 0] SymmetricProduct @@ {factors}[[ordering]]]]
