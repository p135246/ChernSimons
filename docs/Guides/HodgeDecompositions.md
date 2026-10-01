---
Template: Guide
Name: HodgeDecompositions
Title: Hodge Decompositions
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/HodgeDecompositions
Description: Finite cochain complexes with a pairing and their axioms, Hodge type, the degenerate subspace and the nondegenerate quotient, harmonic subspaces, pre-Hodge and Hodge decompositions, and the special propagators and extensions of Hodge type
Keywords: [Hodge decomposition, pre-Hodge decomposition, harmonic subspace, coexact subspace, Hodge type, degenerate subspace, nondegenerate quotient, cochain complex with pairing, Poincare duality algebra]
RelatedGuides: [AlgebraicModels]
RelatedTutorials: [HodgeTypeAndTheNondegenerateQuotient]
---

## Abstract

A Hodge decomposition of a cochain complex with a pairing splits it into a harmonic subspace, the exact elements and a coexact part perpendicular to itself and to the harmonic subspace, and a complex that admits one is of Hodge type.
Their study covers finite cochain complexes with a pairing and their axioms; Hodge type, the degenerate subspace and the nondegenerate quotient; harmonic subspaces, pre-Hodge and Hodge decompositions; and the special propagators and extensions of Hodge type.

## Functions

### Cochain complexes with a pairing

- `CochainComplexWithPairing` a finite cochain complex with a graded symmetric pairing, from its data, from a product and an orientation, or from a model
- `Relations` the axioms of a complex, on its differential, its pairing and its product
- `Obstruction` the obstruction of an axiom on given elements, the difference of its two sides
- `RelationsQ` tests every axiom of a complex or of a decomposition

### Hodge type and the nondegenerate quotient

- `DegenerateSubspace` the elements that pair to zero with everything
- `NullSpace` (WL) a basis of the null space of a matrix
- `HodgeTypeQ` tests whether a model or a complex is of Hodge type
- `HodgeTypeReport` the dimensions of the space, its cohomology, the degenerate subspace and the quotient in each degree
- `NondegenerateQuotient` the quotient by the degenerate subspace, a Poincaré duality algebra on chain level
- `PoincareDualityAlgebra` a finite-dimensional Poincaré duality algebra, with its differential and triple product
- `PoincareDualityAlgebraQ` tests whether an expression is a Poincaré duality algebra

### Hodge decompositions

- `FindHarmonicSubspace` a harmonic subspace, a complement of the exact elements in the cocycles
- `FindPreHodgeDecomposition` a pre-Hodge decomposition, with the coexact part perpendicular to the harmonic subspace
- `FindHodgeDecomposition` a Hodge decomposition, with the coexact part perpendicular to itself as well
- `PreHodgeDecomposition` a pre-Hodge decomposition as an object, with its parts in every degree
- `HodgeDecomposition` a Hodge decomposition as an object, with its parts in every degree

### Special propagators and extensions

- `SpecialPropagator` the special propagator of a Hodge decomposition, minus the inverse of the differential on the exact elements and zero on the harmonic subspace and the coexact part
- `HarmonicProjection` the projection onto the harmonic subspace along the exact elements and the coexact part, the identity plus dP + Pd
- `FindHodgeDecomposition` the Hodge decomposition of a special propagator, the image of the harmonic projection and the image of the propagator
- `HodgeExtension` the extension by acyclic pairs, one for each coexact basis element, that makes a space of Hodge type and retracts onto it
- `RelationsQ` the four relations of a special propagator, with those of its decomposition
