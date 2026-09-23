ChordContraction::usage = "ChordContraction[u, v, {i, j}, pairing] is the term of the bracket of two cyclic words in which particle i of u is contracted against particle j of v: their pairing value, the Koszul sign of the convention of the pairing, and the cyclic word made of the two remainders. ChordContraction[w, {i, j}, pairing] is the term of the co-bracket of one cyclic word in which particles i and j are contracted and the word is cut into the arc from i to j and the arc from j to i, as a product of two cyclic words. An empty remainder gives 0, or the empty word with the option \"EmptyWord\" -> True.";

InvolutiveBracket::usage = "InvolutiveBracket[u, v, pairing] is the bracket q(2,1,0) of two cyclic words, in the convention of the pairing: the sum of ChordContraction over every pair of particles. InvolutiveBracket[p, pairing] applies its extension as a derivation to a product p of any number of factors; the extension lowers the number of factors by one and so vanishes on a single cyclic word. Both forms are linear, accept a word as the list of its particles, and return a single remaining factor as the word itself. With \"EmptyWord\" -> True the bracket of two particles is the empty word instead of 0.";

InvolutiveCobracket::usage = "InvolutiveCobracket[w, pairing] is the co-bracket q(1,2,0) of a cyclic word, in the convention of the pairing: one half of the sum of ChordContraction over every ordered pair of distinct particles, a product of two cyclic words. InvolutiveCobracket[p, pairing] applies its extension as a co-derivation to a product p. Both forms are linear and accept a word as the list of its particles. With \"EmptyWord\" -> True a cut next to a contracted particle is kept, with the empty word as the empty arc; without it, the paper's convention, only cuts with two nonempty arcs count.";

CyclicDifferential::usage = "CyclicDifferential[w, pairing] is the differential q(1,1,0) of a cyclic word, induced particle by particle by the differential of the Poincare duality algebra the pairing carries: each particle is replaced by its image, with the sign of the degree of the particles after it. CyclicDifferential[p, pairing] applies its extension as a derivation to a product p. It is linear, lowers the degree by one, preserves the length of a word and the number of factors of a product, and is identically 0 unless the pairing came from GradedPairing[NondegenerateQuotient[model]] for a model that is not formal.";

ShiftIsomorphism::usage = "ShiftIsomorphism[e, pairing] sends a symmetric product to an exterior one by the reversal rule, the sign (-1)^(Sum (k - i) [f_i]) over the factors f_1, ..., f_k, which is the rule that intertwines InvolutiveBracket and InvolutiveCobracket in every arity. ShiftIsomorphism[e, pairing, \"Position\"] uses the position rule (-1)^(Sum i [f_i]) instead, which does not. Both accept \"Inverse\" -> True, and both are linear.";

DualPairing::usage = "DualPairing[f, e, pairing] evaluates a cyclic word f of particles on a cyclic word e of dual particles: the sum over the rotations of e, with their Koszul signs, of the product of the pairing values, times the reversal sign of f. It requires a pairing object carrying a \"Dual\" key, and is linear in both arguments.";

ProductPairing::usage = "ProductPairing[f, e, pairing] extends DualPairing to two products with the same number of factors, summing over all matchings with their Koszul signs; symmetric products carry the weight 1/k! and exterior products do not. It is linear in both arguments.";

Options[ChordContraction] = {"EmptyWord" -> False}

Options[InvolutiveBracket] = {"EmptyWord" -> False}

Options[InvolutiveCobracket] = {"EmptyWord" -> False}

Options[ShiftIsomorphism] = {"Rule" -> "Reversal", "Inverse" -> False}

GradedPairing::dual = "The pairing object carries no dual alphabet; build it with GradedPairing[degrees, spec, dualDegrees, evaluation].";

