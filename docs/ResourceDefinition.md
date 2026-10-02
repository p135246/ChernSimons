---
Template: Paclet
ResourceType: Paclet
Name: ChernSimons
Context: ChernSimons`
Paclet: ChernSimons
Description: The large n limit of Chern-Simons theory: canonical Lie bialgebras of cyclic words, the Beilinson-Drinfeld formalism and its Maurer-Cartan elements, algebraic models, and homotopy algebras
ContributedBy: Pavel Hajek
Keywords: [Chern-Simons theory, large n limit, cyclic words, canonical Lie bialgebra, IBL infinity, involutive bi-Lie algebra, Beilinson-Drinfeld algebra, Maurer-Cartan element, string topology, symplectic field theory, Sullivan model, Hodge decomposition, A-infinity algebra]
MainGuide: Documentation/English/Guides/ChernSimons.nb
License: MIT
WolframVersion: 15.0.1+
Categories: [Higher Mathematical Computation]
SourceControlURL: https://github.com/p135246/ChernSimons
---

## Basic Description

The theory is the large-$n$ limit of $U(n)$ Chern-Simons theory on a closed oriented manifold. Its action is a Beilinson-Drinfeld action on the cyclic words of the de Rham cohomology, equivalently a Maurer-Cartan element of an IBL-infinity algebra. It is related to string topology and to symplectic field theory. One can imagine it as the open part of an open-closed string field theory of holomorphic curves in a cotangent bundle, the closed part being the symplectic field theory of the unit cotangent bundle.

The paclet has four areas. Canonical Lie bialgebras: a graded alphabet with a pairing, its cyclic words, and the bracket, the co-bracket and the differential that make them the canonical involutive Lie bialgebra of Cieliebak, Fukaya and Latschev. Beilinson-Drinfeld formalism: the operator on products of cyclic words, its Maurer-Cartan elements, the canonical element of a Poincaré duality algebra and the twisted structure. Algebraic models: Sullivan models with an orientation, the test for Hodge type, the nondegenerate quotient, Hodge decompositions and special propagators. Homotopy algebras: finite-dimensional A-infinity algebras and their morphisms, with the relations of every structure in one place.

The paclet maps the computational boundary of the theory, gives LLM agents a computational interface for checking papers, verifies the axiomatic formalization in bounded cases, and computes string topology operations.

## Details & Options

- The paclet runs on the [Wolfram Engine](https://www.wolfram.com/engine/) 15.0.1 or later, which is freely available, and in Mathematica.
- Install it from this page with <code>PacletInstall[ResourceObject["https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons"], ForceVersionInstall -> True]</code>.
- Load it with <code>Needs["ChernSimons\`"]</code>; <code>?ChernSimons\`*</code> lists the exports.
- The same build is a plain archive: <code>PacletInstall["https://www.wolframcloud.com/obj/hajek_pavel/s1paper/ChernSimons.paclet", ForceVersionInstall -> True]</code>.
- The documentation is read online without installing anything, starting at the guide [Chern-Simons Theory](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/guide/ChernSimons.html); after the install it is in the Documentation Center.
- The guide [Chern-Simons Theory](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/guide/ChernSimons.html) is the landing page of the documentation; every symbol it lists has a reference page with examples, and the four areas have the guides [Canonical Lie Bialgebras](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/guide/CanonicalLieBialgebras.html), [Beilinson-Drinfeld Formalism](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/guide/BeilinsonDrinfeldFormalism.html), [Algebraic Models](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/guide/AlgebraicModels.html) and [Homotopy Algebras](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/guide/HomotopyAlgebras.html).
- Three tutorials: [The Canonical IBL Algebra of the Circle](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/tutorial/TheCanonicalIBLAlgebraOfTheCircle.html) builds the canonical IBL-infinity algebra of the circle from its minimal model in a few lines; [From a Sullivan Model to an IBL Algebra](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/tutorial/FromASullivanModelToAnIBLAlgebra.html) does the same for any model; [Hodge Type and the Nondegenerate Quotient](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/ChernSimons/Documentation/ChernSimons/tutorial/HodgeTypeAndTheNondegenerateQuotient.html) explains when the construction applies.
- The paclet accompanies the paper of Cieliebak and Hájek on the Chern-Simons IBL-infinity algebra of the circle, in preparation; the formulas it computes are the ones the paper states. It is based on the original implementation in [Algebraic Model of String Operations](https://notebookarchive.org/2024-07-6ij9go2), Wolfram Notebook Archive 2024.
- Every export computes on an arbitrary graded alphabet; the circle is the running example of the documentation.

## Hero Image

Above, the bracket and the co-bracket of cyclic words as surfaces: strings propagate from the top to the bottom, and each red curve is a pairing that annihilates two particles. Below, the involutivity relation as glued surfaces. From Algebraic Model of String Operations, Wolfram Notebook Archive 2024.

```wl
Import[PacletObject["ChernSimons"]["AssetLocation", "HeroImage"]]
```
