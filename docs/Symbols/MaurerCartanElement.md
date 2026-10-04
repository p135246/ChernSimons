---
Template: Symbol
Name: MaurerCartanElement
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/MaurerCartanElement
Keywords: [Maurer-Cartan element, parts, BD action, genus, factors]
SeeAlso: [Obstruction, RelationsQ, CanonicalMaurerCartan, MaurerCartanAnsatz, TwistedDifferential, TwistedCobracket]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[MaurerCartanElement]()[*parts*, *pairing*]</code> is the element of the dIBL algebra of *pairing* with the given parts, an Association from $\{\ell, g\}$ to the part $\mathfrak{m}_{\ell,g}$.

<code>[MaurerCartanElement]()[*s*, *pairing*]</code> gives the element whose BD action is *s*.

<!-- #| annotation: 26.09.30: Design review - the element is its parts m_{l,g}, keyed by {l, g} with l the number of factors and g the genus, as the paper writes a Maurer-Cartan element (design 2 of the names doc, R5d, kept by Pavel). Both forms give the inert MaurerCartanElement[<|"Parts" -> parts, "Pairing" -> pairing|>], one Association like every other object of the paclet: with the two-argument expression as the object, an input that built nothing (a part with the wrong number of factors, a product of the other convention) would look exactly like an element, and its summary box would show it as one, while MatchQ[e, MaurerCartanElement[_Association]] tells them apart. The parts form splits the sum of HBar^g m_{l,g} again and compares, so the two forms accept the same elements. The terms are kept as given, expanded and grouped by key, and words are not brought to their canonical rotation, so that the element of an expanded BD action s gives s back exactly; two elements written with different rotations of one word therefore compare unequal. The element is not required to solve the Maurer-Cartan equation, since the Ansatz carries unknowns; Obstruction and RelationsQ test it, in place of the former MaurerCartanEquation and MaurerCartanQ. Prior art: the Wolfram Language has no dIBL or BD algebras; the engine the verification suites load keeps a Maurer-Cartan element as a bare expression, mcCanonical = cyc[{"x", "x", "y"}], and T12/paclet-maurer-cartan-element pins both round trips, the accessors, the head of the parts and six inputs that are not elements. -->

## Details & Options

- The part $\mathfrak{m}_{\ell,g}$ is a sum of products of $\ell$ cyclic words with coefficients free of [HBar](), where $\ell$ is the number of factors and $g$ the genus.
- The BD action of the element is $s = \sum_{\ell, g} \hbar^g\,\mathfrak{m}_{\ell,g}$, and the second form splits *s* into its parts.
- A part with $\ell = 1$ is a sum of cyclic words. The products of a part with $\ell \geq 2$ carry the head of the convention of *pairing*: [SymmetricProduct]() under `"Symmetric"`, [ExteriorProduct]() under `"Exterior"`.
- A word may be given as the list of its letters.
- The terms are kept as given, expanded and grouped by $\{\ell, g\}$. Words are not brought to a canonical rotation, so the element of an expanded BD action *s* gives *s* back.
- The zero BD action gives the element with no parts.
- For an element *m* the following properties are available:

| Form | Value |
|---|---|
| <code>*m*[{*l*, *g*}]</code> | the part $\mathfrak{m}_{\ell,g}$, $0$ when it is absent |
| <code>*m*["Parts"]</code> | the Association of the nonzero parts, sorted by key |
| <code>*m*["BDAction"]</code> | the BD action $\sum \hbar^g\,\mathfrak{m}_{\ell,g}$ |
| <code>*m*["Pairing"]</code> | the pairing |

- The element is not required to solve the Maurer-Cartan equation. <code>[Obstruction]()[*m*]</code> is the obstruction of that equation, and <code>[RelationsQ]()[*m*]</code> tests whether it is $0$.
- [TwistedDifferential]() and [TwistedCobracket]() take the element and read the pairing from it.
- The element displays as a summary box: the keys of its parts and the alphabet, with the convention and the parts themselves under the opener.
- [MaurerCartanElement]() returns unevaluated when a term of *s* is not a scalar times $\hbar^g$, $g \geq 0$, times one cyclic word or one product.
- It returns unevaluated when a product carries the head of the other convention.
- In the first form it returns unevaluated when a key is not $\{\ell, g\}$ with $\ell \geq 1$ and $g \geq 0$, or when a part contains [HBar]() or has terms with a number of factors other than $\ell$.

## Basic Examples

The canonical element of the circle, from its BD action:

