PackageExported[AInfinityAlgebra]
PackageExported[AInfinityOperation]
PackageExported[AInfinityMorphism]

AInfinityAlgebra::usage = "AInfinityAlgebra[degrees, products] is the A-infinity algebra with the basis elements and shifted degrees of the Association degrees and the operations m_k given by the function products.";

AInfinityOperation::usage = "AInfinityOperation[algebra, {e1, ..., ek}] gives the operation m_k of algebra applied to the elements e1, ..., ek.";

AInfinityMorphism::usage = "AInfinityMorphism[source, target, f] is the collection of multilinear maps f_k from the AInfinityAlgebra source to the AInfinityAlgebra target given by the function f.";

AInfinityAlgebra[degrees_Association, products_] /; And[
		AllTrue[degrees, IntegerQ],
		AllTrue[Keys[degrees], b |-> MatchQ[CoefficientRules[b, Variables[b]], {_ -> 1}]]] :=
	AInfinityAlgebra[<|"Degrees" -> degrees, "Basis" -> Keys[degrees], "Products" -> products|>]

AInfinityOperation[algebra_AInfinityAlgebra, arguments_List] /;
	AllTrue[arguments, e |-> PolynomialQ[e, Variables[algebra["Basis"]]]] := With[
	{variables = Variables[algebra["Basis"]]},
	{coordinates = Map[
		e |-> Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[e, variables]],
		arguments]},
	Expand[Total[Map[
		tuple |-> Times @@ Values[tuple] algebra["Products"][Keys[tuple]],
		Tuples[coordinates]]]] /; SubsetQ[algebra["Basis"], Keys[Catenate[coordinates]]]]

AInfinityMorphism[source : AInfinityAlgebra[_Association], target : AInfinityAlgebra[_Association], f_] :=
	AInfinityMorphism[<|"Source" -> source, "Target" -> target, "Components" -> f|>]
