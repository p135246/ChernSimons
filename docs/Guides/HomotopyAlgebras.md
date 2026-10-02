---
Template: Guide
Name: HomotopyAlgebras
Title: Homotopy Algebras
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/guide/HomotopyAlgebras
Description: Finite-dimensional A-infinity algebras, their operations and morphisms, and the relations of the algebraic structures, with their obstructions and tests
Keywords: [homotopy algebra, A-infinity algebra, A-infinity morphism, A-infinity relations, relations, obstruction, string algebra, Maurer-Cartan equation, cochain complex with pairing, Hodge decomposition]
RelatedGuides: [ChernSimons]
---

## Abstract

Homotopy algebras are algebras whose relations hold up to coherent homotopy: finite-dimensional A-infinity algebras, their operations and their morphisms; and the relations of an algebraic structure, the obstruction of each and the test of all of them, for canonical Lie bialgebras, Maurer-Cartan elements, A-infinity algebras and morphisms, and cochain complexes with a pairing and their decompositions.

## Functions

### A-infinity algebras and morphisms

- `AInfinityAlgebra` a finite-dimensional A-infinity algebra, from the degrees of a basis and the operations $m_k$
- `AInfinityOperation` the operation $m_k$ applied to $k$ elements
- `AInfinityMorphism` a morphism of A-infinity algebras, from its components $f_k$
- `AInfinityAlgebraQ` tests whether an expression is an A-infinity algebra

### Relations of a structure

- `Relations` the names and arities of the relations of a canonical Lie bialgebra, an A-infinity algebra or morphism, a complex with a pairing or a decomposition
- `Obstruction` the obstruction of a relation on given arguments, zero when it holds, and of the Maurer-Cartan equation of an element
- `RelationsQ` tests every relation of a structure over a range of arguments, and the Maurer-Cartan equation of an element
