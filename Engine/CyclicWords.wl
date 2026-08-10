$letterDegrees = <|"x" -> -1, "y" -> 0, "a" -> -1, "b" -> 0|>;

$alphabet = {"x", "y"};

$primalAlphabet = {"a", "b"};

$pdDegree = 1;

cyc[{}] := 0

cyc[s_String] := cyc[Characters[s]]

cyc[w_List?cycAntisymmetricQ] := 0

cyc[w_List] := With[{min = cycCanonical[{1, w}]}, min[[1]] cyc[min[[2]]] /; min[[2]] =!= w]

Format[cyc[w_List]] := Row[w]

cycWords[n_Integer] := cycWords[n, $alphabet]

cycWords[n_Integer, alphabet_List] := DeleteCases[
	cyc /@ DeleteDuplicates[Map[w |-> cycCanonical[{1, w}][[2]], Tuples[alphabet, n]]], 0]

cycWordsUpTo[n_Integer] := cycWordsUpTo[n, $alphabet]

cycWordsUpTo[n_Integer, alphabet_List] := Join @@ Map[k |-> cycWords[k, alphabet], Range[n]]

cycAntisymmetricQ[w_List] := NestWhile[rotateLeft, rotateLeft[{1, w}], pair |-> pair[[2]] =!= w][[1]] == -1

cycCanonical[{c_Integer, w_List}] := First[SortBy[NestList[rotateLeft, {c, w}, Length[w] - 1], Last]]

rotateLeft[{c_Integer, {}}] := {c, {}}

rotateLeft[{c_Integer, w_List}] := {sgn[degBar[Take[w, 1]] degBar[Drop[w, 1]]] c, RotateLeft[w]}

rotateLeft[w_List] := rotateLeft[{1, w}][[2]]

degBar[w_List] := Total[Lookup[$letterDegrees, w]]

degBar[s_String] := degBar[Characters[s]]

degBar[cyc[w_List]] := degBar[w]

degC[w : _String | _List | _cyc] := degBar[w] + $pdDegree - 2

degC1[w : _String | _List | _cyc] := degC[w] - 1

cycLength[w_List] := Length[w]

cycLength[s_String] := StringLength[s]

cycLength[cyc[w_List]] := Length[w]
