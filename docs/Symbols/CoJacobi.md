---
Template: Symbol
Name: CoJacobi
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/CoJacobi
Keywords: [co-Jacobi identity, obstruction, cobracket, defining identity]
SeeAlso: [Cobracket, Jacobi, Drinfeld, Involutivity, RelationFailures, $Relations]
---

## Usage

<code>[CoJacobi]()[*w*, *pairing*]</code> gives the co-Jacobi obstruction of a cyclic word; $0$ means the identity holds there.

## Details & Options

The obstruction is the composite $\hat q_{1,2,0}\circ\hat q_{1,2,0}$ applied to *w* — the co-Jacobi identity written as the statement that the co-derivation extension of [Cobracket]() squares to zero.

The convention key of *pairing* selects the picture, exactly as it does for [Cobracket]().

The identity is dual to the one [Jacobi]() tests, and takes one word rather than three: the co-bracket raises the number of factors, so composing it with itself already involves every cut of the single input word.

[CoJacobi]() is the arity-$1$ entry of [$Relations](); [RelationFailures]() sweeps it over an enumerated range of words.

Words short enough to have vanishing [Cobracket]() have vanishing obstruction for trivial reasons; the first informative test over the alphabet of the circle is at length $4$.

## Basic Examples

The identity holds on the shortest word with a nonzero co-bracket:

```wl
CoJacobi[CyclicWord[{x, y, y, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

And in the exterior picture:

```wl
exterior = Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
CoJacobi[CyclicWord[{x, y, y, y}], exterior]
```

<!-- => 0 -->

## Scope

Over every word of length at most $5$:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Union[Map[CoJacobi[#, pairing] &, CyclicWords[5, pairing, "UpTo" -> True]]]
```

<!-- => {0} -->

## Properties and Relations

[RelationFailures]() is the sweep form:

```wl
RelationFailures["CoJacobi", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 5]
```

<!-- => {} -->

---

Composed the other way round, [Bracket]() after [Cobracket]() is what [Involutivity]() tests:

```wl
Involutivity[CyclicWord[{x, y, y, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->
