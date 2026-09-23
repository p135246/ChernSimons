---
Template: Symbol
Name: KoszulSign
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/KoszulSign
Keywords: [Koszul sign, permutation, graded, parity, transposition]
SeeAlso: [WordDegree, ExteriorProduct, SymmetricProduct, ShiftIsomorphism]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[KoszulSign]()[*perm*, *degrees*, *parity*]</code> gives the sign of the permutation *perm* of a list of objects of the given *degrees*, counting *parity* for each transposition in addition to the product of the degrees.

## Details & Options

*perm* is a permutation given as a list of positions, *degrees* the list of degrees of the objects being permuted, and *parity* an integer, in practice $0$ or $1$.

Each transposition of neighbouring objects of degrees $d_1$ and $d_2$ contributes $(-1)^{d_1 d_2 + \textit{parity}}$. With *parity* $0$ this is the plain Koszul sign; with *parity* $1$ it is the Koszul sign of the shifted grading, which is what the exterior picture uses.

*degrees* may be longer than *perm*; only the entries that *perm* addresses take part.

This is the primitive underneath the sorting done by [ExteriorProduct]() and [SymmetricProduct]() and underneath the shuffle sums of the derivation extensions. It is exported so that a sign convention can be checked directly rather than inferred from a result.

## Basic Examples

The identity permutation is always $+1$:

```wl
KoszulSign[{1, 2}, {-1, 0}, 0]
```

<!-- => 1 -->

---

A transposition of an odd and an even object costs nothing by degree, so the plain sign is $+1$:

```wl
KoszulSign[{2, 1}, {-1, 0}, 0]
```

<!-- => 1 -->

---

The same transposition with *parity* $1$ picks up the shift:

```wl
KoszulSign[{2, 1}, {-1, 0}, 1]
```

<!-- => -1 -->

## Scope

Two odd objects anticommute in the plain grading and commute in the shifted one:

```wl
{KoszulSign[{2, 1}, {1, 1}, 0], KoszulSign[{2, 1}, {1, 1}, 1]}
```

<!-- => {-1, 1} -->

---

Longer permutations are decomposed into transpositions:

```wl
KoszulSign[{2, 3, 1}, {-1, 0, -1}, 0]
```

<!-- => -1 -->

---

The whole sign table of the transpositions of a three-element list:

```wl
Map[# -> KoszulSign[#, {-1, 0, -1}, 0] &, Permutations[Range[3]]]
```

<!-- => {{1, 2, 3} -> 1, …} -->

## Properties and Relations

The sign the products apply when sorting is this one, at the grading and parity of the picture: [ExteriorProduct]() sorts at the exterior degree with *parity* $1$, [SymmetricProduct]() at the symmetric degree with *parity* $0$.

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], pairing], KoszulSign[{2, 1}, {WordDegree[{y}, pairing, "Exterior"], WordDegree[{x}, pairing, "Exterior"]}, 1]}
```

<!-- => {-ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]], -1} -->

---

The symmetric picture sorts the same factors at parity $0$, and gets the other sign:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], pairing], KoszulSign[{2, 1}, {WordDegree[{y}, pairing, "Symmetric"], WordDegree[{x}, pairing, "Symmetric"]}, 0]}
```

<!-- => {SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]], 1} -->

---

A permutation and its inverse have the same sign:

```wl
{KoszulSign[{2, 3, 1}, {1, 1, 1}, 0], KoszulSign[{3, 1, 2}, {1, 1, 1}, 0]}
```

<!-- => {1, 1} -->
