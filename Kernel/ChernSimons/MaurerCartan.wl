PackageExported[MaurerCartanElement]
PackageExported[MaurerCartanBasis]
PackageExported[MaurerCartanAnsatz]
PackageExported[TwistedDifferential]
PackageExported[TwistedCobracket]
PackageExported[StringBeilinsonDrinfeldHomotopy]
PackageExported[CanonicalMaurerCartan]

MaurerCartanElement::usage = "MaurerCartanElement[parts, pairing] is the element of the dIBL algebra of pairing with the given parts, an Association from {l, g} to the part m_{l,g}, a sum of products of l cyclic words.\nMaurerCartanElement[s, pairing] gives the element whose BD action is s = Sum HBar^g m_{l,g}.";

MaurerCartanBasis::usage = "MaurerCartanBasis[pairing, n] gives the products of cyclic words of total length at most n whose symmetric degree is that of HBar, the genus-zero monomials of a BD action.\nMaurerCartanBasis[degree, pairing, n] gives the products of cyclic words of total length at most n of the given symmetric degree.\nThe option \"EmptyWord\" -> True lets the empty word be a factor, with at most n factors in a monomial.";

MaurerCartanAnsatz::usage = "MaurerCartanAnsatz[coefficient, pairing, n] gives the general genus-zero MaurerCartanElement over MaurerCartanBasis[pairing, n], with the unknown coefficient[w] on a word w and coefficient[{w1, w2, ...}] on a product, named by particle lists.\nMaurerCartanAnsatz[coefficient, degree, pairing, n] gives the general element over MaurerCartanBasis[degree, pairing, n].\nThe option \"EmptyWord\" -> True lets the empty word be a factor of the monomials.";

TwistedDifferential::usage = "TwistedDifferential[m, w] gives the differential q(1,1,0) twisted by the MaurerCartanElement m, applied to the cyclic word w.\nTwistedDifferential[m, p] gives the extension of the twisted differential as a derivation, applied to a product p of cyclic words.\nThe option \"EmptyWord\" -> True gives the twist with the bracket of the empty-word extension.";

TwistedCobracket::usage = "TwistedCobracket[m, w] gives the co-bracket q(1,2,0) twisted by the MaurerCartanElement m, applied to the cyclic word w.\nTwistedCobracket[m, p] gives the extension of the twisted co-bracket as a co-derivation, applied to a product p of cyclic words.\nThe option \"EmptyWord\" -> True gives the co-bracket and the bracket of the empty-word extension.";

StringBeilinsonDrinfeldHomotopy::usage = "StringBeilinsonDrinfeldHomotopy[a, b, pairing, n, t, order] gives the solution a(t) of the BD homotopy equation \[CapitalDelta]b + {a(t), b} = -a'(t) with a(0) = a, by Picard iteration, as a polynomial in t of degree at most order truncated to total word length at most n.\nThe option \"EmptyWord\" -> True gives the flow in the empty-word extension.";

CanonicalMaurerCartan::usage = "CanonicalMaurerCartan[pairing] gives the canonical Maurer-Cartan element of the Poincare duality algebra that pairing carries, a MaurerCartanElement with the one part m_{1,0} made from the triple product.";

Options[MaurerCartanBasis] = {"EmptyWord" -> False}

Options[MaurerCartanAnsatz] = {"EmptyWord" -> False}

Options[TwistedDifferential] = {"EmptyWord" -> False}

Options[TwistedCobracket] = {"EmptyWord" -> False}

Options[StringBeilinsonDrinfeldHomotopy] = {"EmptyWord" -> False}

MaurerCartanElement[parts_Association, pairing_GradedPairing] /;
	AllTrue[Keys[parts], key |-> MatchQ[key, {_Integer?Positive, _Integer?NonNegative}]] := With[
	{given = DeleteCases[KeySort[Map[part |-> Expand[Replace[part, w_List :> CyclicWord[w]]], parts]], 0]},
	{element = MaurerCartanElement[Expand[Total[KeyValueMap[{key, part} |-> HBar^Last[key] part, given]]], pairing]},
	element /; MatchQ[element, MaurerCartanElement[_Association]] && element["Parts"] === given]

MaurerCartanElement[w_List, pairing_GradedPairing] := MaurerCartanElement[CyclicWord[w], pairing]

MaurerCartanElement[s_, pairing_GradedPairing] /; ! AssociationQ[s] && ! ListQ[s] := With[
	{product = If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct],
		terms = Replace[Expand[s], {0 -> {}, sum_Plus :> List @@ sum, term_ :> {term}}]},
	{keys = Map[
		term |-> With[{g = Exponent[term, HBar]},
			{factors = If[Head[term/HBar^g] === Times, List @@ (term/HBar^g), {term/HBar^g}]},
			{basis = Select[factors, f |-> MatchQ[f, _CyclicWord | product[__CyclicWord]]]},
			If[IntegerQ[g] && g >= 0 && Length[basis] === 1 &&
					FreeQ[DeleteCases[factors, First[basis], {1}, 1], HBar | CyclicWord | ExteriorProduct | SymmetricProduct],
				{If[Head[First[basis]] === CyclicWord, 1, Length[First[basis]]], g},
				None]],
		terms]},
	MaurerCartanElement[<|
		"Parts" -> KeySort[GroupBy[Transpose[{keys, terms}], First -> (pair |-> pair[[2]]/HBar^pair[[1, 2]]), Total]],
		"Pairing" -> pairing|>] /; FreeQ[keys, None]]

