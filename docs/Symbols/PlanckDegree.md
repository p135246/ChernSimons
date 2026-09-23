---
Template: Symbol
Name: PlanckDegree
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/PlanckDegree
Keywords: [HBar, degree, Poincare duality, grading]
SeeAlso: [BeilinsonDrinfeldBracket, BeilinsonDrinfeldMasterEquation, BeilinsonDrinfeldMasterQ, MaurerCartanEquation, PlanckDegree, HBar]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[PlanckDegree]()[*pairing*]</code> gives the symmetric degree $2(n-3)$ of the formal variable [HBar](), where $n$ is the Poincare duality degree of *pairing*.

## Details & Options

It is also the symmetric degree of a BD action, so it is the degree [MaurerCartanBasis]() and [MaurerCartanAnsatz]() use when none is given.

The Poincare duality degree is recovered from the pairing as $n = |\langle-,-\rangle| + 2$, so the value is $2(|\langle-,-\rangle| - 1)$.

## Basic Examples

For the circle, where $n = 1$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
PlanckDegree[pairing]
```

---

It is the degree of the canonical element, and the default degree of the basis:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{WordDegree[{x, x, y}, pairing, "Symmetric"], MaurerCartanBasis[pairing, 4] === MaurerCartanBasis[PlanckDegree[pairing], pairing, 4]}
```
