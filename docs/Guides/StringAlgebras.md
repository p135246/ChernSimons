---
Template: Guide
Name: StringAlgebras
Title: String Algebras
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/StringAlgebras
Description: Graded alphabets with a pairing and their cyclic words, the exterior and symmetric products and the degree shift, the differential, bracket and co-bracket of cyclic words, and the string algebra they make
Keywords: [string algebra, cyclic words, graded alphabet, pairing, Koszul sign, exterior product, symmetric product, degree shift, cyclic Hochschild differential, string bracket, string co-bracket, involutive bi-Lie algebra, dIBL algebra]
RelatedGuides: [ChernSimons]
RelatedTutorials: [TheCanonicalIBLAlgebraOfTheCircle]
---

## Abstract

String algebras are the differential involutive bi-Lie algebras of cyclic words over a graded alphabet with a pairing: the alphabet, its cyclic words and their degrees; the exterior and symmetric products of cyclic words and the degree shift between them; the string operations, a differential, a bracket that joins two words and a co-bracket that cuts one; and the string algebra they make, with its four relations.

## Functions

### Graded alphabets and cyclic words

- `GradedPairing` a graded alphabet with a pairing, from degrees and pairing values or from a Poincaré duality algebra
- `CyclicWord` a cyclic word of particles, and its canonical rotation with the Koszul sign
- `GenerateCyclicWords` the nonzero cyclic words of a given length
- `ElementDegree` the bar, exterior or symmetric degree of a particle, a cyclic word or a product
- `KoszulSign` the sign of a permutation of graded objects
- `Signature` (WL) the sign of a permutation
- `GradedPairingQ` tests whether an expression is a graded alphabet with a pairing

### Products and the degree shift

- `ExteriorProduct` the graded exterior product of cyclic words, in the exterior degree
- `SymmetricProduct` the graded symmetric product of cyclic words, in the symmetric degree
- `SymmetricToExterior` the degree shift from symmetric to exterior products, which intertwines the string operations
- `ExteriorToSymmetric` the inverse of the degree shift
- `DualPairing` the value of cyclic words and their products on dual cyclic words and their products

### String operations

- `CyclicHochschildDifferential` the differential $\mathfrak{q}_{1,1,0}$, induced by the differential of the Poincaré duality algebra
- `StringBracket` the bracket $\mathfrak{q}_{2,1,0}$, joining two cyclic words at a contracted pair of particles
- `StringCobracket` the co-bracket $\mathfrak{q}_{1,2,0}$, cutting a cyclic word in two at a contracted pair of particles
- `ChordContraction` one term of the bracket or of the co-bracket, a single contracted pair of particles

### String algebras and their relations

- `StringAlgebra` the differential involutive bi-Lie algebra of the cyclic words of an alphabet, with or without the empty word
- `Relations` the Jacobi, co-Jacobi, Drinfeld and involutivity relations of a string algebra
- `Obstruction` the obstruction of a relation of a string algebra on given cyclic words, zero when it holds
- `RelationsQ` tests the relations of a string algebra on all cyclic words up to a given length