ChordContraction[CyclicWord[u_List], CyclicWord[v_List], {i_Integer, j_Integer}, pairing_GradedPairing,
	opts : OptionsPattern[]] /; 1 <= i <= Length[u] && 1 <= j <= Length[v] := With[
	{k = Length[u], l = Length[v], d = pairing["Degree"], du = WordDegree[u, pairing], dv = WordDegree[v, pairing]},
	{exponent = If[pairing["Convention"] === "Exterior", d du + du dv, (d - 1) du + d + du dv]},
	Times[
		Lookup[pairing["Values"], Key[{u[[i]], v[[j]]}], 0],
		(-1)^exponent,
		KoszulSign[
			Join[{i, k + l + 1, k + j}, Rest[RotateLeft[Range[k], i - 1]], k + Rest[RotateLeft[Range[l], j - 1]]],
			Append[Map[p |-> WordDegree[{p}, pairing], Join[u, v]], d], 0],
		CyclicWord[Join[Rest[RotateLeft[u, i - 1]], Rest[RotateLeft[v, j - 1]]], pairing, opts]]]

ChordContraction[CyclicWord[w_List], {i_Integer, j_Integer}, pairing_GradedPairing, opts : OptionsPattern[]] /;
	1 <= i <= Length[w] && 1 <= j <= Length[w] && i =!= j := With[
	{k = Length[w], d = pairing["Degree"], cut = Mod[j - i, Length[w]] + 1,
		rotated = RotateLeft[w, i - 1], positions = RotateLeft[Range[Length[w]], i - 1]},
	{first = rotated[[2 ;; cut - 1]], second = rotated[[cut + 1 ;;]]},
	{dFirst = WordDegree[first, pairing], dSecond = WordDegree[second, pairing]},
	{exponent = If[pairing["Convention"] === "Exterior", d dFirst + dFirst dSecond, (d - 1) dFirst + d + dFirst dSecond]},
	If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct][
		Times[
			Lookup[pairing["Values"], Key[{First[rotated], rotated[[cut]]}], 0],
			(-1)^exponent,
			KoszulSign[
				Join[{i, k + 1, j}, positions[[2 ;; cut - 1]], positions[[cut + 1 ;;]]],
				Append[Map[p |-> WordDegree[{p}, pairing], w], d], 0],
			CyclicWord[first, pairing, opts]],
		CyclicWord[second, pairing, opts], pairing]]

InvolutiveBracket[before___, 0, after___, pairing_GradedPairing, OptionsPattern[]] := 0

InvolutiveBracket[before___, sum_Plus, after___, pairing_GradedPairing, opts : OptionsPattern[]] :=
	Map[term |-> InvolutiveBracket[before, term, after, pairing, opts], sum]

InvolutiveBracket[before___, Times[scalar_, e_], after___, pairing_GradedPairing, opts : OptionsPattern[]] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar InvolutiveBracket[before, e, after, pairing, opts]

InvolutiveBracket[before___, w_List, after___, pairing_GradedPairing, opts : OptionsPattern[]] :=
	InvolutiveBracket[before, CyclicWord[w], after, pairing, opts]

InvolutiveBracket[CyclicWord[u_List], CyclicWord[v_List], pairing_GradedPairing, opts : OptionsPattern[]] :=
	Total[Table[ChordContraction[CyclicWord[u], CyclicWord[v], {i, j}, pairing, opts], {i, Length[u]}, {j, Length[v]}], 2]

InvolutiveBracket[CyclicWord[_List], pairing_GradedPairing, OptionsPattern[]] := 0

InvolutiveBracket[SymmetricProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Expand[Total[Map[
	pair |-> Times[
		KoszulSign[Join[pair, Complement[Range[Length[{factors}]], pair]],
			Map[f |-> WordDegree[f, pairing, "Symmetric"], {factors}], 0],
		SymmetricProduct[InvolutiveBracket[{factors}[[First[pair]]], {factors}[[Last[pair]]], pairing, opts],
			Sequence @@ Delete[{factors}, List /@ pair], pairing]],
	Subsets[Range[Length[{factors}]], {2}]]]]

InvolutiveBracket[ExteriorProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] === "Exterior" := Expand[Total[Map[
	pair |-> Times[
		KoszulSign[Join[pair, Complement[Range[Length[{factors}]], pair]],
			Map[f |-> WordDegree[f, pairing, "Exterior"], {factors}], 1],
		ExteriorProduct[InvolutiveBracket[{factors}[[First[pair]]], {factors}[[Last[pair]]], pairing, opts],
			Sequence @@ Delete[{factors}, List /@ pair], pairing]],
	Subsets[Range[Length[{factors}]], {2}]]]]

InvolutiveCobracket[0, pairing_GradedPairing, OptionsPattern[]] := 0

InvolutiveCobracket[sum_Plus, pairing_GradedPairing, opts : OptionsPattern[]] :=
	Map[term |-> InvolutiveCobracket[term, pairing, opts], sum]

InvolutiveCobracket[Times[scalar_, e_], pairing_GradedPairing, opts : OptionsPattern[]] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar InvolutiveCobracket[e, pairing, opts]

InvolutiveCobracket[w_List, pairing_GradedPairing, opts : OptionsPattern[]] :=
	InvolutiveCobracket[CyclicWord[w], pairing, opts]

InvolutiveCobracket[CyclicWord[w_List], pairing_GradedPairing, opts : OptionsPattern[]] := Expand[Total[Map[
	pair |-> ChordContraction[CyclicWord[w], pair, pairing, opts]/2,
	Select[Tuples[Range[Length[w]], 2], pair |-> First[pair] =!= Last[pair]]]]]

InvolutiveCobracket[SymmetricProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> WordDegree[f, pairing, "Symmetric"], {factors}], 0],
		SymmetricProduct[InvolutiveCobracket[{factors}[[i]], pairing, opts], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]

