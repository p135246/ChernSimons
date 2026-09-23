JacobiObstruction::usage = "JacobiObstruction[u, v, w, pairing] is the Jacobi obstruction of three cyclic words, the derivation extension of InvolutiveBracket applied twice to their product; 0 means the identity holds there. It accepts the option \"EmptyWord\" of the bracket.";

CoJacobiObstruction::usage = "CoJacobiObstruction[w, pairing] is the co-Jacobi obstruction of a cyclic word, the co-derivation extension of InvolutiveCobracket applied twice; 0 means the identity holds there. It accepts the option \"EmptyWord\" of the co-bracket.";

DrinfeldObstruction::usage = "DrinfeldObstruction[u, v, pairing] is the Drinfeld compatibility obstruction of two cyclic words, the anticommutator of the extensions of InvolutiveBracket and InvolutiveCobracket on their product; 0 means the identity holds there. It accepts the option \"EmptyWord\" of the two operations.";

InvolutivityObstruction::usage = "InvolutivityObstruction[w, pairing] is the involutivity obstruction of a cyclic word, the extension of InvolutiveBracket applied to InvolutiveCobracket; 0 means the identity holds there. It accepts the option \"EmptyWord\" of the two operations.";

$DefiningIdentities::usage = "$DefiningIdentities is the Association of the defining identities of an involutive bi-Lie algebra, each carrying its arity and the function computing its obstruction.";

Options[JacobiObstruction] = {"EmptyWord" -> False}

Options[CoJacobiObstruction] = {"EmptyWord" -> False}

Options[DrinfeldObstruction] = {"EmptyWord" -> False}

Options[InvolutivityObstruction] = {"EmptyWord" -> False}

JacobiObstruction[u_, v_, w_, pairing_GradedPairing, opts : OptionsPattern[]] := Expand[InvolutiveBracket[
	InvolutiveBracket[
		If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct][u, v, w, pairing], pairing, opts],
	pairing, opts]]

CoJacobiObstruction[w_, pairing_GradedPairing, opts : OptionsPattern[]] :=
	Expand[InvolutiveCobracket[InvolutiveCobracket[w, pairing, opts], pairing, opts]]

DrinfeldObstruction[u_, v_, pairing_GradedPairing, opts : OptionsPattern[]] := With[
	{product = If[pairing["Convention"] === "Exterior", ExteriorProduct, SymmetricProduct][u, v, pairing]},
	Expand[InvolutiveCobracket[InvolutiveBracket[product, pairing, opts], pairing, opts]
		+ InvolutiveBracket[InvolutiveCobracket[product, pairing, opts], pairing, opts]]]

InvolutivityObstruction[w_, pairing_GradedPairing, opts : OptionsPattern[]] :=
	Expand[InvolutiveBracket[InvolutiveCobracket[w, pairing, opts], pairing, opts]]

$DefiningIdentities = <|
	"JacobiObstruction" -> <|"Arity" -> 3, "Function" -> JacobiObstruction|>,
	"CoJacobiObstruction" -> <|"Arity" -> 1, "Function" -> CoJacobiObstruction|>,
	"DrinfeldObstruction" -> <|"Arity" -> 2, "Function" -> DrinfeldObstruction|>,
	"InvolutivityObstruction" -> <|"Arity" -> 1, "Function" -> InvolutivityObstruction|>|>
