---
Template: Symbol
Name: Jacobi
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/Jacobi
Keywords: [Jacobi identity, obstruction, Lie bracket, defining identity]
SeeAlso: [Bracket, CoJacobi, Drinfeld, Involutivity, RelationFailures, $Relations]
---

## Usage

<code>[Jacobi]()[*u*, *v*, *w*, *pairing*]</code> gives the Jacobi obstruction of three cyclic words; $0$ means the identity holds there.

## Details & Options

The obstruction is the composite $\hat q_{2,1,0}\circ\hat q_{2,1,0}$ applied to the product $u\odot v\odot w$ — the graded Jacobi identity written as the statement that the derivation extension of [Bracket]() squares to zero.

The convention key of *pairing* selects the picture, exactly as it does for [Bracket]().

A nonzero value is a counterexample to the identity for that pairing, not a bug in the input: the identity is a property of the pairing, and this function is how it is tested.

[Jacobi]() is the arity-$3$ entry of [$Relations](); [RelationFailures]() sweeps it over an enumerated range of words rather than one triple at a time.

## Basic Examples

The identity holds on a triple of words of the circle:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Jacobi[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], pairing]
```

<!-- => 0 -->

---

And in the exterior picture:

```wl
exterior = Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
Jacobi[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], exterior]
```

<!-- => 0 -->

## Scope

Over every triple of words of length at most $2$:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
words = CyclicWords[2, pairing, "UpTo" -> True];
Union[Flatten[Table[Jacobi[u, v, w, pairing], {u, words}, {v, words}, {w, words}]]]
```

<!-- => {0} -->

## Properties and Relations

[RelationFailures]() is the sweep form, and returns the empty list when the identity holds throughout the range:

```wl
RelationFailures["Jacobi", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 3]
```

<!-- => {} -->

---

Its arity is recorded in [$Relations](), which is what fixes the shape of the sweep:

```wl
$Relations["Jacobi"]["Arity"]
```

<!-- => 3 -->
