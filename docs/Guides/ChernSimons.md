---
Template: Guide
Name: ChernSimons
Title: Chern-Simons Theory
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/ChernSimons
Description: The large n limit of Chern-Simons theory: canonical Lie bialgebras of cyclic words, the Beilinson-Drinfeld formalism and its Maurer-Cartan elements, algebraic models, and homotopy algebras
Keywords: [Chern-Simons theory, large n limit, cyclic words, IBL infinity, involutive bi-Lie algebra, Beilinson-Drinfeld algebra, Maurer-Cartan element, string topology, symplectic field theory, Sullivan model, Hodge decomposition, A-infinity algebra]
RelatedGuides: [CanonicalLieBialgebra, BeilinsonDrinfeldFormalism, AlgebraicModels, HomotopyAlgebras]
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

This paclet contains computable aspects of a version of **Chern-Simons theory** announced by [Cieliebak, Fukaya and Latschev](https://arxiv.org/abs/1508.02741), defined by [Cieliebak and Volkov](https://arxiv.org/abs/2312.05922) and, among others, studied in [Hájek's PhD thesis](https://arxiv.org/abs/2003.07933). It corresponds to the **large-$n$ limit** of $U(n)$ Chern-Simons theory on a closed oriented manifold (see also the recent paper of [Hamilton](https://arxiv.org/abs/2505.15938)).

It can be formulated on the **cyclic words** of the de Rham cohomology either as an IBL-infinity **Maurer-Cartan element** of a **canonical involutive bi-Lie algebra** (IBL), or equivalently, as a **Beilinson-Drinfeld action** of a **canonical BD operator**. The action defines an **open string field theory** on the de Rham cohomology that corresponds to a **quantum A-infinity algebra** generalizing [Stasheff](https://doi.org/10.1090/S0002-9947-1963-0158400-5)'s **A-infinity homotopy transfer** from trees to **trivalent ribbon graphs** (see [Münster and Sachs](https://arxiv.org/abs/1109.4101)).

This open string field theory can be thought of as the open sector of an **open-closed string field theory** ([Münster and Sachs](https://arxiv.org/abs/1303.3444)), with the closed part being the **symplectic field theory** of the unit cotangent bundle, and the **IBL-infinity morphism** between the canonical IBL algebra twisted by the Maurer-Cartan element and the IBL-infinity algebra of symplectic field theory twisted by the canonical augmentation being obtained by integrating forms over the **moduli spaces of holomorphic curves** with boundary punctures on the zero section (open string insertions), where the forms are pulled back, and interior punctures asymptotic to Reeb orbits (closed string insertions).

If the manifold is simply connected, the structure is related to **string topology**: the twisted IBL-infinity algebra is a chain model of **Chas-Sullivan equivariant string topology** relative to a base point, via **Chen's iterated integrals**. If the manifold is homologically simply connected, strong vanishing results hold ([Cieliebak, Hájek and Volkov](https://arxiv.org/abs/2202.06837)) and the structure can be equivalently computed by taking a **Poincaré duality model** of the de Rham cohomology and the canonical IBL algebra on its cyclic words equipped with the **cyclic Hochschild differential**.

![The bracket and the co-bracket of cyclic words as surfaces](../images/StringOperations.png "Center")

The areas of the paclet are the canonical Lie bialgebras of cyclic words, the Beilinson-Drinfeld formalism with its Maurer-Cartan elements, the algebraic models from which the graded alphabet of the cyclic words is read, and the homotopy algebras. Each area has its own guide.

## Functions

### [Canonical Lie Bialgebra](paclet:ChernSimons/guide/CanonicalLieBialgebra)

- `GradedPairing` the graded alphabet with a pairing that the cyclic words are written in
- `CyclicWord` a cyclic word of particles
- `CanonicalLieBracket` the bracket of two cyclic words
- `CanonicalLieCobracket` the co-bracket of a cyclic word
- `CanonicalLieBialgebra` the differential involutive bi-Lie algebra of the cyclic words of an alphabet

### [Beilinson-Drinfeld Formalism](paclet:ChernSimons/guide/BeilinsonDrinfeldFormalism)

- `CanonicalBeilinsonDrinfeldOperator` the Beilinson-Drinfeld operator on the symmetric powers of cyclic words
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
