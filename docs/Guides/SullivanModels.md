---
Template: Guide
Name: SullivanModels
Title: Sullivan Models
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/SullivanModels
Description: Sullivan models from a catalogue or from generators, their bases, products and differentials, and orientations and Poincaré duality on cohomology and on chain level
Keywords: [Sullivan model, minimal model, rational homotopy theory, commutative differential graded algebra, catalogue, monomial basis, tensor product, orientation, Poincare duality, perfect pairing]
RelatedGuides: [AlgebraicModels]
---

## Abstract

Sullivan models are free graded commutative algebras with a differential, the algebraic models of rational homotopy theory: the models of a catalogue and those given by generators, with their monomial bases, products and differentials; and orientations, the pairings they define, and Poincaré duality on cohomology and on chain level.

## Functions

### Models and the catalogue

- `SullivanModel` a Sullivan model with an orientation, from the catalogue, from its generators or as a tensor product
- `$SullivanModels` the names of the models in the catalogue
- `SullivanModelBasis` the monomials of one degree
- `SullivanModelProduct` the graded commutative product of elements
- `SullivanModelDifferential` the differential of an element
- `SullivanModelQ` tests whether an expression is a Sullivan model

### Orientations and Poincaré duality

- `SullivanModelOrientation` the orientation, a linear form on the elements of degree $n$
- `SullivanModelPairing` the pairing $\langle x, y\rangle = \mathcal{O}(xy)$ that the orientation defines
- `OrientationQ` tests whether values on the elements of one degree define an orientation
- `PoincareDualityQ` tests whether the pairing is perfect on cohomology
- `PerfectPairingQ` tests whether the pairing is perfect on chain level