```wl
MaurerCartanElement[CyclicWord[{x, x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => a MaurerCartanElement object with the one part {1, 0} -> CyclicWord[{x, x, y}], over the letters x and y, in the symmetric convention -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The Chern-Simons truncation of the circle, from its two parts:

```wl
m = MaurerCartanElement[<|{1, 0} -> CyclicWord[{x, x, y}], {2, 0} -> -(1/48) SymmetricProduct[{y}, {y}, pairing]|>, pairing]
```

<!-- => a MaurerCartanElement object with the parts {1, 0} and {2, 0}, over the letters x and y, in the symmetric convention -->

Its part $\mathfrak{m}_{2,0}$:

```wl
m[{2, 0}]
```

<!-- => -1/48 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

A part that is absent is $0$:

```wl
m[{1, 1}]
```

<!-- => 0 -->

## Scope

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The Chern-Simons truncation, from its BD action:

```wl
m = MaurerCartanElement[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, pairing], pairing]
```

<!-- => a MaurerCartanElement object with the parts {1, 0} and {2, 0}, over the letters x and y, in the symmetric convention -->

Its parts:

```wl
m["Parts"]
```

<!-- => <|{1, 0} -> CyclicWord[{x, x, y}], {2, 0} -> -1/48 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]]|> -->

Its BD action:

```wl
m["BDAction"]
```

<!-- => CyclicWord[{x, x, y}] - SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]]/48 -->

Its pairing:

```wl
m["Pairing"]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

---

A genus-one part is the coefficient of [HBar]():

```wl
MaurerCartanElement[CyclicWord[{x, x, y}] + g HBar CyclicWord[{x, x, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]["Parts"]
```

<!-- => <|{1, 0} -> CyclicWord[{x, x, y}], {1, 1} -> g CyclicWord[{x, x, y, y}]|> -->

---

A word may be given as the list of its letters:

```wl
MaurerCartanElement[<|{1, 0} -> {x, x, y}|>, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]["Parts"]
```

<!-- => <|{1, 0} -> CyclicWord[{x, x, y}]|> -->

---

The zero BD action gives the element with no parts:

```wl
MaurerCartanElement[0, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]["Parts"]
```

<!-- => <||> -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The same alphabet in the exterior convention:

```wl
exterior = Append[pairing, "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1, in the exterior convention -->

In the exterior convention the parts carry exterior products:

```wl
MaurerCartanElement[SymmetricToExterior[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, pairing], pairing], exterior][{2, 0}]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]]/48 -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The BD action of the general element at truncation $4$:

```wl
s = MaurerCartanAnsatz[c, pairing, 4]["BDAction"]
```

<!-- => the sum of c[{x, x, y}] CyclicWord[{x, x, y}], c[{x, x, y, y}] CyclicWord[{x, x, y, y}] and four unknowns times symmetric products of two words -->

The two forms are inverse to each other:

```wl
MaurerCartanElement[MaurerCartanElement[s, pairing]["Parts"], pairing]["BDAction"] === s
```

<!-- => True -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The Chern-Simons truncation solves the Maurer-Cartan equation:

```wl
RelationsQ[MaurerCartanElement[CyclicWord[{x, x, y}] - (1/48) SymmetricProduct[{y}, {y}, pairing], pairing]]
```

<!-- => True -->

An element need not solve it:

```wl
RelationsQ[MaurerCartanElement[CyclicWord[{x, x, y, y}], pairing]]
```

<!-- => False -->

---

A word keeps the rotation it is given:

```wl
MaurerCartanElement[CyclicWord[{x, y, x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]["Parts"]
```

<!-- => <|{1, 0} -> CyclicWord[{x, y, x}]|> -->

## Possible Issues

A part whose terms do not have its number of factors is not an element, and the expression returns unevaluated:

```wl
MaurerCartanElement[<|{2, 0} -> CyclicWord[{x, x, y}]|>, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->

---

A part that contains [HBar]() returns unevaluated:

```wl
MaurerCartanElement[<|{1, 0} -> HBar CyclicWord[{x, x, y}]|>, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->

---

A key with no factors returns unevaluated:

```wl
MaurerCartanElement[<|{0, 0} -> CyclicWord[{x, x, y}]|>, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

A product with the head of the other convention returns unevaluated:

```wl
MaurerCartanElement[ExteriorProduct[{y}, {x, y}, Append[pairing, "Convention" -> "Exterior"]], pairing]
```

<!-- => the input with the exterior product in its canonical order, unevaluated -->

---

Two rotations of one word give different elements:

```wl
MaurerCartanElement[CyclicWord[{x, y, x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]] === MaurerCartanElement[CyclicWord[{x, x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => False -->
