---
Template: Symbol
Name: Drinfeld
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/Drinfeld
Keywords: [Drinfeld compatibility, bi-Lie, obstruction, defining identity]
SeeAlso: [Bracket, Cobracket, Jacobi, CoJacobi, Involutivity, RelationFailures, $Relations]
---

## Usage

<code>[Drinfeld]()[*u*, *v*, *pairing*]</code> gives the Drinfeld compatibility obstruction of two cyclic words; $0$ means the identity holds there.

## Details & Options

The obstruction is $\hat q_{1,2,0}\circ\hat q_{2,1,0} + \hat q_{2,1,0}\circ\hat q_{1,2,0}$ applied to the product $u\odot v$ — the statement that the co-bracket is a derivation for the bracket, which is what makes the two operations a bi-Lie structure rather than two unrelated ones.

The convention key of *pairing* selects the picture.

Both composites raise and lower the number of factors by one, so the obstruction lives in the same two-factor space as the input product, and the identity is the vanishing of their sum rather than of either term.

[Drinfeld]() is the arity-$2$ entry of [$Relations](); [RelationFailures]() sweeps it over an enumerated range of pairs.

## Basic Examples

The identity holds on a pair of words of the circle:

```wl
Drinfeld[CyclicWord[{x, y}], CyclicWord[{x, y, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

And in the exterior picture:

```wl
exterior = Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
Drinfeld[CyclicWord[{x, y}], CyclicWord[{x, y, y}], exterior]
```

<!-- => 0 -->

## Scope

Over every pair of words of length at most $3$:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
words = CyclicWords[3, pairing, "UpTo" -> True];
Union[Flatten[Table[Drinfeld[u, v, pairing], {u, words}, {v, words}]]]
```

<!-- => {0} -->

## Properties and Relations

[RelationFailures]() is the sweep form:

```wl
RelationFailures["Drinfeld", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 3]
```

<!-- => {} -->

---

The four defining identities together, each on its own arity:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[# -> RelationFailures[#, pairing, 3] &, Keys[$Relations]]
```

<!-- => {"Jacobi" -> {}, "CoJacobi" -> {}, "Drinfeld" -> {}, "Involutivity" -> {}} -->
