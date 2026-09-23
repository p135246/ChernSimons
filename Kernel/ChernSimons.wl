BeginPackage["ChernSimons`"];

(* ----- the API -----

   The fifty-five documented names, declared here so that the usage messages and definitions
   loaded from the category directories inside `Private` attach to them. Each category directory
   holds one area of the mathematics and carries its own usage messages beside its definitions,
   the layout WolframInstitute/PureMath uses. A new export has to be added here or it silently
   goes private; T12/paclet-context-is-clean fails if the two drift. *)

Scan[Symbol, {
	"GradedPairing", "CyclicWord", "CyclicWords", "WordDegree", "ExteriorProduct", "SymmetricProduct",
	"ChordContraction", "InvolutiveBracket", "InvolutiveCobracket", "CyclicDifferential", "ShiftIsomorphism", "DualPairing", "ProductPairing",
	"KoszulSign", "BeilinsonDrinfeldOperator", "BeilinsonDrinfeldBracket", "BeilinsonDrinfeldMasterEquation", "BeilinsonDrinfeldMasterQ", "PlanckDegree",
	"HBar", "MaurerCartanEquation", "MaurerCartanQ", "MaurerCartanBasis", "MaurerCartanAnsatz",
	"TwistedDifferential", "TwistedCobracket", "GaugeFlow", "AInfinityAlgebra",
	"AInfinityOperation", "AInfinityObstruction", "AInfinityQ", "AInfinityMorphismObstruction",
	"AInfinityMorphismQ", "JacobiObstruction", "CoJacobiObstruction", "DrinfeldObstruction", "InvolutivityObstruction", "$DefiningIdentities",
	"SullivanModel", "$SullivanModels", "SullivanModelBasis", "SullivanModelProduct", "SullivanModelDifferential",
	"SullivanModelOrientation", "SullivanModelPairing", "DegenerateSubspace", "HodgeTypeQ", "HodgeTypeReport",
	"NondegenerateQuotient", "CanonicalMaurerCartan", "PoincareDualityAlgebra",
	"GradedPairingQ", "SullivanModelQ", "PoincareDualityAlgebraQ", "AInfinityAlgebraQ"}];

(* ----- the engine -----

   The 125 names below are declared here, in ChernSimons`, so that the definitions loaded from
   Engine/ inside `Private` attach to them while their pattern and Module variables stay private.
   Without the declaration the engine's own w, x, perm, known, ... would be public too, which is
   what the IBLInfinity`Engine` context used to do — 130 accidental names alongside the real ones.
   A new public name in an Engine/*.wl file has to be added here; T12/paclet-context-is-clean
   fails if the two drift. *)

Scan[Symbol, {
	"koszulSign", "sgn",
	"cyc", "cycWords", "cycWordsUpTo", "cycAntisymmetricQ", "cycCanonical", "cycLength",
	"rotateLeft", "degBar", "degC", "degC1",
	"$letterDegrees", "$alphabet", "$primalAlphabet", "$pdDegree",
	"odot", "wedge", "shiftIso", "shiftIsoInverse", "shiftIsoK", "shiftIsoKInverse",
	"wedgePairing", "odotPairing", "evalWord", "evalWordCore", "evalLetter",
	"positionSign", "kSign", "reversalSign", "scalarQ", "declareLinear", "declareGradedProduct",
	"$letterPairing",
	"mu", "muOdotNaive", "delta", "deltaOdotNaive",
	"q210Wedge", "q210Odot", "q210OdotNaive", "q120Wedge", "q120Odot", "q120OdotNaive",
	"hatQ210Wedge", "hatQ120Wedge", "hatQ210Odot", "hatQ120Odot", "hatQ210OdotNaive",
	"jacobiWedge", "jacobiOdot", "jacobiOdotNaive", "cojacobiWedge", "cojacobiOdot",
	"drinfeldWedge", "drinfeldOdot", "involutivityWedge", "involutivityOdot",
	"mcCanonical", "q110Can", "q110Twisted", "q120Twisted", "q210Comp1", "hochschildDual",
	"bracketSum", "bracketTerms", "bracketPerm", "deltaSum", "cobracketTerms", "cobracketPerm",
	"hochschildTerms", "hochschildPerm", "declareHat", "shufflePairs", "tp", "veeValue",
	"$veePairing", "$diamondCoproduct",
	"bdOperator", "bdOperatorNaive", "bdBracket", "bvBracket", "bvQme", "hochschildPrimal", "unwrapOdot",
	"degF", "degF1", "primalTerm", "HBar", "$diamondProduct",
	"ainftyM", "ainftyF", "ainftyRelation", "ainftyMorphism", "hochschildTwisted",
	"ainftyChainF", "ainftyChainFPrinted", "chainFWeighted", "blockCompositions", "veePrimal",
	"$veePrimalPairing",
	"gaugeFlowWedge", "gaugeFlow", "gaugeFlowSolve", "gaugePicardStep",
	"gaugeCdot", "gaugeDdotWedge", "gaugeDdot", "gaugeDdotPrinted", "gaugeC", "gaugeD",
	"gaugeIntT", "gaugeTriple", "gaugeACoef", "gaugePhiWedge", "gaugePhiValueWedge",
	"gaugePhiGFWedge", "gaugePhiGFKernelWedge", "gaugePhi", "gaugeDefect", "gaugeFirstRow",
	"gaugeMCRows", "gaugeMCData", "gaugeCharMap", "gaugeTruncX",
	"$KernelDirectory",
	"sullivanModel", "modelMonomials", "modelDegree", "modelProduct", "modelDifferential",
	"modelOrientation", "modelPairing", "modelPairingValue", "modelTripleValue",
	"modelPairingMatrix", "modelDifferentialMatrix", "modelDegenerateBasis",
	"modelCohomologyDimension", "modelDegenerateCohomologyDimension", "modelHodgeTypeQ",
	"modelReport", "modelQuotientMonomials", "modelQuotient",
	"pdShiftedDegrees", "pdShiftedPairing", "pdCanonicalMC", "canonicalSign",
	"exponentVectors", "asElement", "collectTerms", "monomialTimes", "sortMonomial",
	"monomialDifferential", "matrixRank", "restrictedRank", "independentRows",
	"quotientDifferentialPairing", "quotientDifferentialMatrix", "quotientTriple",
	"$modelNames", "modelNamed", "modelDefaultGenerators", "modelTensor"}];


Begin["`Private`"];

$KernelDirectory = FileNameJoin[{ParentDirectory[DirectoryName[$InputFileName]], "Engine"}];

Scan[m |-> Get[FileNameJoin[{$KernelDirectory, m}]],
	{"Signs.wl", "CyclicWords.wl", "Products.wl", "DIBL.wl", "BV.wl", "AInfinity.wl", "Gauge.wl",
		"Models.wl"}]


Scan[f |-> Get[FileNameJoin[Prepend[f, DirectoryName[$InputFileName]]]], {
		{"Algebra", "GradedWords.wl"},
		{"DIBL", "Operations.wl"},
		{"DIBL", "Identities.wl"},
		{"EngineBridge.wl"},
		{"DIBL", "BeilinsonDrinfeld.wl"},
		{"DIBL", "MaurerCartan.wl"},
		{"HomotopyAlgebras", "AInfinity.wl"},
		{"RationalHomotopy", "SullivanModels.wl"},
		{"Objects.wl"},
		{"Boxes.wl"}}]

End[];

EndPackage[];