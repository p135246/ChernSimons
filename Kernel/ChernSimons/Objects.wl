PackageExported[GradedPairingQ]

GradedPairingQ::usage = "GradedPairingQ[expr] tests whether expr is a pairing object built by GradedPairing.";

GradedPairing[data_Association][key_String] := data[key]

GradedPairing /: Append[GradedPairing[data_Association], new_] := GradedPairing[Append[data, new]]
GradedPairing /: Normal[GradedPairing[data_Association]] := data
GradedPairing /: Keys[GradedPairing[data_Association]] := Keys[data]
GradedPairing /: KeyExistsQ[GradedPairing[data_Association], key_] := KeyExistsQ[data, key]
GradedPairing /: Lookup[GradedPairing[data_Association], rest___] := Lookup[data, rest]
GradedPairing /: KeyDrop[GradedPairing[data_Association], keys_] := GradedPairing[KeyDrop[data, keys]]
GradedPairing /: KeyTake[GradedPairing[data_Association], keys_] := GradedPairing[KeyTake[data, keys]]

GradedPairingQ[GradedPairing[KeyValuePattern[{"Degrees" -> _Association, "Values" -> _Association, "Degree" -> _, "Convention" -> "Symmetric" | "Exterior"}]?AssociationQ]] := True
GradedPairingQ[_] := False

CanonicalLieBialgebra[data : KeyValuePattern[{"Pairing" -> _GradedPairing, "EmptyWord" -> True | False}]?AssociationQ][key_String] := data[key]

MaurerCartanElement[data_Association][{l_Integer, g_Integer}] := Lookup[data["Parts"], Key[{l, g}], 0]

MaurerCartanElement[data_Association]["BDAction"] :=
	Expand[Total[KeyValueMap[{key, part} |-> HBar^Last[key] part, data["Parts"]]]]

MaurerCartanElement[data_Association][key_String] := data[key]
