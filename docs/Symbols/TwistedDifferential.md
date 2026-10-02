---
Template: Symbol
Name: TwistedDifferential
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/TwistedDifferential
Keywords: [twisted differential, Maurer-Cartan, q110, Hochschild]
SeeAlso: [TwistedCobracket, MaurerCartanElement, Obstruction, CanonicalLieBracket, CyclicHochschildDifferential]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[TwistedDifferential]()[*m*, *w*]</code> gives the differential $q^{\mathfrak{m}}_{1,1,0}$ twisted by the [MaurerCartanElement]() *m*, applied to the cyclic word *w*.

<code>[TwistedDifferential]()[*m*, *p*]</code> gives the extension of the twisted differential as a derivation, applied to a product *p* of cyclic words.

<!-- #| annotation: 26.09.30: Design review - the twisted differential takes the whole MaurerCartanElement and reads its part m_{1,0} and its pairing from it, so it takes no pairing argument (design 2 of the names doc, R5d, kept by Pavel); before R5d it took a BD action and a pairing, and a BD action in place of the element now returns unevaluated. Only m_{1,0} enters, as in q^m_{110} = q_{110} + q_{210} o_1 m_{10}. On a word the result is the same in both conventions, because the sign exponents of the two pictures differ by 2|m|; on a product the head must be that of the convention, and a product of the other kind returns unevaluated rather than being coerced, as for CanonicalLieBracket. The extension to products is the derivation extension CyclicHochschildDifferential and CanonicalLieBracket use. Prior art: the Wolfram Language has no twisted string operations; the engine the verification suites load computes the same differential as q110Twisted[mcCanonical, -], a function of the bare BD action, and T12/paclet-twisted-operations pins this function against it on every word to length 5 in both conventions, T12/paclet-twisted-operations-on-products on products of two words. No alternative interface was recorded. -->

## Details & Options

- The twisted differential is $q^{\mathfrak{m}}_{1,1,0} = q_{1,1,0} + q_{2,1,0}\circ_1\mathfrak{m}_{1,0}$: [CyclicHochschildDifferential]() of *w* plus [CanonicalLieBracket]() of the part <code>*m*[{1, 0}]</code> with *w*.
- The pairing is <code>*m*["Pairing"]</code>.
- Only the part $\mathfrak{m}_{1,0}$ enters. The part $\mathfrak{m}_{2,0}$ is what [TwistedCobracket]() reads.
- When the pairing carries no differential, [CyclicHochschildDifferential]() is $0$ and the twist is the bracket alone.
- On a cyclic word the result is the same in both conventions.
- On a product the twisted differential acts on each factor in turn, with the Koszul sign of the shuffle, in the picture the convention of the pairing selects: a [SymmetricProduct]() under `"Symmetric"`, an [ExteriorProduct]() under `"Exterior"`.
- A product of the other kind returns unevaluated.
- [TwistedDifferential]() is linear in its second argument, and a word may be given as the list of its particles.
- When *m* solves the Maurer-Cartan equation, the twisted differential squares to zero.
- For the element <code>[CanonicalMaurerCartan]()[*pairing*]</code> of a Poincaré duality algebra it is the dual of the cyclic Hochschild differential of the algebra, whose homology is Connes' cyclic cohomology.
- [TwistedDifferential]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the bracket of two one-particle words is the empty word <code>[CyclicWord]()[{}]</code> rather than $0$ |

## Basic Examples

Twisting by the canonical element of the circle:

```wl
TwistedDifferential[MaurerCartanElement[CyclicWord[{x, x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], CyclicWord[{x, y, y}]]
```

<!-- => CyclicWord[{x, x, y, y}] -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The canonical element of the circle:

```wl
m = MaurerCartanElement[CyclicWord[{x, x, y}], pairing]
```

<!-- => a MaurerCartanElement object with the one part {1, 0} -> CyclicWord[{x, x, y}], over the particles x and y, in the symmetric convention -->

