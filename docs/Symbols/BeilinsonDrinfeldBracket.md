---
Template: Symbol
Name: BeilinsonDrinfeldBracket
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/BeilinsonDrinfeldBracket
Keywords: [BD bracket, Beilinson-Drinfeld, Poisson bracket, derived bracket]
SeeAlso: [BeilinsonDrinfeldBracket, BeilinsonDrinfeldMasterEquation, BeilinsonDrinfeldMasterQ, MaurerCartanEquation, PlanckDegree, HBar]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[BeilinsonDrinfeldBracket]()[*f*, *g*, *pairing*]</code> gives the BD bracket $\{f, g\}$.

## Details & Options

The bracket of the BD axiom satisfied by [BeilinsonDrinfeldOperator](). It is already present on the symmetric powers of cyclic words before $\HBar$ is adjoined, and carries no $\HBar$ itself: it is $q_{2,1,0}$ inserted into *f*, with the sign of the symmetric degree of *f*.

The derived bracket of $\Delta$ — the failure of $\Delta$ to be a derivation — is $\HBar$ times this one. That derived bracket is the BV bracket of the localization at $\HBar$, and is what the engine calls `bvBracket`. Confusing the two is a factor of $\HBar$ in every formula, so the distinction is worth keeping.

## Basic Examples

The bracket of two cyclic words of the circle, free of $\HBar$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldBracket[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing]
```

---

The derived bracket of [BeilinsonDrinfeldOperator]() is $\HBar$ times it:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
With[{u = CyclicWord[{x, y, y, y}], v = CyclicWord[{x, y}]},
 With[{s = (-1)^WordDegree[u, pairing, "Symmetric"]},
  Expand[BeilinsonDrinfeldOperator[SymmetricProduct[u, v, pairing], pairing] - SymmetricProduct[BeilinsonDrinfeldOperator[u, pairing], v, pairing] - s SymmetricProduct[u, BeilinsonDrinfeldOperator[v, pairing], pairing] - s HBar BeilinsonDrinfeldBracket[u, v, pairing]]]]
```

## Possible Issues

The bracket is free of `HBar`, and that is a property worth testing rather than assuming:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
FreeQ[BeilinsonDrinfeldBracket[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], HBar]
```
