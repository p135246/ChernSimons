gaugeFlow[w_, c0_Association, d0_Association, nMax_Integer, tVar_, tDeg_Integer] :=
	gaugeFlowSolve[gaugeDdot, w, c0, d0, nMax, tVar, tDeg]

gaugeFlowOdot[w_, c0_Association, d0_Association, nMax_Integer, tVar_, tDeg_Integer] :=
	gaugeFlowSolve[gaugeDdotOdot, w, c0, d0, nMax, tVar, tDeg]

gaugeFlowSolve[ddot_, w_, c0_, d0_, nMax_, tVar_, tDeg_] := With[
	{ckeys = Select[Subsets[Range[0, nMax], {2}], k |-> Total[k] <= nMax],
		dkeys = Select[Join @@ Table[{i, j}, {i, 1, nMax}, {j, i, nMax}], k |-> Total[k] <= nMax]},
	Nest[state |-> gaugePicardStep[ddot, w, c0, d0, ckeys, dkeys, tVar, tDeg, state],
		<|"c" -> c0, "d" -> d0|>, tDeg]]

gaugePicardStep[ddot_, w_, c0_, d0_, ckeys_, dkeys_, tVar_, tDeg_, state_] := <|
	"c" -> Association[Map[k |-> k ->
		Lookup[c0, Key[k], 0] + gaugeIntT[gaugeCdot[gaugeC[state["c"]], w][k[[1]], k[[2]]], tVar, tDeg], ckeys]],
	"d" -> Association[Map[k |-> k ->
		Lookup[d0, Key[k], 0] + gaugeIntT[ddot[gaugeD[state["d"]], w][k[[1]], k[[2]]], tVar, tDeg], dkeys]]|>

gaugeCdot[c_, w_][i_, j_] := Sum[u w[i + 1 - u] c[u, j], {u, 0, i + 1}] +
	Sum[v w[j + 1 - v] c[i, v], {v, 0, j + 1}] -
	2 Sum[w[u + v + 1] c[i - u, j - v], {u, 0, i}, {v, 0, j}]

gaugeDdot[d_, w_][i_, j_] := Sum[u w[i + 1 - u] d[u, j], {u, 0, i + 1}] +
	Sum[v w[j + 1 - v] d[i, v], {v, 0, j + 1}] - 2 w[i + j + 1]

gaugeDdotOdot[d_, w_][i_, j_] := Sum[u w[i + 1 - u] d[u, j], {u, 0, i + 1}] +
	Sum[v w[j + 1 - v] d[i, v], {v, 0, j + 1}] + 2 w[i + j + 1]

gaugeDdotPrinted[d_, w_][i_, j_] := Sum[u w[i + 1 - u] d[u, j], {u, 0, i + 1}] +
	Sum[v w[j + 1 - v] d[i, v], {v, 0, j + 1}] - w[i + j + 1]

gaugeC[a_Association][i_, j_] := Which[i < 0 || j < 0 || i == j, 0,
	i < j, Lookup[a, Key[{i, j}], 0], True, -Lookup[a, Key[{j, i}], 0]]

gaugeD[a_Association][i_, j_] := Which[i < 1 || j < 1, 0,
	i <= j, Lookup[a, Key[{i, j}], 0], True, Lookup[a, Key[{j, i}], 0]]

gaugeIntT[e_, tVar_, tDeg_] := With[{ex = Expand[e]},
	Sum[Coefficient[ex, tVar, m] tVar^(m + 1)/(m + 1), {m, 0, tDeg - 1}]]

gaugeTriple[c_][p_, q_, r_] := gaugeACoef[c][p, q, r] + gaugeACoef[c][r, p, q] + gaugeACoef[c][q, r, p]

gaugeACoef[c_][p_, q_, r_] := Sum[c[i, j] c[r, p + q + 1 - i - j], {i, 0, p}, {j, 0, q}]

gaugePhi[cf_][i_, j_] := gaugePhiValue[cf, Min[i, j], Max[i, j]]

gaugePhiValue[cf_, 1, j_] /; 1 <= j <= 6 := 2 cf[0, j + 2]/cf[0, 1]