Obstruction[m : MaurerCartanElement[_Association], opts : OptionsPattern[]] /;
	m["Pairing"]["Convention"] =!= "Exterior" := With[{s = m["BDAction"], pairing = m["Pairing"]},
	Expand[StringBeilinsonDrinfeldOperator[s, pairing, opts] + StringBeilinsonDrinfeldBracket[s, s, pairing, opts]/2]]

Obstruction[m : MaurerCartanElement[_Association], "Equations", opts : OptionsPattern[]] /;
	m["Pairing"]["Convention"] =!= "Exterior" := With[
	{terms = Obstruction[m, opts]},
	DeleteCases[GroupBy[If[Head[terms] === Plus, List @@ terms, {terms}],
		(term |-> Times @@ Select[If[Head[term] === Times, List @@ term, {term}], f |-> ! FreeQ[f, CyclicWord | HBar]]) ->
			(term |-> Times @@ Select[If[Head[term] === Times, List @@ term, {term}], f |-> FreeQ[f, CyclicWord | HBar]]),
		Total], 0]]

RelationsQ[m : MaurerCartanElement[_Association], opts : OptionsPattern[]] /;
	m["Pairing"]["Convention"] =!= "Exterior" := Obstruction[m, opts] === 0

MaurerCartanBasis[pairing_GradedPairing, n_Integer?NonNegative, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := MaurerCartanBasis[ElementDegree[HBar, pairing, "Symmetric"], pairing, n, opts]

MaurerCartanBasis[degree_Integer, pairing_GradedPairing, n_Integer?NonNegative, OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := With[
	{words = GenerateCyclicWords[n, pairing, "UpTo" -> True, "EmptyWord" -> OptionValue["EmptyWord"]]},
	{lengths = Map[w |-> Length[First[w]], words], degrees = Map[w |-> ElementDegree[w, pairing, "Symmetric"], words]},
	DeleteCases[Map[
		indices |-> If[Length[indices] === 1, words[[First[indices]]],
			Replace[SymmetricProduct @@ Append[words[[indices]], pairing], Times[_, p_SymmetricProduct] :> p]],
		Select[
			Join @@ NestList[
				tuples |-> Join @@ Map[
					t |-> Map[i |-> Append[t, i],
						Select[Range[Last[t], Length[words]], i |-> Total[lengths[[t]]] + lengths[[i]] <= n]],
					tuples],
				Map[i |-> {i}, Range[Length[words]]], Max[n - 1, 0]],
			indices |-> Total[degrees[[indices]]] === degree]],
		0]]

MaurerCartanAnsatz[c_, pairing_GradedPairing, n_Integer?NonNegative, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := MaurerCartanAnsatz[c, ElementDegree[HBar, pairing, "Symmetric"], pairing, n, opts]

MaurerCartanAnsatz[c_, degree_Integer, pairing_GradedPairing, n_Integer?NonNegative, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := MaurerCartanElement[Total[Map[
	b |-> c[Replace[b, {CyclicWord[w_List] :> w, SymmetricProduct[fs__CyclicWord] :> Map[First, {fs}]}]] b,
	MaurerCartanBasis[degree, pairing, n, opts]]], pairing]

TwistedDifferential[m : MaurerCartanElement[_Association], 0, OptionsPattern[]] := 0

TwistedDifferential[m : MaurerCartanElement[_Association], sum_Plus, opts : OptionsPattern[]] :=
	Map[term |-> TwistedDifferential[m, term, opts], sum]

TwistedDifferential[m : MaurerCartanElement[_Association], Times[scalar_, e_], opts : OptionsPattern[]] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] := scalar TwistedDifferential[m, e, opts]

TwistedDifferential[m : MaurerCartanElement[_Association], w_List, opts : OptionsPattern[]] :=
	TwistedDifferential[m, CyclicWord[w], opts]

TwistedDifferential[m : MaurerCartanElement[_Association], CyclicWord[w_List], opts : OptionsPattern[]] := Expand[
	CyclicHochschildDifferential[CyclicWord[w], m["Pairing"]] +
		StringBracket[m[{1, 0}], CyclicWord[w], Append[m["Pairing"], "Convention" -> "Symmetric"], opts]]

TwistedDifferential[m : MaurerCartanElement[_Association], SymmetricProduct[factors__CyclicWord], opts : OptionsPattern[]] /;
	m["Pairing"]["Convention"] =!= "Exterior" := With[{pairing = m["Pairing"]}, Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> ElementDegree[f, pairing, "Symmetric"], {factors}], 0],
		SymmetricProduct[TwistedDifferential[m, {factors}[[i]], opts], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]]

TwistedDifferential[m : MaurerCartanElement[_Association], ExteriorProduct[factors__CyclicWord], opts : OptionsPattern[]] /;
	m["Pairing"]["Convention"] === "Exterior" := With[{pairing = m["Pairing"]}, Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> ElementDegree[f, pairing, "Exterior"], {factors}], 1],
		ExteriorProduct[TwistedDifferential[m, {factors}[[i]], opts], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]]

