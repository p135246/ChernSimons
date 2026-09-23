---
Template: Symbol
Name: MaurerCartanEquation
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/MaurerCartanEquation
Keywords: [Maurer-Cartan equation, obstruction, BD master equation]
SeeAlso: [MaurerCartanQ, MaurerCartanBasis, MaurerCartanAnsatz, BeilinsonDrinfeldMasterEquation, PlanckDegree]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[MaurerCartanEquation]()[*s*, *pairing*]</code> gives the obstruction of the Maurer-Cartan equation for the element whose BD action is *s*; $0$ means it is a Maurer-Cartan element.

<code>[MaurerCartanEquation]()[*s*, *pairing*, "Equations"]</code> gives the Association of scalar equations on the coefficients of *s*.

## Details & Options

The same function as [BeilinsonDrinfeldMasterEquation](): the coefficient of the BD master equation in $\mathrm{S}_\ell(C[1])\HBar^g$ is exactly the $(\ell, g)$ Maurer-Cartan equation, so the two names name one computation seen from two sides.

The recipe that produces a Maurer-Cartan element from a geometry — ribbon graphs, their combinatorial coefficients, the configuration-space integrals and the signs — is **not** implemented. An element is supplied, either written out or as a [MaurerCartanAnsatz]() over [MaurerCartanBasis]().

## Basic Examples

The canonical element of the circle, and a word that is not a solution:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{MaurerCartanEquation[CyclicWord[{x, x, y}], pairing], MaurerCartanEquation[CyclicWord[{x, x, y, y}], pairing]}
```

## Scope

The `"Equations"` form turns an Ansatz into the equations on its unknowns, which is what makes the round trip useful:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
MaurerCartanEquation[MaurerCartanAnsatz[c, pairing, 4], pairing, "Equations"]
```

---

Those equations are what <code>[Solve]()</code> wants:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
With[{equations = Values[MaurerCartanEquation[MaurerCartanAnsatz[c, pairing, 4], pairing, "Equations"]]},
 Solve[Thread[equations == 0], Variables[equations]]]
```

## Properties and Relations

Nothing here is the circle's — a three-letter alphabet works the same way:

```wl
three = GradedPairing[<|p -> -1, q -> 0, r -> -1|>, <|{p, q} -> 1, {r, q} -> 1|>];
{MaurerCartanEquation[CyclicWord[{p, p, q}], three], MaurerCartanEquation[CyclicWord[{p, q, q}], three]}
```
