BeginPackage["IBLInfinity`", {"IBLInfinity`Engine`"}];

Pairing::usage = "Pairing[degrees, spec] builds the pairing object of a graded alphabet. degrees is an Association from particles to their degrees; spec is either a function of two particles or an Association giving some of the values, which are completed by graded antisymmetry. The result is a plain Association with keys \"Degrees\", \"Values\", \"Degree\" (the degree of the pairing) and \"Convention\" (\"Symmetric\" by default, \"Exterior\" to work in the exterior picture). An optional \"Dual\" key, supplied as Pairing[degrees, spec, dualDegrees, evaluation], carries a dual alphabet for DualPairing.";

CyclicWord::usage = "CyclicWord[w] is a cyclic word, w being the list of its particles. CyclicWord[w, data] returns its canonical rotation together with the Koszul sign, or 0 if the word is cyclically antisymmetric; data is a pairing object or a degrees Association.";

CyclicWords::usage = "CyclicWords[n, data] enumerates the nonzero cyclic words of length n over the alphabet of data. CyclicWords[n, data, \"UpTo\" -> True] gives all lengths up to n.";

WordDegree::usage = "WordDegree[w, data] is the degree of a cyclic word. WordDegree[w, pairing, \"Exterior\"] adds the degree of the pairing (the Koszul degree of ExteriorProduct); WordDegree[w, pairing, \"Symmetric\"] subtracts a further 1 (the Koszul degree of SymmetricProduct).";

ExteriorProduct::usage = "ExteriorProduct[u, v, ..., pairing] is the graded exterior product of cyclic words, sorted with the Koszul sign of the exterior degree. The normalized result carries only its factors.";

SymmetricProduct::usage = "SymmetricProduct[u, v, ..., pairing] is the graded symmetric product of cyclic words, sorted with the Koszul sign of the symmetric degree. The normalized result carries only its factors.";

Bracket::usage = "Bracket[u, v, pairing] is the bracket of two cyclic words, in the convention of the pairing object. Bracket[p, pairing] applies its extension as a derivation to a product p of any number of factors.";

Cobracket::usage = "Cobracket[w, pairing] is the co-bracket of a cyclic word, in the convention of the pairing object. Cobracket[p, pairing] applies its extension as a co-derivation to a product p.";

ShiftIsomorphism::usage = "ShiftIsomorphism[e, pairing] sends a symmetric product to an exterior one by the reversal rule, which is the one that intertwines Bracket and Cobracket in every arity. ShiftIsomorphism[e, pairing, \"Position\"] uses the position rule instead, which does not. Both accept \"Inverse\" -> True.";

DualPairing::usage = "DualPairing[f, e, pairing] evaluates a cyclic word f of particles on a cyclic word e of dual particles. Requires a pairing object carrying a \"Dual\" key.";

ProductPairing::usage = "ProductPairing[f, e, pairing] extends DualPairing to products of equal length, with the Koszul signs of all matchings and, in the symmetric convention, the weight 1/k!.";

KoszulSign::usage = "KoszulSign[perm, degrees, parity] is the sign of the permutation perm of a list of objects of the given degrees, counting parity for each transposition in addition to the product of the degrees.";

Jacobi::usage = "Jacobi[u, v, w, pairing] is the Jacobi obstruction of three cyclic words; 0 means the identity holds there.";

CoJacobi::usage = "CoJacobi[w, pairing] is the co-Jacobi obstruction of a cyclic word; 0 means the identity holds there.";

Drinfeld::usage = "Drinfeld[u, v, pairing] is the Drinfeld compatibility obstruction of two cyclic words; 0 means the identity holds there.";

Involutivity::usage = "Involutivity[w, pairing] is the involutivity obstruction of a cyclic word; 0 means the identity holds there.";

$Relations::usage = "$Relations is the Association of the defining identities of an involutive bi-Lie algebra, each carrying its arity and the function computing its obstruction.";

RelationFailures::usage = "RelationFailures[name, pairing, n] returns the tuples of cyclic words of length at most n on which the named identity fails. An empty list means it holds throughout the range.";

Begin["`Private`"];

