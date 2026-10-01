PackageExported[StringBeilinsonDrinfeldOperator]
PackageExported[StringBeilinsonDrinfeldBracket]
PackageExported[HBar]

StringBeilinsonDrinfeldOperator::usage = "StringBeilinsonDrinfeldOperator[e, pairing] gives the operator \[CapitalDelta] = q110 + q120 + HBar q210 of the Beilinson-Drinfeld algebra of cyclic words, applied to e.\nThe option \"EmptyWord\" -> True gives the operator of the extension by the empty word.";

StringBeilinsonDrinfeldBracket::usage = "StringBeilinsonDrinfeldBracket[f, g, pairing] gives the Beilinson-Drinfeld bracket {f, g} of the BD axiom, the extension of StringBracket to products, free of HBar.\nThe option \"EmptyWord\" -> True gives the bracket of the extension by the empty word.";

HBar::usage = "HBar is the formal variable \[HBar] of the Beilinson-Drinfeld algebra, a scalar to every operation.";

Options[StringBeilinsonDrinfeldOperator] = {"EmptyWord" -> False}

Options[StringBeilinsonDrinfeldBracket] = {"EmptyWord" -> False}

StringBeilinsonDrinfeldOperator[0, pairing_GradedPairing, OptionsPattern[]] /; pairing["Convention"] =!= "Exterior" := 0

StringBeilinsonDrinfeldOperator[sum_Plus, pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Map[term |-> StringBeilinsonDrinfeldOperator[term, pairing, opts], sum]

StringBeilinsonDrinfeldOperator[Times[scalar_, e_], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" && FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar StringBeilinsonDrinfeldOperator[e, pairing, opts]

StringBeilinsonDrinfeldOperator[w_List, pairing_GradedPairing, opts : OptionsPattern[]] /; pairing["Convention"] =!= "Exterior" :=
	StringBeilinsonDrinfeldOperator[CyclicWord[w], pairing, opts]

StringBeilinsonDrinfeldOperator[e : _CyclicWord | SymmetricProduct[__CyclicWord], pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Expand[
	CyclicHochschildDifferential[e, pairing] + StringCobracket[e, pairing, opts] + HBar StringBracket[e, pairing, opts]]

StringBeilinsonDrinfeldBracket[before___, 0, after___, pairing_GradedPairing, OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := 0

StringBeilinsonDrinfeldBracket[before___, sum_Plus, after___, pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := Map[term |-> StringBeilinsonDrinfeldBracket[before, term, after, pairing, opts], sum]

StringBeilinsonDrinfeldBracket[before___, Times[scalar_, e_], after___, pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" && FreeQ[scalar, CyclicWord | ExteriorProduct | SymmetricProduct] :=
	scalar StringBeilinsonDrinfeldBracket[before, e, after, pairing, opts]

StringBeilinsonDrinfeldBracket[before___, w_List, after___, pairing_GradedPairing, opts : OptionsPattern[]] /;
	pairing["Convention"] =!= "Exterior" := StringBeilinsonDrinfeldBracket[before, CyclicWord[w], after, pairing, opts]

StringBeilinsonDrinfeldBracket[f : _CyclicWord | SymmetricProduct[__CyclicWord], g : _CyclicWord | SymmetricProduct[__CyclicWord],
	pairing_GradedPairing, opts : OptionsPattern[]] /; pairing["Convention"] =!= "Exterior" := With[
	{k = If[Head[f] === CyclicWord, 1, Length[f]],
		factors = Join[If[Head[f] === CyclicWord, {f}, List @@ f], If[Head[g] === CyclicWord, {g}, List @@ g]]},
	{degrees = Map[u |-> ElementDegree[u, pairing, "Symmetric"], factors]},
	Expand[(-1)^Total[Take[degrees, k]] Total[Flatten[Table[
		Times[
			KoszulSign[Join[{i, j}, Delete[Range[Length[factors]], {{i}, {j}}]], degrees, 0],
			SymmetricProduct[StringBracket[factors[[i]], factors[[j]], pairing, opts],
				Sequence @@ Delete[factors, {{i}, {j}}], pairing]],
		{i, k}, {j, k + 1, Length[factors]}]]]]]
