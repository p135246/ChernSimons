---
Template: Guide
Name: ChernSimons
Title: Chern-Simons Theory
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/ChernSimons
Description: The large n limit of Chern-Simons theory: string algebras of cyclic words, the Beilinson-Drinfeld formalism and its Maurer-Cartan elements, algebraic models, and homotopy algebras
Keywords: [Chern-Simons theory, large n limit, cyclic words, IBL infinity, involutive bi-Lie algebra, Beilinson-Drinfeld algebra, Maurer-Cartan element, string topology, symplectic field theory, Sullivan model, Hodge decomposition, A-infinity algebra]
RelatedGuides: [StringAlgebras, BeilinsonDrinfeldFormalism, AlgebraicModels, HomotopyAlgebras]
RelatedTutorials: [FromASullivanModelToAnIBLAlgebra, HodgeTypeAndTheNondegenerateQuotient, TheCanonicalIBLAlgebraOfTheCircle]
Links: ["[Cieliebak, Fukaya, Latschev: Homological algebra related to surfaces with boundary (2015)](https://arxiv.org/abs/1508.02741)",
  "[Hájek: Twisted IBL-infinity-algebra and string topology: first look and examples (2018)](https://arxiv.org/abs/1811.05281)",
  "[Hájek: IBL-infinity model of string topology from perturbative Chern-Simons theory (2020)](https://arxiv.org/abs/2003.07933)",
  "[Cieliebak, Hájek, Volkov: Chain-level equivariant string topology: algebra versus analysis (2022)](https://arxiv.org/abs/2202.06837)",
  "[Cieliebak, Volkov: Chern-Simons theory and string topology (2023)](https://arxiv.org/abs/2312.05922)",
  "[Cieliebak, Volkov: String topology operations under Chen's iterated integrals and homotopy transfer (2026)](https://arxiv.org/abs/2607.03782)",
  "[Algebraic Model of String Operations, Wolfram Notebook Archive (2024)](https://notebookarchive.org/2024-07-6ij9go2)"]
---

## Abstract

The theory is the large-$n$ limit of $U(n)$ Chern-Simons theory on a closed oriented manifold.
Its action is a Beilinson-Drinfeld action on the cyclic words of the de Rham cohomology, equivalently a Maurer-Cartan element of an IBL-infinity algebra.
It is related to string topology: the bracket and the co-bracket of cyclic words model the string topology operations on the free loop space of the manifold.
It is related to symplectic field theory, whose algebraic structure is an IBL-infinity algebra as well.
One can imagine it as the open part of an open-closed string field theory of holomorphic curves in the cotangent bundle, the closed part being the symplectic field theory of the unit cotangent bundle.
Its areas are the string algebras of cyclic words, the Beilinson-Drinfeld formalism with its Maurer-Cartan elements, the algebraic models from which the graded alphabet of the cyclic words is read, and the homotopy algebras.
Each area has its own guide.

## Functions

### [String Algebras](paclet:ChernSimons/guide/StringAlgebras)

- `GradedPairing` the graded alphabet with a pairing that the cyclic words are written in
- `CyclicWord` a cyclic word of particles
- `StringBracket` the bracket of two cyclic words
- `StringCobracket` the co-bracket of a cyclic word
- `StringAlgebra` the differential involutive bi-Lie algebra of the cyclic words of an alphabet

### [Beilinson-Drinfeld Formalism](paclet:ChernSimons/guide/BeilinsonDrinfeldFormalism)

- `StringBeilinsonDrinfeldOperator` the Beilinson-Drinfeld operator on the symmetric powers of cyclic words
- `HBar` the formal variable $\hbar$
- `MaurerCartanElement` an element given by its parts or by its action, the unknown of the master equation
- `CanonicalMaurerCartan` the canonical Maurer-Cartan element of a Poincaré duality algebra, made from its triple product
- `TwistedDifferential` the differential twisted by a Maurer-Cartan element

### [Algebraic Models](paclet:ChernSimons/guide/AlgebraicModels)

- `SullivanModel` a Sullivan model with an orientation
- `HodgeTypeQ` tests whether a model is of Hodge type
- `NondegenerateQuotient` the Poincaré duality algebra of a model, its quotient by the degenerate subspace
- `FindHodgeDecomposition` a Hodge decomposition of a model

### [Homotopy Algebras](paclet:ChernSimons/guide/HomotopyAlgebras)

- `AInfinityAlgebra` a finite-dimensional A-infinity algebra
- `AInfinityMorphism` a morphism of A-infinity algebras
- `RelationsQ` tests the relations of a structure
