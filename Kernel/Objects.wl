GradedPairingQ::usage = "GradedPairingQ[expr] is True for a pairing object built by GradedPairing, and False otherwise.";

SullivanModelQ::usage = "SullivanModelQ[expr] is True for a model built by SullivanModel, and False otherwise.";

PoincareDualityAlgebraQ::usage = "PoincareDualityAlgebraQ[expr] is True for the algebra NondegenerateQuotient returns, and False otherwise.";

AInfinityAlgebraQ::usage = "AInfinityAlgebraQ[expr] is True for an algebra built by AInfinityAlgebra, and False otherwise.";

PoincareDualityAlgebra::usage = "PoincareDualityAlgebra[data] is the finite-dimensional Poincare duality algebra NondegenerateQuotient returns, carrying the keys \"Degree\", \"Basis\", \"Degrees\", \"Pairing\", \"DifferentialPairing\", \"Differential\", \"Triple\" and \"Model\". It is the object GradedPairing takes to build the alphabet of a geometry, and it is what the rational homotopy layer hands to the dIBL layer.";

$objectHeads = {GradedPairing, SullivanModel, PoincareDualityAlgebra, AInfinityAlgebra};

Scan[head |-> (head[data_Association][key_String] := data[key]), $objectHeads]

Scan[head |-> (
		head /: Append[head[data_Association], new_] := head[Append[data, new]];
		head /: Normal[head[data_Association]] := data;
		head /: Keys[head[data_Association]] := Keys[data];
		head /: KeyExistsQ[head[data_Association], key_] := KeyExistsQ[data, key];
		head /: Lookup[head[data_Association], rest___] := Lookup[data, rest];
		head /: KeyDrop[head[data_Association], keys_] := head[KeyDrop[data, keys]];
		head /: KeyTake[head[data_Association], keys_] := head[KeyTake[data, keys]]),
	$objectHeads]

GradedPairingQ[GradedPairing[_Association]] := True
GradedPairingQ[_] := False

SullivanModelQ[SullivanModel[_Association]] := True
SullivanModelQ[_] := False

PoincareDualityAlgebraQ[PoincareDualityAlgebra[_Association]] := True
PoincareDualityAlgebraQ[_] := False

AInfinityAlgebraQ[AInfinityAlgebra[_Association]] := True
AInfinityAlgebraQ[_] := False
