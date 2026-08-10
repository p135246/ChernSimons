ainftyRelation[cfun_, w_List] := Expand[Total[Map[
	s |-> With[{inner = ainftyM[cfun, w[[s[[1]] + 1 ;; s[[1]] + s[[2]]]]]},
		With[{outer = ainftyM[cfun, Join[w[[;; s[[1]]]], {inner[[2]]}, w[[s[[1]] + s[[2]] + 1 ;;]]]]},
			sgn[Total[Lookup[$letterDegrees, w[[;; s[[1]]]]]]] inner[[1]] outer[[1]] outer[[2]]]],
	Flatten[Table[{i, j}, {i, 0, Length[w] - 1}, {j, 1, Length[w] - i}], 1]]]]

ainftyMorphism[cfun_, w_List] := Expand[Total[Map[
	s |-> With[{inner = ainftyM[cfun, w[[s[[1]] + 1 ;; s[[1]] + s[[2]]]]]},
		With[{outer = ainftyF[cfun, Join[w[[;; s[[1]]]], {inner[[2]]}, w[[s[[1]] + s[[2]] + 1 ;;]]]]},
			sgn[Total[Lookup[$letterDegrees, w[[;; s[[1]]]]]]] inner[[1]] outer[[1]] outer[[2]]]],
	Flatten[Table[{i, j}, {i, 0, Length[w] - 1}, {j, 1, Length[w] - i}], 1]]] -
	Total[Map[
		u |-> With[{t1 = ainftyF[cfun, w[[;; u]]], t2 = ainftyF[cfun, w[[u + 1 ;;]]]},
			With[{d = Lookup[$diamondProduct, Key[{t1[[2]], t2[[2]]}], {0, "a"}]},
				t1[[1]] t2[[1]] d[[1]] d[[2]]]],
		Range[1, Length[w] - 1]]]]

hochschildTwisted[cfun_, cyc[f_List]] := Total[Map[
	ri |-> With[{w = RotateLeft[f, ri[[1]] - 1]},
		With[{t = ainftyM[cfun, Take[w, ri[[2]]]]},
			t[[1]] koszulSign[RotateLeft[Range[Length[f]], ri[[1]] - 1], Lookup[$letterDegrees, f], 0] cyc[Prepend[Drop[w, ri[[2]]], t[[2]]]]]],
		Flatten[Table[{r, i}, {r, 1, Length[f]}, {i, 2, Length[f]}], 1]]]

ainftyChainF[cfun_, cyc[f_List]] := chainFWeighted[cfun, {l, k} |-> 1/l, cyc[f]]

ainftyChainFPrinted[cfun_, cyc[f_List]] := chainFWeighted[cfun, {l, k} |-> 1, cyc[f]]

ainftyM[cfun_, w_List] := With[{pos = Flatten[Position[w, "a", {1}, Heads -> False]]},
	Which[
		Length[pos] == 1, {cfun[pos[[1]] - 1, Length[w] - pos[[1]]], "b"},
		Length[pos] == 2, {cfun[pos[[2]] - pos[[1]] - 1, pos[[1]] + Length[w] - pos[[2]]], "a"},
		True, {0, "a"}]]

ainftyF[cfun_, w_List] := With[{pos = Flatten[Position[w, "a", {1}, Heads -> False]]},
	Which[
		Length[pos] == 1, {Sum[cfun[t, Length[w] - t], {t, 0, pos[[1]] - 1}], "a"},
		Length[pos] == 0 && Length[w] == 1, {cfun[0, 1], "b"},
		True, {0, "a"}]]

veePrimal[p_String, q_String] := Lookup[$veePrimalPairing, Key[{p, q}], 0]

$veePrimalPairing = <|{"a", "b"} -> 1, {"b", "a"} -> -1|>;

chainFWeighted[cfun_, wt_, cyc[f_List]] := Expand[Total[Map[
	rc |-> With[{w = RotateLeft[f, rc[[1]] - 1], ends = Accumulate[rc[[2]]]},
		With[{ts = MapThread[{e1, e2} |-> ainftyF[cfun, w[[e1 + 1 ;; e2]]], {Prepend[Most[ends], 0], ends}]},
			wt[Length[rc[[2]]], Length[f]] Times @@ Map[First, ts] koszulSign[RotateLeft[Range[Length[f]], rc[[1]] - 1], Lookup[$letterDegrees, f], 0] cyc[Map[Last, ts]]]],
	Flatten[Table[{r, comp}, {r, 1, Length[f]}, {comp, blockCompositions[Length[f]]}], 1]]]]

blockCompositions[k_] := Flatten[Map[Permutations, IntegerPartitions[k]], 1]

Scan[declareLinear, {hochschildTwisted, ainftyChainF, ainftyChainFPrinted}]
