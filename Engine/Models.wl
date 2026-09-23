sullivanModel[gens_Association, diff_Association, vol_List] := sullivanModel[gens, diff, vol, Infinity]

sullivanModel[gens_Association, diff_Association, vol_List, trunc_] := <|
	"Generators" -> gens,
	"Differential" -> Association[Map[g |-> g -> asElement[Lookup[diff, Key[g], <||>]], Keys[gens]]],
	"Volume" -> vol,
	"Degree" -> Total[Lookup[gens, vol]],
	"Truncation" -> trunc|>

modelMonomials[model_Association, k_Integer] := If[k < 0 || k > model["Truncation"], {},
	Map[e |-> Catenate[MapThread[ConstantArray, {Keys[model["Generators"]], e}]],
		exponentVectors[Values[model["Generators"]], k]]]

modelDegree[mono_List, model_Association] := Total[Lookup[model["Generators"], mono]]

modelProduct[e1_Association, e2_Association, model_Association] := collectTerms[Catenate[Catenate[
	Map[p |-> Map[q |-> monomialTimes[p, q, Lookup[e1, Key[p], 0] Lookup[e2, Key[q], 0], model],
			Keys[e2]],
		Keys[e1]]]]]

modelDifferential[e_Association, model_Association] := collectTerms[Catenate[
	Map[p |-> monomialDifferential[p, Lookup[e, Key[p], 0], model], Keys[e]]]]

modelOrientation[e_Association, model_Association] := Lookup[e, Key[model["Volume"]], 0]

modelPairing[e1_Association, e2_Association, model_Association] :=
	modelOrientation[modelProduct[e1, e2, model], model]

modelPairingValue[p_List, q_List, model_Association] := modelPairing[<|p -> 1|>, <|q -> 1|>, model]

modelTripleValue[p_List, q_List, r_List, model_Association] := modelOrientation[
	modelProduct[modelProduct[<|p -> 1|>, <|q -> 1|>, model], <|r -> 1|>, model], model]

modelPairingMatrix[model_Association, k_Integer] := With[
	{cols = modelMonomials[model, model["Degree"] - k]},
	Map[p |-> Map[q |-> modelPairingValue[p, q, model], cols], modelMonomials[model, k]]]

modelDifferentialMatrix[model_Association, k_Integer] := With[
	{cols = modelMonomials[model, k + 1]},
	Map[p |-> With[{image = modelDifferential[<|p -> 1|>, model]},
			Map[q |-> Lookup[image, Key[q], 0], cols]],
		modelMonomials[model, k]]]

modelDegenerateBasis[model_Association, k_Integer] := With[{mat = modelPairingMatrix[model, k]},
	Which[
		mat === {}, {},
		First[mat] === {}, IdentityMatrix[Length[mat]],
		True, NullSpace[Transpose[mat]]]]

modelCohomologyDimension[model_Association, k_Integer] :=
	Length[modelMonomials[model, k]] - matrixRank[modelDifferentialMatrix[model, k]] -
		matrixRank[modelDifferentialMatrix[model, k - 1]]

modelDegenerateCohomologyDimension[model_Association, k_Integer] :=
	Length[modelDegenerateBasis[model, k]] - restrictedRank[model, k] - restrictedRank[model, k - 1]

modelHodgeTypeQ[model_Association] := modelHodgeTypeQ[model, model["Degree"] + 1]

modelHodgeTypeQ[model_Association, dmax_Integer] :=
	AllTrue[Range[0, dmax], k |-> modelDegenerateCohomologyDimension[model, k] === 0]

modelReport[model_Association, dmax_Integer] := Association[Map[
	k |-> k -> <|
		"Dimension" -> Length[modelMonomials[model, k]],
		"Cohomology" -> modelCohomologyDimension[model, k],
		"Degenerate" -> Length[modelDegenerateBasis[model, k]],
		"DegenerateCohomology" -> modelDegenerateCohomologyDimension[model, k],
		"Quotient" -> Length[modelQuotientMonomials[model, k]]|>,
	Range[0, dmax]]]

modelQuotientMonomials[model_Association, k_Integer] :=
	modelMonomials[model, k][[independentRows[modelPairingMatrix[model, k]]]]

