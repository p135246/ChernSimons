PackageExported[Obstruction]
PackageExported[Relations]
PackageExported[RelationsQ]

Obstruction::usage = "Obstruction[structure, relation, {a1, ..., ak}] gives the obstruction of the named relation of structure on the arguments a1, ..., ak, which is 0 when the relation holds there.\nObstruction[structure, {a1, ..., ak}] gives the obstruction of the one relation of structure on the arguments a1, ..., ak.\nObstruction[m] gives the obstruction \[CapitalDelta]s + 1/2 {s, s} of the Maurer-Cartan equation for the MaurerCartanElement m with BD action s.\nObstruction[m, \"Equations\"] gives the Association of the scalar equations on the coefficients of m.\nThe option \"EmptyWord\" -> True computes the obstruction of an element m with the empty word.";

Relations::usage = "Relations[structure] gives the Association from the name of each relation of structure to its arity, the number of arguments Obstruction takes for it.";

RelationsQ::usage = "RelationsQ[structure, n] tests whether every relation of structure holds on every tuple of arguments in the range n sets.\nRelationsQ[structure] tests whether every relation of a CochainComplexWithPairing, a PreHodgeDecomposition, a HodgeDecomposition or a SpecialPropagator holds.\nRelationsQ[m] tests whether the MaurerCartanElement m solves the Maurer-Cartan equation.\nThe option \"EmptyWord\" -> True tests an element m with the empty word.";

Options[Obstruction] = {"EmptyWord" -> False}

Options[RelationsQ] = {"EmptyWord" -> False}

Relations[AInfinityAlgebra[_Association]] := <|"AInfinity" -> All|>

Relations[AInfinityMorphism[_Association]] := <|"AInfinityMorphism" -> All|>

Obstruction[algebra : AInfinityAlgebra[_Association], arguments_List] /;
	AllTrue[arguments, e |-> PolynomialQ[e, Variables[algebra["Basis"]]]] := With[
	{variables = Variables[algebra["Basis"]], n = Length[arguments]},
	{coordinates = Map[
		e |-> Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[e, variables]],
		arguments]},
	Expand[Total[Map[
		tuple |-> With[{basis = Keys[tuple]},
			Times @@ Values[tuple] Total[Map[
				rs |-> Times[
					(-1)^Total[Lookup[algebra["Degrees"], Take[basis, First[rs]]]],
					AInfinityOperation[algebra, Join[
						Take[basis, First[rs]],
						{AInfinityOperation[algebra, basis[[First[rs] + 1 ;; Total[rs]]]]},
						Drop[basis, Total[rs]]]]],
				Catenate[Table[{r, s}, {r, 0, n - 1}, {s, n - r}]]]]],
		Tuples[coordinates]]]] /; SubsetQ[algebra["Basis"], Keys[Catenate[coordinates]]]]

Obstruction[algebra : AInfinityAlgebra[_Association], "AInfinity", arguments_List] := With[
	{obstruction = Obstruction[algebra, arguments]},
	obstruction /; Head[obstruction] =!= Obstruction]

Obstruction[morphism : AInfinityMorphism[_Association], arguments_List] /;
	AllTrue[arguments, e |-> PolynomialQ[e, Variables[morphism["Source"]["Basis"]]]] := With[
	{source = morphism["Source"], target = morphism["Target"], f = morphism["Components"],
		variables = Variables[morphism["Source"]["Basis"]], n = Length[arguments]},
	{coordinates = Map[
		e |-> Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[e, variables]],
		arguments]},
	Expand[Total[Map[
		tuple |-> With[{basis = Keys[tuple]},
			Times @@ Values[tuple] Subtract[
				Total[Map[
					rs |-> Times[
						(-1)^Total[Lookup[source["Degrees"], Take[basis, First[rs]]]],
						Total[Map[
							inner |-> Last[inner] f[Join[Take[basis, First[rs]], {First[inner]}, Drop[basis, Total[rs]]]],
							Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule], CoefficientRules[
								AInfinityOperation[source, basis[[First[rs] + 1 ;; Total[rs]]]], variables]]]]],
					Catenate[Table[{r, s}, {r, 0, n - 1}, {s, n - r}]]]],
				Total[Map[
					sizes |-> AInfinityOperation[target, Map[block |-> f[block], TakeList[basis, sizes]]],
					Catenate[Map[Permutations, IntegerPartitions[n]]]]]]],
		Tuples[coordinates]]]] /; SubsetQ[source["Basis"], Keys[Catenate[coordinates]]]]

Obstruction[morphism : AInfinityMorphism[_Association], "AInfinityMorphism", arguments_List] := With[
	{obstruction = Obstruction[morphism, arguments]},
	obstruction /; Head[obstruction] =!= Obstruction]

RelationsQ[algebra : AInfinityAlgebra[_Association], n_Integer?NonNegative] := AllTrue[
	Catenate[Table[Tuples[algebra["Basis"], k], {k, n}]],
	tuple |-> Obstruction[algebra, tuple] === 0]

RelationsQ[morphism : AInfinityMorphism[_Association], n_Integer?NonNegative] := AllTrue[
	Catenate[Table[Tuples[morphism["Source"]["Basis"], k], {k, n}]],
	tuple |-> Obstruction[morphism, tuple] === 0]
