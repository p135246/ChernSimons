PackageExported[SullivanModelQ]
PackageExported[PoincareDualityAlgebraQ]

SullivanModelQ::usage = "SullivanModelQ[expr] gives True if expr is a SullivanModel object, and False otherwise.";

PoincareDualityAlgebraQ::usage = "PoincareDualityAlgebraQ[expr] gives True if expr is a PoincareDualityAlgebra object, and False otherwise.";

$objectHeads = {SullivanModel, PoincareDualityAlgebra, CochainComplexWithPairing, PreHodgeDecomposition, HodgeDecomposition,
	SpecialPropagator};

Scan[head |-> (head[data_Association][key_String] := data[key]), $objectHeads]

Scan[head |-> (head[data_Association][key : "Harmonic" | "Coexact", k_Integer] := Lookup[data[key], k, {}]),
	{PreHodgeDecomposition, HodgeDecomposition}]

SpecialPropagator[data_Association]["Images", k_Integer] := Lookup[data["Images"], k, <||>]

Scan[head |-> (
		head /: Append[head[data_Association], new_] := head[Append[data, new]];
		head /: Normal[head[data_Association]] := data;
		head /: Keys[head[data_Association]] := Keys[data];
		head /: KeyExistsQ[head[data_Association], key_] := KeyExistsQ[data, key];
		head /: Lookup[head[data_Association], rest___] := Lookup[data, rest];
		head /: KeyDrop[head[data_Association], keys_] := head[KeyDrop[data, keys]];
		head /: KeyTake[head[data_Association], keys_] := head[KeyTake[data, keys]]),
	$objectHeads]

SullivanModelQ[SullivanModel[_Association]] := True
SullivanModelQ[_] := False

PoincareDualityAlgebraQ[PoincareDualityAlgebra[KeyValuePattern[{"Degree" -> _Integer, "Basis" -> _List, "Degrees" -> _List, "Pairing" -> _List,
	"DifferentialPairing" -> _Association, "Differential" -> _List, "Triple" -> _Association}]?AssociationQ]] := True
PoincareDualityAlgebraQ[_] := False
