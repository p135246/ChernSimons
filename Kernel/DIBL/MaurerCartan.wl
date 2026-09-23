MaurerCartanEquation::usage = "MaurerCartanEquation[s, pairing] is the obstruction of the Maurer-Cartan equation for the element whose BD action is s; 0 means it is a Maurer-Cartan element. It is BeilinsonDrinfeldMasterEquation: the coefficient of the master equation in S_l(C[1]) HBar^g is exactly the (l, g) Maurer-Cartan equation. MaurerCartanEquation[s, pairing, \"Equations\"] returns the Association of the scalar equations on the coefficients, which is the form to feed to Solve.";

MaurerCartanQ::usage = "MaurerCartanQ[m, pairing] tests whether m is a Maurer-Cartan element.";

MaurerCartanBasis::usage = "MaurerCartanBasis[pairing, n] lists the normalized products of cyclic words of total length at most n whose symmetric degree is PlanckDegree[pairing] — the genus-zero monomials a BD action is built from. One-factor monomials are bare cyclic words. MaurerCartanBasis[degree, pairing, n] uses the given degree instead.";

MaurerCartanAnsatz::usage = "MaurerCartanAnsatz[coefficient, pairing, n] is the general genus-zero BD action over MaurerCartanBasis[pairing, n], with coefficient[k] the unknown on the k-th basis monomial. MaurerCartanAnsatz[coefficient, degree, pairing, n] is the general element of the given symmetric degree over MaurerCartanBasis[degree, pairing, n], with coefficient[k] the unknown on the k-th basis monomial. Feed it to MaurerCartanEquation to get the equations those unknowns must satisfy. The coefficients must be free of CyclicWord and HBar, or the operations stop being linear in them.";

TwistedDifferential::usage = "TwistedDifferential[m, w, pairing] is the differential q110 twisted by the element m, in the exterior picture the paper writes it in. It is CyclicDifferential plus the bracket with m; on a formal alphabet the first summand vanishes and the twist is the whole of it, and when m is a Maurer-Cartan element the sum squares to zero and its homology is Connes' cyclic cohomology.";

TwistedCobracket::usage = "TwistedCobracket[m, w, pairing] is the co-bracket q120 twisted by the element m, in the exterior picture the paper writes it in.";

GaugeFlow::usage = "GaugeFlow[a, b, pairing, n, t, order] solves the BD homotopy equation \[CapitalDelta]b + {a, b} = -a' by Picard iteration, starting from the BD action a at t = 0 and flowing along the interval component b. The result is a polynomial in t of degree at most order, truncated to monomials of total word length at most n. Two BD actions are BD homotopic, equivalently their Maurer-Cartan elements are gauge equivalent, when such a flow connects them.";

(* ----- Maurer-Cartan elements -----

   The recipe that produces the element of a given geometry — ribbon graphs, their combinatorial
   coefficients, the integrals and the signs — is not implemented. An element is supplied, as an
   Ansatz over MaurerCartanBasis or written out, and everything here works from it. *)

MaurerCartanEquation[s_, pr_Association] := BeilinsonDrinfeldMasterEquation[s, pr]

MaurerCartanEquation[s_, pr_Association, "Equations"] := BeilinsonDrinfeldMasterEquation[s, pr, "Equations"]

MaurerCartanQ[s_, pr_Association] := BeilinsonDrinfeldMasterQ[s, pr]

PlanckDegree[pr_Association] := 2 (pr["Degree"] + 2 - 3)

MaurerCartanBasis[pr_Association, n_Integer] := MaurerCartanBasis[PlanckDegree[pr], pr, n]

MaurerCartanBasis[degree_Integer, pr_Association, n_Integer] :=
	Select[mcMonomials[pr, n], b |-> productDegree[b, pr] === degree]

mcMonomials[pr_Association, n_Integer] := DeleteDuplicates @ DeleteCases[
	Map[fs |-> normalizedProduct[fs, pr], Join @@ Table[
		Select[Tuples[CyclicWords[n, GradedPairing[pr], "UpTo" -> True], k],
			fs |-> Total[Map[Length @* First, fs]] <= n],
		{k, n}]], 0]

normalizedProduct[{u_}, _Association] := u

normalizedProduct[fs_List, pr_Association] :=
	FirstCase[{SymmetricProduct @@ Append[fs, GradedPairing[pr]]}, _SymmetricProduct, 0, Infinity]

productDegree[b_, pr_Association] := operationValue[degF1, {b}, pr]

(* the coefficients are indexed by position in MaurerCartanBasis, not by the monomial itself: a
   coefficient carrying a CyclicWord is rewritten to the engine's cyc along with everything else,
   and the engine's scalarQ then refuses to pull it out of a product, so the operations stop being
   linear in it and come back unevaluated. Any coefficient free of CyclicWord and HBar is safe. *)

MaurerCartanAnsatz[c_, pr_Association, n_Integer] := MaurerCartanAnsatz[c, PlanckDegree[pr], pr, n]

MaurerCartanAnsatz[c_, degree_Integer, pr_Association, n_Integer] :=
	With[{basis = MaurerCartanBasis[degree, pr, n]},
		Total[MapIndexed[{b, k} |-> c[First[k]] b, basis]]]

(* ----- the twisted operations ----- *)

TwistedDifferential[m_, w_, pr_Association] := operationValue[q110Twisted, {m, w}, pr]

TwistedCobracket[m_, w_, pr_Association] := operationValue[q120Twisted, {m, w}, pr]

(* ----- BD homotopies and the gauge defect -----

   The flow is generic: the BD homotopy equation is written in the BD algebra itself, so it needs
   no alphabet. The circle's own slaving map and defect are not part of the API; they are in
   Code/CircleGauge.wl. *)

GaugeFlow[a0_, b_, pr_Association, n_Integer, tVar_, tOrder_Integer] :=
	With[{source = BeilinsonDrinfeldOperator[b, pr]},
		Nest[a |-> truncateMonomials[
				a0 - gaugeIntT[source + BeilinsonDrinfeldBracket[a, b, pr], tVar, tOrder], n],
			a0, tOrder]]

truncateMonomials[e_, n_Integer] :=
	Expand[e] /. m : (_CyclicWord | _SymmetricProduct) /; monomialLength[m] > n :> 0

monomialLength[CyclicWord[w_List]] := Length[w]

monomialLength[SymmetricProduct[fs__]] := Total[Map[monomialLength, {fs}]]
