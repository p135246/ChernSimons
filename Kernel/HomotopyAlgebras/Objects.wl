PackageExported[AInfinityAlgebraQ]

AInfinityAlgebraQ::usage = "AInfinityAlgebraQ[expr] tests whether expr is an AInfinityAlgebra object.";

AInfinityAlgebra[data_Association][key_String] := data[key]

AInfinityAlgebra /: Append[AInfinityAlgebra[data_Association], new_] := AInfinityAlgebra[Append[data, new]]
AInfinityAlgebra /: Normal[AInfinityAlgebra[data_Association]] := data
AInfinityAlgebra /: Keys[AInfinityAlgebra[data_Association]] := Keys[data]
AInfinityAlgebra /: KeyExistsQ[AInfinityAlgebra[data_Association], key_] := KeyExistsQ[data, key]
AInfinityAlgebra /: Lookup[AInfinityAlgebra[data_Association], rest___] := Lookup[data, rest]
AInfinityAlgebra /: KeyDrop[AInfinityAlgebra[data_Association], keys_] := AInfinityAlgebra[KeyDrop[data, keys]]
AInfinityAlgebra /: KeyTake[AInfinityAlgebra[data_Association], keys_] := AInfinityAlgebra[KeyTake[data, keys]]

AInfinityMorphism[data_Association][key_String] := data[key]

AInfinityAlgebraQ[AInfinityAlgebra[_Association]] := True
AInfinityAlgebraQ[_] := False