modelQuotient[model_Association] := With[
	{basis = Catenate[Map[k |-> modelQuotientMonomials[model, k], Range[0, model["Degree"]]]]},
	With[{degrees = Map[p |-> modelDegree[p, model], basis],
			gram = Map[p |-> Map[q |-> modelPairingValue[p, q, model], basis], basis]},
		With[{differential = quotientDifferentialPairing[model, basis, degrees]},
			<|"Degree" -> model["Degree"],
				"Basis" -> basis,
				"Degrees" -> degrees,
				"Pairing" -> gram,
				"DifferentialPairing" -> differential,
				"Differential" -> quotientDifferentialMatrix[differential, gram, Length[basis]],
				"Triple" -> quotientTriple[model, basis, degrees],
				"Model" -> model|>]]]

pdShiftedDegrees[pd_Association] := pd["Degrees"] - 1

pdShiftedPairing[pd_Association] := Map[
	i |-> Map[j |-> sgn[pd["Degrees"][[i]]] pd["Pairing"][[i, j]], Range[Length[pd["Basis"]]]],
	Range[Length[pd["Basis"]]]]

pdCanonicalMC[names_List, degrees_List, n_Integer, triple_Association] := Expand[(1/3) Total[Map[
	t |-> canonicalSign[n, degrees[[t[[1]]]], degrees[[t[[2]]]], degrees[[t[[3]]]]] *
		Lookup[triple, Key[t], 0] cyc[names[[t]]],
	Keys[triple]]]]

exponentVectors[{}, 0] := {{}}

exponentVectors[{}, _Integer] := {}

exponentVectors[degs_List, k_Integer] := With[{d = First[degs]},
	Catenate[Map[
		i |-> Map[e |-> Prepend[e, i], exponentVectors[Rest[degs], k - i d]],
		Range[0, If[OddQ[d], Min[1, Quotient[k, d]], Quotient[k, d]]]]]]

asElement[mono_List] := <|mono -> 1|>

asElement[e_Association] := e

collectTerms[terms_List] := DeleteCases[Merge[Map[Apply[Rule], terms], Total], 0]

monomialTimes[p_List, q_List, c_, model_Association] := With[
	{sorted = sortMonomial[Join[p, q], model["Generators"]]},
	If[sorted[[1]] === 0 || modelDegree[sorted[[2]], model] > model["Truncation"], {},
		{{sorted[[2]], sorted[[1]] c}}]]

sortMonomial[w_List, gens_Association] := Module[
	{index = AssociationThread[Keys[gens] -> Range[Length[gens]]], list = w, sign = 1, swap, pass, spot},
	Do[Do[If[index[list[[spot]]] > index[list[[spot + 1]]],
			sign = sign sgn[gens[list[[spot]]] gens[list[[spot + 1]]]];
			swap = list[[spot]]; list[[spot]] = list[[spot + 1]]; list[[spot + 1]] = swap],
		{spot, Length[list] - 1}], {pass, Length[list]}];
	If[AnyTrue[Split[list], run |-> Length[run] > 1 && OddQ[gens[First[run]]]], {0, list}, {sign, list}]]

monomialDifferential[mono_List, c_, model_Association] := Catenate[Map[
	i |-> With[{pre = Take[mono, i - 1], post = Drop[mono, i],
			image = Lookup[model["Differential"], Key[mono[[i]]], <||>]},
		Catenate[Map[t |-> monomialTimes[Join[pre, t], post,
				c sgn[modelDegree[pre, model]] Lookup[image, Key[t], 0], model],
			Keys[image]]]],
	Range[Length[mono]]]]

matrixRank[mat_List] := If[mat === {} || First[mat] === {}, 0, MatrixRank[mat]]

restrictedRank[model_Association, k_Integer] := With[
	{basis = modelDegenerateBasis[model, k], mat = modelDifferentialMatrix[model, k]},
	If[basis === {} || mat === {} || First[mat] === {}, 0, matrixRank[basis . mat]]]

independentRows[mat_List] := If[mat === {} || First[mat] === {}, {},
	Module[{chosen = {}, rank = 0, taken = {}, row},
		Do[If[MatrixRank[Append[chosen, mat[[row]]]] > rank,
				AppendTo[chosen, mat[[row]]]; AppendTo[taken, row]; rank++],
			{row, Length[mat]}];
		taken]]

quotientDifferentialPairing[model_Association, basis_List, degrees_List] :=
	DeleteCases[Association[Map[
		t |-> t -> modelPairing[modelDifferential[<|basis[[t[[1]]]] -> 1|>, model],
			<|basis[[t[[2]]]] -> 1|>, model],
		Select[Tuples[Range[Length[basis]], 2],
			t |-> degrees[[t[[1]]]] + degrees[[t[[2]]]] === model["Degree"] - 1]]], 0]

quotientDifferentialMatrix[differential_Association, gram_List, size_Integer] := If[size === 0, {},
	Normal[SparseArray[Normal[differential], {size, size}, 0]] . Inverse[gram]]

