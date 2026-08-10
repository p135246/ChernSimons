shiftIso[odot[w__cyc]] := positionSign[{w}] wedge[w]

shiftIso[w_cyc] := shiftIso[odot[w]]

shiftIsoInverse[wedge[w__cyc]] := positionSign[{w}] odot[w]

shiftIsoInverse[w_cyc] := shiftIsoInverse[wedge[w]]

shiftIsoK[odot[w__cyc]] := kSign[{w}] wedge[w]

shiftIsoK[w_cyc] := shiftIsoK[odot[w]]

shiftIsoKInverse[wedge[w__cyc]] := kSign[{w}] odot[w]

shiftIsoKInverse[w_cyc] := shiftIsoKInverse[wedge[w]]

wedgePairing[wedge[f__cyc], wedge[e__cyc]] := 0 /; Length[{f}] =!= Length[{e}]

wedgePairing[wedge[f__cyc], wedge[e__cyc]] := reversalSign[degC1, {f}] Total[Map[
	perm |-> koszulSign[perm, Map[degC, {e}], 1] Inner[evalWord, {f}, {e}[[perm]], Times],
	Permutations[Range[Length[{e}]]]]]

wedgePairing[f_cyc, e_] := wedgePairing[wedge[f], e]

wedgePairing[f_wedge, e_cyc] := wedgePairing[f, wedge[e]]

odotPairing[odot[f__cyc], odot[e__cyc]] := 0 /; Length[{f}] =!= Length[{e}]

odotPairing[odot[f__cyc], odot[e__cyc]] := reversalSign[degC1, {f}]/Factorial[Length[{f}]] Total[Map[
	perm |-> koszulSign[perm, Map[degC1, {e}], 0] Inner[evalWord, {f}, {e}[[perm]], Times],
	Permutations[Range[Length[{e}]]]]]

odotPairing[f_cyc, e_] := odotPairing[odot[f], e]

odotPairing[f_odot, e_cyc] := odotPairing[f, odot[e]]

evalWord[cyc[f_List], cyc[e_List]] := evalWordCore[f, e]

evalWordCore[f_List, e_List] := 0 /; Length[f] =!= Length[e]

evalWordCore[f_List, e_List] := reversalSign[degBar, f] Total[Map[
	rot |-> rot[[1]] Inner[evalLetter, f, rot[[2]], Times],
	NestList[rotateLeft, {1, e}, Length[e] - 1]]]

$letterPairing = <|{"x", "a"} -> 1, {"y", "b"} -> 1|>;

evalLetter[f_String, e_String] := Lookup[$letterPairing, Key[{f, e}], 0]

positionSign[ws_List] := sgn[Range[Length[ws]] . Map[degC, ws]]

kSign[ws_List] := sgn[(Length[ws] - Range[Length[ws]]) . Map[degC, ws]]

reversalSign[deg_, ws_List] := sgn[Total[Map[pr |-> deg[pr[[1]]] deg[pr[[2]]], Subsets[ws, {2}]]]]

SetAttributes[scalarQ, HoldAll]

scalarQ[c_] := FreeQ[Unevaluated[c], cyc | odot | wedge | _String | _List]

declareLinear[head_Symbol] := (
	head[x___, 0, y___] := 0;
	head[x___, p_Plus, y___] := Map[e |-> head[x, e, y], p];
	head[x___, Times[c_?scalarQ, e_], y___] := c head[x, e, y];
	head[x___, s_String, y___] := head[x, cyc[s], y];
	head[x___, w_List, y___] := head[x, cyc[w], y];
)

declareGradedProduct[head_Symbol, deg_, parity_Integer, symbol_String] := (
	SetAttributes[head, Flat];
	declareLinear[head];
	head[w__cyc] := 0 /; !DuplicateFreeQ[Select[{w}, u |-> EvenQ[deg[u] + parity + 1]]];
	head[w__cyc] := With[{ord = OrderingBy[{w}, Last]},
		koszulSign[ord, Map[deg, {w}], parity] head @@ {w}[[ord]] /; ord =!= Range[Length[{w}]]];
	Format[head[w__]] := Row[Riffle[{w}, symbol]];
)

declareGradedProduct[odot, degC1, 0, "\[CircleDot]"]

declareGradedProduct[wedge, degC, 1, "\[Wedge]"]

Scan[declareLinear, {shiftIso, shiftIsoInverse, shiftIsoK, shiftIsoKInverse, wedgePairing, odotPairing, evalWord}]
