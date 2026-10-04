---
Template: Symbol
Name: CanonicalBeilinsonDrinfeldOperator
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CanonicalBeilinsonDrinfeldOperator
Keywords: [BD algebra, Beilinson-Drinfeld, BV operator, Delta, cobracket, bracket]
SeeAlso: [CanonicalBeilinsonDrinfeldBracket, MaurerCartanElement, Obstruction, ElementDegree, HBar]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[CanonicalBeilinsonDrinfeldOperator]()[*e*, *pairing*]</code> gives the operator $\Delta = \widehat{q}_{1,1,0} + \widehat{q}_{1,2,0} + \hbar\,\widehat{q}_{2,1,0}$ of the Beilinson-Drinfeld algebra, applied to *e*.

<!-- #| annotation: 26.09.30: Design review - the operator is the sum of three exported extensions, CyclicHochschildDifferential + CanonicalLieCobracket + HBar CanonicalLieBracket, all in the symmetric convention, and carries its own linearity rules; HBar is a scalar to every linearity rule and has even degree, so it never contributes a sign. A pairing in the exterior convention returns unevaluated, since the BD algebra is the symmetric algebra and computing in the symmetric product under an exterior key would ignore the one switch between the pictures; the decision of R2 was kept by Pavel, who wants the conversion between the pictures available, as SymmetricToExterior and ExteriorToSymmetric. The option "EmptyWord" is passed to the bracket and the co-bracket, where the empty word enters. Alternative name considered: BeilinsonDrinfeldOperator, the name until 2026-09-30. Prior art: the Wolfram Language has no BV or BD operators. T12/paclet-bd-operator-and-bracket pins the operator against the bdOperator of the engine the verification suites load on every word to length 5 and on the two-factor products of words to length 4, and T12/paclet-bd-operator-squares-to-zero pins that it squares to zero there. -->

## Details & Options

- $\Delta$ acts on the symmetric powers of cyclic words, completed over $\mathbb{R}[[\hbar]]$. It is a derivative of order at most $2$ and of symmetric degree $-1$, and it squares to zero exactly when the underlying structure is a dIBL algebra.
- The first summand is [CyclicHochschildDifferential]() extended as a derivation. It is $0$ unless the pairing carries a Poincaré duality algebra with a differential, so on a formal alphabet $\Delta$ is $\widehat{q}_{1,2,0} + \hbar\,\widehat{q}_{2,1,0}$.
- The second summand is [CanonicalLieCobracket]() extended as a co-derivation, and the third is [CanonicalLieBracket]() extended as a derivation and weighted by [HBar]().
- Only the third summand carries $\hbar$, so $\Delta$ is not divisible by $\hbar$.
- $\Delta$ obeys the BD axiom
$$\Delta(f f') = \Delta(f) f' + (-1)^{|f|} f \Delta(f') + (-1)^{|f|}\hbar\,\{f, f'\},$$
with $|f|$ the symmetric degree of $f$, whose bracket is [CanonicalBeilinsonDrinfeldBracket]() and carries no $\hbar$ of its own.
- *e* is a [CyclicWord](), a [SymmetricProduct]() of cyclic words, a list of letters, or a linear combination of these.
- The operator is linear, and [HBar]() is a scalar to it.
- A pairing object in the exterior convention, or an [ExteriorProduct](), returns unevaluated.
- [CanonicalBeilinsonDrinfeldOperator]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the bracket and the co-bracket are those of the extension by the empty word |

## Basic Examples

The operator on a word of the circle:

```wl
CanonicalBeilinsonDrinfeldOperator[CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

A product of two words:

```wl
p = SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{x, y}], CyclicWord[{x, y, y, y}]] -->

The operator on it has a term in [HBar]():

```wl
CanonicalBeilinsonDrinfeldOperator[p, pairing]
```

<!-- => 2*HBar*CyclicWord[{x, y, y, y}] - SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

It squares to zero:

```wl
CanonicalBeilinsonDrinfeldOperator[CanonicalBeilinsonDrinfeldOperator[p, pairing], pairing]
```

<!-- => 0 -->

## Scope

A word may be given as the list of its letters:

```wl
CanonicalBeilinsonDrinfeldOperator[{x, y, y, y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

---

The operator is linear, with [HBar]() a scalar:

```wl
CanonicalBeilinsonDrinfeldOperator[3 HBar CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -3 HBar SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

---

A product of three words:

```wl
CanonicalBeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => HBar SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] - 2 HBar SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y}]] -->

## Options

### EmptyWord

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

On a product of two one-letter words the operator is $0$ in the positive-length convention:

```wl
CanonicalBeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing], pairing]
```

<!-- => 0 -->

With `"EmptyWord" -> True` the bracket of the two words is the empty word:

```wl
CanonicalBeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing], pairing, "EmptyWord" -> True]
```

<!-- => -(HBar*CyclicWord[{}]) -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

A product of two words:

```wl
p = SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{x, y}], CyclicWord[{x, y, y, y}]] -->

The operator is the sum of the three extensions:

```wl
CanonicalBeilinsonDrinfeldOperator[p, pairing] === Expand[CyclicHochschildDifferential[p, pairing] + CanonicalLieCobracket[p, pairing] + HBar CanonicalLieBracket[p, pairing]]
```

<!-- => True -->

The classical limit, at $\hbar = 0$, is the co-bracket alone:

```wl
CanonicalBeilinsonDrinfeldOperator[p, pairing] /. HBar -> 0
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

The coefficient of $\hbar$ is the bracket term:

```wl
Coefficient[CanonicalBeilinsonDrinfeldOperator[p, pairing], HBar]
```

<!-- => 2*CyclicWord[{x, y, y, y}] -->

The operator lowers the symmetric degree by $1$:

```wl
ElementDegree[CanonicalBeilinsonDrinfeldOperator[p, pairing], pairing, "Symmetric"] - ElementDegree[p, pairing, "Symmetric"]
```

<!-- => -1 -->

## Possible Issues

The alphabet of the circle in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1, in the exterior convention -->

The Beilinson-Drinfeld algebra lives in the symmetric picture, so an exterior pairing returns unevaluated:

```wl
CanonicalBeilinsonDrinfeldOperator[CyclicWord[{x, y, y, y}], exterior]
```

<!-- => the input with exterior in place, unevaluated -->
