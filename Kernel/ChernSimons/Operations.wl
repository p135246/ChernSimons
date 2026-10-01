PackageExported[ChordContraction]
PackageExported[StringBracket]
PackageExported[StringCobracket]
PackageExported[CyclicHochschildDifferential]
PackageExported[SymmetricToExterior]
PackageExported[ExteriorToSymmetric]
PackageExported[DualPairing]

ChordContraction::usage = "ChordContraction[u, v, {i, j}, pairing] gives the term of the bracket of the cyclic words u and v in which particle i of u is contracted against particle j of v.\nChordContraction[w, {i, j}, pairing] gives the term of the co-bracket of the cyclic word w in which particles i and j are contracted and w is cut into two arcs.\nThe option \"EmptyWord\" -> True keeps an empty remainder or an empty arc as the empty word rather than giving 0.";

StringBracket::usage = "StringBracket[u, v, pairing] gives the bracket q(2,1,0) of the cyclic words u and v, in the convention of pairing.\nStringBracket[p, pairing] gives the extension of the bracket as a derivation, applied to a product p of cyclic words.\nThe option \"EmptyWord\" -> True gives the bracket of the extension by the empty word, in which the bracket of two one-particle words is the empty word rather than 0.";

StringCobracket::usage = "StringCobracket[w, pairing] gives the co-bracket q(1,2,0) of the cyclic word w, a product of two cyclic words, in the convention of pairing.\nStringCobracket[p, pairing] gives the extension of the co-bracket as a co-derivation, applied to a product p of cyclic words.\nThe option \"EmptyWord\" -> True gives the co-bracket of the extension by the empty word, in which a cut next to a contracted particle is kept with the empty word as its empty arc.";

CyclicHochschildDifferential::usage = "CyclicHochschildDifferential[w, pairing] gives the differential q(1,1,0) of the cyclic word w, induced particle by particle by the differential of the Poincare duality algebra that pairing carries.\nCyclicHochschildDifferential[p, pairing] gives the extension of the differential as a derivation, applied to a product p of cyclic words.";

SymmetricToExterior::usage = "SymmetricToExterior[e, pairing] gives the exterior product that corresponds to the symmetric product e, with the sign of the reversal rule.\nSymmetricToExterior[e, pairing, rule] gives it with the sign of rule, \"Reversal\" or \"Position\".\nThe option \"Rule\" gives the sign rule as the third argument does, \"Reversal\" by default.";

ExteriorToSymmetric::usage = "ExteriorToSymmetric[e, pairing] gives the symmetric product that corresponds to the exterior product e, with the sign of the reversal rule; it inverts SymmetricToExterior[e, pairing].\nExteriorToSymmetric[e, pairing, rule] gives it with the sign of rule, \"Reversal\" or \"Position\", and inverts SymmetricToExterior with the same rule.\nThe option \"Rule\" gives the sign rule as the third argument does, \"Reversal\" by default.";

DualPairing::usage = "DualPairing[u, v, pairing] gives the value of the cyclic word u of particles on the cyclic word v of dual particles.\nDualPairing[p, q, pairing] gives the value of the product p of cyclic words on the product q of dual cyclic words, two symmetric or two exterior products.";

Options[ChordContraction] = {"EmptyWord" -> False}

Options[StringBracket] = {"EmptyWord" -> False}

Options[StringCobracket] = {"EmptyWord" -> False}

Options[SymmetricToExterior] = {"Rule" -> "Reversal"}

Options[ExteriorToSymmetric] = {"Rule" -> "Reversal"}

GradedPairing::dual = "The pairing object carries no dual alphabet; build it with GradedPairing[degrees, spec, dual, evaluation].";

ChordContraction[CyclicWord[u_List], CyclicWord[v_List], {i_Integer, j_Integer}, pairing_GradedPairing,
	opts : OptionsPattern[]] /; 1 <= i <= Length[u] && 1 <= j <= Length[v] := With[
	{k = Length[u], l = Length[v], d = pairing["Degree"], du = ElementDegree[u, pairing, "Bar"], dv = ElementDegree[v, pairing, "Bar"]},
	{exponent = If[pairing["Convention"] === "Exterior", d du + du dv, (d - 1) du + d + du dv]},
	Times[
		Lookup[pairing["Values"], Key[{u[[i]], v[[j]]}], 0],
		(-1)^exponent,
		KoszulSign[
			Join[{i, k + l + 1, k + j}, Rest[RotateLeft[Range[k], i - 1]], k + Rest[RotateLeft[Range[l], j - 1]]],
			Append[Map[p |-> ElementDegree[{p}, pairing, "Bar"], Join[u, v]], d], 0],
		CyclicWord[Join[Rest[RotateLeft[u, i - 1]], Rest[RotateLeft[v, j - 1]]], pairing, opts]]]

