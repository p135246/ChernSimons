---
Template: Symbol
Name: MaurerCartanBasis
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/MaurerCartanBasis
Keywords: [basis, monomials, degree, truncation, Ansatz]
SeeAlso: [MaurerCartanAnsatz, MaurerCartanElement, Obstruction, ElementDegree]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[MaurerCartanBasis]()[*pairing*, *n*]</code> gives the products of cyclic words of total length at most *n* whose symmetric degree is that of [HBar]().

<code>[MaurerCartanBasis]()[*degree*, *pairing*, *n*]</code> gives the products of cyclic words of total length at most *n* of symmetric degree *degree*.

<!-- #| annotation: 26.09.30: Design review - the basis is the list of genus-zero monomials a BD action is built from, and it is the input of MaurerCartanAnsatz, which puts one unknown on each monomial. The degree defaults to ElementDegree[HBar, pairing, "Symmetric"], the degree of a BD action, since R5f, where PlanckDegree gave it before; the three-argument form takes any degree. A monomial of one factor is a bare cyclic word, as the paper writes m_{1,0}, and the list carries no signs and no duplicates, so that no two unknowns sit on the same monomial. With "EmptyWord" -> True a monomial has at most n factors: the empty word has length 0, so the length bound alone does not bound the number of factors, and when the algebra has degree 3 every power of the empty word has the degree of HBar (R2, kept). The products are enumerated as multisets of words rather than as all tuples, which took the length-5 basis of the circle from 8.5 s to 5 ms. Prior art: the Wolfram Language has no graded symmetric algebra of cyclic words; T12/paclet-maurer-cartan-basis pins the circle's basis to length 4 and T12/paclet-maurer-cartan-is-not-the-circle a three-letter alphabet. Since R7 (Pavel, 2026-10-01) the basis returns unevaluated on a pairing in the exterior convention, as MaurerCartanAnsatz does, by the first decision of PacletRewrite: the BD and Maurer-Cartan exports live in the symmetric picture; before, it gave symmetric products under an exterior key. Since R7 the two-argument form also tests n before it forwards, so a negative n returns the input as typed rather than the degree form. No alternative interface was recorded. -->

## Details & Options

- The degree of [HBar]() is <code>[ElementDegree]()[HBar, *pairing*, "Symmetric"]</code>, the degree of a BD action, so the first form gives the genus-zero monomials a BD action is built from.
- A monomial of one factor is a bare cyclic word. A monomial of two or more factors is a [SymmetricProduct]().
- Each monomial appears once, with its factors in their canonical order and without the sign that reordering produces.
- The truncation is by total word length: a product of words of lengths $2$ and $3$ has length $5$.
- With a pairing in the exterior convention, or a negative *n*, [MaurerCartanBasis]() returns unevaluated.
- [MaurerCartanBasis]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the empty word <code>[CyclicWord]()[{}]</code>, of length $0$, may be a factor |

- With `"EmptyWord" -> True` a monomial has at most *n* factors.
- Over the circle the option adds the monomials $\varepsilon\odot y^j$, whose coefficients are the modes $d_{0,j}$ of the empty-word extension.

## Basic Examples

The monomials of a BD action of the circle, up to total length $4$:

```wl
MaurerCartanBasis[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 4]
```

<!-- => {CyclicWord[{x, x, y}], CyclicWord[{x, x, y, y}], SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]], SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]], SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y, y}]], SymmetricProduct[CyclicWord[{y, y}], CyclicWord[{y, y}]]} -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The degree of [HBar]():

```wl
ElementDegree[HBar, pairing, "Symmetric"]
```

<!-- => -4 -->

Every monomial has that symmetric degree:

```wl
ElementDegree[#, pairing, "Symmetric"] & /@ MaurerCartanBasis[pairing, 4]
```

<!-- => {-4, -4, -4, -4, -4, -4} -->

## Scope

The monomials of the circle of symmetric degree $-3$, up to total length $3$:

```wl
MaurerCartanBasis[-3, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 3]
```

<!-- => {CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{x, y, y}]} -->

---

A three-letter alphabet:

```wl
three = GradedPairing[<|p -> -1, q -> 0, r -> -1|>, <|{p, q} -> 1, {r, q} -> 1|>]
```

<!-- => a GradedPairing object with particles p, q and r, of pairing degree -1 -->

Its basis up to total length $3$:

```wl
MaurerCartanBasis[three, 3]
```

<!-- => {CyclicWord[{p, r}], CyclicWord[{p, p, q}], CyclicWord[{p, q, r}], CyclicWord[{p, r, q}], CyclicWord[{q, r, r}], SymmetricProduct[CyclicWord[{q}], CyclicWord[{q}]], SymmetricProduct[CyclicWord[{q}], CyclicWord[{q, q}]]} -->

## Options

### EmptyWord

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The monomials the empty word adds up to total length $4$:

```wl
Complement[MaurerCartanBasis[pairing, 4, "EmptyWord" -> True], MaurerCartanBasis[pairing, 4]]
```

<!-- => {SymmetricProduct[CyclicWord[{}], CyclicWord[{}]], SymmetricProduct[CyclicWord[{}], CyclicWord[{y}]], SymmetricProduct[CyclicWord[{}], CyclicWord[{y, y}]], SymmetricProduct[CyclicWord[{}], CyclicWord[{y, y, y}]], SymmetricProduct[CyclicWord[{}], CyclicWord[{y, y, y, y}]]} -->

---

With the empty word a monomial has at most *n* factors, here $2$:

```wl
MaurerCartanBasis[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 2, "EmptyWord" -> True]
```

<!-- => {SymmetricProduct[CyclicWord[{}], CyclicWord[{}]], SymmetricProduct[CyclicWord[{}], CyclicWord[{y}]], SymmetricProduct[CyclicWord[{}], CyclicWord[{y, y}]], SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]]} -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The first form is the second in the degree of [HBar]():

```wl
MaurerCartanBasis[pairing, 4] === MaurerCartanBasis[ElementDegree[HBar, pairing, "Symmetric"], pairing, 4]
```

<!-- => True -->

[MaurerCartanAnsatz]() puts one unknown on each monomial:

```wl
MaurerCartanAnsatz[c, pairing, 4]["BDAction"] === Total[(b |-> c[Replace[b, {CyclicWord[w_] :> w, SymmetricProduct[f__] :> First /@ {f}}]] b) /@ MaurerCartanBasis[pairing, 4]]
```

<!-- => True -->

## Possible Issues

The BD algebra is the symmetric algebra, so a pairing in the exterior convention returns unevaluated, as in [MaurerCartanAnsatz]():

```wl
MaurerCartanBasis[Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"], 3]
```

<!-- => the input with the exterior pairing in place, unevaluated -->

---

A negative truncation returns unevaluated:

```wl
MaurerCartanBasis[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], -1]
```

<!-- => the input with the pairing in place, unevaluated -->
