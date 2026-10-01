---
Template: Symbol
Name: SymmetricProduct
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SymmetricProduct
Keywords: [symmetric product, odot, Koszul sign, shifted grading]
SeeAlso: [ExteriorProduct, SymmetricToExterior, ExteriorToSymmetric, ElementDegree, StringBracket, StringCobracket, GradedPairing]
RelatedGuides: [StringAlgebras, BeilinsonDrinfeldFormalism]
---

## Usage

<code>[SymmetricProduct]()[*u*, *v*, …, *pairing*]</code> gives the graded symmetric product $u\odot v\odot\cdots$ of the cyclic words *u*, *v*, …, in canonical order with the Koszul sign of the symmetric grading.

<!-- #| annotation: 26.09.30: Design review - the symmetric product is the default of the two pictures the paper works in: a pairing object built by GradedPairing carries "Convention" -> "Symmetric", and the Beilinson-Drinfeld exports compute in it only. The sign translation between it and the exterior product is the heart of the project, so both products are exported and SymmetricToExterior and ExteriorToSymmetric carry one to the other. The pairing is the last positional argument, because the sort needs the symmetric degrees and they depend on the pairing degree; it is consumed, and the result SymmetricProduct[u, v, ...] carries only its factors, so an expression without a pairing is inert and is the normal form. A single remaining factor is the word itself, never a one-factor product, the rule every product of the paclet follows; the engine keeps a one-factor odot instead, which is why the comparison with it starts at two factors. The product carries its own linearity rules and accepts lists of particles, so a sum or a scalar multiple composes without a wrapper. Prior art: the Wolfram Language has no graded symmetric product; Symmetrize symmetrizes arrays. The engine the verification suites load builds its odot and wedge from one constructor, and T12/paclet-products-and-shift pins this product against its odot on all products of two and three words to length 3. -->

## Details & Options

- The factors are cyclic words or lists of particles, and the last argument is the pairing object.
- The factors are brought into canonical rotation and sorted in the symmetric grading $[-]_1 = [-]-1$, the one [ElementDegree]() gives under `"Symmetric"`. Exchanging two factors $u$ and $v$ costs $(-1)^{[u]_1[v]_1}$, the sign [KoszulSign]() gives with *parity* $0$.
- The pairing is consumed: the result is an expression <code>[SymmetricProduct]()[*u'*, *v'*, …]</code> of the sorted factors, possibly with a scalar sign in front.
- A product with a repeated factor of odd symmetric degree is $0$.
- The product of a single factor is the word itself.
- The product is linear in every factor, and a nested product is flattened.
- A factor given as the empty list is the empty word.
- The grading is shifted by one from that of [ExteriorProduct](), so the two products sort the same factors with different signs. [SymmetricToExterior]() and [ExteriorToSymmetric]() translate between them.
- A pairing object built by [GradedPairing]() carries `"Convention" -> "Symmetric"` unless it is reset, and its operations give their products as [SymmetricProduct]().
- A sorted product displays as its factors joined by $\odot$, each word in its own parentheses.

## Basic Examples

Two factors, sorted into canonical order:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

A repeated factor of odd symmetric degree vanishes, and $[x]_1 = -3$:

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

Factors may be given as lists of particles:

```wl
SymmetricProduct[{y}, {x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

Factors are brought into canonical rotation:

```wl
SymmetricProduct[CyclicWord[{y, x, x}], CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, x, y}]] -->

---

A repeated factor of even symmetric degree survives, and $[y]_1 = -2$:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

---

The product is linear in every factor:

```wl
SymmetricProduct[2 CyclicWord[{y}] + CyclicWord[{x, y}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 2 SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] - SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}]] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The two pictures sort the same factors with different signs. In the symmetric picture:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

In the exterior picture:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

A product of three words:

```wl
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

[SymmetricToExterior]() carries it to the exterior picture:

```wl
SymmetricToExterior[e, pairing]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

[ExteriorToSymmetric]() carries it back:

```wl
ExteriorToSymmetric[SymmetricToExterior[e, pairing], pairing] === e
```

<!-- => True -->

[StringCobracket]() of a word gives a two-factor symmetric product:

```wl
StringCobracket[CyclicWord[{x, y, y, y}], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Possible Issues

The pairing object is a positional argument and comes last. Without it the product returns unevaluated, unsorted:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}]]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}]] -->
