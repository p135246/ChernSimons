---
Template: Symbol
Name: InvolutivityObstruction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/InvolutivityObstruction
Keywords: [involutivity, involutive bi-Lie algebra, obstruction, defining identity]
SeeAlso: [InvolutiveBracket, InvolutiveCobracket, JacobiObstruction, CoJacobiObstruction, DrinfeldObstruction, $DefiningIdentities]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[InvolutivityObstruction]()[*w*, *pairing*]</code> gives the involutivity obstruction of a cyclic word; $0$ means the identity holds there.

## Details & Options

The obstruction is the composite $\hat q_{2,1,0}\circ\hat q_{1,2,0}$ applied to *w* — cut the word in two with [InvolutiveCobracket](), then bracket the two pieces back together. Its vanishing is the *involutive* in involutive bi-Lie algebra, and it is the identity that fails for a general bi-Lie structure.

The convention key of *pairing* selects the picture.

The composite lands back where it started, on a single cyclic word, so the obstruction is a word rather than a product.

[InvolutivityObstruction]() is the arity-$1$ entry of [$DefiningIdentities]().

Words with vanishing [InvolutiveCobracket]() have vanishing obstruction for trivial reasons; over the alphabet of the circle the first informative test is at length $4$.

## Basic Examples

The identity holds on the shortest word with a nonzero co-bracket:

```wl
InvolutivityObstruction[CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

And in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
InvolutivityObstruction[CyclicWord[{x, y, y, y}], exterior]
```

<!-- => 0 -->

## Scope

Over every word of length at most $5$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Union[Map[InvolutivityObstruction[#, pairing] &, CyclicWords[5, pairing, "UpTo" -> True]]]
```

<!-- => {0} -->

## Properties and Relations

Sweeping it over an enumerated range of words, every value is zero:

```wl
words[n_] := CyclicWords[n, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True];
DeleteDuplicates[Map[w |-> Expand[InvolutivityObstruction[w, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]], words[5]]]
```

<!-- => {0} -->

---

The other composite of the same two operations is what [CoJacobiObstruction]() and [DrinfeldObstruction]() test; together the four make up [$DefiningIdentities]():

```wl
Keys[$DefiningIdentities]
```

<!-- => {"JacobiObstruction", "CoJacobiObstruction", "DrinfeldObstruction", "InvolutivityObstruction"} -->
