---
Template: Symbol
Name: BeilinsonDrinfeldOperator
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/BeilinsonDrinfeldOperator
Keywords: [BD algebra, Beilinson-Drinfeld, BV operator, Delta, cobracket, bracket]
SeeAlso: [BeilinsonDrinfeldBracket, BeilinsonDrinfeldMasterEquation, BeilinsonDrinfeldMasterQ, MaurerCartanEquation, PlanckDegree, HBar]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[BeilinsonDrinfeldOperator]()[*e*, *pairing*]</code> gives the operator $\Delta = \widehat{q}_{1,1,0} + \widehat{q}_{1,2,0} + \HBar\,\widehat{q}_{2,1,0}$ of the Beilinson-Drinfeld algebra, applied to *e*.

## Details & Options

$\Delta$ acts on the symmetric powers of cyclic words completed over $\mathbb{R}[[\HBar]]$. It is a derivative of order at most $2$ and of symmetric degree $-1$, and it squares to zero exactly when the underlying structure is involutive bi-Lie.

The first summand is [CyclicDifferential]() extended as a derivation — identically zero unless the pairing carries a Poincare duality algebra with a differential, so on a formal alphabet it drops out. The second is the co-bracket extended as a co-derivation, the third the bracket extended as a derivation and weighted by [HBar](). Only the second carries $\HBar$, which is why the algebra is a BD algebra and not the BD algebra of a BV algebra: $\Delta$ is not divisible by $\HBar$.

It obeys the BD axiom
$$\Delta(f f') = \Delta(f) f' + (-1)^{|f|_\odot} f \Delta(f') + (-1)^{|f|_\odot}\HBar\,\{f, f'\},$$
whose bracket is [BeilinsonDrinfeldBracket]() and carries no $\HBar$ of its own.

*pairing* fixes the alphabet; nothing here is tied to any particular one.

## Basic Examples

The operator on a product of two cyclic words of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], pairing]
```

---

It squares to zero:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldOperator[BeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], pairing], pairing]
```

## Properties and Relations

The classical limit, at $\HBar = 0$, is the co-bracket alone:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
BeilinsonDrinfeldOperator[CyclicWord[{x, y, y, y}], pairing] /. HBar -> 0
```

---

The term the classical limit drops is the bracket, and it is the only place $\HBar$ enters:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Coefficient[BeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], pairing], HBar]
```