(* ----- particles and the translation to the engine's letter strings ----- *)

particleName[p_Symbol] := SymbolName[p]

particleName[p_] := ToString[p]

nameMap[degs_Association] := AssociationThread[Keys[degs] -> particleName /@ Keys[degs]]

particleMap[degs_Association] := AssociationThread[particleName /@ Keys[degs] -> Keys[degs]]

allDegrees[pr_Association] := Join[pr["Degrees"], Lookup[Lookup[pr, "Dual", <||>], "Degrees", <||>]]

conventionOf[pr_Association] := Lookup[pr, "Convention", "Symmetric"]

degreesOf[x_Association] := If[KeyExistsQ[x, "Degrees"], allDegrees[x], x]

(* ----- the pairing object ----- *)

Pairing[degs_Association, spec_] := Module[{values, degree},
	values = completePairing[degs, spec];
	degree = pairingDegree[degs, values];
	<|"Degrees" -> degs, "Values" -> values, "Degree" -> degree, "Convention" -> "Symmetric"|>]

Pairing[degs_Association, spec_, dualDegs_Association, evaluation_Association] :=
	Append[Pairing[degs, spec], "Dual" -> <|"Degrees" -> dualDegs, "Values" -> evaluation|>]

completePairing[degs_Association, spec_Association] := Association @@ Map[
	pair |-> pair -> pairingValue[degs, spec, pair], Tuples[Keys[degs], 2]]

completePairing[degs_Association, f_] := Association @@ Map[
	pair |-> pair -> (f @@ pair), Tuples[Keys[degs], 2]]

pairingValue[degs_Association, spec_Association, {p_, q_}] := Which[
	KeyExistsQ[spec, {p, q}], spec[{p, q}],
	KeyExistsQ[spec, {q, p}], sgn[1 + degs[p] degs[q]] spec[{q, p}],
	True, 0]

pairingDegree[degs_Association, values_Association] := With[
	{ds = DeleteDuplicates[Map[k |-> degs[k[[1]]] + degs[k[[2]]], Keys[Select[values, # =!= 0 &]]]]},
	If[Length[ds] === 1, First[ds], Message[Pairing::degree]; Abort[]]]

Pairing::degree = "The pairing has no well-defined degree.";

(* ----- running the engine under the data of a pairing object ----- *)

SetAttributes[{withDegrees, withPairing}, HoldRest]

withDegrees[degs_Association, body_] := Block[{
		$letterDegrees = KeyMap[particleName, degs],
		$alphabet = particleName /@ Keys[degs]},
	body]

withPairing[pr_Association, body_] := Block[{
		$letterDegrees = KeyMap[particleName, allDegrees[pr]],
		$alphabet = particleName /@ Keys[pr["Degrees"]],
		$primalAlphabet = particleName /@ Keys[Lookup[Lookup[pr, "Dual", <||>], "Degrees", <||>]],
		$pdDegree = pr["Degree"] + 2,
		$veePairing = KeyMap[Map[particleName, #] &, pr["Values"]],
		$letterPairing = KeyMap[Map[particleName, #] &, Lookup[Lookup[pr, "Dual", <||>], "Values", <||>]]},
	body]

toEngine[e_, degs_Association] := With[{names = nameMap[degs]},
	e /. {CyclicWord[w_List] :> cyc[Lookup[names, w]],
		ExteriorProduct -> wedge, SymmetricProduct -> odot}]

fromEngine[e_, degs_Association] := With[{particles = particleMap[degs]},
	e /. {cyc[w_List] :> CyclicWord[Lookup[particles, w]],
		wedge -> ExteriorProduct, odot -> SymmetricProduct}]

(* ----- words ----- *)

CyclicWord[w_List, data_Association] := With[{degs = degreesOf[data]},
	withDegrees[degs, fromEngine[cyc[Lookup[nameMap[degs], w]], degs]]]

CyclicWords[n_Integer, data_Association, opts : OptionsPattern[]] := With[{degs = degreesOf[data]},
	withDegrees[degs, fromEngine[
		If[TrueQ[OptionValue[CyclicWords, {opts}, "UpTo"]], cycWordsUpTo, cycWords][n, $alphabet], degs]]]

Options[CyclicWords] = {"UpTo" -> False};

WordDegree[CyclicWord[w_List], data_Association] := With[{degs = degreesOf[data]},
	withDegrees[degs, degBar[Lookup[nameMap[degs], w]]]]

WordDegree[CyclicWord[w_List], pr_Association, "Exterior"] :=
	withPairing[pr, degC[Lookup[nameMap[allDegrees[pr]], w]]]

WordDegree[CyclicWord[w_List], pr_Association, "Symmetric"] :=
	withPairing[pr, degC1[Lookup[nameMap[allDegrees[pr]], w]]]

WordDegree[w_List, data_Association, rest___] := WordDegree[CyclicWord[w], data, rest]

KoszulSign[perm_List, degs_List, parity_Integer] := koszulSign[perm, degs, parity]

(* ----- products ----- *)

ExteriorProduct[args__, pr_Association] := productValue[wedge, {args}, pr]

SymmetricProduct[args__, pr_Association] := productValue[odot, {args}, pr]

productValue[head_, args_List, pr_Association] := With[{degs = allDegrees[pr]},
	withPairing[pr, fromEngine[head @@ toEngine[args, degs], degs]]]

(* ----- the operations ----- *)

Bracket[u_, v_, pr_Association] := operationValue[
	If[conventionOf[pr] === "Exterior", q210Wedge, q210Odot], {u, v}, pr]

Bracket[p : (_ExteriorProduct | _SymmetricProduct), pr_Association] := operationValue[
	If[conventionOf[pr] === "Exterior", hatQ210Wedge, hatQ210Odot], {p}, pr]

Cobracket[w_, pr_Association] := operationValue[
	If[conventionOf[pr] === "Exterior", q120Wedge, q120Odot], {w}, pr]

Cobracket[p : (_ExteriorProduct | _SymmetricProduct), pr_Association] := operationValue[
	If[conventionOf[pr] === "Exterior", hatQ120Wedge, hatQ120Odot], {p}, pr]

operationValue[f_, args_List, pr_Association] := With[{degs = allDegrees[pr]},
	withPairing[pr, fromEngine[f @@ toEngine[args, degs], degs]]]

(* ----- the shift isomorphisms ----- *)

ShiftIsomorphism[e_, pr_Association, opts : OptionsPattern[]] := operationValue[
	Switch[{OptionValue[ShiftIsomorphism, {opts}, "Rule"], TrueQ[OptionValue[ShiftIsomorphism, {opts}, "Inverse"]]},
		{"Position", False}, shiftIso,
		{"Position", True}, shiftIsoInverse,
		{_, False}, shiftIsoK,
		{_, True}, shiftIsoKInverse],
	{e}, pr]

ShiftIsomorphism[e_, pr_Association, rule_String, opts : OptionsPattern[]] :=
	ShiftIsomorphism[e, pr, "Rule" -> rule, opts]

Options[ShiftIsomorphism] = {"Rule" -> "Reversal", "Inverse" -> False};

(* ----- the pairings ----- *)

DualPairing[f_, e_, pr_Association] := (checkDual[pr]; operationValue[evalWord, {f, e}, pr])

ProductPairing[f_, e_, pr_Association] := (checkDual[pr]; operationValue[
	If[conventionOf[pr] === "Exterior", wedgePairing, odotPairing], {f, e}, pr])

checkDual[pr_Association] := If[!KeyExistsQ[pr, "Dual"], Message[Pairing::dual]; Abort[]]

Pairing::dual = "The pairing object carries no dual alphabet; build it with Pairing[degrees, spec, dualDegrees, evaluation].";

(* ----- the defining identities ----- *)

Jacobi[u_, v_, w_, pr_Association] := operationValue[
	If[conventionOf[pr] === "Exterior", jacobiWedge, jacobiOdot], {u, v, w}, pr]

CoJacobi[w_, pr_Association] := operationValue[
	If[conventionOf[pr] === "Exterior", cojacobiWedge, cojacobiOdot], {w}, pr]

Drinfeld[u_, v_, pr_Association] := operationValue[
	If[conventionOf[pr] === "Exterior", drinfeldWedge, drinfeldOdot], {u, v}, pr]

Involutivity[w_, pr_Association] := operationValue[
	If[conventionOf[pr] === "Exterior", involutivityWedge, involutivityOdot], {w}, pr]

$Relations = <|
	"Jacobi" -> <|"Arity" -> 3, "Function" -> Jacobi|>,
	"CoJacobi" -> <|"Arity" -> 1, "Function" -> CoJacobi|>,
	"Drinfeld" -> <|"Arity" -> 2, "Function" -> Drinfeld|>,
	"Involutivity" -> <|"Arity" -> 1, "Function" -> Involutivity|>|>;

RelationFailures[name_String, pr_Association, n_Integer] := With[
	{relation = $Relations[name], words = CyclicWords[n, pr, "UpTo" -> True]},
	Select[Tuples[words, relation["Arity"]],
		tuple |-> Expand[relation["Function"] @@ Append[tuple, pr]] =!= 0]]

End[];

EndPackage[];
