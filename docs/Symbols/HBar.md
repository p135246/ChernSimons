---
Template: Symbol
Name: HBar
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HBar
Keywords: [HBar, Planck constant, formal variable, BD algebra, genus]
SeeAlso: [BeilinsonDrinfeldBracket, BeilinsonDrinfeldMasterEquation, BeilinsonDrinfeldMasterQ, MaurerCartanEquation, PlanckDegree, HBar]
RelatedGuides: [ChernSimons]
---

## Usage

[HBar]() is the formal variable $\HBar$ of the Beilinson-Drinfeld algebra.

## Details & Options

An ordinary symbol carrying no value, of symmetric degree [PlanckDegree]()[*pairing*].

It appears in [BeilinsonDrinfeldOperator]() as the weight of the bracket term, and in a BD action as the weight $\HBar^g$ of the genus-$g$ component. The BD formalism never inverts it; negative powers appear only in the localized BV picture, where the BV action is $\HBar^{-1}$ times the BD one.

It is the one exported symbol of the paclet with no value of its own.

It displays as $\HBar$.

## Basic Examples

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], pairing]
```

---

Setting it to zero gives the classical limit:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], pairing] /. HBar -> 0
```
