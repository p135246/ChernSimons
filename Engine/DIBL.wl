mu[cyc[f_List], cyc[g_List]] := sgn[$pdDegree - 2 + degBar[f] degBar[g]] bracketSum[f, g]

muOdotNaive[cyc[f_List], cyc[g_List]] := sgn[$pdDegree - 2] bracketSum[f, g]

delta[cyc[f_List]] := deltaSum[f, {u, v} |-> sgn[$pdDegree - 2 + degBar[u] degBar[v]], tp]

deltaOdotNaive[cyc[f_List]] := deltaSum[f, {u, v} |-> sgn[$pdDegree - 2], tp]

q110[cyc[f_List]] := Total[Map[t |-> t[[1]] cyc[t[[2]]], q110Terms[f]]]

q110[odot[u_cyc]] := q110[u]

q110[wedge[u_cyc]] := q110[u]

q210Wedge[wedge[u_cyc, v_cyc]] := q210Wedge[u, v]

q210Wedge[cyc[f_List], cyc[g_List]] := sgn[($pdDegree - 2) degBar[f] + degBar[f] degBar[g]] bracketSum[f, g]

q210Odot[odot[u_cyc, v_cyc]] := q210Odot[u, v]

q210Odot[u_cyc, v_cyc] := sgn[($pdDegree - 3) degBar[u]] mu[u, v]

q210OdotNaive[odot[u_cyc, v_cyc]] := q210OdotNaive[u, v]

q210OdotNaive[u_cyc, v_cyc] := sgn[($pdDegree - 3) degBar[u]] muOdotNaive[u, v]

q120Wedge[wedge[u_cyc]] := q120Wedge[u]

q120Wedge[cyc[f_List]] := 1/2 deltaSum[f, {u, v} |-> sgn[($pdDegree - 2) degBar[u] + degBar[u] degBar[v]], wedge]

q120Odot[odot[u_cyc]] := q120Odot[u]

q120Odot[cyc[f_List]] := 1/2 deltaSum[f, {u, v} |-> sgn[$pdDegree - 2 + ($pdDegree - 3) degBar[u] + degBar[u] degBar[v]], odot]

q120OdotNaive[odot[u_cyc]] := q120OdotNaive[u]

q120OdotNaive[cyc[f_List]] := 1/2 deltaSum[f, {u, v} |-> sgn[$pdDegree - 2 + ($pdDegree - 3) degBar[u]], odot]

jacobiWedge[a_, b_, c_] := hatQ210Wedge[hatQ210Wedge[wedge[a, b, c]]]

jacobiOdot[a_, b_, c_] := hatQ210Odot[hatQ210Odot[odot[a, b, c]]]

jacobiOdotNaive[a_, b_, c_] := hatQ210OdotNaive[hatQ210OdotNaive[odot[a, b, c]]]

cojacobiWedge[w_] := hatQ120Wedge[hatQ120Wedge[w]]

cojacobiOdot[w_] := hatQ120Odot[hatQ120Odot[w]]

drinfeldWedge[a_, b_] := hatQ120Wedge[hatQ210Wedge[wedge[a, b]]] + hatQ210Wedge[hatQ120Wedge[wedge[a, b]]]

drinfeldOdot[a_, b_] := hatQ120Odot[hatQ210Odot[odot[a, b]]] + hatQ210Odot[hatQ120Odot[odot[a, b]]]

involutivityWedge[w_] := hatQ210Wedge[hatQ120Wedge[w]]

involutivityOdot[w_] := hatQ210Odot[hatQ120Odot[w]]

mcCanonical = cyc[{"x", "x", "y"}];

q110Can[w_] := q210Comp1[mcCanonical, w]

q110Twisted[m10_, w_] := q110[w] + q210Comp1[m10, w]

q120Twisted[m20_, w_] := q120Wedge[w] + q210Comp1[m20, w]

q210Comp1[f_cyc, g_cyc] := sgn[degC[f]] q210Wedge[wedge[f, g]]

q210Comp1[wedge[f_cyc, g_cyc], h_cyc] := sgn[degBar[f] + degBar[g]] (
	sgn[1 + degC[h] degC[g]] wedge[q210Wedge[wedge[f, h]], g] +
	sgn[degC[f] (degBar[g] + degBar[h])] wedge[q210Wedge[wedge[g, h]], f])

hochschildDual[cyc[f_List]] := Total[Map[t |-> t[[1]] cyc[t[[2]]], hochschildTerms[f]]]

bracketSum[f_List, g_List] := Total[Map[t |-> t[[1]] cyc[t[[2]]], bracketTerms[f, g]]]

