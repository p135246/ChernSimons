---
Template: Symbol
Name: Bracket
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/Bracket
Keywords: [bracket, Lie bracket, derivation, involutive bi-Lie algebra]
SeeAlso: [Cobracket, Jacobi, Drinfeld, SymmetricProduct, ExteriorProduct, Pairing]
---

## Usage

<code>[Bracket]()[*u*, *v*, *pairing*]</code> gives the bracket $[u,v]$ of two cyclic words, in the convention carried by *pairing*.

<code>[Bracket]()[*p*, *pairing*]</code> applies the extension of the bracket as a derivation to a product *p* of any number of factors.

## Details & Options

The bracket is the operation $q_{2,1,0}$ of the involutive bi-Lie structure: it takes two cyclic words and returns one, contracting one particle of each against the pairing.

The convention key of *pairing* selects the picture. `"Symmetric"` gives the bracket of the [SymmetricProduct]() grading, `"Exterior"` that of the [ExteriorProduct]() grading; the two differ by signs, not by the underlying contraction.

In the two-argument form *p* is a [SymmetricProduct]() or an [ExteriorProduct](), and the result is the derivation extension $\hat q_{2,1,0}$: the bracket is applied to each pair of factors in turn, with the Koszul sign of the shuffle, and the remaining factors are carried along. The extension lowers the number of factors by one.

The identities the bracket satisfies are the business of [Jacobi]() and [Drinfeld](); [RelationFailures]() searches for a counterexample over a range of word lengths.

## Basic Examples

The bracket of two words of the circle:

```wl
Bracket[CyclicWord[{x}], CyclicWord[{x, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -CyclicWord[{x}] -->

---

Multiplicities show up as integer coefficients:

```wl
Bracket[CyclicWord[{x, y}], CyclicWord[{y, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -2 CyclicWord[{y, y}] -->

---

The bracket of a word with itself may vanish:

```wl
Bracket[CyclicWord[{x, y}], CyclicWord[{x, y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

## Scope

The derivation extension applied to a two-factor product returns a one-factor product:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Bracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{x}]] -->

---

On three factors it sums over the pairs, with the shuffle signs:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Bracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], pairing], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] - 2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y}]] -->

---

The same in the exterior picture:

```wl
exterior = Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
Bracket[ExteriorProduct[CyclicWord[{x}], CyclicWord[{x, y}], exterior], exterior]
```

<!-- => -ExteriorProduct[CyclicWord[{x}]] -->

---

The whole bracket table in length at most $2$:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
words = CyclicWords[2, pairing, "UpTo" -> True];
Outer[Bracket[#1, #2, pairing] &, words, words]
```

<!-- => a 4x4 array of cyclic words and 0s -->

## Properties and Relations

On two cyclic words the two conventions agree here, and differ only through the signs the products carry:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
exterior = Append[pairing, "Convention" -> "Exterior"];
{Bracket[CyclicWord[{x}], CyclicWord[{x, y}], pairing], Bracket[CyclicWord[{x}], CyclicWord[{x, y}], exterior]}
```

<!-- => {-CyclicWord[{x}], -CyclicWord[{x}]} -->

---

The bracket satisfies the graded Jacobi identity throughout the enumerated range:

```wl
RelationFailures["Jacobi", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 3]
```

<!-- => {} -->

## Possible Issues

**The derivation form does not see a scalar coefficient.** <code>[Bracket]()[*c* *p*, *pairing*]</code> for a number *c* — including the sign a product returns when its factors need reordering — matches neither definition and is returned unevaluated. Divide the coefficient out and multiply it back afterwards.

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
p = SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing];
Head[Bracket[-p, pairing]]
```

<!-- => Bracket -->

---

For the same reason <code>[Bracket]()[0, *pairing*]</code> does not evaluate to $0$; test for a vanishing argument before applying the extension.

```wl
Head[Bracket[0, Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]]
```

<!-- => Bracket -->
