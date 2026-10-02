PackageExported[CanonicalLieBialgebra]

CanonicalLieBialgebra::usage = "CanonicalLieBialgebra[pairing] is the canonical differential involutive Lie bialgebra of cyclic words over the alphabet of pairing, with the operations CanonicalLieBracket, CanonicalLieCobracket and CyclicHochschildDifferential.\nThe option \"EmptyWord\" -> True gives its extension by the empty word, in which every operation computes with that option.";

Options[CanonicalLieBialgebra] = {"EmptyWord" -> False}

CanonicalLieBialgebra[pairing_GradedPairing, opts : OptionsPattern[]] := With[{emptyWord = OptionValue["EmptyWord"]},
	CanonicalLieBialgebra[<|"Pairing" -> pairing, "EmptyWord" -> emptyWord|>] /; BooleanQ[emptyWord]]

Relations[CanonicalLieBialgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ]] := <|"Jacobi" -> 3, "CoJacobi" -> 1, "Drinfeld" -> 2, "Involutivity" -> 1|>

Obstruction[algebra : CanonicalLieBialgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], "Jacobi", {u_, v_, w_}] := With[
	{pairing = algebra["Pairing"], option = "EmptyWord" -> algebra["EmptyWord"]},
	Expand[CanonicalLieBracket[
		CanonicalLieBracket[
			If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct][u, v, w, pairing], pairing, option],
		pairing, option]]]

Obstruction[algebra : CanonicalLieBialgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], "CoJacobi", {w_}] := With[
	{pairing = algebra["Pairing"], option = "EmptyWord" -> algebra["EmptyWord"]},
	Expand[CanonicalLieCobracket[CanonicalLieCobracket[w, pairing, option], pairing, option]]]

Obstruction[algebra : CanonicalLieBialgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], "Drinfeld", {u_, v_}] := With[
	{pairing = algebra["Pairing"], option = "EmptyWord" -> algebra["EmptyWord"]},
	{product = If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct][u, v, pairing]},
	Expand[CanonicalLieCobracket[CanonicalLieBracket[product, pairing, option], pairing, option]
		+ CanonicalLieBracket[CanonicalLieCobracket[product, pairing, option], pairing, option]]]

Obstruction[algebra : CanonicalLieBialgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], "Involutivity", {w_}] := With[
	{pairing = algebra["Pairing"], option = "EmptyWord" -> algebra["EmptyWord"]},
	Expand[CanonicalLieBracket[CanonicalLieCobracket[w, pairing, option], pairing, option]]]

RelationsQ[algebra : CanonicalLieBialgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], n_Integer?NonNegative] := With[
	{words = GenerateCyclicWords[n, algebra["Pairing"], "UpTo" -> True, "EmptyWord" -> algebra["EmptyWord"]]},
	AllTrue[Normal[Relations[algebra]], relation |->
		AllTrue[Tuples[words, Last[relation]], tuple |-> Obstruction[algebra, First[relation], tuple] === 0]]]
