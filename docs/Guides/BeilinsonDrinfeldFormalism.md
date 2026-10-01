---
Template: Guide
Name: BeilinsonDrinfeldFormalism
Title: Beilinson-Drinfeld Formalism
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/BeilinsonDrinfeldFormalism
Description: The Beilinson-Drinfeld operator and bracket on symmetric powers of cyclic words, Maurer-Cartan elements and the master equation, the canonical element of a Poincaré duality algebra, and twisted operations and homotopies
Keywords: [Beilinson-Drinfeld algebra, BD operator, BD bracket, BD action, master equation, Maurer-Cartan element, IBL infinity, canonical Maurer-Cartan element, twisted differential, twisted co-bracket, BD homotopy, gauge equivalence]
RelatedGuides: [ChernSimons]
RelatedTutorials: [TheCanonicalIBLAlgebraOfTheCircle, FromASullivanModelToAnIBLAlgebra]
---

## Abstract

The Beilinson-Drinfeld formalism encodes the differential involutive bi-Lie algebra of cyclic words in one operator on their symmetric powers, with coefficients in power series in a formal variable $\hbar$: the Beilinson-Drinfeld operator and the bracket it defines; Maurer-Cartan elements, the solutions of the master equation; the canonical Maurer-Cartan element of a Poincaré duality algebra; and the operations twisted by a Maurer-Cartan element, with the homotopies between elements.

## Functions

### Beilinson-Drinfeld operator and bracket

- `StringBeilinsonDrinfeldOperator` the operator $\Delta = \widehat{q}_{1,1,0} + \widehat{q}_{1,2,0} + \hbar\,\widehat{q}_{2,1,0}$ on the symmetric powers of cyclic words
- `StringBeilinsonDrinfeldBracket` the bracket of the Beilinson-Drinfeld axiom, the bracket of cyclic words extended to products
- `HBar` the formal variable $\hbar$
- `SymmetricProduct` the product of the symmetric powers that the operator acts on

### Maurer-Cartan elements and the master equation

- `MaurerCartanElement` an element given by its parts $\mathfrak{m}_{\ell,g}$, products of $\ell$ cyclic words at genus $g$, or by its action $s = \sum_{\ell, g} \hbar^g\,\mathfrak{m}_{\ell,g}$
- `Obstruction` the left side $\Delta s + \tfrac12\{s, s\}$ of the master equation, and its scalar equations on the coefficients
- `RelationsQ` tests whether an element solves the master equation
- `MaurerCartanBasis` the genus-zero monomials of an action, the products of cyclic words of the degree of $\hbar$
- `MaurerCartanAnsatz` the general genus-zero element over those monomials, with unknown coefficients
- `Solve` (WL) solves the scalar equations of the master equation for the unknown coefficients

### Canonical element of a Poincaré duality algebra

- `CanonicalMaurerCartan` the canonical Maurer-Cartan element, whose one part $\mathfrak{m}_{1,0}$ is made from the triple product
- `GradedPairing` the alphabet of a Poincaré duality algebra, its basis with the pairing and the differential
- `PoincareDualityAlgebra` a finite-dimensional Poincaré duality algebra, with its differential and triple product

### Twisted operations and homotopies

- `TwistedDifferential` the differential $q^{\mathfrak{m}}_{1,1,0}$ twisted by a Maurer-Cartan element
- `TwistedCobracket` the co-bracket $q^{\mathfrak{m}}_{1,2,0}$ twisted by a Maurer-Cartan element
- `StringBeilinsonDrinfeldHomotopy` the Beilinson-Drinfeld homotopy flow of an action, which connects gauge equivalent Maurer-Cartan elements
