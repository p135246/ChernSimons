---
Template: Symbol
Name: Cobracket
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/Cobracket
Keywords: [cobracket, co-Lie, co-derivation, involutive bi-Lie algebra]
SeeAlso: [Bracket, CoJacobi, Involutivity, Drinfeld, SymmetricProduct, ExteriorProduct, Pairing]
---

## Usage

<code>[Cobracket]()[*w*, *pairing*]</code> gives the co-bracket of a cyclic word *w*, a product of two words, in the convention carried by *pairing*.

<code>[Cobracket]()[*p*, *pairing*]</code> applies the extension of the co-bracket as a co-derivation to a product *p*.

## Details & Options

The co-bracket is the operation $q_{1,2,0}$ of the involutive bi-Lie structure: it takes one cyclic word and returns a product of two, cutting the word at a pair of positions and contracting the two removed particles against the pairing.

The convention key of *pairing* selects the picture: the result is a [SymmetricProduct]() under `"Symmetric"` and an [ExteriorProduct]() under `"Exterior"`.

A word too short to be cut in two, or one whose cuts all cancel, has co-bracket $0$. Over the alphabet of the circle the first nonzero co-bracket appears in length $4$.

In the two-argument form with a product argument the result is the co-derivation extension $\hat q_{1,2,0}$: the co-bracket is applied to each factor in turn, with the Koszul sign of the shuffle. The extension raises the number of factors by one.

The identities the co-bracket satisfies are the business of [CoJacobi](), [Drinfeld]() and [Involutivity]().

## Basic Examples

The first nonzero co-bracket over the alphabet of the circle:

```wl
Cobracket[CyclicWord[{x, y, y, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

---

A word too short to cut has co-bracket $0$:

```wl
Cobracket[CyclicWord[{x, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

The same computation in the exterior picture, where the answer lands in an [ExteriorProduct]():

```wl
exterior = Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
Cobracket[CyclicWord[{x, y, y, y}], exterior]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Scope

Over the whole alphabet up to length $5$, only two words have a nonzero co-bracket:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
DeleteCases[Map[# -> Cobracket[#, pairing] &, CyclicWords[5, pairing, "UpTo" -> True]], _ -> 0]
```

<!-- => {CyclicWord[{x, y, y, y}] -> -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]], CyclicWord[{x, y, y, y, y}] -> -2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]]} -->

---

The co-derivation extension raises the number of factors by one:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Cobracket[SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y, y, y}], pairing], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{y}]] -->

## Properties and Relations

The co-bracket squares to zero — the co-Jacobi identity — throughout the enumerated range:

```wl
RelationFailures["CoJacobi", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 5]
```

<!-- => {} -->

---

Composing it with [Bracket]() gives zero as well, which is involutivity:

```wl
RelationFailures["Involutivity", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 5]
```

<!-- => {} -->

---

[ShiftIsomorphism]() is the map that intertwines [Bracket]() and [Cobracket]() between the two pictures:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
exterior = Append[pairing, "Convention" -> "Exterior"];
{Cobracket[CyclicWord[{x, y, y, y}], pairing], Cobracket[CyclicWord[{x, y, y, y}], exterior]}
```

<!-- => {-SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]], ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]]} -->

## Possible Issues

**The co-derivation form does not see a scalar coefficient, and fails silently.** <code>[Cobracket]()[*c* *p*, *pairing*]</code> for a number *c* — including the sign a product returns when its factors need reordering — falls through to the one-word definition, and the result contains an unreduced private symbol of the engine rather than a product of cyclic words. The same happens on a sum of products. Divide the coefficient out, map over the terms of a sum, and multiply back afterwards.

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
p = SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y, y, y}], pairing];
Cobracket[-p, pairing] === -Cobracket[p, pairing]
```

<!-- => False -- the co-derivation extension is not linear in its first argument -->

---

The reliable form is to apply the extension to the bare product and put the coefficient back by hand:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
p = SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y, y, y}], pairing];
-Cobracket[p, pairing]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{y}]] -->
