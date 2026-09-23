---
Template: Symbol
Name: DrinfeldObstruction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/DrinfeldObstruction
Keywords: [Drinfeld compatibility, bi-Lie, obstruction, defining identity]
SeeAlso: [InvolutiveBracket, InvolutiveCobracket, JacobiObstruction, CoJacobiObstruction, InvolutivityObstruction, $DefiningIdentities]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[DrinfeldObstruction]()[*u*, *v*, *pairing*]</code> gives the Drinfeld compatibility obstruction of two cyclic words; $0$ means the identity holds there.

## Details & Options

The obstruction is $\hat q_{1,2,0}\circ\hat q_{2,1,0} + \hat q_{2,1,0}\circ\hat q_{1,2,0}$ applied to the product $u\odot v$ — the statement that the co-bracket is a derivation for the bracket, which is what makes the two operations a bi-Lie structure rather than two unrelated ones.

The convention key of *pairing* selects the picture.

Both composites raise and lower the number of factors by one, so the obstruction lives in the same two-factor space as the input product, and the identity is the vanishing of their sum rather than of either term.

[DrinfeldObstruction]() is the arity-$2$ entry of [$DefiningIdentities]().

## Basic Examples

The identity holds on a pair of words of the circle:

```wl
DrinfeldObstruction[CyclicWord[{x, y}], CyclicWord[{x, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

And in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
DrinfeldObstruction[CyclicWord[{x, y}], CyclicWord[{x, y, y}], exterior]
```

<!-- => 0 -->

## Scope

Over every pair of words of length at most $3$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
words = CyclicWords[3, pairing, "UpTo" -> True];
Union[Flatten[Table[DrinfeldObstruction[u, v, pairing], {u, words}, {v, words}]]]
```

<!-- => {0} -->

## Properties and Relations

Sweeping it over an enumerated range of words, every value is zero:

```wl
words[n_] := CyclicWords[n, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True];
DeleteDuplicates[Map[t |-> Expand[DrinfeldObstruction[t[[1]], t[[2]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]], Tuples[words[3], 2]]]
```

<!-- => {0} -->

---

The four defining identities together, each on its own arity:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Normal[Map[e |-> DeleteDuplicates[Map[t |-> Expand[e["Function"] @@ Append[t, pairing]],
   Tuples[CyclicWords[3, pairing, "UpTo" -> True], e["Arity"]]]], $DefiningIdentities]]
```

<!-- => {"JacobiObstruction" -> {0}, "CoJacobiObstruction" -> {0}, "DrinfeldObstruction" -> {0}, "InvolutivityObstruction" -> {0}} -->