TwistedCobracket[m : MaurerCartanElement[_Association], 0, OptionsPattern[]] := 0

TwistedCobracket[m : MaurerCartanElement[_Association], sum_Plus, opts : OptionsPattern[]] :=
	Map[term |-> TwistedCobracket[m, term, opts], sum]

TwistedCobracket[m : MaurerCartanElement[_Association], Times[scalar_, e_], opts : OptionsPattern[]] /;
	FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] := scalar TwistedCobracket[m, e, opts]

TwistedCobracket[m : MaurerCartanElement[_Association], w_List, opts : OptionsPattern[]] :=
	TwistedCobracket[m, CyclicWord[w], opts]

TwistedCobracket[m : MaurerCartanElement[_Association], CyclicWord[w_List], opts : OptionsPattern[]] := With[
	{pairing = m["Pairing"], terms = m[{2, 0}]},
	{exterior = pairing["Convention"] === "Exterior"},
	{product = If[exterior, ExteriorProduct, SymmetricProduct], grading = If[exterior, "Exterior", "Symmetric"],
		parity = If[exterior, 1, 0]},
	Expand[StringCobracket[CyclicWord[w], pairing, opts] + Total[Cases[
		If[Head[terms] === Plus, List @@ terms, {terms}],
		Times[c_., product[f_CyclicWord, g_CyclicWord]] :> With[
			{degrees = Map[u |-> ElementDegree[u, pairing, grading], {f, g, CyclicWord[w]}]},
			Times[c, (-1)^(parity (degrees[[1]] + degrees[[2]])), Plus[
				KoszulSign[{1, 3, 2}, degrees, parity] product[StringBracket[f, CyclicWord[w], pairing, opts], g, pairing],
				KoszulSign[{2, 3, 1}, degrees, parity] product[StringBracket[g, CyclicWord[w], pairing, opts], f, pairing]]]]]]]]

TwistedCobracket[m : MaurerCartanElement[_Association], SymmetricProduct[factors__CyclicWord], opts : OptionsPattern[]] /;
	m["Pairing"]["Convention"] =!= "Exterior" := With[{pairing = m["Pairing"]}, Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> ElementDegree[f, pairing, "Symmetric"], {factors}], 0],
		SymmetricProduct[TwistedCobracket[m, {factors}[[i]], opts], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]]

TwistedCobracket[m : MaurerCartanElement[_Association], ExteriorProduct[factors__CyclicWord], opts : OptionsPattern[]] /;
	m["Pairing"]["Convention"] === "Exterior" := With[{pairing = m["Pairing"]}, Expand[Total[Map[
	i |-> Times[
		KoszulSign[Prepend[Delete[Range[Length[{factors}]], i], i],
			Map[f |-> ElementDegree[f, pairing, "Exterior"], {factors}], 1],
		ExteriorProduct[TwistedCobracket[m, {factors}[[i]], opts], Sequence @@ Delete[{factors}, i], pairing]],
	Range[Length[{factors}]]]]]]

StringBeilinsonDrinfeldHomotopy[a0_, b_, pairing_GradedPairing, n_Integer, t_, order_Integer, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := With[
	{source = StringBeilinsonDrinfeldOperator[b, pairing, opts]},
	Nest[
		a |-> With[{integrand = Expand[source + StringBeilinsonDrinfeldBracket[a, b, pairing, opts]]},
			Expand[a0 - Sum[Coefficient[integrand, t, k] t^(k + 1)/(k + 1), {k, 0, order - 1}]] /. {
				CyclicWord[w_List] /; Length[w] > n :> 0,
				SymmetricProduct[fs__CyclicWord] /; Total[Map[f |-> Length[First[f]], {fs}]] > n :> 0}],
		a0, order]]

CanonicalMaurerCartan[pairing_GradedPairing] /; KeyExistsQ[pairing, "Algebra"] := With[
	{particles = Keys[pairing["Degrees"]], degrees = Values[pairing["Degrees"]],
		n = pairing["Algebra"]["Degree"], triple = pairing["Algebra"]["Triple"]},
	MaurerCartanElement[<|{1, 0} -> (1/3) Total[KeyValueMap[
		{t, value} |-> With[{a = degrees[[t[[1]]]], b = degrees[[t[[2]]]], c = degrees[[t[[3]]]]},
			(-1)^(n - 1 + b + a b + b c + c a) value CyclicWord[particles[[t]], pairing]],
		triple]]|>, pairing] /; IntegerQ[n] && AssociationQ[triple]]
