---
Template: Symbol
Name: TwistedCobracket
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/TwistedCobracket
Keywords: [twisted cobracket, Maurer-Cartan, q120]
SeeAlso: [TwistedDifferential, MaurerCartanElement, CanonicalLieCobracket, Obstruction]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[TwistedCobracket]()[*m*, *w*]</code> gives the co-bracket $q^{\mathfrak{m}}_{1,2,0}$ twisted by the [MaurerCartanElement]() *m*, applied to the cyclic word *w*.

<code>[TwistedCobracket]()[*m*, *p*]</code> gives the extension of the twisted co-bracket as a co-derivation, applied to a product *p* of cyclic words.

<!-- #| annotation: 26.09.30: Design review - the twisted co-bracket takes the whole MaurerCartanElement and reads its part m_{2,0} and its pairing from it, so it takes no pairing argument (design 2 of the names doc, R5d, kept by Pavel); a BD action in place of the element returns unevaluated. The part is read in the head of the convention of the pairing, which the element guarantees, since an element whose products carry the other head is not built. A review proposed accepting either head and computing in the exterior picture, but the paper draft states the twist in the symmetric picture, and silently dropping a part of the wrong head would lose terms (R2, kept by Pavel). Unlike the twisted differential the result depends on the convention, and SymmetricToExterior relates the two pictures. Prior art: the Wolfram Language has no twisted string operations; T12/paclet-twisted-operations pins the exterior picture against the engine's q120Twisted and the symmetric one against the engine's q120Odot plus the BD bracket with the two-word part, on every word to length 5, and T12/paclet-twisted-operations-on-products pins the extension to products of two words. No alternative interface was recorded. -->

## Details & Options

- The twisted co-bracket is $q^{\mathfrak{m}}_{1,2,0} = q_{1,2,0} + q_{2,1,0}\circ_1\mathfrak{m}_{2,0}$: [CanonicalLieCobracket]() of *w*, plus the insertion of the part <code>*m*[{2, 0}]</code>, in which [CanonicalLieBracket]() pairs *w* with one factor and the other factor is kept, with the Koszul signs of the convention.
- The pairing is <code>*m*["Pairing"]</code>.
- Only the part $\mathfrak{m}_{2,0}$ enters. The part $\mathfrak{m}_{1,0}$ is what [TwistedDifferential]() reads.
- On a cyclic word the result is a sum of products of two words.
- The convention of the pairing selects the picture. Under `"Symmetric"` the parts of *m* and the result are [SymmetricProduct]() terms, under `"Exterior"` [ExteriorProduct]() terms.
- [SymmetricToExterior]() relates the two pictures: it sends $f\odot g$ to $(-1)^{|f|_\wedge} f\wedge g$, so over the circle $y\odot y$ corresponds to $-y\wedge y$.
- On a product the twisted co-bracket acts on each factor in turn, with the Koszul sign of the shuffle.
- A product of the other kind returns unevaluated.
- [TwistedCobracket]() is linear in its second argument, and a word may be given as the list of its particles.
- [TwistedCobracket]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether [CanonicalLieCobracket]() and [CanonicalLieBracket]() count the empty word <code>[CyclicWord]()[{}]</code> as a word |

## Basic Examples

The Chern-Simons truncation of the circle twists the co-bracket of $xy^2$:

```wl
TwistedCobracket[MaurerCartanElement[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], {x, y, y}]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]]/24 -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The Chern-Simons truncation:

```wl
chernSimons = MaurerCartanElement[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, pairing], pairing]
```

<!-- => a MaurerCartanElement object with the parts {1, 0} and {2, 0}, over the particles x and y, in the symmetric convention -->

The untwisted co-bracket of $xy^2$ is $0$:

```wl
CanonicalLieCobracket[{x, y, y}, pairing]
```

<!-- => 0 -->

On a product the twisted co-bracket acts factor by factor:

```wl
TwistedCobracket[chernSimons, SymmetricProduct[{x, y, y}, {y}, pairing]]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{y, y}]]/24 -->

## Scope

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The Chern-Simons truncation:

```wl
chernSimons = MaurerCartanElement[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, pairing], pairing]
```

<!-- => a MaurerCartanElement object with the parts {1, 0} and {2, 0}, over the particles x and y, in the symmetric convention -->

On $xy^3$ both the co-bracket and the twist contribute:

```wl
TwistedCobracket[chernSimons, {x, y, y, y}]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] + SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y, y}]]/24 -->

The twisted co-bracket is linear:

```wl
TwistedCobracket[chernSimons, 3 CyclicWord[{x, y, y}]]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]]/8 -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The same alphabet in the exterior convention:

```wl
exterior = Append[pairing, "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1, in the exterior convention -->

The Chern-Simons truncation, sent to the exterior picture by [SymmetricToExterior]():

```wl
element = MaurerCartanElement[SymmetricToExterior[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, pairing], pairing], exterior]
```

<!-- => a MaurerCartanElement object with the parts {1, 0} and {2, 0}, over the particles x and y, in the exterior convention -->

The twisted co-bracket of $xy^2$ in the exterior picture:

```wl
TwistedCobracket[element, {x, y, y}]
```

<!-- => -1/24 ExteriorProduct[CyclicWord[{y}], CyclicWord[{y, y}]] -->

On an exterior product it acts factor by factor:

```wl
TwistedCobracket[element, ExteriorProduct[{x, y, y}, {y}, exterior]]
```

<!-- => -1/24 ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

## Options

### EmptyWord

The co-bracket of $xy$ is $0$ by default:

```wl
TwistedCobracket[MaurerCartanElement[CyclicWord[{x, x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], {x, y}]
```

<!-- => 0 -->

---

With `"EmptyWord" -> True` it is a product of two empty words:

```wl
TwistedCobracket[MaurerCartanElement[CyclicWord[{x, x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], {x, y}, "EmptyWord" -> True]
```

<!-- => -SymmetricProduct[CyclicWord[{}], CyclicWord[{}]] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The symmetric result, sent to the exterior picture, is the exterior result:

```wl
SymmetricToExterior[TwistedCobracket[MaurerCartanElement[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, pairing], pairing], {x, y, y}], pairing]
```

<!-- => -1/24 ExteriorProduct[CyclicWord[{y}], CyclicWord[{y, y}]] -->

The canonical element has no two-word part, so it leaves the co-bracket as it is:

```wl
TwistedCobracket[MaurerCartanElement[CyclicWord[{x, x, y}], pairing], {x, y, y, y}] === CanonicalLieCobracket[{x, y, y, y}, pairing]
```

<!-- => True -->

## Possible Issues

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

An exterior product under a symmetric pairing returns unevaluated, after the product has brought its factors to their canonical order:

```wl
TwistedCobracket[MaurerCartanElement[CyclicWord[{x, x, y}], pairing], ExteriorProduct[{x, y, y}, {y}, Append[pairing, "Convention" -> "Exterior"]]]
```

<!-- => minus the input with ExteriorProduct[CyclicWord[{y}], CyclicWord[{x, y, y}]] in place, unevaluated -->

---

A BD action in place of the element returns unevaluated:

```wl
TwistedCobracket[CyclicWord[{x, x, y}], {x, y, y}]
```

<!-- => TwistedCobracket[CyclicWord[{x, x, y}], {x, y, y}] -->
