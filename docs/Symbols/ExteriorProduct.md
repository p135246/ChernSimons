---
Template: Symbol
Name: ExteriorProduct
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/ExteriorProduct
Keywords: [exterior product, wedge, Koszul sign, graded commutative]
SeeAlso: [SymmetricProduct, ShiftIsomorphism, WordDegree, InvolutiveBracket, InvolutiveCobracket, GradedPairing]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[ExteriorProduct]()[*u*, *v*, …, *pairing*]</code> gives the graded exterior product $u\wedge v\wedge\cdots$ of cyclic words, sorted into canonical order with the Koszul sign of the exterior grading.

## Details & Options

The factors are cyclic words; the last argument is always the pairing object.

Sorting uses the exterior grading $[-]$, the one [WordDegree]() returns under `"Exterior"`. Exchanging two factors costs $(-1)^{[u][v]}$.

The normalized result carries only its factors — the pairing argument is consumed, so <code>[ExteriorProduct]()[*u*, *v*, *pairing*]</code> returns an expression of the form <code>[ExteriorProduct]()[*u'*, *v'*]</code>, possibly with a scalar sign in front.

A product with a repeated factor of odd exterior degree is $0$.

The product of a single factor is the word itself. The arities of [InvolutiveBracket]() and [InvolutiveCobracket]() as a derivation and a co-derivation are counted in factors, a bare word counting as one. The factors may be given as lists of particles, and the product is linear in every factor.

This is the exterior half of the pair of pictures the paclet works in. Use it when the pairing object carries `"Convention" -> "Exterior"`; the symmetric picture is [SymmetricProduct]().

A normalized product displays as its factors joined by $\wedge$, each word in its own parentheses.

## Basic Examples

Two factors already in order:

```wl
ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

Exchanging them costs a Koszul sign:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

A repeated factor of odd exterior degree vanishes:

```wl
ExteriorProduct[CyclicWord[{x}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

## Scope

Any number of factors is sorted at once:

```wl
ExteriorProduct[CyclicWord[{y, y}], CyclicWord[{y}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

---

A repeated factor of even exterior degree survives:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Properties and Relations

[ShiftIsomorphism]() is what carries a [SymmetricProduct]() over to an [ExteriorProduct]():

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ShiftIsomorphism[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing], pairing]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

The two pictures disagree on signs, which is the whole point of keeping both:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], pairing], SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]}
```

<!-- => {-ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]], SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]]} -->

---

[InvolutiveCobracket]() lands in a two-factor product:

```wl
pairing = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
InvolutiveCobracket[CyclicWord[{x, y, y, y}], pairing]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Possible Issues

The pairing object is a positional argument, not an option, and it must come last. Omitting it leaves the product unevaluated rather than raising a message.

```wl
Head[ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}]]]
```

<!-- => ExteriorProduct -->
