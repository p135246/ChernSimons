---
Template: Symbol
Name: Involutivity
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/Involutivity
Keywords: [involutivity, involutive bi-Lie algebra, obstruction, defining identity]
SeeAlso: [Bracket, Cobracket, Jacobi, CoJacobi, Drinfeld, RelationFailures, $Relations]
---

## Usage

<code>[Involutivity]()[*w*, *pairing*]</code> gives the involutivity obstruction of a cyclic word; $0$ means the identity holds there.

## Details & Options

The obstruction is the composite $\hat q_{2,1,0}\circ\hat q_{1,2,0}$ applied to *w* — cut the word in two with [Cobracket](), then bracket the two pieces back together. Its vanishing is the *involutive* in involutive bi-Lie algebra, and it is the identity that fails for a general bi-Lie structure.

The convention key of *pairing* selects the picture.

The composite lands back where it started, on a single cyclic word, so the obstruction is a word rather than a product.

[Involutivity]() is the arity-$1$ entry of [$Relations](); [RelationFailures]() sweeps it over an enumerated range of words.

Words with vanishing [Cobracket]() have vanishing obstruction for trivial reasons; over the alphabet of the circle the first informative test is at length $4$.

## Basic Examples

The identity holds on the shortest word with a nonzero co-bracket:

```wl
Involutivity[CyclicWord[{x, y, y, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

And in the exterior picture:

```wl
exterior = Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
Involutivity[CyclicWord[{x, y, y, y}], exterior]
```

<!-- => 0 -->

## Scope

Over every word of length at most $5$:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Union[Map[Involutivity[#, pairing] &, CyclicWords[5, pairing, "UpTo" -> True]]]
```

<!-- => {0} -->

## Properties and Relations

[RelationFailures]() is the sweep form:

```wl
RelationFailures["Involutivity", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 5]
```

<!-- => {} -->

---

The other composite of the same two operations is what [CoJacobi]() and [Drinfeld]() test; together the four make up [$Relations]():

```wl
Keys[$Relations]
```

<!-- => {"Jacobi", "CoJacobi", "Drinfeld", "Involutivity"} -->
