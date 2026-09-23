---
Template: Guide
Name: ChernSimons
Title: Chern-Simons IBL Algebras
Paclet: ChernSimons
URI: ChernSimons/guide/ChernSimons
Keywords: [IBL infinity, involutive bi-Lie, cyclic words, Maurer-Cartan, Poincare duality, Sullivan model, Hodge decomposition, Chern-Simons]
RelatedTutorials: [FromASullivanModelToAnIBLAlgebra, HodgeTypeAndTheNondegenerateQuotient, TheCanonicalIBLAlgebraOfTheCircle]
Links: ["arXiv:2004.07362 Hodge decompositions and Poincare duality models" -> "https://arxiv.org/abs/2004.07362"]
---

## Abstract

An involutive bi-Lie infinity structure on the cyclic words of a graded alphabet with a pairing, in both the graded exterior and the graded symmetric convention. The alphabet is data, not global state: a pairing object carries the degrees of the particles and the values of the pairing, and every operation takes it as its last argument. The pairing that matters geometrically comes from Poincare duality, so the paclet also builds it — from a Sullivan minimal model with a volume form, through the test for Hodge type and the nondegenerate quotient, to the finite-dimensional Poincare duality algebra and the canonical Maurer-Cartan element its triple product carries. When the model is not formal that algebra carries a differential too, and the alphabet carries it into the operation q(1,1,0), the first summand of the Beilinson-Drinfeld operator and of the twisted differential.

## Functions

### From a space to an alphabet

- `SullivanModel` a Sullivan minimal model with a volume form, from a catalogue or from generators, degrees and a differential
- `$SullivanModels` the catalogue names
- `SullivanModelBasis` the monomials of one degree
- `SullivanModelProduct`, `SullivanModelDifferential` the graded commutative product and the differential of the model
- `SullivanModelOrientation`, `SullivanModelPairing` the coefficient of the volume monomial, and the chain-level pairing it defines
- `DegenerateSubspace` the elements paired to zero with everything
- `HodgeTypeQ`, `HodgeTypeReport` whether the degenerate subspace is acyclic — equivalently, whether the quotient map is a quasi-isomorphism
- `NondegenerateQuotient` the finite-dimensional Poincare duality algebra the model retracts onto
- `PoincareDualityAlgebra` that algebra as an object, and what the rational homotopy layer hands to the dIBL layer
- `SullivanModelQ`, `PoincareDualityAlgebraQ` recognizers for the two
- `CanonicalMaurerCartan` the Maurer-Cartan element carrying the triple product of that algebra

### The graded alphabet

- `GradedPairing` the pairing object every operation takes as its last argument, built from degrees and values or from a Poincare duality algebra
- `GradedPairingQ` its recognizer
- `CyclicWord`, `CyclicWords` a cyclic word in its canonical rotation, and the enumeration of them
- `WordDegree` the degree of a cyclic word, in either grading
- `KoszulSign` the sign of a permutation of graded objects

### The two products

- `ExteriorProduct`, `SymmetricProduct` the graded exterior and graded symmetric products of cyclic words
- `ShiftIsomorphism` the map between the two pictures that intertwines the operations

### The operations

- `CyclicDifferential` the differential q(1,1,0), zero unless the model is non-formal, and its extension as a derivation
- `ChordContraction` one term of the bracket or of the co-bracket: two particles contracted along a chord, joining two words or cutting one
- `InvolutiveBracket` the bracket q(2,1,0), and its extension as a derivation
- `InvolutiveCobracket` the co-bracket q(1,2,0), and its extension as a co-derivation
- `DualPairing`, `ProductPairing` the evaluation of words on dual words, and its extension to products

### The defining identities

- `JacobiObstruction`, `CoJacobiObstruction`, `DrinfeldObstruction`, `InvolutivityObstruction` the four obstructions; zero means the identity holds
- `$DefiningIdentities` the four collected, with their arities

### The Beilinson-Drinfeld algebra

- `BeilinsonDrinfeldOperator` the operator q(1,1,0) + q(1,2,0) + HBar q(2,1,0) on symmetric powers
- `BeilinsonDrinfeldBracket` the bracket of the BD axiom, carrying no HBar
- `BeilinsonDrinfeldMasterEquation`, `BeilinsonDrinfeldMasterQ` the master equation over R[[HBar]], and its test
- `PlanckDegree` the symmetric degree of HBar, and so of a BD action
- `HBar` the formal variable

### Maurer-Cartan elements

- `MaurerCartanEquation`, `MaurerCartanQ` the equation on an element, and its test
- `MaurerCartanBasis`, `MaurerCartanAnsatz` the genus-zero monomials, and the general element over them
- `TwistedDifferential`, `TwistedCobracket` the operations twisted by an element

### Gauge equivalence

- `GaugeFlow` the BD homotopy flow, over any alphabet

### A-infinity algebras

- `AInfinityAlgebraQ` its recognizer
- `AInfinityAlgebra`, `AInfinityOperation` a finite-dimensional A-infinity algebra, and its operations
- `AInfinityObstruction`, `AInfinityQ` the relations, and their test
- `AInfinityMorphismObstruction`, `AInfinityMorphismQ` the morphism relations, and their test