InvolutiveCobracket[ExteriorProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] === "Exterior" := Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> WordDegree[f, pairing, "Exterior"], {factors}], 1],
		ExteriorProduct[InvolutiveCobracket[{factors}[[i]], pairing, opts], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]

CyclicDifferential[0, pairing_GradedPairing] := 0

CyclicDifferential[sum_Plus, pairing_GradedPairing] := Map[term |-> CyclicDifferential[term, pairing], sum]

CyclicDifferential[Times[scalar_, e_], pairing_GradedPairing] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar CyclicDifferential[e, pairing]

CyclicDifferential[w_List, pairing_GradedPairing] := CyclicDifferential[CyclicWord[w], pairing]

CyclicDifferential[CyclicWord[w_List], pairing_GradedPairing] := With[
	{particles = Keys[pairing["Degrees"]], matrix = Lookup[Lookup[pairing, "Algebra", <||>], "Differential", None]},
	If[matrix === None, 0,
		With[{images = AssociationThread[particles -> Transpose[matrix]]},
			Expand[Total[Table[
				Times[(-1)^WordDegree[Drop[w, j], pairing], images[w[[j]]][[q]],
					CyclicWord[ReplacePart[w, j -> particles[[q]]], pairing]],
				{j, Length[w]}, {q, Length[particles]}], 2]]]]]

CyclicDifferential[SymmetricProduct[factors__CyclicWord], pairing_GradedPairing] /;
	pairing["Convention"] =!= "Exterior" := Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> WordDegree[f, pairing, "Symmetric"], {factors}], 0],
		SymmetricProduct[CyclicDifferential[{factors}[[i]], pairing], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]

CyclicDifferential[ExteriorProduct[factors__CyclicWord], pairing_GradedPairing] /;
	pairing["Convention"] === "Exterior" := Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> WordDegree[f, pairing, "Exterior"], {factors}], 1],
		ExteriorProduct[CyclicDifferential[{factors}[[i]], pairing], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]

ShiftIsomorphism[e_, pairing_GradedPairing, rule_String, opts : OptionsPattern[]] :=
	ShiftIsomorphism[e, pairing, "Rule" -> rule, opts]

ShiftIsomorphism[0, pairing_GradedPairing, OptionsPattern[]] := 0

ShiftIsomorphism[sum_Plus, pairing_GradedPairing, opts : OptionsPattern[]] :=
	Map[term |-> ShiftIsomorphism[term, pairing, opts], sum]

ShiftIsomorphism[Times[scalar_, e_], pairing_GradedPairing, opts : OptionsPattern[]] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar ShiftIsomorphism[e, pairing, opts]

ShiftIsomorphism[w_List, pairing_GradedPairing, opts : OptionsPattern[]] :=
	ShiftIsomorphism[CyclicWord[w], pairing, opts]

ShiftIsomorphism[w_CyclicWord, pairing_GradedPairing, opts : OptionsPattern[]] := ShiftIsomorphism[
	If[TrueQ[OptionValue[ShiftIsomorphism, {opts}, "Inverse"]], ExteriorProduct[w], SymmetricProduct[w]], pairing, opts]

