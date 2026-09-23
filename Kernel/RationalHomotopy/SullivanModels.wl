SullivanModel::usage = "SullivanModel[name] gives a Sullivan minimal model from the catalogue $SullivanModels, as an Association with keys \"Generators\", \"Differential\", \"Volume\", \"Degree\" and \"Truncation\". SullivanModel[name, generators] uses the given generator symbols instead of the default ones. SullivanModel[degrees, differential, volume] builds a model from an Association of generators to their degrees, an Association giving the differential on the generators, and a volume monomial whose degree is the Poincare duality degree. A fourth argument truncates the algebra above that degree. SullivanModel[{model1, model2, ...}] is the tensor product, whose degree is the sum of the degrees.";

$SullivanModels::usage = "$SullivanModels is the list of catalogue names SullivanModel accepts. Those taking a parameter are used as name[k].";

SullivanModelBasis::usage = "SullivanModelBasis[model, k] lists the monomials of degree k in the model, each written as a product of generators in the order the model declares them. It is empty above the truncation degree.";

SullivanModelProduct::usage = "SullivanModelProduct[e1, e2, ..., model] multiplies elements of the model, with the Koszul signs of the graded commutative product and the truncation applied. A monomial written as a product of generators is read in the order the model declares them, so the order of the arguments is what carries the sign.";

SullivanModelDifferential::usage = "SullivanModelDifferential[e, model] applies the model's differential, extended as a derivation.";

SullivanModelOrientation::usage = "SullivanModelOrientation[e, model] is the coefficient of the volume monomial in e -- the orientation of the model, of degree the model's degree.";

SullivanModelPairing::usage = "SullivanModelPairing[e1, e2, model] is SullivanModelOrientation[SullivanModelProduct[e1, e2, model], model], the chain-level pairing of the oriented model.";

DegenerateSubspace::usage = "DegenerateSubspace[model, k] gives a basis of the degree-k part of the degenerate subspace -- the elements paired to zero with everything. It is the whole of degree k above the model's degree.";

HodgeTypeQ::usage = "HodgeTypeQ[model] tests whether the oriented model is of Hodge type, by testing whether the degenerate subspace is acyclic. The test runs in degrees 0 to n+1, n being the model's degree, which is complete when the cohomology vanishes above degree n; \"MaxDegree\" -> d checks the degrees 0 to d instead.";

HodgeTypeReport::usage = "HodgeTypeReport[model] is a Dataset with one row per degree: the dimension of the model, of its cohomology, of the degenerate subspace, of the cohomology of the degenerate subspace, and of the nondegenerate quotient. The quotient map is a quasi-isomorphism exactly when the fourth column vanishes throughout. \"MaxDegree\" -> d sets the last degree shown.";

NondegenerateQuotient::usage = "NondegenerateQuotient[model] is the quotient of the model by its degenerate subspace, as an Association with keys \"Degree\", \"Basis\", \"Degrees\", \"Pairing\", \"DifferentialPairing\", \"Differential\", \"Triple\" and \"Model\". It is a finite-dimensional Poincare duality algebra, and the quotient map is a quasi-isomorphism exactly when the model is of Hodge type.";

CanonicalMaurerCartan::usage = "CanonicalMaurerCartan[pairing] is the canonical Maurer-Cartan element of the dIBL algebra of a Poincare duality algebra -- the cyclic word of length three carrying the triple product, one third of the sum over the basis with the reversal sign. The pairing object must carry an \"Algebra\" key, which GradedPairing[algebra] supplies.";

(* ----- Sullivan models, the nondegenerate quotient, and the canonical Maurer-Cartan element -----

   The layer above turns a graded alphabet with a pairing into a dIBL algebra. This one produces the
   alphabet: a Sullivan minimal model with a volume form is an oriented PDGA, its nondegenerate
   quotient is a finite-dimensional Poincare duality algebra when the model is of Hodge type, and the
   dual pairing on that quotient is the alphabet. The canonical Maurer-Cartan element is eq:canmc of
   the paper, so this is the first recipe in the paclet producing an element rather than taking one. *)

SullivanModel[spec_String] := SullivanModel[modelNamed[spec]]

SullivanModel[spec_String[arg_Integer]] := SullivanModel[modelNamed[spec[arg]]]

SullivanModel[spec_String, gens_List] := SullivanModel[modelNamed[spec, gens]]

SullivanModel[spec_String[arg_Integer], gens_List] := SullivanModel[modelNamed[spec[arg], gens]]

SullivanModel[models_List] := SullivanModel[modelTensor[Map[First, models]]]

SullivanModel[gens_Association, diff_Association, vol_] :=
	SullivanModel[sullivanModel[gens, modelDifferentialSpec[diff, gens], monomialList[vol, gens]]]

