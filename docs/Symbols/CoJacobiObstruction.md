---
Template: Symbol
Name: CoJacobiObstruction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CoJacobiObstruction
Keywords: [co-Jacobi identity, obstruction, cobracket, defining identity]
SeeAlso: [InvolutiveCobracket, JacobiObstruction, DrinfeldObstruction, InvolutivityObstruction, $DefiningIdentities]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[CoJacobiObstruction]()[*w*, *pairing*]</code> gives the co-Jacobi obstruction of a cyclic word; $0$ means the identity holds there.

## Details & Options

The obstruction is the composite $\hat q_{1,2,0}\circ\hat q_{1,2,0}$ applied to *w* — the co-Jacobi identity written as the statement that the co-derivation extension of [InvolutiveCobracket]() squares to zero.

The convention key of *pairing* selects the picture, exactly as it does for [InvolutiveCobracket]().

The identity is dual to the one [JacobiObstruction]() tests, and takes one word rather than three: the co-bracket raises the number of factors, so composing it with itself already involves every cut of the single input word.

[CoJacobiObstruction]() is the arity-$1$ entry of [$DefiningIdentities]().

Words short enough to have vanishing [InvolutiveCobracket]() have vanishing obstruction for trivial reasons; the first informative test over the alphabet of the circle is at length $4$.

## Basic Examples

The identity holds on the shortest word with a nonzero co-bracket:

```wl
CoJacobiObstruction[CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

And in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
CoJacobiObstruction[CyclicWord[{x, y, y, y}], exterior]
```

<!-- => 0 -->

## Scope

Over every word of length at most $5$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Union[Map[CoJacobiObstruction[#, pairing] &, CyclicWords[5, pairing, "UpTo" -> True]]]
```

<!-- => {0} -->

## Properties and Relations

Sweeping it over an enumerated range of words, every value is zero:

```wl
words[n_] := CyclicWords[n, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True];
DeleteDuplicates[Map[w |-> Expand[CoJacobiObstruction[w, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]], words[5]]]
```

<!-- => {0} -->

---

Composed the other way round, [InvolutiveBracket]() after [InvolutiveCobracket]() is what [InvolutivityObstruction]() tests:

```wl
InvolutivityObstruction[CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->