ChordContraction[CyclicWord[w_List], {i_Integer, j_Integer}, pairing_GradedPairing, opts : OptionsPattern[]] /;
	1 <= i <= Length[w] && 1 <= j <= Length[w] && i =!= j := With[
	{k = Length[w], d = pairing["Degree"], cut = Mod[j - i, Length[w]] + 1,
		rotated = RotateLeft[w, i - 1], positions = RotateLeft[Range[Length[w]], i - 1]},
	{first = rotated[[2 ;; cut - 1]], second = rotated[[cut + 1 ;;]]},
	{dFirst = ElementDegree[first, pairing, "Bar"], dSecond = ElementDegree[second, pairing, "Bar"]},
	{exponent = If[pairing["Convention"] === "Exterior", d dFirst + dFirst dSecond, (d - 1) dFirst + d + dFirst dSecond]},
	If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct][
		Times[
			Lookup[pairing["Values"], Key[{First[rotated], rotated[[cut]]}], 0],
			(-1)^exponent,
			KoszulSign[
				Join[{i, k + 1, j}, positions[[2 ;; cut - 1]], positions[[cut + 1 ;;]]],
				Append[Map[p |-> ElementDegree[{p}, pairing, "Bar"], w], d], 0],
			CyclicWord[first, pairing, opts]],
		CyclicWord[second, pairing, opts], pairing]]

StringBracket[before___, 0, after___, pairing_GradedPairing, OptionsPattern[]] := 0

StringBracket[before___, sum_Plus, after___, pairing_GradedPairing, opts : OptionsPattern[]] :=
	Map[term |-> StringBracket[before, term, after, pairing, opts], sum]

StringBracket[before___, Times[scalar_, e_], after___, pairing_GradedPairing, opts : OptionsPattern[]] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar StringBracket[before, e, after, pairing, opts]

StringBracket[before___, w_List, after___, pairing_GradedPairing, opts : OptionsPattern[]] :=
	StringBracket[before, CyclicWord[w], after, pairing, opts]

StringBracket[CyclicWord[u_List], CyclicWord[v_List], pairing_GradedPairing, opts : OptionsPattern[]] :=
	Total[Table[ChordContraction[CyclicWord[u], CyclicWord[v], {i, j}, pairing, opts], {i, Length[u]}, {j, Length[v]}], 2]

StringBracket[CyclicWord[_List], pairing_GradedPairing, OptionsPattern[]] := 0

StringBracket[SymmetricProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Expand[Total[Map[
	pair |-> Times[
		KoszulSign[Join[pair, Complement[Range[Length[{factors}]], pair]],
			Map[f |-> ElementDegree[f, pairing, "Symmetric"], {factors}], 0],
		SymmetricProduct[StringBracket[{factors}[[First[pair]]], {factors}[[Last[pair]]], pairing, opts],
			Sequence @@ Delete[{factors}, List /@ pair], pairing]],
	Subsets[Range[Length[{factors}]], {2}]]]]

StringBracket[ExteriorProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] === "Exterior" := Expand[Total[Map[
	pair |-> Times[
		KoszulSign[Join[pair, Complement[Range[Length[{factors}]], pair]],
			Map[f |-> ElementDegree[f, pairing, "Exterior"], {factors}], 1],
		ExteriorProduct[StringBracket[{factors}[[First[pair]]], {factors}[[Last[pair]]], pairing, opts],
			Sequence @@ Delete[{factors}, List /@ pair], pairing]],
	Subsets[Range[Length[{factors}]], {2}]]]]

StringCobracket[0, pairing_GradedPairing, OptionsPattern[]] := 0

StringCobracket[sum_Plus, pairing_GradedPairing, opts : OptionsPattern[]] :=
	Map[term |-> StringCobracket[term, pairing, opts], sum]

StringCobracket[Times[scalar_, e_], pairing_GradedPairing, opts : OptionsPattern[]] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar StringCobracket[e, pairing, opts]

StringCobracket[w_List, pairing_GradedPairing, opts : OptionsPattern[]] :=
	StringCobracket[CyclicWord[w], pairing, opts]

StringCobracket[CyclicWord[w_List], pairing_GradedPairing, opts : OptionsPattern[]] := Expand[Total[Map[
	pair |-> ChordContraction[CyclicWord[w], pair, pairing, opts]/2,
	Select[Tuples[Range[Length[w]], 2], pair |-> First[pair] =!= Last[pair]]]]]

StringCobracket[SymmetricProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> ElementDegree[f, pairing, "Symmetric"], {factors}], 0],
		SymmetricProduct[StringCobracket[{factors}[[i]], pairing, opts], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]

