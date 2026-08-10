koszulSign[perm_List, degs_List, parity_Integer] :=
	Module[{len = Length[perm], p, q, e = 0, i, j},
		p = Range[len];
		q = Range[len];
		For[i = 1, i <= len, i++,
			For[j = q[[perm[[i]]]] - 1, j >= i, j--,
				p[[j + 1]] = p[[j]];
				e += parity + degs[[p[[j]]]] degs[[perm[[i]]]];
				q[[p[[j]]]]++
			];
			p[[i]] = perm[[i]];
			q[[perm[[i]]]] = i
		];
		sgn[e]
	]

sgn[k_Integer] := If[OddQ[k], -1, 1]
