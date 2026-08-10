---
Template: Symbol
Name: SymmetricProduct
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/SymmetricProduct
Keywords: [symmetric product, odot, Koszul sign, shifted grading]
SeeAlso: [ExteriorProduct, ShiftIsomorphism, WordDegree, Bracket, Cobracket, Pairing]
---

## Usage

<code>[SymmetricProduct]()[*u*, *v*, …, *pairing*]</code> gives the graded symmetric product $u\odot v\odot\cdots$ of cyclic words, sorted into canonical order with the Koszul sign of the symmetric grading.

## Details & Options

The factors are cyclic words; the last argument is always the pairing object.

Sorting uses the symmetric grading $[-]_1 = [-]-1$, the one [WordDegree]() returns under `"Symmetric"`. Exchanging two factors costs $(-1)^{[u]_1[v]_1}$.

Because the grading is shifted by one relative to [ExteriorProduct](), the two products disagree on signs on the very same factors. Reconciling them is what [ShiftIsomorphism]() is for, and the sign translation between the two pictures is the delicate part of the whole subject.

The normalized result carries only its factors — the pairing argument is consumed.

A product with a repeated factor of odd symmetric degree is $0$.

This is the default picture: a pairing object built by [Pairing]() carries `"Convention" -> "Symmetric"` unless it is reset.

## Basic Examples

Two factors, sorted into canonical order:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

A repeated factor of odd symmetric degree vanishes:

```wl
SymmetricProduct[CyclicWord[{x}], CyclicWord[{x}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

Any number of factors is sorted at once:

```wl
SymmetricProduct[CyclicWord[{y, y}], CyclicWord[{y}], CyclicWord[{x}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

## Scope

A single factor is a one-factor product, not the bare word:

```wl
SymmetricProduct[CyclicWord[{x}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}]] -->

---

A repeated factor of even symmetric degree survives:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Properties and Relations

The symmetric and exterior pictures differ by exactly the shift in the grading:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], pairing], ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]}
```

<!-- => {SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]], -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]]} -->

---

[ShiftIsomorphism]() carries one to the other, and back:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}], pairing];
ShiftIsomorphism[ShiftIsomorphism[e, pairing], pairing, "Inverse" -> True] === e
```

<!-- => True -->

---

[Cobracket]() of a word lands in a two-factor symmetric product:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Cobracket[CyclicWord[{x, y, y, y}], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Possible Issues

The pairing object is a positional argument and must come last. Omitting it leaves the product unevaluated rather than raising a message.

```wl
Head[SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}]]]
```

<!-- => SymmetricProduct -->
