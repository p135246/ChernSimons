---
Template: Symbol
Name: JacobiObstruction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/JacobiObstruction
Keywords: [Jacobi identity, obstruction, Lie bracket, defining identity]
SeeAlso: [InvolutiveBracket, CoJacobiObstruction, DrinfeldObstruction, InvolutivityObstruction, $DefiningIdentities]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[JacobiObstruction]()[*u*, *v*, *w*, *pairing*]</code> gives the Jacobi obstruction of three cyclic words; $0$ means the identity holds there.

## Details & Options

The obstruction is the composite $\hat q_{2,1,0}\circ\hat q_{2,1,0}$ applied to the product $u\odot v\odot w$ — the graded Jacobi identity written as the statement that the derivation extension of [InvolutiveBracket]() squares to zero.

The convention key of *pairing* selects the picture, exactly as it does for [InvolutiveBracket]().

A nonzero value is a counterexample to the identity for that pairing, not a bug in the input: the identity is a property of the pairing, and this function is how it is tested.

[JacobiObstruction]() is the arity-$3$ entry of [$DefiningIdentities]().

## Basic Examples

The identity holds on a triple of words of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
JacobiObstruction[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], pairing]
```

<!-- => 0 -->

---

And in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
JacobiObstruction[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], exterior]
```

<!-- => 0 -->

## Scope

Over every triple of words of length at most $2$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
words = CyclicWords[2, pairing, "UpTo" -> True];
Union[Flatten[Table[JacobiObstruction[u, v, w, pairing], {u, words}, {v, words}, {w, words}]]]
```

<!-- => {0} -->

## Properties and Relations

Sweeping it over an enumerated range of words, every value is zero:

```wl
words[n_] := CyclicWords[n, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True];
DeleteDuplicates[Map[t |-> Expand[JacobiObstruction[t[[1]], t[[2]], t[[3]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]], Tuples[words[3], 3]]]
```

<!-- => {0} -->

---

Its arity is recorded in [$DefiningIdentities](), which is what fixes the shape of the sweep:

```wl
$DefiningIdentities["JacobiObstruction"]["Arity"]
```

<!-- => 3 -->
