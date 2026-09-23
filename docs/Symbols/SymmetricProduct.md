---
Template: Symbol
Name: SymmetricProduct
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SymmetricProduct
Keywords: [symmetric product, odot, Koszul sign, shifted grading]
SeeAlso: [ExteriorProduct, ShiftIsomorphism, WordDegree, InvolutiveBracket, InvolutiveCobracket, GradedPairing]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[SymmetricProduct]()[*u*, *v*, …, *pairing*]</code> gives the graded symmetric product $u\odot v\odot\cdots$ of cyclic words, sorted into canonical order with the Koszul sign of the symmetric grading.

## Details & Options

The factors are cyclic words, or lists of particles; the last argument is always the pairing object. The product is linear in every factor.

Sorting uses the symmetric grading $[-]_1 = [-]-1$, the one [WordDegree]() returns under `"Symmetric"`. Exchanging two factors costs $(-1)^{[u]_1[v]_1}$.

Because the grading is shifted by one relative to [ExteriorProduct](), the two products disagree on signs on the very same factors. Reconciling them is what [ShiftIsomorphism]() is for, and the sign translation between the two pictures is the delicate part of the whole subject.

The normalized result carries only its factors — the pairing argument is consumed.

A product with a repeated factor of odd symmetric degree is $0$.

This is the default picture: a pairing object built by [GradedPairing]() carries `"Convention" -> "Symmetric"` unless it is reset.

A normalized product displays as its factors joined by $\odot$, each word in its own parentheses.

## Basic Examples

Two factors, sorted into canonical order:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

A repeated factor of odd symmetric degree vanishes:

```wl
SymmetricProduct[CyclicWord[{x}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

Any number of factors is sorted at once:

```wl
SymmetricProduct[CyclicWord[{y, y}], CyclicWord[{y}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

## Scope

A single factor is the word itself:

```wl
SymmetricProduct[CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => CyclicWord[{x}] -->

---

Factors may be given as lists of particles, and are brought into canonical rotation:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{SymmetricProduct[{y}, {x}, pairing], SymmetricProduct[CyclicWord[{y, x, x}], CyclicWord[{y}], pairing]}
```

<!-- => {SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]], SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, x, y}]]} -->

---

A repeated factor of even symmetric degree survives:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Properties and Relations

The symmetric and exterior pictures differ by exactly the shift in the grading:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], pairing], ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]}
```

<!-- => {SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]], -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]]} -->

---

[ShiftIsomorphism]() carries one to the other, and back:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}], pairing];
ShiftIsomorphism[ShiftIsomorphism[e, pairing], pairing, "Inverse" -> True] === e
```

<!-- => True -->

---

[InvolutiveCobracket]() of a word lands in a two-factor symmetric product:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
InvolutiveCobracket[CyclicWord[{x, y, y, y}], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Possible Issues

The pairing object is a positional argument and must come last. Omitting it leaves the product unevaluated rather than raising a message.

```wl
Head[SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}]]]
```

<!-- => SymmetricProduct -->
