PackageExported[SullivanModel]
PackageExported[$SullivanModels]
PackageExported[SullivanModelBasis]
PackageExported[SullivanModelProduct]
PackageExported[SullivanModelDifferential]
PackageExported[SullivanModelOrientation]
PackageExported[SullivanModelPairing]
PackageExported[OrientationQ]
PackageExported[PoincareDualityQ]
PackageExported[PerfectPairingQ]

SullivanModel::usage = "SullivanModel[name] gives the Sullivan model name of the catalogue $SullivanModels, with its orientation.\nSullivanModel[name, generators] gives the same model on the list of symbols generators.\nSullivanModel[degrees, differential, orientation] gives the Sullivan model whose generators have the degrees of the Association degrees, with the differential on the generators given by the Association differential and the orientation orientation, a monomial of degree n or an Association of values on the monomials of degree n.\nSullivanModel[degrees, differential, orientation, truncation] gives its quotient by the monomials above degree truncation.\nSullivanModel[{model1, model2, ...}] gives the tensor product of the models.";

$SullivanModels::usage = "$SullivanModels is the list of the names of the catalogue models that SullivanModel gives; a name that takes a parameter is used as name[k].";

SullivanModelBasis::usage = "SullivanModelBasis[model, k] gives the monomials of degree k of the Sullivan model model.\nSullivanModelBasis[complex, k] gives the basis elements of degree k of the CochainComplexWithPairing complex.";

SullivanModelProduct::usage = "SullivanModelProduct[e1, e2, ..., model] gives the graded commutative product of the elements e1, e2, ... of the Sullivan model model.";

SullivanModelDifferential::usage = "SullivanModelDifferential[e, model] gives the differential of the Sullivan model model applied to the element e.";

SullivanModelOrientation::usage = "SullivanModelOrientation[e, model] gives the orientation of the Sullivan model model applied to the element e.";

SullivanModelPairing::usage = "SullivanModelPairing[e1, e2, model] gives the pairing of the elements e1 and e2 of the Sullivan model model, the orientation of their product.";

OrientationQ::usage = "OrientationQ[values, model] tests whether the Association values on monomials of one degree n defines an orientation of the Sullivan model model.\nOrientationQ[values, complex] tests whether values on basis elements of one degree n defines an orientation of the CochainComplexWithPairing complex.";

PoincareDualityQ::usage = "PoincareDualityQ[model] tests whether the pairing that the orientation of the Sullivan model model induces on cohomology is perfect, checking the degrees 0 to n+1.\nPoincareDualityQ[complex] tests whether the pairing of the CochainComplexWithPairing complex is perfect on cohomology.\nThe option \"MaxDegree\" -> d, with d at least n, checks the degrees 0 to d of a model instead.";

PerfectPairingQ::usage = "PerfectPairingQ[model] tests whether the pairing of the Sullivan model model is perfect on chain level.\nPerfectPairingQ[complex] tests whether the pairing of the CochainComplexWithPairing complex is perfect on chain level.";

Options[PoincareDualityQ] = {"MaxDegree" -> Automatic};

SullivanModel[degrees_Association, differential_Association, orientation_] :=
	SullivanModel[degrees, differential, orientation, Infinity]

SullivanModel[degrees_Association, differential_Association, orientation : Except[_Association], truncation_] :=
	SullivanModel[degrees, differential, <|orientation -> 1|>, truncation]