ShiftIsomorphism[SymmetricProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	! TrueQ[OptionValue[ShiftIsomorphism, {opts}, "Inverse"]] := With[
	{weights = If[OptionValue[ShiftIsomorphism, {opts}, "Rule"] === "Position",
		Range[Length[{factors}]], Length[{factors}] - Range[Length[{factors}]]]},
	Times[(-1)^(weights . Map[f |-> WordDegree[f, pairing, "Exterior"], {factors}]), ExteriorProduct[factors, pairing]]]

ShiftIsomorphism[ExteriorProduct[factors__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	TrueQ[OptionValue[ShiftIsomorphism, {opts}, "Inverse"]] := With[
	{weights = If[OptionValue[ShiftIsomorphism, {opts}, "Rule"] === "Position",
		Range[Length[{factors}]], Length[{factors}] - Range[Length[{factors}]]]},
	Times[(-1)^(weights . Map[f |-> WordDegree[f, pairing, "Exterior"], {factors}]), SymmetricProduct[factors, pairing]]]

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
			(-1)^Total[Map[pair |-> Times @@ Map[p |-> WordDegree[{p}, pairing], pair], Subsets[f, {2}]]],
			Total[Map[
				rotation |-> First[rotation] Times @@ MapThread[
					{p, q} |-> Lookup[pairing["Dual"]["Values"], Key[{p, q}], 0], {f, Last[rotation]}],
				NestList[
					Apply[{sign, u} |-> {(-1)^(WordDegree[Take[u, 1], pairing] WordDegree[Drop[u, 1], pairing]) sign, RotateLeft[u]}],
					{1, e}, Length[e] - 1]]]]]

DualPairing[f_, e_, pairing_GradedPairing] /; (! KeyExistsQ[pairing, "Dual"] && (Message[GradedPairing::dual]; False)) := Null

ProductPairing[before___, 0, after___, pairing_GradedPairing] := 0

ProductPairing[before___, sum_Plus, after___, pairing_GradedPairing] :=
	Map[term |-> ProductPairing[before, term, after, pairing], sum]

ProductPairing[before___, Times[scalar_, e_], after___, pairing_GradedPairing] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar ProductPairing[before, e, after, pairing]

ProductPairing[before___, w_List, after___, pairing_GradedPairing] := ProductPairing[before, CyclicWord[w], after, pairing]

ProductPairing[f_CyclicWord, e_CyclicWord, pairing_GradedPairing] := DualPairing[f, e, pairing]

ProductPairing[SymmetricProduct[fs__CyclicWord], SymmetricProduct[es__CyclicWord], pairing_GradedPairing] :=
	If[Length[{fs}] =!= Length[{es}], 0,
		Times[
			(-1)^Total[Map[Apply[Times], Subsets[Map[f |-> WordDegree[f, pairing, "Symmetric"], {fs}], {2}]]],
			1/Length[{fs}]!,
			Total[Map[
				perm |-> Times[
					KoszulSign[perm, Map[e |-> WordDegree[e, pairing, "Symmetric"], {es}], 0],
					Times @@ MapThread[{f, e} |-> DualPairing[f, e, pairing], {{fs}, {es}[[perm]]}]],
				Permutations[Range[Length[{es}]]]]]]]

ProductPairing[ExteriorProduct[fs__CyclicWord], ExteriorProduct[es__CyclicWord], pairing_GradedPairing] :=
	If[Length[{fs}] =!= Length[{es}], 0,
		Times[
			(-1)^Total[Map[Apply[Times], Subsets[Map[f |-> WordDegree[f, pairing, "Symmetric"], {fs}], {2}]]],
			Total[Map[
				perm |-> Times[
					KoszulSign[perm, Map[e |-> WordDegree[e, pairing, "Exterior"], {es}], 1],
					Times @@ MapThread[{f, e} |-> DualPairing[f, e, pairing], {{fs}, {es}[[perm]]}]],
				Permutations[Range[Length[{es}]]]]]]]

ProductPairing[_CyclicWord, _SymmetricProduct | _ExteriorProduct, pairing_GradedPairing] := 0

ProductPairing[_SymmetricProduct | _ExteriorProduct, _CyclicWord, pairing_GradedPairing] := 0