On a product it acts factor by factor:

```wl
TwistedDifferential[m, SymmetricProduct[{x, y, y}, {y}, pairing]]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, x, y, y}]] -->

## Scope

The alphabet of the circle in the exterior convention:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1, in the exterior convention -->

The canonical element in that convention:

```wl
m = MaurerCartanElement[CyclicWord[{x, x, y}], exterior]
```

<!-- => a MaurerCartanElement object with the one part {1, 0} -> CyclicWord[{x, x, y}], over the particles x and y, in the exterior convention -->

On a cyclic word the result is that of the symmetric convention:

```wl
TwistedDifferential[m, CyclicWord[{x, y, y}]]
```

<!-- => CyclicWord[{x, x, y, y}] -->

On an exterior product it acts factor by factor:

```wl
TwistedDifferential[m, ExteriorProduct[{x, y, y}, {y}, exterior]]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{x, x, y, y}]] -->

---

Words may be given as lists of particles:

```wl
TwistedDifferential[MaurerCartanElement[{x, x, y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], {x, y, y}]
```

<!-- => CyclicWord[{x, x, y, y}] -->

---

The twisted differential is linear:

```wl
TwistedDifferential[MaurerCartanElement[{x, x, y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], 2 CyclicWord[{x, y, y}] + a CyclicWord[{y}]]
```

<!-- => 2 CyclicWord[{x, x, y, y}] -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The part $\mathfrak{m}_{2,0}$ of the Chern-Simons truncation does not enter:

```wl
TwistedDifferential[MaurerCartanElement[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, pairing], pairing], {x, y, y}]
```

<!-- => CyclicWord[{x, x, y, y}] -->

## Options

### EmptyWord

The twist by a one-particle word of a one-particle word is $0$ by default:

```wl
TwistedDifferential[MaurerCartanElement[CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], {x}]
```

<!-- => 0 -->

---

With `"EmptyWord" -> True` it is the empty word:

```wl
TwistedDifferential[MaurerCartanElement[CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], {x}, "EmptyWord" -> True]
```

<!-- => -CyclicWord[{}] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The canonical element of the circle:

```wl
m = MaurerCartanElement[{x, x, y}, pairing]
```

<!-- => a MaurerCartanElement object with the one part {1, 0} -> CyclicWord[{x, x, y}], over the particles x and y, in the symmetric convention -->

For a Maurer-Cartan element it squares to zero on every word of length at most $5$:

```wl
Union[(w |-> TwistedDifferential[m, TwistedDifferential[m, w]]) /@ GenerateCyclicWords[5, pairing, "UpTo" -> True]]
```

<!-- => {0} -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The pairing carries no differential, so the untwisted differential is $0$:

```wl
CyclicHochschildDifferential[CyclicWord[{x, y, y}], pairing]
```

<!-- => 0 -->

The twist is the bracket with the part $\mathfrak{m}_{1,0}$:

```wl
CanonicalLieBracket[CyclicWord[{x, x, y}], CyclicWord[{x, y, y}], pairing]
```

<!-- => CyclicWord[{x, x, y, y}] -->

## Possible Issues

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

An exterior product under a symmetric pairing returns unevaluated, after the product has brought its factors to their canonical order:

```wl
TwistedDifferential[MaurerCartanElement[CyclicWord[{x, x, y}], pairing], ExteriorProduct[{x, y, y}, {y}, Append[pairing, "Convention" -> "Exterior"]]]
```

<!-- => minus the input with ExteriorProduct[CyclicWord[{y}], CyclicWord[{x, y, y}]] in place, unevaluated -->

---

A BD action in place of the element returns unevaluated:

```wl
TwistedDifferential[CyclicWord[{x, x, y}], CyclicWord[{x, y, y}]]
```

<!-- => TwistedDifferential[CyclicWord[{x, x, y}], CyclicWord[{x, y, y}]] -->