SullivanModel[degrees_Association, differential_Association, orientation_Association, truncation_] /; And[
		AllTrue[degrees, degree |-> IntegerQ[degree] && degree >= 1],
		SubsetQ[Keys[degrees], Keys[differential]],
		AllTrue[differential, image |-> PolynomialQ[image, Keys[degrees]]],
		AllTrue[orientation, NumericQ],
		truncation === Infinity || IntegerQ[truncation]] := With[
	{values = DeleteCases[orientation, 0]},
	{model = SullivanModel[<|
		"Generators" -> degrees,
		"Differential" -> AssociationMap[generator |-> Expand[Lookup[differential, generator, 0]], Keys[degrees]],
		"Orientation" -> values,
		"Degree" -> Exponent[First[Keys[values], 1], Keys[degrees]] . Values[degrees],
		"Truncation" -> If[truncation === Infinity, <||>, <|Keys[degrees] -> truncation|>]|>]},
	Which[
		! AllTrue[Keys[degrees], generator |-> And[
				AllTrue[CoefficientRules[model["Differential"][generator], Keys[degrees]],
					rule |-> First[rule] . Values[degrees] === degrees[generator] + 1],
				SullivanModelDifferential[model["Differential"][generator], model] === 0]],
			Failure["SullivanModel", <|"MessageTemplate" ->
				"The differential does not raise the degree by one or does not square to zero."|>],
		! OrientationQ[values, model],
			Failure["SullivanModel", <|"MessageTemplate" -> "The values do not define an orientation."|>],
		True, model]]

SullivanModel[models : {__SullivanModel}] /;
	DuplicateFreeQ[Catenate[Map[model |-> Keys[model["Generators"]], models]]] := SullivanModel[<|
	"Generators" -> Join @@ Map[model |-> model["Generators"], models],
	"Differential" -> Join @@ Map[model |-> model["Differential"], models],
	"Orientation" -> Fold[
		{values, model} |-> Association[Map[
			pair |-> Times @@ pair -> values[First[pair]] model["Orientation"][Last[pair]],
			Tuples[{Keys[values], Keys[model["Orientation"]]}]]],
		<|1 -> 1|>, models],
	"Degree" -> Total[Map[model |-> model["Degree"], models]],
	"Truncation" -> Join @@ Map[model |-> model["Truncation"], models]|>]

SullivanModel["Circle"] := SullivanModel["Circle", {Symbol["v"]}]

SullivanModel["Circle", {v_}] := SullivanModel[<|v -> 1|>, <||>, v]

SullivanModel["Sphere"[dim_Integer]] /; dim >= 1 :=
	SullivanModel["Sphere"[dim], If[OddQ[dim], {Symbol["v"]}, {Symbol["v"], Symbol["w"]}]]

SullivanModel["Sphere"[dim_Integer], {v_}] /; dim >= 1 && OddQ[dim] := SullivanModel[<|v -> dim|>, <||>, v]

SullivanModel["Sphere"[dim_Integer], {v_, w_}] /; dim >= 2 && EvenQ[dim] :=
	SullivanModel[<|v -> dim, w -> 2 dim - 1|>, <|w -> v^2|>, v]

SullivanModel["ComplexProjectiveSpace"[rank_Integer]] :=
	SullivanModel["ComplexProjectiveSpace"[rank], {Symbol["a"], Symbol["b"]}]

SullivanModel["ComplexProjectiveSpace"[rank_Integer], {a_, b_}] /; rank >= 1 :=
	SullivanModel[<|a -> 2, b -> 2 rank + 1|>, <|b -> a^(rank + 1)|>, a^rank]

SullivanModel["QuaternionicProjectiveSpace"[rank_Integer]] :=
	SullivanModel["QuaternionicProjectiveSpace"[rank], {Symbol["a"], Symbol["b"]}]

SullivanModel["QuaternionicProjectiveSpace"[rank_Integer], {a_, b_}] /; rank >= 1 :=
	SullivanModel[<|a -> 4, b -> 4 rank + 3|>, <|b -> a^(rank + 1)|>, a^rank]

SullivanModel["Torus"[rank_Integer]] :=
	SullivanModel["Torus"[rank], Map[i |-> Symbol["v" <> ToString[i]], Range[rank]]]

SullivanModel["Torus"[rank_Integer], generators_List] /; rank >= 1 && Length[generators] === rank :=
	SullivanModel[AssociationThread[generators -> ConstantArray[1, rank]], <||>, Times @@ generators]

