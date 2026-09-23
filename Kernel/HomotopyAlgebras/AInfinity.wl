AInfinityAlgebra::usage = "AInfinityAlgebra[degrees, products] builds an A-infinity algebra on a finite-dimensional graded space. degrees is an Association from basis elements to their shifted degrees; products is a function of a list of basis elements giving m_k on it, as a linear combination of basis elements, and 0 on the arities it does not define. The result is a plain Association with keys \"Degrees\", \"Basis\" and \"Products\".";

AInfinityOperation::usage = "AInfinityOperation[algebra, {e1, ..., ek}] is m_k applied to the elements, each a linear combination of basis elements. It is the multilinear extension of the algebra's products.";

AInfinityObstruction::usage = "AInfinityObstruction[algebra, {e1, ..., en}] is the obstruction of the A-infinity relation on those elements; 0 means the relation holds there. The convention is the shifted one: the term with the inner operation on arguments r+1 to r+s carries the sign of the sum of the degrees of the first r arguments.";

AInfinityQ::usage = "AInfinityQ[algebra, n] tests the A-infinity relations on every tuple of basis elements of length at most n.";

AInfinityMorphismObstruction::usage = "AInfinityMorphismObstruction[source, target, f, {e1, ..., en}] is the obstruction of the morphism relation for the collection f, a function of a list of source elements giving f_k on it as an element of the target; 0 means the relation holds there. The right-hand side sums over all compositions of the arguments into blocks, so a target with operations beyond m_2 is handled.";

AInfinityMorphismQ::usage = "AInfinityMorphismQ[source, target, f, n] tests the morphism relations on every tuple of basis elements of the source of length at most n.";

(* ----- A-infinity algebras -----

   Finite-dimensional, and general: unlike the Maurer-Cartan and BD layer above, which takes a
   pairing, an A-infinity algebra here is its own object — a basis, its shifted degrees, and the
   structure constants. The sign convention is the shifted one, the same the engine's ainftyRelation
   uses, so the circle's twisted structure is an instance and T12 pins it as one. *)

AInfinityAlgebra[degs_Association, products_] :=
	AInfinityAlgebra[<|"Degrees" -> degs, "Basis" -> Keys[degs], "Products" -> products|>]

AInfinityOperation[alg_Association, args_List] :=
	multilinearValue[alg, alg["Products"], args]

(* both the products and a morphism's components are given by their values on basis tuples, so both
   have to be extended multilinearly before they meet a composite argument — the inner operation of
   a relation returns a linear combination, not a basis element. *)

multilinearValue[alg_Association, f_, args_List] :=
	Expand[Total[Map[tuple |-> basisCoefficient[args, tuple] f[tuple],
		Tuples[alg["Basis"], Length[args]]]]]

basisCoefficient[args_List, tuple_List] :=
	Times @@ MapThread[{e, b} |-> Coefficient[e, b], {args, tuple}]

AInfinityObstruction[alg_Association, args_List] := Expand[Total[Map[
	rs |-> shiftedSign[alg, Take[args, rs[[1]]]] AInfinityOperation[alg,
		Join[Take[args, rs[[1]]],
			{AInfinityOperation[alg, args[[rs[[1]] + 1 ;; rs[[1]] + rs[[2]]]]]},
			Drop[args, rs[[1]] + rs[[2]]]]],
	splittings[Length[args]]]]]

splittings[n_Integer] := Join @@ Table[{r, s}, {r, 0, n - 1}, {s, n - r}]

shiftedSign[alg_Association, args_List] :=
	sgn[Total[Map[e |-> Total[Map[b |-> Coefficient[e, b] alg["Degrees"][b], alg["Basis"]]], args]]]

AInfinityQ[alg_Association, n_Integer] :=
	AllTrue[basisTuples[alg, n], tuple |-> AInfinityObstruction[alg, tuple] === 0]

basisTuples[alg_Association, n_Integer] :=
	Join @@ Table[Tuples[alg["Basis"], k], {k, n}]

AInfinityMorphismObstruction[source_Association, target_Association, f_, args_List] :=
	Expand[Total[Map[
			rs |-> shiftedSign[source, Take[args, rs[[1]]]] multilinearValue[source, f,
				Join[Take[args, rs[[1]]],
					{AInfinityOperation[source, args[[rs[[1]] + 1 ;; rs[[1]] + rs[[2]]]]]},
					Drop[args, rs[[1]] + rs[[2]]]]],
			splittings[Length[args]]]] -
		Total[Map[blocks |-> AInfinityOperation[target,
				Map[block |-> multilinearValue[source, f, block], blocks]],
			compositions[args]]]]

compositions[args_List] := Map[
	sizes |-> MapThread[{a, b} |-> args[[a + 1 ;; b]], {Prepend[Most[#], 0], #}] &[Accumulate[sizes]],
	Join @@ Map[Permutations, IntegerPartitions[Length[args]]]]

AInfinityMorphismQ[source_Association, target_Association, f_, n_Integer] :=
	AllTrue[basisTuples[source, n],
		tuple |-> AInfinityMorphismObstruction[source, target, f, tuple] === 0]
