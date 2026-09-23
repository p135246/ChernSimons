BeilinsonDrinfeldOperator::usage = "BeilinsonDrinfeldOperator[e, pairing] is the operator \[CapitalDelta] = q110 + q120 + HBar q210 of the Beilinson-Drinfeld algebra of symmetric powers of cyclic words. It is a derivative of order at most 2 of symmetric degree -1, and squares to zero exactly when the underlying structure is a dIBL algebra. The q110 term is CyclicDifferential, which is zero unless the pairing carries a Poincare duality algebra with a differential, so on a formal alphabet \[CapitalDelta] is q120 + HBar q210.";

BeilinsonDrinfeldBracket::usage = "BeilinsonDrinfeldBracket[f, g, pairing] is the BD bracket, the bracket already present on symmetric powers of cyclic words before HBar is adjoined: q210 inserted into f, with the sign of the symmetric degree of f. It is the bracket of the BD axiom \[CapitalDelta](f g) = \[CapitalDelta](f) g + (-1)^|f| f \[CapitalDelta](g) + (-1)^|f| HBar {f, g}, and carries no HBar itself; the derived bracket of \[CapitalDelta] on the localization is HBar times it, and is the BV bracket.";

BeilinsonDrinfeldMasterEquation::usage = "BeilinsonDrinfeldMasterEquation[s, pairing] is the obstruction \[CapitalDelta]s + 1/2 {s, s} of the BD master equation for the BD action s; 0 means s solves it. The equation is taken over R[[HBar]], without inverting HBar. BeilinsonDrinfeldMasterEquation[s, pairing, \"Equations\"] returns instead the Association of the scalar equations, one per HBar power and product of cyclic words appearing in the obstruction.";

BeilinsonDrinfeldMasterQ::usage = "BeilinsonDrinfeldMasterQ[s, pairing] tests whether the BD action s solves the BD master equation.";

PlanckDegree::usage = "PlanckDegree[pairing] is the symmetric degree 2(n - 3) of the formal variable HBar, n being the Poincare duality degree of the pairing. It is also the degree of a BD action, so it is the default degree of MaurerCartanBasis.";

HBar::usage = "HBar is the formal \[HBar] of the BD algebra, of symmetric degree PlanckDegree[pairing] = 2(n - 3). BeilinsonDrinfeldOperator is q120 + HBar q210, and the BD action of a Maurer-Cartan element is the sum of its genus-g components weighted by HBar^g.";

(* ----- the Beilinson-Drinfeld algebra -----

   The paper works over R[[HBar]] and never inverts HBar. The engine's bvBracket is the derived
   bracket of Delta, which the BD axiom makes HBar times the BD bracket — that is the BV bracket of
   the localization. So the HBar-free bracket the BD formalism is written in is bvBracket/HBar, and
   the BD master equation is Delta S + 1/2 {S, S} with no HBar^-1 anywhere. *)

BeilinsonDrinfeldOperator[e_, pr_Association] := operationValue[bdOperator, {e}, pr]

BeilinsonDrinfeldBracket[f_, g_, pr_Association] := operationValue[bdBracket, {f, g}, pr]

BeilinsonDrinfeldMasterEquation[s_, pr_Association] := Expand[BeilinsonDrinfeldOperator[s, pr] + BeilinsonDrinfeldBracket[s, s, pr]/2]

BeilinsonDrinfeldMasterEquation[s_, pr_Association, "Equations"] :=
	elementCoefficients[BeilinsonDrinfeldMasterEquation[s, pr]]

BeilinsonDrinfeldMasterQ[s_, pr_Association] := BeilinsonDrinfeldMasterEquation[s, pr] === 0

(* An element of the obstruction is a sum of scalar times monomial, the monomial being a power of
   HBar times a product of cyclic words. Different HBar powers are independent equations, so HBar
   belongs to the monomial and not to the coefficient. *)

elementCoefficients[e_] := With[{terms = Expand[e]},
	GroupBy[If[Head[terms] === Plus, List @@ terms, {terms}],
		monomialPart -> scalarPart, Total]]

monomialPart[t_] := Times @@ Select[termFactors[t], ! FreeQ[#, CyclicWord | HBar] &]

scalarPart[t_] := Times @@ Select[termFactors[t], FreeQ[#, CyclicWord | HBar] &]

termFactors[t_] := If[Head[t] === Times, List @@ t, {t}]
