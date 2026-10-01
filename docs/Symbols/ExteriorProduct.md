---
Template: Symbol
Name: ExteriorProduct
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/ExteriorProduct
Keywords: [exterior product, wedge, Koszul sign, graded commutative]
SeeAlso: [SymmetricProduct, SymmetricToExterior, ExteriorToSymmetric, ElementDegree, StringBracket, StringCobracket, GradedPairing]
RelatedGuides: [StringAlgebras]
---

## Usage

<code>[ExteriorProduct]()[*u*, *v*, …, *pairing*]</code> gives the graded exterior product $u\wedge v\wedge\cdots$ of the cyclic words *u*, *v*, …, in canonical order with the Koszul sign of the exterior grading.

<!-- #| annotation: 26.09.30: Design review - the exterior product is one of the two pictures the paper works in, and the sign translation between it and the symmetric product is the heart of the project, so both products are exported and SymmetricToExterior and ExteriorToSymmetric carry one to the other. The pairing is the last positional argument, because the sort needs the exterior degrees and they depend on the pairing degree; it is consumed, and the result ExteriorProduct[u, v, ...] carries only its factors, so an expression without a pairing is inert and is the normal form. A single remaining factor is the word itself, never a one-factor product, the rule every product of the paclet follows; the engine keeps a one-factor wedge instead, which is why the comparison with it starts at two factors. The product carries its own linearity rules and accepts lists of particles, so a sum or a scalar multiple composes without a wrapper. Prior art: the Wolfram Language has Wedge, an operator with no built-in meaning, and TensorWedge, the antisymmetric product of arrays; neither sorts graded words. The engine the verification suites load builds its odot and wedge from one constructor, and T12/paclet-products-and-shift pins this product against its wedge on all products of two and three words to length 3. -->

## Details & Options

- The factors are cyclic words or lists of particles, and the last argument is the pairing object.
- The factors are brought into canonical rotation and sorted in the exterior grading $[-]$, the one [ElementDegree]() gives under `"Exterior"`. Exchanging two factors $u$ and $v$ costs $(-1)^{[u][v]+1}$, the sign [KoszulSign]() gives with *parity* $1$.
- The pairing is consumed: the result is an expression <code>[ExteriorProduct]()[*u'*, *v'*, …]</code> of the sorted factors, possibly with a scalar sign in front.
- A product with a repeated factor of even exterior degree is $0$.
- The product of a single factor is the word itself.
- The product is linear in every factor, and a nested product is flattened.
- A factor given as the empty list is the empty word.
- The operations of a pairing object in the exterior convention give their products as [ExteriorProduct](); the symmetric picture is [SymmetricProduct]().
- The arities of [StringBracket]() and [StringCobracket]() as a derivation and a co-derivation are counted in factors, a single word counting as one.
- A sorted product displays as its factors joined by $\wedge$, each word in its own parentheses.

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

A repeated factor of even exterior degree vanishes, and $[x] = -2$:

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

A repeated factor of odd exterior degree survives, and $[y] = -1$:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

---

Factors may be given as lists of particles, and are brought into canonical rotation:

```wl
ExteriorProduct[{y}, {y, x, x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{x, x, y}]] -->

---

The product is linear in every factor:

```wl
ExteriorProduct[2 CyclicWord[{y}] + CyclicWord[{x, y}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -2 ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] - ExteriorProduct[CyclicWord[{x}], CyclicWord[{x, y}]] -->

---

A single factor is the word itself:

```wl
ExteriorProduct[CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => CyclicWord[{x}] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

[SymmetricToExterior]() carries a [SymmetricProduct]() over to an [ExteriorProduct]():

```wl
SymmetricToExterior[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing], pairing]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

The two pictures sort the same factors with different signs. In the exterior picture:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

In the symmetric picture:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

The alphabet of the circle in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1, in the exterior convention -->

[StringCobracket]() of a word gives a two-factor exterior product:

```wl
StringCobracket[CyclicWord[{x, y, y, y}], exterior]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Possible Issues

The pairing object is a positional argument and comes last. Without it the product returns unevaluated, unsorted:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}]]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}]] -->
