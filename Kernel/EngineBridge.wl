$bridgedNames = {"BeilinsonDrinfeldOperator", "BeilinsonDrinfeldBracket", "BeilinsonDrinfeldMasterEquation",
	"BeilinsonDrinfeldMasterQ", "PlanckDegree", "MaurerCartanEquation", "MaurerCartanQ", "MaurerCartanBasis",
	"MaurerCartanAnsatz", "TwistedDifferential", "TwistedCobracket", "GaugeFlow",
	"AInfinityOperation", "AInfinityObstruction", "AInfinityQ", "AInfinityMorphismObstruction", "AInfinityMorphismQ",
	"SullivanModelBasis", "SullivanModelProduct", "SullivanModelDifferential", "SullivanModelOrientation",
	"SullivanModelPairing", "DegenerateSubspace", "HodgeTypeQ", "HodgeTypeReport", "NondegenerateQuotient",
	"CanonicalMaurerCartan"}

Scan[name |-> With[{symbol = Symbol["ChernSimons`" <> name]},
		symbol[before___, object : _GradedPairing | _SullivanModel | _PoincareDualityAlgebra | _AInfinityAlgebra, after___] :=
			symbol[before, First[object], after]],
	$bridgedNames]

particleName[p_Symbol] := SymbolName[p]

particleName[p_] := ToString[p]

nameMap[degs_Association] := AssociationThread[Keys[degs] -> particleName /@ Keys[degs]]

particleMap[degs_Association] := AssociationThread[particleName /@ Keys[degs] -> Keys[degs]]

allDegrees[pr_Association] := Join[pr["Degrees"], Lookup[Lookup[pr, "Dual", <||>], "Degrees", <||>]]

conventionOf[pr_Association] := Lookup[pr, "Convention", "Symmetric"]

SetAttributes[withPairing, HoldRest]

withPairing[pr_Association, body_] := Block[{
		$letterDegrees = KeyMap[particleName, allDegrees[pr]],
		$alphabet = particleName /@ Keys[pr["Degrees"]],
		$primalAlphabet = particleName /@ Keys[Lookup[Lookup[pr, "Dual", <||>], "Degrees", <||>]],
		$pdDegree = pr["Degree"] + 2,
		$veePairing = KeyMap[Map[particleName, #] &, pr["Values"]],
		$letterDifferential = alphabetDifferential[pr],
		$letterPairing = KeyMap[Map[particleName, #] &, Lookup[Lookup[pr, "Dual", <||>], "Values", <||>]]},
	body]

alphabetDifferential[pr_Association] := With[{pd = Lookup[pr, "Algebra", <||>]},
	If[KeyExistsQ[pd, "Differential"],
		letterDifferential[particleName /@ Keys[pr["Degrees"]], pd["Differential"]], <||>]]

letterDifferential[names_List, matrix_List] := DeleteCases[
	AssociationThread[names -> Map[
		p |-> DeleteCases[AssociationThread[names -> matrix[[All, p]]], 0],
		Range[Length[names]]]],
	<||>]

toEngine[e_, degs_Association] := With[{names = nameMap[degs]},
	e /. {CyclicWord[w_List] :> cyc[Lookup[names, w]],
		ExteriorProduct -> wedge, SymmetricProduct -> odot}]

fromEngine[e_, degs_Association] := With[{particles = particleMap[degs]},
	e /. {cyc[w_List] :> CyclicWord[Lookup[particles, w]],
		wedge -> ExteriorProduct, odot -> SymmetricProduct}]

operationValue[f_, args_List, pr_Association] := With[{degs = allDegrees[pr]},
	withPairing[pr, fromEngine[f @@ toEngine[args, degs], degs]]]
