---
Template: Symbol
Name: ExteriorProduct
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/ExteriorProduct
Keywords: [exterior product, wedge, Koszul sign, graded commutative]
SeeAlso: [SymmetricProduct, ShiftIsomorphism, WordDegree, Bracket, Cobracket, Pairing]
---

## Usage

<code>[ExteriorProduct]()[*u*, *v*, …, *pairing*]</code> gives the graded exterior product $u\wedge v\wedge\cdots$ of cyclic words, sorted into canonical order with the Koszul sign of the exterior grading.

## Details & Options

The factors are cyclic words; the last argument is always the pairing object.

Sorting uses the exterior grading $[-]$, the one [WordDegree]() returns under `"Exterior"`. Exchanging two factors costs $(-1)^{[u][v]}$.

The normalized result carries only its factors — the pairing argument is consumed, so <code>[ExteriorProduct]()[*u*, *v*, *pairing*]</code> returns an expression of the form <code>[ExteriorProduct]()[*u'*, *v'*]</code>, possibly with a scalar sign in front.

A product with a repeated factor of odd exterior degree is $0$.

The product of a single factor is a legitimate one-factor product, not the bare word: the arities of [Bracket]() and [Cobracket]() as a derivation and a co-derivation are counted in factors.

This is the exterior half of the pair of pictures the paclet works in. Use it when the pairing object carries `"Convention" -> "Exterior"`; the symmetric picture is [SymmetricProduct]().

## Basic Examples

Two factors already in order:

```wl
ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

Exchanging them costs a Koszul sign:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

A repeated factor of odd exterior degree vanishes:

```wl
ExteriorProduct[CyclicWord[{x}], CyclicWord[{x}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

## Scope

Any number of factors is sorted at once:

```wl
ExteriorProduct[CyclicWord[{y, y}], CyclicWord[{y}], CyclicWord[{x}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

---

A repeated factor of even exterior degree survives:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}], Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Properties and Relations

[ShiftIsomorphism]() is what carries a [SymmetricProduct]() over to an [ExteriorProduct]():

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ShiftIsomorphism[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing], pairing]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

The two pictures disagree on signs, which is the whole point of keeping both:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], pairing], SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]}
```

<!-- => {-ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]], SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]]} -->

---

[Cobracket]() lands in a two-factor product:

```wl
pairing = Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
Cobracket[CyclicWord[{x, y, y, y}], pairing]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Possible Issues

The pairing object is a positional argument, not an option, and it must come last. Omitting it leaves the product unevaluated rather than raising a message.

```wl
Head[ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}]]]
```

<!-- => ExteriorProduct -->
