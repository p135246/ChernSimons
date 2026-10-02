---
Template: Guide
Name: AlgebraicModels
Title: Algebraic Models
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/AlgebraicModels
Description: Sullivan models with an orientation, and the Hodge decompositions and the nondegenerate quotient that make them Poincaré duality algebras on chain level
Keywords: [algebraic model, rational homotopy theory, Sullivan model, orientation, Poincare duality, Hodge decomposition, Hodge type, nondegenerate quotient, Poincare duality algebra]
RelatedGuides: [ChernSimons, SullivanModels, HodgeDecompositions]
RelatedTutorials: [FromASullivanModelToAnIBLAlgebra]
---

## Abstract

The Sullivan model of a closed oriented manifold, with the orientation of the manifold, satisfies Poincaré duality on cohomology.
Its nondegenerate quotient is a Poincaré duality algebra on chain level, with the same cohomology when the model is of Hodge type, and the canonical Lie bialgebras are built on the cyclic words of its basis.
Algebraic models span Sullivan models with their orientations, and the Hodge decompositions that decide Hodge type, with the nondegenerate quotient.
Each area has its own guide.

## Functions

### [Sullivan Models](paclet:ChernSimons/guide/SullivanModels)

- `SullivanModel` the Sullivan model of a space, with its orientation
- `SullivanModelOrientation` the orientation, which defines the pairing
- `PoincareDualityQ` tests Poincaré duality on cohomology

### [Hodge Decompositions](paclet:ChernSimons/guide/HodgeDecompositions)

- `CochainComplexWithPairing` the finite cochain complex with a pairing that agrees with a model up to degree $n+1$
- `HodgeTypeQ` tests whether a model is of Hodge type
- `FindHodgeDecomposition` a Hodge decomposition of a model
- `NondegenerateQuotient` the Poincaré duality algebra of a model, on which the canonical Lie bialgebras are built