SullivanModel["SpecialUnitaryGroup"[rank_Integer]] :=
	SullivanModel["SpecialUnitaryGroup"[rank], Map[i |-> Symbol["h" <> ToString[i]], Range[3, 2 rank - 1, 2]]]

SullivanModel["SpecialUnitaryGroup"[rank_Integer], generators_List] /; rank >= 2 && Length[generators] === rank - 1 :=
	SullivanModel[AssociationThread[generators -> Range[3, 2 rank - 1, 2]], <||>, Times @@ generators]

SullivanModel["HeisenbergNilmanifold"] :=
	SullivanModel["HeisenbergNilmanifold", {Symbol["x"], Symbol["y"], Symbol["z"]}]

SullivanModel["HeisenbergNilmanifold", {x_, y_, z_}] :=
	SullivanModel[<|x -> 1, y -> 1, z -> 1|>, <|z -> x y|>, x y z]

SullivanModel["KodairaThurston"] :=
	SullivanModel["KodairaThurston", {Symbol["x"], Symbol["y"], Symbol["z"], Symbol["t"]}]

SullivanModel["KodairaThurston", {x_, y_, z_, t_}] :=
	SullivanModel[<|x -> 1, y -> 1, z -> 1, t -> 1|>, <|z -> x y|>, x y z t]

SullivanModel["Degree4Obstruction"] := SullivanModel["Degree4Obstruction", {Symbol["a"], Symbol["c"]}]

SullivanModel["Degree4Obstruction", {a_, c_}] := SullivanModel[<|a -> 2, c -> 3|>, <|a -> c|>, a^2, 4]

$SullivanModels = {"Circle", "Sphere", "ComplexProjectiveSpace", "QuaternionicProjectiveSpace", "Torus",
	"SpecialUnitaryGroup", "HeisenbergNilmanifold", "KodairaThurston", "Degree4Obstruction"};

SullivanModelBasis[model_SullivanModel, k_Integer] := With[
	{generators = Keys[model["Generators"]], degrees = Values[model["Generators"]]},
	Map[exponents |-> Times @@ (generators^exponents),
		Select[Sort[FrobeniusSolve[degrees, k]], exponents |-> And[
			AllTrue[Pick[exponents, OddQ /@ degrees], exponent |-> exponent <= 1],
			With[{weights = AssociationThread[generators -> exponents degrees]},
				AllTrue[Normal[model["Truncation"]], Apply[{group, top} |-> Total[Lookup[weights, group]] <= top]]]]]]]

SullivanModelBasis[complex_CochainComplexWithPairing, k_Integer] := Keys[Select[complex["Degrees"], EqualTo[k]]]

SullivanModelProduct[e_, model_SullivanModel] := SullivanModelProduct[1, e, model]

SullivanModelProduct[e1_, e2_, e3__, model_SullivanModel] :=
	SullivanModelProduct[SullivanModelProduct[e1, e2, model], e3, model]

SullivanModelProduct[e1_, e2_, model_SullivanModel] /;
	PolynomialQ[e1, Keys[model["Generators"]]] && PolynomialQ[e2, Keys[model["Generators"]]] := With[
	{generators = Keys[model["Generators"]], degrees = Values[model["Generators"]]},
	Expand[Total[Map[
		pair |-> With[{p = First[First[pair]], q = First[Last[pair]]},
			{weights = AssociationThread[generators -> (p + q) degrees]},
			If[
				And[
					AllTrue[Pick[p + q, OddQ /@ degrees], exponent |-> exponent <= 1],
					AllTrue[Normal[model["Truncation"]], Apply[{group, top} |-> Total[Lookup[weights, group]] <= top]]],
				Times[
					(-1)^Sum[p[[i]] q[[j]] degrees[[i]] degrees[[j]], {i, Length[generators]}, {j, i - 1}],
					Last[First[pair]], Last[Last[pair]],
					Times @@ (generators^(p + q))],
				0]],
		Tuples[{CoefficientRules[e1, generators], CoefficientRules[e2, generators]}]]]]]

