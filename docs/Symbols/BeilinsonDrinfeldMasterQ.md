---
Template: Symbol
Name: BeilinsonDrinfeldMasterQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/BeilinsonDrinfeldMasterQ
Keywords: [BD master equation, test, predicate]
SeeAlso: [BeilinsonDrinfeldBracket, BeilinsonDrinfeldMasterEquation, BeilinsonDrinfeldMasterQ, MaurerCartanEquation, PlanckDegree, HBar]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[BeilinsonDrinfeldMasterQ]()[*s*, *pairing*]</code> tests whether the BD action *s* solves the BD master equation.

## Details & Options

Equivalent to testing whether [BeilinsonDrinfeldMasterEquation]()[*s*, *pairing*] is $0$. Since the obstruction is expanded before the test, an action with symbolic coefficients returns `False` unless the obstruction vanishes identically.

## Basic Examples

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{BeilinsonDrinfeldMasterQ[CyclicWord[{x, x, y}], pairing], BeilinsonDrinfeldMasterQ[CyclicWord[{x, x, y, y}], pairing]}
```

---

Every multiple of the canonical element solves it:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldMasterQ[lambda CyclicWord[{x, x, y}], pairing]
```
