bvDelta[e_] := unwrapOdot[hatQ120Odot[e] + hbar hatQ210Odot[e]]

bvDeltaNaive[e_] := unwrapOdot[hatQ120Odot[e] + hbar hatQ210OdotNaive[e]]

bvBracket[u : _cyc | _odot, v : _cyc | _odot] := unwrapOdot[sgn[degF1[u]] (bvDelta[odot[u, v]] - odot[bvDelta[u], v]) - odot[u, bvDelta[v]]]

bvQme[s_] := Expand[bvDelta[s] + 1/2 bvBracket[s, s]]

hochschildPrimal[cyc[f_List]] := 0 /; Length[f] < 2

hochschildPrimal[cyc[f_List]] := Total[Map[r |-> primalTerm[f, r], Range[Length[f]]]]

unwrapOdot[e_] := e /. odot[u_cyc] :> u

degF1[cyc[w_List]] := degC1[w]

degF1[w_odot] := Total[Map[degF1, List @@ w]]

degF[cyc[w_List]] := degC[w]

degF[w_odot] := Total[Map[degF, List @@ w]]

primalTerm[f_List, r_Integer] := With[{w = RotateLeft[f, r - 1]},
	With[{t = Lookup[$diamondProduct, Key[w[[1 ;; 2]]], {0, "a"}]},
		t[[1]] koszulSign[RotateLeft[Range[Length[f]], r - 1], Lookup[$letterDegrees, f], 0] cyc[Prepend[Drop[w, 2], t[[2]]]]]]

$diamondProduct = <|{"a", "a"} -> {1, "a"}, {"a", "b"} -> {1, "b"}, {"b", "a"} -> {-1, "b"}|>;

Scan[declareLinear, {bvBracket, hochschildPrimal}]
