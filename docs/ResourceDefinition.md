---
Template: Paclet
ResourceType: Paclet
Name: ChernSimons
Context: ChernSimons`
Paclet: ChernSimons
Description: The large n limit of Chern-Simons theory: string algebras of cyclic words, the Beilinson-Drinfeld formalism and its Maurer-Cartan elements, algebraic models, and homotopy algebras
ContributedBy: Pavel Hajek
Keywords: [Chern-Simons theory, large n limit, cyclic words, IBL infinity, involutive bi-Lie algebra, Beilinson-Drinfeld algebra, Maurer-Cartan element, string topology, symplectic field theory, Sullivan model, Hodge decomposition, A-infinity algebra]
MainGuide: Documentation/English/Guides/ChernSimons.nb
License: MIT
WolframVersion: 15.0.1+
Categories: [Higher Mathematical Computation]
SourceControlURL: https://github.com/p135246/ChernSimons
---

## Basic Description

The theory is the large-$n$ limit of $U(n)$ Chern-Simons theory on a closed oriented manifold. Its action is a Beilinson-Drinfeld action on the cyclic words of the de Rham cohomology, equivalently a Maurer-Cartan element of an IBL-infinity algebra. The bracket and the co-bracket of cyclic words model the string topology operations on the free loop space of the manifold, and the same algebraic structure governs symplectic field theory.

## Details & Options

- The paclet has four areas, each with its own guide. String algebras: the graded alphabet with a pairing, cyclic words, the bracket, the co-bracket and the differential involutive bi-Lie algebra they form. Beilinson-Drinfeld formalism: the operator on symmetric powers of cyclic words, Maurer-Cartan elements, the canonical element of a Poincaré duality algebra and the twisted differential. Algebraic models: Sullivan models with an orientation, the test for Hodge type, the nondegenerate quotient, Hodge decompositions and special propagators. Homotopy algebras: finite-dimensional A-infinity algebras and their morphisms, with the relations of every structure in one place.
- Install with <code>PacletInstall[ResourceObject["https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons"], ForceVersionInstall -> True]</code>, then load with <code>Needs["ChernSimons\`"]</code>.
- Every export computes on an arbitrary graded alphabet; the circle is the running example of the documentation, and the tutorial [TheCanonicalIBLAlgebraOfTheCircle]() builds its canonical IBL-infinity algebra from the minimal model in a few lines.
- The Chern-Simons Theory guide, [ChernSimons](), is the landing page; every symbol it lists has a reference page.
- The paclet accompanies the paper of Cieliebak and Hájek on the Chern-Simons IBL-infinity algebra of the circle; the formulas it computes are the ones the paper states.
