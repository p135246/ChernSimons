---
Template: Symbol
Name: BeilinsonDrinfeldMasterEquation
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/BeilinsonDrinfeldMasterEquation
Keywords: [BD master equation, quantum master equation, Maurer-Cartan, BD action]
SeeAlso: [BeilinsonDrinfeldBracket, BeilinsonDrinfeldMasterEquation, BeilinsonDrinfeldMasterQ, MaurerCartanEquation, PlanckDegree, HBar]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[BeilinsonDrinfeldMasterEquation]()[*s*, *pairing*]</code> gives the obstruction $\Delta s + \tfrac12\{s, s\}$ of the BD master equation for the BD action *s*; $0$ means *s* solves it.

<code>[BeilinsonDrinfeldMasterEquation]()[*s*, *pairing*, "Equations"]</code> gives instead the Association of scalar equations, one per monomial of the obstruction.

## Details & Options

The equation is taken over $\mathbb{R}[[\HBar]]$, without inverting $\HBar$. The bracket is [BeilinsonDrinfeldBracket](), not the derived one, so no negative power of $\HBar$ appears anywhere.

A BD action is $S_{\mathfrak{m}} = \sum_{g\ge0}\sum_{\ell\ge1}\mathfrak{m}_{\ell,g}\HBar^g$, of symmetric degree [PlanckDegree]()[*pairing*]. The coefficient of the master equation in $\mathrm{S}_\ell\HBar^g$ is exactly the $(\ell, g)$ Maurer-Cartan equation, which is why [MaurerCartanEquation]() is the same function under another name.

In the `"Equations"` form the keys are the monomials — a power of $\HBar$ times a product of cyclic words — and the values the scalar coefficients, each of which must vanish. That is the form to hand to <code>[Solve]()</code>.

## Basic Examples

The canonical element of the circle solves it:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldMasterEquation[CyclicWord[{x, x, y}], pairing]
```

---

Another word does not, and the obstruction is free of $\HBar$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldMasterEquation[CyclicWord[{x, x, y, y}], pairing]
```

## Scope

The `"Equations"` form of the same obstruction:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldMasterEquation[CyclicWord[{x, x, y, y}], pairing, "Equations"]
```