gaugePhiValue[cf_, 2, 2] := 2 cf[0, 5]/cf[0, 1] + cf[0, 3]^2/cf[0, 1]^2

gaugePhiValue[cf_, 2, 3] := 2 cf[0, 6]/cf[0, 1] + 2 cf[0, 3] cf[0, 4]/cf[0, 1]^2

gaugePhiValue[cf_, 2, 4] := 2 cf[0, 7]/cf[0, 1] + (cf[0, 4]^2 + 2 cf[0, 3] cf[0, 5])/cf[0, 1]^2

gaugePhiValue[cf_, 2, 5] := 2 cf[0, 8]/cf[0, 1] + 2 (cf[0, 4] cf[0, 5] + cf[0, 3] cf[0, 6])/cf[0, 1]^2

gaugePhiValue[cf_, 3, 3] := 2 cf[0, 7]/cf[0, 1] + (2 cf[0, 4]^2 + 2 cf[0, 3] cf[0, 5])/cf[0, 1]^2 + 2 cf[0, 3]^3/(3 cf[0, 1]^3)

gaugePhiValue[cf_, 3, 4] := 2 cf[0, 8]/cf[0, 1] + (4 cf[0, 4] cf[0, 5] + 2 cf[0, 3] cf[0, 6])/cf[0, 1]^2 + 2 cf[0, 3]^2 cf[0, 4]/cf[0, 1]^3

gaugePhiGF[cf_][i_, j_] := With[{s = i + j},
	2 Sum[Coefficient[Coefficient[Expand[gaugePhiGFKernel[cf, s]^r], \[FormalX], i], \[FormalY], j]/r,
		{r, 1, Quotient[s, 2]}]]

gaugePhiGFKernel[cf_, s_] := Expand[\[FormalX] \[FormalY] Sum[(cf[0, m + 1]/cf[0, 1])
	Sum[\[FormalX]^a \[FormalY]^(m - 2 - a), {a, 0, m - 2}], {m, 2, s}]]

gaugePhiOdot[cf_][i_, j_] := -gaugePhiGF[cf][i, j]

gaugeDefectOdot[cf_, df_][i_, j_] := df[i, j] - gaugePhiOdot[cf][i, j]

gaugeFirstRow[a_Association][i_, j_] := Which[i == 0, Lookup[a, Key[{0, j}], 0],
	j == 0, -Lookup[a, Key[{0, i}], 0], True, 0]

gaugeMCRows[row_, nMax_Integer] := Module[{known = <||>, cf, relations, unknowns, solution},
	Do[
		cf = {i, j} |-> Which[i < 0 || j < 0 || i == j, 0, i > j, -cf[j, i], i == 0, row[j],
			KeyExistsQ[known, {i, j}], known[{i, j}], True, \[FormalC][i, j]];
		relations = DeleteCases[Expand[Flatten[Table[If[p <= q <= r && p + q + r == level,
			gaugeTriple[cf][p, q, r], Nothing], {p, 0, level}, {q, 0, level}, {r, 0, level}]]], 0];
		unknowns = Select[Variables[relations], v |-> MatchQ[v, \[FormalC][_, _]]];
		If[unknowns =!= {},
			solution = First[Quiet[Solve[Thread[relations == 0], unknowns]]];
			Scan[u |-> AssociateTo[known, List @@ u -> Together[u /. solution]], unknowns]],
		{level, 2, nMax}];
	known]

gaugeMCData[row_, nMax_Integer] := With[{rows = gaugeMCRows[row, nMax]},
	Association[Map[k |-> k -> Lookup[rows, Key[k], row[k[[2]]]],
		Select[Subsets[Range[0, nMax], {2}], k |-> Total[k] <= nMax]]]]

gaugeCharMap[w_, nMax_Integer, tVar_, tDeg_Integer] := Nest[e |-> \[FormalX] +
	gaugeIntT[gaugeTruncX[Sum[w[k] \[FormalX]^k, {k, 0, nMax}] D[e, \[FormalX]], nMax], tVar, tDeg],
	\[FormalX], tDeg + 1]

gaugeTruncX[e_, n_] := Sum[Coefficient[Expand[e], \[FormalX], m] \[FormalX]^m, {m, 0, n}]