bracketTerms[f_List, g_List] := With[{k = Length[f], l = Length[g],
		degs = Append[Join[Lookup[$letterDegrees, f], Lookup[$letterDegrees, g]], $pdDegree - 2]},
	Join @@ Table[
		{veeValue[f[[r]], g[[s]]] koszulSign[bracketPerm[k, l, r, s], degs, 0],
			Join[Rest[RotateLeft[f, r - 1]], Rest[RotateLeft[g, s - 1]]]},
		{r, k}, {s, l}]]

bracketPerm[k_Integer, l_Integer, r_Integer, s_Integer] := With[
	{rf = RotateLeft[Range[k], r - 1], sg = k + RotateLeft[Range[l], s - 1]},
	Join[{rf[[1]], k + l + 1, sg[[1]]}, Rest[rf], Rest[sg]]]

deltaSum[f_List, sign_, head_] := Total[Map[
	t |-> t[[2]] sign[t[[3]], t[[4]]] head[cyc[t[[3]]], cyc[t[[4]]]],
	cobracketTerms[f]]]

cobracketTerms[f_List] := With[{k = Length[f],
		degs = Append[Lookup[$letterDegrees, f], $pdDegree - 2]},
	Join @@ Table[
		With[{rf = RotateLeft[Range[k], r - 1], w = RotateLeft[f, r - 1]},
			{i, veeValue[w[[1]], w[[i]]] koszulSign[cobracketPerm[rf, i], degs, 0],
				w[[2 ;; i - 1]], w[[i + 1 ;;]]}],
		{r, k}, {i, 3, k - 1}]]

cobracketPerm[rf_List, i_Integer] := Join[{rf[[1]], Length[rf] + 1, rf[[i]]}, rf[[2 ;; i - 1]], rf[[i + 1 ;;]]]

veeValue[p_String, q_String] := Lookup[$veePairing, Key[{p, q}], 0]

$veePairing = <|{"x", "y"} -> 1, {"y", "x"} -> -1|>;

q110Terms[f_List] := Join @@ Table[
	Map[t |-> {sgn[degBar[Drop[f, j]]] t[[2]], ReplacePart[f, j -> t[[1]]]},
		letterDifferentialTerms[f[[j]]]],
	{j, Length[f]}]

letterDifferentialTerms[p_String] :=
	Map[Apply[List], Normal[Lookup[$letterDifferential, Key[p], <||>]]]

$letterDifferential = <||>;

hochschildTerms[f_List] := With[{k = Length[f], degs = Append[Lookup[$letterDegrees, f], 1]},
	Join @@ Table[
		With[{rf = RotateLeft[Range[k], r - 1], w = RotateLeft[f, r - 1]},
			Map[t |-> {t[[1]] koszulSign[hochschildPerm[rf], degs, 0], Join[t[[2]], Rest[w]]},
				$diamondCoproduct[w[[1]]]]],
		{r, k}]]

hochschildPerm[rf_List] := Join[{rf[[1]], Length[rf] + 1}, Rest[rf]]

$diamondCoproduct = <|"x" -> {{-1, {"x", "x"}}}, "y" -> {{1, {"x", "y"}}, {-1, {"y", "x"}}}|>;

declareHat[hat_Symbol, op_, prod_Symbol, deg_, parity_Integer, p_Integer] := (
	declareLinear[hat];
	hat[w_cyc] := hat[prod[w]];
	hat[w_prod] := Total[Map[
		sh |-> koszulSign[Join @@ sh, Map[deg, List @@ w], parity] (prod @@ Prepend[(List @@ w)[[sh[[2]]]], op[prod @@ (List @@ w)[[sh[[1]]]]]]),
		shufflePairs[p, Length[w] - p]]];
)

shufflePairs[p_Integer, q_Integer] := Map[s |-> {s, Complement[Range[p + q], s]}, Subsets[Range[p + q], {p}]]

Format[tp[u_, v_]] := Row[{u, "\[CircleTimes]", v}]

declareHat[hatQ110Wedge, q110, wedge, degC, 1, 1]

declareHat[hatQ210Wedge, q210Wedge, wedge, degC, 1, 2]

declareHat[hatQ120Wedge, q120Wedge, wedge, degC, 1, 1]

declareHat[hatQ110Odot, q110, odot, degC1, 0, 1]

declareHat[hatQ210Odot, q210Odot, odot, degC1, 0, 2]

declareHat[hatQ120Odot, q120Odot, odot, degC1, 0, 1]

declareHat[hatQ210OdotNaive, q210OdotNaive, odot, degC1, 0, 2]

Scan[declareLinear, {mu, muOdotNaive, delta, deltaOdotNaive, q110,
	q210Wedge, q210Odot, q210OdotNaive, q120Wedge, q120Odot, q120OdotNaive, tp,
	q210Comp1, hochschildDual}]