StringCobracket[ExteriorProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] === "Exterior" := Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> ElementDegree[f, pairing, "Exterior"], {factors}], 1],
		ExteriorProduct[StringCobracket[{factors}[[i]], pairing, opts], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]

CyclicHochschildDifferential[0, pairing_GradedPairing] := 0

CyclicHochschildDifferential[sum_Plus, pairing_GradedPairing] := Map[term |-> CyclicHochschildDifferential[term, pairing], sum]

CyclicHochschildDifferential[Times[scalar_, e_], pairing_GradedPairing] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar CyclicHochschildDifferential[e, pairing]

CyclicHochschildDifferential[w_List, pairing_GradedPairing] := CyclicHochschildDifferential[CyclicWord[w], pairing]

CyclicHochschildDifferential[CyclicWord[w_List], pairing_GradedPairing] := With[
	{particles = Keys[pairing["Degrees"]], matrix = Lookup[Lookup[pairing, "Algebra", <||>], "Differential", None]},
	If[matrix === None, 0,
		With[{images = AssociationThread[particles -> Transpose[matrix]]},
			Expand[Total[Table[
				Times[(-1)^ElementDegree[Drop[w, j], pairing, "Bar"], images[w[[j]]][[q]],
					CyclicWord[ReplacePart[w, j -> particles[[q]]], pairing]],
				{j, Length[w]}, {q, Length[particles]}], 2]]]]]

CyclicHochschildDifferential[SymmetricProduct[factors__CyclicWord], pairing_GradedPairing] /;
	pairing["Convention"] =!= "Exterior" := Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> ElementDegree[f, pairing, "Symmetric"], {factors}], 0],
		SymmetricProduct[CyclicHochschildDifferential[{factors}[[i]], pairing], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]

CyclicHochschildDifferential[ExteriorProduct[factors__CyclicWord], pairing_GradedPairing] /;
	pairing["Convention"] === "Exterior" := Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> ElementDegree[f, pairing, "Exterior"], {factors}], 1],
		ExteriorProduct[CyclicHochschildDifferential[{factors}[[i]], pairing], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]

SymmetricToExterior[e_, pairing_GradedPairing, rule : "Reversal" | "Position", opts : ("Rule" -> "Reversal" | "Position") ...] :=
	SymmetricToExterior[e, pairing, "Rule" -> rule, opts]

SymmetricToExterior[0, pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] := 0

SymmetricToExterior[sum_Plus, pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] :=
	Map[term |-> SymmetricToExterior[term, pairing, opts], sum]

