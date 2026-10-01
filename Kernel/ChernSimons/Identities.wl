PackageExported[StringAlgebra]

StringAlgebra::usage = "StringAlgebra[pairing] is the dIBL algebra of cyclic words over the alphabet of pairing, with the operations StringBracket, StringCobracket and CyclicHochschildDifferential.\nThe option \"EmptyWord\" -> True gives its extension by the empty word, in which every operation computes with that option.";

Options[StringAlgebra] = {"EmptyWord" -> False}

StringAlgebra[pairing_GradedPairing, opts : OptionsPattern[]] := With[{emptyWord = OptionValue["EmptyWord"]},
	StringAlgebra[<|"Pairing" -> pairing, "EmptyWord" -> emptyWord|>] /; BooleanQ[emptyWord]]

Relations[StringAlgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ]] := <|"Jacobi" -> 3, "CoJacobi" -> 1, "Drinfeld" -> 2, "Involutivity" -> 1|>

Obstruction[algebra : StringAlgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], "Jacobi", {u_, v_, w_}] := With[
	{pairing = algebra["Pairing"], option = "EmptyWord" -> algebra["EmptyWord"]},
	Expand[StringBracket[
		StringBracket[
			If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct][u, v, w, pairing], pairing, option],
		pairing, option]]]

Obstruction[algebra : StringAlgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], "CoJacobi", {w_}] := With[
	{pairing = algebra["Pairing"], option = "EmptyWord" -> algebra["EmptyWord"]},
	Expand[StringCobracket[StringCobracket[w, pairing, option], pairing, option]]]

Obstruction[algebra : StringAlgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], "Drinfeld", {u_, v_}] := With[
	{pairing = algebra["Pairing"], option = "EmptyWord" -> algebra["EmptyWord"]},
	{product = If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct][u, v, pairing]},
	Expand[StringCobracket[StringBracket[product, pairing, option], pairing, option]
		+ StringBracket[StringCobracket[product, pairing, option], pairing, option]]]

Obstruction[algebra : StringAlgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], "Involutivity", {w_}] := With[
	{pairing = algebra["Pairing"], option = "EmptyWord" -> algebra["EmptyWord"]},
	Expand[StringBracket[StringCobracket[w, pairing, option], pairing, option]]]

RelationsQ[algebra : StringAlgebra[KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ], n_Integer?NonNegative] := With[
	{words = GenerateCyclicWords[n, algebra["Pairing"], "UpTo" -> True, "EmptyWord" -> algebra["EmptyWord"]]},
	AllTrue[Normal[Relations[algebra]], relation |->
		AllTrue[Tuples[words, Last[relation]], tuple |-> Obstruction[algebra, First[relation], tuple] === 0]]]