quotientTriple[model_Association, basis_List, degrees_List] := DeleteCases[Association[Map[
	t |-> t -> modelTripleValue[basis[[t[[1]]]], basis[[t[[2]]]], basis[[t[[3]]]], model],
	Select[Tuples[Range[Length[basis]], 3], t |-> Total[degrees[[t]]] === model["Degree"]]]], 0]

canonicalSign[n_Integer, a_Integer, b_Integer, c_Integer] :=
	sgn[n - 1 + b + a b + b c + c a]

$modelNames = {"Circle", "Sphere", "ComplexProjectiveSpace", "QuaternionicProjectiveSpace",
	"Torus", "SpecialUnitaryGroup", "HeisenbergNilmanifold", "KodairaThurston", "Degree4Obstruction"};

modelNamed[spec_] := modelNamed[spec, modelDefaultGenerators[spec]]

modelNamed["Circle", {gv_}] := sullivanModel[<|gv -> 1|>, <||>, {gv}]

modelNamed["Sphere"[dim_Integer], {gv_}] := sullivanModel[<|gv -> dim|>, <||>, {gv}] /; OddQ[dim]

modelNamed["Sphere"[dim_Integer], {gv_, gw_}] :=
	sullivanModel[<|gv -> dim, gw -> 2 dim - 1|>, <|gw -> {gv, gv}|>, {gv}] /; EvenQ[dim]

modelNamed["ComplexProjectiveSpace"[rank_Integer], {ga_, gb_}] := sullivanModel[
	<|ga -> 2, gb -> 2 rank + 1|>, <|gb -> ConstantArray[ga, rank + 1]|>, ConstantArray[ga, rank]]

modelNamed["QuaternionicProjectiveSpace"[rank_Integer], {ga_, gb_}] := sullivanModel[
	<|ga -> 4, gb -> 4 rank + 3|>, <|gb -> ConstantArray[ga, rank + 1]|>, ConstantArray[ga, rank]]

modelNamed["Torus"[rank_Integer], gens_List] :=
	sullivanModel[AssociationThread[gens -> ConstantArray[1, rank]], <||>, gens]

modelNamed["SpecialUnitaryGroup"[rank_Integer], gens_List] := sullivanModel[
	AssociationThread[gens -> Range[3, 2 rank - 1, 2]], <||>, gens]

modelNamed["HeisenbergNilmanifold", {gx_, gy_, gz_}] :=
	sullivanModel[<|gx -> 1, gy -> 1, gz -> 1|>, <|gz -> {gx, gy}|>, {gx, gy, gz}]

modelNamed["KodairaThurston", {gx_, gy_, gz_, gt_}] := sullivanModel[
	<|gx -> 1, gy -> 1, gz -> 1, gt -> 1|>, <|gz -> {gx, gy}|>, {gx, gy, gz, gt}]

modelNamed["Degree4Obstruction", {ga_, gc_}] :=
	sullivanModel[<|ga -> 2, gc -> 3|>, <|ga -> {gc}|>, {ga, ga}, 4]

modelDefaultGenerators["Circle"] := {Symbol["v"]}

modelDefaultGenerators["Sphere"[dim_Integer]] :=
	If[OddQ[dim], {Symbol["v"]}, {Symbol["v"], Symbol["w"]}]

modelDefaultGenerators["ComplexProjectiveSpace"[_Integer]] := {Symbol["a"], Symbol["b"]}

modelDefaultGenerators["QuaternionicProjectiveSpace"[_Integer]] := {Symbol["a"], Symbol["b"]}

modelDefaultGenerators["Torus"[rank_Integer]] := Map[i |-> Symbol["v" <> ToString[i]], Range[rank]]

modelDefaultGenerators["SpecialUnitaryGroup"[rank_Integer]] :=
	Map[i |-> Symbol["h" <> ToString[i]], Range[3, 2 rank - 1, 2]]

modelDefaultGenerators["HeisenbergNilmanifold"] := {Symbol["x"], Symbol["y"], Symbol["z"]}

modelDefaultGenerators["KodairaThurston"] := {Symbol["x"], Symbol["y"], Symbol["z"], Symbol["t"]}

modelDefaultGenerators["Degree4Obstruction"] := {Symbol["a"], Symbol["c"]}

modelTensor[models_List] := sullivanModel[
	Join @@ Map[one |-> one["Generators"], models],
	Join @@ Map[one |-> one["Differential"], models],
	Catenate[Map[one |-> one["Volume"], models]],
	Min[Map[one |-> one["Truncation"], models]]]
