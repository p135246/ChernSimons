---
Template: Symbol
Name: MaurerCartanBasis
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/MaurerCartanBasis
Keywords: [basis, monomials, degree, truncation, Ansatz]
SeeAlso: [MaurerCartanQ, MaurerCartanBasis, MaurerCartanAnsatz, BeilinsonDrinfeldMasterEquation, PlanckDegree]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[MaurerCartanBasis]()[*pairing*, *n*]</code> lists the normalized products of cyclic words of total length at most *n* whose symmetric degree is [PlanckDegree]()[*pairing*].

<code>[MaurerCartanBasis]()[*degree*, *pairing*, *n*]</code> uses the given degree instead.

## Details & Options

These are the monomials a genus-zero BD action of that degree is built from. One-factor monomials are returned as bare cyclic words, matching how the paper writes $\mathfrak{m}_{1,0}$; monomials of two or more factors are symmetric products.

The list is sign-normalized and duplicate-free: each monomial appears once, in the canonical order the products sort into, without the scalar sign that reordering would produce.

The truncation is by **total** word length, so a two-factor monomial of lengths $2$ and $3$ counts as $5$.

## Basic Examples

The degree $-4$ monomials of the circle, up to total length $4$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
MaurerCartanBasis[pairing, 4]
```

---

Every one of them has the same symmetric degree, which is why they can be summed:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{PlanckDegree[pairing], DeleteDuplicates[Map[b |-> WordDegree[First[b], pairing, "Symmetric"], Select[MaurerCartanBasis[pairing, 4], Head[#] === CyclicWord &]]]}
```

## Scope

A different alphabet gives a different basis:

```wl
three = GradedPairing[<|p -> -1, q -> 0, r -> -1|>, <|{p, q} -> 1, {r, q} -> 1|>];
MaurerCartanBasis[three, 3]
```
