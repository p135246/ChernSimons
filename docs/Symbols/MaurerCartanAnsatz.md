---
Template: Symbol
Name: MaurerCartanAnsatz
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/MaurerCartanAnsatz
Keywords: [Ansatz, unknowns, coefficients, Maurer-Cartan]
SeeAlso: [MaurerCartanElement, MaurerCartanBasis, Obstruction, RelationsQ, ElementDegree]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[MaurerCartanAnsatz]()[*coefficient*, *pairing*, *n*]</code> gives the general genus-zero [MaurerCartanElement]() over <code>[MaurerCartanBasis]()[*pairing*, *n*]</code>, with one unknown per monomial.

<code>[MaurerCartanAnsatz]()[*coefficient*, *degree*, *pairing*, *n*]</code> gives the general element over <code>[MaurerCartanBasis]()[*degree*, *pairing*, *n*]</code>.

<!-- #| annotation: 26.09.30: Design review - the Ansatz is the general genus-zero element over MaurerCartanBasis, so that Obstruction[m, "Equations"] turns it into the scalar equations on its unknowns: the round trip from an element to its equations and back. The unknowns are named by particle lists, coefficient[{x, x, y}] on a word and coefficient[{{y}, {y}}] on a product, because coefficient[CyclicWord[...]] would fail the scalar test FreeQ[scalar, CyclicWord | ...] of every linearity rule of the operations (R2; Pavel: the simpler the better, kept). Both forms give a MaurerCartanElement, one function having one kind of result, and a pairing in the exterior convention returns unevaluated, since the BD layer lives in the symmetric picture; before R5d the Ansatz gave symmetric products under an exterior key (R5d, kept by Pavel). Prior art: the Wolfram Language has no Maurer-Cartan equations; T12/paclet-maurer-cartan-ansatz-round-trip pins the circle's Ansatz to length 4, its unknowns and its one equation. No alternative interface was recorded. -->

## Details & Options

- The unknown on a cyclic word is *coefficient*[*w*], *w* the list of its particles.
- The unknown on a product is *coefficient*[{$w_1$, $w_2$, …}], the list of the particle lists of its factors, so an equation can be read without the Ansatz beside it.
- The monomials of one word make up the part $\mathfrak{m}_{1,0}$ of the element, and the products of $\ell$ words the part $\mathfrak{m}_{\ell,0}$.
- The default degree is that of [HBar](), <code>[ElementDegree]()[HBar, *pairing*, "Symmetric"]</code>, the degree of a BD action.
- <code>[Obstruction]()[*m*, "Equations"]</code> of the result gives the equations the unknowns must satisfy, one for each product of words in the obstruction.
- With a pairing in the exterior convention [MaurerCartanAnsatz]() returns unevaluated.
- [MaurerCartanAnsatz]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the empty word may be a factor of the monomials, as in [MaurerCartanBasis]() |

## Basic Examples

The general element of the circle at truncation $4$:

```wl
m = MaurerCartanAnsatz[c, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 4]
```

<!-- => a MaurerCartanElement object with the parts {1, 0} and {2, 0}, over the particles x and y, in the symmetric convention -->

Its parts, with one unknown per monomial:

```wl
m["Parts"]
```

<!-- => <|{1, 0} -> c[{x, x, y}] CyclicWord[{x, x, y}] + c[{x, x, y, y}] CyclicWord[{x, x, y, y}], {2, 0} -> c[{{y}, {y}}] SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] + c[{{y}, {y, y}}] SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]] + c[{{y}, {y, y, y}}] SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y, y}]] + c[{{y, y}, {y, y}}] SymmetricProduct[CyclicWord[{y, y}], CyclicWord[{y, y}]]|> -->

Its equations, keyed by the words they are the coefficients of:

```wl
Obstruction[m, "Equations"]
```

<!-- => <|CyclicWord[{x, x, y, x, y, y}] -> c[{x, x, y, y}]^2, CyclicWord[{x, x, y, y, x, y}] -> -c[{x, x, y, y}]^2|> -->

Their solution: at this truncation the only obstruction is that one coefficient vanishes:

```wl
Solve[Thread[Values[Obstruction[m, "Equations"]] == 0], c[{x, x, y, y}]]
```

<!-- => {{c[{x, x, y, y}] -> 0}, {c[{x, x, y, y}] -> 0}} -->

## Scope

The general element of symmetric degree $-3$ up to total length $3$:

```wl
MaurerCartanAnsatz[c, -3, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 3]["Parts"]
```

<!-- => <|{1, 0} -> c[{x}] CyclicWord[{x}] + c[{x, y}] CyclicWord[{x, y}] + c[{x, y, y}] CyclicWord[{x, y, y}]|> -->

---

At truncation $5$ the first equation relates three coefficients of the one-word part, those of $x^2y^2$, $x^2y$ and $xyxy^2$:

```wl
First[Obstruction[MaurerCartanAnsatz[c, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 5], "Equations"]]
```

<!-- => c[{x, x, y, y}]^2 - c[{x, x, y}] c[{x, y, x, y, y}] -->

## Options

### EmptyWord

With `"EmptyWord" -> True` the empty word is a factor of the products:

```wl
MaurerCartanAnsatz[c, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 2, "EmptyWord" -> True]["Parts"]
```

<!-- => <|{2, 0} -> c[{{}, {}}] SymmetricProduct[CyclicWord[{}], CyclicWord[{}]] + c[{{}, {y}}] SymmetricProduct[CyclicWord[{}], CyclicWord[{y}]] + c[{{}, {y, y}}] SymmetricProduct[CyclicWord[{}], CyclicWord[{y, y}]] + c[{{y}, {y}}] SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]]|> -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

Where the unknowns solve the equations, the element solves the Maurer-Cartan equation:

```wl
RelationsQ[MaurerCartanElement[MaurerCartanAnsatz[c, pairing, 4]["BDAction"] /. c[{x, x, y, y}] -> 0, pairing]]
```

<!-- => True -->

The BD action of the Ansatz is a BD action, of the degree of [HBar]():

```wl
ElementDegree[MaurerCartanAnsatz[c, pairing, 4]["BDAction"], pairing, "Symmetric"]
```

<!-- => -4 -->

## Possible Issues

The BD algebra is the symmetric algebra, so a pairing in the exterior convention returns unevaluated:

```wl
MaurerCartanAnsatz[c, Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"], 3]
```

<!-- => the input with the exterior pairing in place, unevaluated -->