SullivanModelDifferential[e_, model_SullivanModel] /; PolynomialQ[e, Keys[model["Generators"]]] := With[
	{generators = Keys[model["Generators"]], degrees = Values[model["Generators"]]},
	Expand[Total[Map[
		rule |-> With[{p = First[rule]},
			Last[rule] Total[Map[
				i |-> Times[
					(-1)^(Take[p, i - 1] . Take[degrees, i - 1]),
					p[[i]],
					SullivanModelProduct[
						Times @@ (Take[generators, i - 1]^Take[p, i - 1]),
						generators[[i]]^(p[[i]] - 1),
						model["Differential"][generators[[i]]],
						Times @@ (Drop[generators, i]^Drop[p, i]),
						model]],
				Flatten[Position[p, _?Positive]]]]],
		CoefficientRules[SullivanModelProduct[e, model], generators]]]]]

SullivanModelOrientation[e_, model_SullivanModel] /; PolynomialQ[e, Keys[model["Generators"]]] := Expand[Total[Map[
	rule |-> Lookup[model["Orientation"], Times @@ (Keys[model["Generators"]]^First[rule]), 0] Last[rule],
	CoefficientRules[e, Keys[model["Generators"]]]]]]

SullivanModelPairing[e1_, e2_, model_SullivanModel] :=
	SullivanModelOrientation[SullivanModelProduct[e1, e2, model], model]

OrientationQ[values_Association, model_SullivanModel] /; AllTrue[values, NumericQ] := With[
	{nonzero = DeleteCases[values, 0]},
	{n = Exponent[First[Keys[nonzero], 1], Keys[model["Generators"]]] . Values[model["Generators"]]},
	{basis = SullivanModelBasis[model, n], above = SullivanModelBasis[model, n + 1],
		oriented = Append[model, "Orientation" -> nonzero]},
	And[
		nonzero =!= <||>,
		SubsetQ[basis, Keys[nonzero]],
		AllTrue[SullivanModelBasis[model, n - 1],
			p |-> SullivanModelOrientation[SullivanModelDifferential[p, model], oriented] === 0],
		AnyTrue[
			If[above === {}, basis, Map[z |-> z . basis,
				NullSpace[Map[q |-> Map[p |-> Coefficient[SullivanModelDifferential[p, model], q], basis], above]]]],
			z |-> SullivanModelOrientation[z, oriented] =!= 0]]]

OrientationQ[values_Association, complex_CochainComplexWithPairing] /; AllTrue[values, NumericQ] := With[
	{nonzero = DeleteCases[values, 0], variables = Variables[Keys[complex["Degrees"]]]},
	{n = Lookup[complex["Degrees"], First[Keys[nonzero], None], None],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]]},
	{basis = Keys[Select[complex["Degrees"], EqualTo[n]]], above = Keys[Select[complex["Degrees"], EqualTo[n + 1]]],
		functional = e |-> Total[KeyValueMap[{p, c} |-> c Lookup[nonzero, p, 0], expansion[e]]]},
	And[
		nonzero =!= <||>,
		SubsetQ[basis, Keys[nonzero]],
		AllTrue[Keys[Select[complex["Degrees"], EqualTo[n - 1]]], p |-> functional[complex["Differential"][p]] === 0],
		AnyTrue[
			If[above === {}, basis, Map[z |-> z . basis,
				NullSpace[Map[q |-> Map[p |-> Lookup[expansion[complex["Differential"][p]], q, 0], basis], above]]]],
			z |-> functional[z] =!= 0]]]