SullivanModel[gens_Association, diff_Association, vol_, trunc_] :=
	SullivanModel[sullivanModel[gens, modelDifferentialSpec[diff, gens], monomialList[vol, gens], trunc]]

$SullivanModels := $modelNames

SullivanModelBasis[model_Association, k_Integer] := Map[monomialExpression, modelMonomials[model, k]]

SullivanModelProduct[args__, model_Association] := With[
	{elements = Map[e |-> modelElement[e, model["Generators"]], {args}]},
	modelExpression[Fold[{acc, e} |-> modelProduct[acc, e, model], First[elements], Rest[elements]]]]

SullivanModelDifferential[e_, model_Association] :=
	modelExpression[modelDifferential[modelElement[e, model["Generators"]], model]]

SullivanModelOrientation[e_, model_Association] :=
	modelOrientation[modelElement[e, model["Generators"]], model]

SullivanModelPairing[e1_, e2_, model_Association] := modelPairing[
	modelElement[e1, model["Generators"]], modelElement[e2, model["Generators"]], model]

DegenerateSubspace[model_Association, k_Integer] := With[
	{monomials = Map[monomialExpression, modelMonomials[model, k]]},
	Map[vector |-> vector . monomials, modelDegenerateBasis[model, k]]]

HodgeTypeQ[model_Association, opts : OptionsPattern[]] :=
	modelHodgeTypeQ[model, reportDegree[HodgeTypeQ, {opts}, model, 1]]

Options[HodgeTypeQ] = {"MaxDegree" -> Automatic};

HodgeTypeReport[model_Association, opts : OptionsPattern[]] :=
	Dataset[modelReport[model, reportDegree[HodgeTypeReport, {opts}, model, 3]]]

Options[HodgeTypeReport] = {"MaxDegree" -> Automatic};

NondegenerateQuotient[model_Association] := With[{quotient = modelQuotient[model]},
	PoincareDualityAlgebra[
		Append[quotient, "Basis" -> Map[monomialExpression, quotient["Basis"]]]]]

GradedPairing[algebra_PoincareDualityAlgebra] := GradedPairing[algebra, First[algebra]["Basis"]]

GradedPairing[PoincareDualityAlgebra[pd_Association], particles_List] :=
	GradedPairing[Append[
		First[GradedPairing[AssociationThread[particles -> pdShiftedDegrees[pd]],
			pairingValues[particles, pdShiftedPairing[pd]]]],
		"Algebra" -> pd]]

CanonicalMaurerCartan[pr_Association] := (checkAlgebra[pr];
	With[{degs = pr["Degrees"], pd = pr["Algebra"]},
		withPairing[pr, fromEngine[
			pdCanonicalMC[particleName /@ Keys[degs], Values[degs], pd["Degree"], pd["Triple"]],
			degs]]])

GradedPairing::algebra = "The pairing object carries no algebra; build it with GradedPairing[NondegenerateQuotient[model]].";

checkAlgebra[pr_Association] := If[!KeyExistsQ[pr, "Algebra"], Message[GradedPairing::algebra]; Abort[]]

pairingValues[particles_List, values_List] := Association[Catenate[Map[
	i |-> Map[j |-> {particles[[i]], particles[[j]]} -> values[[i, j]], Range[Length[particles]]],
	Range[Length[particles]]]]]

reportDegree[head_, opts_List, model_Association, extra_Integer] :=
	Replace[OptionValue[head, opts, "MaxDegree"], Automatic :> model["Degree"] + extra]

modelDifferentialSpec[diff_Association, gens_Association] :=
	Map[e |-> modelElement[e, gens], diff]

monomialExpression[mono_List] := Times @@ mono

modelExpression[e_Association] := Total[Map[
	mono |-> Lookup[e, Key[mono], 0] monomialExpression[mono], Keys[e]]]

modelElement[e_, gens_Association] := With[{expanded = Expand[e]},
	collectTerms[Map[
		term |-> {monomialList[generatorFactor[term, gens], gens], scalarFactor[term, gens]},
		If[Head[expanded] === Plus, List @@ expanded, {expanded}]]]]

generatorFactor[term_, gens_Association] :=
	Times @@ Select[termFactors[term], f |-> !FreeQ[f, Alternatives @@ Keys[gens]]]

scalarFactor[term_, gens_Association] :=
	Times @@ Select[termFactors[term], f |-> FreeQ[f, Alternatives @@ Keys[gens]]]

monomialList[mono_, gens_Association] :=
	SortBy[rawMonomialList[mono, gens], g |-> FirstPosition[Keys[gens], g]]

rawMonomialList[1, _Association] := {}

rawMonomialList[mono_Times, gens_Association] :=
	Catenate[Map[f |-> rawMonomialList[f, gens], List @@ mono]]

rawMonomialList[mono_Power, _Association] := ConstantArray[First[mono], Last[mono]]

rawMonomialList[g_, _Association] := {g}
