PackageExported[CanonicalBeilinsonDrinfeldOperator]
PackageExported[CanonicalBeilinsonDrinfeldBracket]
PackageExported[HBar]

CanonicalBeilinsonDrinfeldOperator::usage = "CanonicalBeilinsonDrinfeldOperator[e, pairing] gives the operator \[CapitalDelta] = q110 + q120 + HBar q210 of the Beilinson-Drinfeld algebra of cyclic words, applied to e.\nThe option \"EmptyWord\" -> True gives the operator of the extension by the empty word.";

CanonicalBeilinsonDrinfeldBracket::usage = "CanonicalBeilinsonDrinfeldBracket[f, g, pairing] gives the Beilinson-Drinfeld bracket {f, g} of the BD axiom, the extension of CanonicalLieBracket to products, free of HBar.\nThe option \"EmptyWord\" -> True gives the bracket of the extension by the empty word.";

HBar::usage = "HBar is the formal variable \[HBar] of the Beilinson-Drinfeld algebra, a scalar to every operation.";

Options[CanonicalBeilinsonDrinfeldOperator] = {"EmptyWord" -> False}

Options[CanonicalBeilinsonDrinfeldBracket] = {"EmptyWord" -> False}

CanonicalBeilinsonDrinfeldOperator[0, pairing_GradedPairing, OptionsPattern[]] /; pairing["Convention"] =!= "Exterior" := 0

CanonicalBeilinsonDrinfeldOperator[sum_Plus, pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Map[term |-> CanonicalBeilinsonDrinfeldOperator[term, pairing, opts], sum]

CanonicalBeilinsonDrinfeldOperator[Times[scalar_, e_], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" && FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar CanonicalBeilinsonDrinfeldOperator[e, pairing, opts]

CanonicalBeilinsonDrinfeldOperator[w_List, pairing_GradedPairing, opts : OptionsPattern[]] /; pairing["Convention"] =!= "Exterior" :=
	CanonicalBeilinsonDrinfeldOperator[CyclicWord[w], pairing, opts]

CanonicalBeilinsonDrinfeldOperator[e : _CyclicWord | SymmetricProduct[__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Expand[
	CyclicHochschildDifferential[e, pairing] + CanonicalLieCobracket[e, pairing, opts] + HBar CanonicalLieBracket[e, pairing, opts]]

CanonicalBeilinsonDrinfeldBracket[before___, 0, after___, pairing_GradedPairing, OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := 0

CanonicalBeilinsonDrinfeldBracket[before___, sum_Plus, after___, pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Map[term |-> CanonicalBeilinsonDrinfeldBracket[before, term, after, pairing, opts], sum]

CanonicalBeilinsonDrinfeldBracket[before___, Times[scalar_, e_], after___, pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" && FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar CanonicalBeilinsonDrinfeldBracket[before, e, after, pairing, opts]

CanonicalBeilinsonDrinfeldBracket[before___, w_List, after___, pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := CanonicalBeilinsonDrinfeldBracket[before, CyclicWord[w], after, pairing, opts]

CanonicalBeilinsonDrinfeldBracket[f : _CyclicWord | SymmetricProduct[__CyclicWord], g : _CyclicWord | SymmetricProduct[__CyclicWord],
	pairing_GradedPairing, opts : OptionsPattern[]] /; pairing["Convention"] =!= "Exterior" := With[
	{k = If[Head[f] === CyclicWord, 1, Length[f]],
		factors = Join[If[Head[f] === CyclicWord, {f}, List @@ f], If[Head[g] === CyclicWord, {g}, List @@ g]]},
	{degrees = Map[u |-> ElementDegree[u, pairing, "Symmetric"], factors]},
	Expand[(-1)^Total[Take[degrees, k]] Total[Flatten[Table[
		Times[
			KoszulSign[Join[{i, j}, Delete[Range[Length[factors]], {{i}, {j}}]], degrees, 0],
			SymmetricProduct[CanonicalLieBracket[factors[[i]], factors[[j]], pairing, opts],
				Sequence @@ Delete[factors, {{i}, {j}}], pairing]],
		{i, k}, {j, k + 1, Length[factors]}]]]]]