PoincareDualityQ[model_SullivanModel, opts : OptionsPattern[]] /;
	MatchQ[OptionValue[PoincareDualityQ, {opts}, "MaxDegree"], Automatic | _Integer?(d |-> d >= model["Degree"])] := With[
	{n = model["Degree"], top = Replace[OptionValue["MaxDegree"], Automatic -> model["Degree"] + 1]},
	{cocycles = AssociationMap[
		k |-> With[{basis = SullivanModelBasis[model, k], above = SullivanModelBasis[model, k + 1]},
			Which[
				basis === {}, {},
				above === {}, basis,
				True, Map[z |-> z . basis,
					NullSpace[Map[q |-> Map[p |-> Coefficient[SullivanModelDifferential[p, model], q], basis], above]]]]],
		Range[0, top]],
		boundaries = AssociationMap[
			k |-> With[{below = SullivanModelBasis[model, k - 1], basis = SullivanModelBasis[model, k]},
				If[below === {} || basis === {}, 0,
					MatrixRank[Map[p |-> Map[q |-> Coefficient[SullivanModelDifferential[p, model], q], basis], below]]]],
			Range[0, top]]},
	{betti = AssociationMap[k |-> Length[cocycles[k]] - boundaries[k], Range[0, top]]},
	And[
		AllTrue[Range[0, n], k |-> And[
			betti[k] === betti[n - k],
			cocycles[k] === {} || MatrixRank[Map[
				z |-> Map[w |-> SullivanModelPairing[z, w, model], cocycles[n - k]], cocycles[k]]] === betti[k]]],
		AllTrue[Range[n + 1, top], k |-> betti[k] === 0]]]

PoincareDualityQ[complex_CochainComplexWithPairing] := With[
	{n = complex["Degree"], degrees = complex["Degrees"], variables = Variables[Keys[complex["Degrees"]]]},
	{labels = k |-> Keys[Select[degrees, EqualTo[k]]],
		expansion = e |-> Association[Map[rule |-> Times @@ (variables^First[rule]) -> Last[rule],
			CoefficientRules[e, variables]]],
		range = Range[Min[Min[Values[degrees]], n - Max[Values[degrees]]], Max[Max[Values[degrees]], n - Min[Values[degrees]]]]},
	{matrix = k |-> Map[p |-> Lookup[expansion[complex["Differential"][p]], labels[k + 1], 0], labels[k]]},
	{cocycles = AssociationMap[
		k |-> Which[
			labels[k] === {}, {},
			labels[k + 1] === {}, IdentityMatrix[Length[labels[k]]],
			True, NullSpace[Transpose[matrix[k]]]],
		range],
		boundaries = AssociationMap[k |-> If[labels[k - 1] === {} || labels[k] === {}, 0, MatrixRank[matrix[k - 1]]], range]},
	{betti = AssociationMap[k |-> Length[cocycles[k]] - boundaries[k], range]},
	AllTrue[range, k |-> And[
		betti[k] === betti[n - k],
		cocycles[k] === {} || cocycles[n - k] === {} || MatrixRank[cocycles[k] .
			Map[p |-> Map[q |-> Lookup[complex["Pairing"], Key[{p, q}], 0], labels[n - k]], labels[k]] .
			Transpose[cocycles[n - k]]] === betti[k]]]]

PerfectPairingQ[model_SullivanModel] := With[
	{free = Complement[Keys[model["Generators"]], Catenate[Keys[model["Truncation"]]]]},
	And[
		NoneTrue[free, generator |-> EvenQ[model["Generators"][generator]]],
		AllTrue[Range[0, Total[Lookup[model["Generators"], free]] + Total[model["Truncation"]]],
			k |-> With[{basis = SullivanModelBasis[model, k], dual = SullivanModelBasis[model, model["Degree"] - k]},
				basis === {} || MatrixRank[Map[p |-> Map[q |-> SullivanModelPairing[p, q, model], dual], basis]] ===
					Length[basis]]]]]

PerfectPairingQ[complex_CochainComplexWithPairing] := AllTrue[Union[Values[complex["Degrees"]]],
	k |-> With[
		{basis = Keys[Select[complex["Degrees"], EqualTo[k]]],
			dual = Keys[Select[complex["Degrees"], EqualTo[complex["Degree"] - k]]]},
		dual =!= {} && MatrixRank[Map[p |-> Map[q |-> Lookup[complex["Pairing"], Key[{p, q}], 0], dual], basis]] ===
			Length[basis]]]
