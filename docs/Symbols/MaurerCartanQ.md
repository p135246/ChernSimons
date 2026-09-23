---
Template: Symbol
Name: MaurerCartanQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/MaurerCartanQ
Keywords: [Maurer-Cartan, test, predicate]
SeeAlso: [MaurerCartanQ, MaurerCartanBasis, MaurerCartanAnsatz, BeilinsonDrinfeldMasterEquation, PlanckDegree]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[MaurerCartanQ]()[*s*, *pairing*]</code> tests whether *s* is a Maurer-Cartan element.

## Details & Options

Equivalent to [BeilinsonDrinfeldMasterQ](), and to testing that [MaurerCartanEquation]() returns $0$.

## Basic Examples

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{MaurerCartanQ[CyclicWord[{x, x, y}], pairing], MaurerCartanQ[CyclicWord[{x, x, y, y}], pairing]}
```

---

Every multiple of the canonical element is one, so the scalar is free:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
MaurerCartanQ[lambda CyclicWord[{x, x, y}], pairing]
```