SymmetricToExterior[Times[scalar_, e_], pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar SymmetricToExterior[e, pairing, opts]

SymmetricToExterior[w_List, pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] :=
	SymmetricToExterior[CyclicWord[w], pairing, opts]

SymmetricToExterior[w_CyclicWord, pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] :=
	SymmetricToExterior[SymmetricProduct[w], pairing, opts]

SymmetricToExterior[SymmetricProduct[factors__CyclicWord], pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] := With[
	{weights = If[OptionValue[SymmetricToExterior, {opts}, "Rule"] === "Position",
		Range[Length[{factors}]], Length[{factors}] - Range[Length[{factors}]]]},
	Times[(-1)^(weights . Map[f |-> ElementDegree[f, pairing, "Exterior"], {factors}]), ExteriorProduct[factors, pairing]]]

ExteriorToSymmetric[e_, pairing_GradedPairing, rule : "Reversal" | "Position", opts : ("Rule" -> "Reversal" | "Position") ...] :=
	ExteriorToSymmetric[e, pairing, "Rule" -> rule, opts]

ExteriorToSymmetric[0, pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] := 0

ExteriorToSymmetric[sum_Plus, pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] :=
	Map[term |-> ExteriorToSymmetric[term, pairing, opts], sum]

ExteriorToSymmetric[Times[scalar_, e_], pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar ExteriorToSymmetric[e, pairing, opts]

ExteriorToSymmetric[w_List, pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] :=
	ExteriorToSymmetric[CyclicWord[w], pairing, opts]

ExteriorToSymmetric[w_CyclicWord, pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] :=
	ExteriorToSymmetric[ExteriorProduct[w], pairing, opts]

ExteriorToSymmetric[ExteriorProduct[factors__CyclicWord], pairing_GradedPairing, opts : ("Rule" -> "Reversal" | "Position") ...] := With[
	{weights = If[OptionValue[ExteriorToSymmetric, {opts}, "Rule"] === "Position",
		Range[Length[{factors}]], Length[{factors}] - Range[Length[{factors}]]]},
	Times[(-1)^(weights . Map[f |-> ElementDegree[f, pairing, "Exterior"], {factors}]), SymmetricProduct[factors, pairing]]]

DualPairing[before___, 0, after___, pairing_GradedPairing] := 0

DualPairing[before___, sum_Plus, after___, pairing_GradedPairing] :=
	Map[term |-> DualPairing[before, term, after, pairing], sum]

DualPairing[before___, Times[scalar_, e_], after___, pairing_GradedPairing] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar DualPairing[before, e, after, pairing]

DualPairing[before___, w_List, after___, pairing_GradedPairing] := DualPairing[before, CyclicWord[w], after, pairing]

DualPairing[CyclicWord[{}], CyclicWord[{}], pairing_GradedPairing] /; KeyExistsQ[pairing, "Dual"] := 1

DualPairing[CyclicWord[f_List], CyclicWord[e_List], pairing_GradedPairing] /; KeyExistsQ[pairing, "Dual"] :=
	If[Length[f] =!= Length[e], 0,
		Times[
			(-1)^Total[Map[pair |-> Times @@ Map[p |-> ElementDegree[{p}, pairing, "Bar"], pair], Subsets[f, {2}]]],
			Total[Map[
				rotation |-> First[rotation] Times @@ MapThread[
					{p, q} |-> Lookup[pairing["Dual"]["Values"], Key[{p, q}], 0], {f, Last[rotation]}],
				NestList[
					Apply[{sign, u} |-> {(-1)^(ElementDegree[Take[u, 1], pairing, "Bar"] ElementDegree[Drop[u, 1], pairing, "Bar"]) sign, RotateLeft[u]}],
					{1, e}, Length[e] - 1]]]]]

DualPairing[SymmetricProduct[fs__CyclicWord], SymmetricProduct[es__CyclicWord], pairing_GradedPairing] /;
	KeyExistsQ[pairing, "Dual"] := If[Length[{fs}] =!= Length[{es}], 0,
		Times[
			(-1)^Total[Map[Apply[Times], Subsets[Map[f |-> ElementDegree[f, pairing, "Symmetric"], {fs}], {2}]]],
			1/Length[{fs}]!,
			Total[Map[
				perm |-> Times[
					KoszulSign[perm, Map[e |-> ElementDegree[e, pairing, "Symmetric"], {es}], 0],
					Times @@ MapThread[{f, e} |-> DualPairing[f, e, pairing], {{fs}, {es}[[perm]]}]],
				Permutations[Range[Length[{es}]]]]]]]

DualPairing[ExteriorProduct[fs__CyclicWord], ExteriorProduct[es__CyclicWord], pairing_GradedPairing] /;
	KeyExistsQ[pairing, "Dual"] := If[Length[{fs}] =!= Length[{es}], 0,
		Times[
			(-1)^Total[Map[Apply[Times], Subsets[Map[f |-> ElementDegree[f, pairing, "Symmetric"], {fs}], {2}]]],
			Total[Map[
				perm |-> Times[
					KoszulSign[perm, Map[e |-> ElementDegree[e, pairing, "Exterior"], {es}], 1],
					Times @@ MapThread[{f, e} |-> DualPairing[f, e, pairing], {{fs}, {es}[[perm]]}]],
				Permutations[Range[Length[{es}]]]]]]]

DualPairing[_CyclicWord, _SymmetricProduct | _ExteriorProduct, pairing_GradedPairing] /; KeyExistsQ[pairing, "Dual"] := 0

DualPairing[_SymmetricProduct | _ExteriorProduct, _CyclicWord, pairing_GradedPairing] /; KeyExistsQ[pairing, "Dual"] := 0

DualPairing[f_, e_, pairing_GradedPairing] /; (! KeyExistsQ[pairing, "Dual"] && (Message[GradedPairing::dual]; False)) := Null
