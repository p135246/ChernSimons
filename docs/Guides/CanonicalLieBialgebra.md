---
Template: Guide
Name: CanonicalLieBialgebra
Title: Canonical Lie Bialgebra
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/CanonicalLieBialgebra
Description: Graded alphabets with a pairing and their cyclic words, the exterior and symmetric products and the degree shift, the differential, bracket and co-bracket of cyclic words, and the canonical Lie bialgebra they make
Keywords: [canonical Lie bialgebra, string algebra, cyclic words, graded alphabet, pairing, Koszul sign, exterior product, symmetric product, degree shift, cyclic Hochschild differential, string bracket, string co-bracket, involutive bi-Lie algebra, dIBL algebra]
RelatedGuides: [ChernSimons]
RelatedTutorials: [TheCanonicalIBLAlgebraOfTheCircle]
---

## Abstract

A **closed string** is modeled as a **necklace of particles**: a **cyclic word** in the letters of a **graded alphabet**, each letter carrying an integer degree. The one piece of data every operation takes is a **pairing**, a graded anti-symmetric bilinear form of degree $d$ on the alphabet. The two diagrams below show the **joining** and the **cutting** of strings: time runs from top to bottom, each red curve is an interaction, a pairing that annihilates two particles and produces a scalar coefficient, and the resulting strings are read off the bottom boundary components of the surface. Summed over all permutations of the input strings and all cyclic rotations of the particles on each string, with the **Koszul signs** of the degrees, the two diagrams define the **bracket** $W \otimes W \to W$ and the **co-bracket** $W \to W \otimes W$ on the vector space $W$ spanned by all strings.

![Joining and cutting strings](../images/StringOperations.png "Center")

[Cieliebak, Fukaya and Latschev](https://arxiv.org/abs/1508.02741) proved that the bracket and the co-bracket satisfy the relations of an **involutive bi-Lie algebra** of degree $d$, the **canonical Lie bialgebra** of the alphabet, and that a differential on the alphabet induces the **cyclic Hochschild differential** making it a **differential involutive bi-Lie algebra**. The construction and the pictures follow [Algebraic Model of String Operations](https://notebookarchive.org/2024-07-6ij9go2), Wolfram Notebook Archive 2024.

In **Chern-Simons theory** one works on the **dual**: the alphabet is a basis of the dual of the de Rham cohomology, so a cyclic word is a **cyclic cochain** on the cohomology, and the pairing is the one induced on the dual by **Poincaré duality**. The paclet carries both sides: a pairing may hold its **dual alphabet**, and a cyclic word is evaluated on a dual cyclic word.

This guide collects the alphabet, its cyclic words and their degrees; the **exterior** and **symmetric products** of cyclic words and the **degree shift** between them; the differential, the bracket and the co-bracket; and the **relations** they satisfy, with the test of each relation on all words up to a given length.

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
- `SymmetricToExterior` the degree shift from symmetric to exterior products, which intertwines the bracket and the co-bracket
- `ExteriorToSymmetric` the inverse of the degree shift
- `DualPairing` the value of cyclic words and their products on dual cyclic words and their products

### Bracket and co-bracket

- `CyclicHochschildDifferential` the differential $\mathfrak{q}_{1,1,0}$, induced by the differential of the Poincaré duality algebra
- `CanonicalLieBracket` the bracket $\mathfrak{q}_{2,1,0}$, joining two cyclic words at a contracted pair of particles
- `CanonicalLieCobracket` the co-bracket $\mathfrak{q}_{1,2,0}$, cutting a cyclic word in two at a contracted pair of particles
- `ChordContraction` one term of the bracket or of the co-bracket, a single contracted pair of particles

### Canonical Lie bialgebras and their relations

- `CanonicalLieBialgebra` the differential involutive bi-Lie algebra of the cyclic words of an alphabet, with or without the empty word
- `Relations` the Jacobi, co-Jacobi, Drinfeld and involutivity relations of a canonical Lie bialgebra
- `Obstruction` the obstruction of a relation of a canonical Lie bialgebra on given cyclic words, zero when it holds
- `RelationsQ` tests the relations of a canonical Lie bialgebra on all cyclic words up to a given length
