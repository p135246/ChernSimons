---
Template: Symbol
Name: AInfinityAlgebra
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityAlgebra
Keywords: [A-infinity algebra, structure constants, finite dimensional, graded]
SeeAlso: [AInfinityOperation, AInfinityObstruction, AInfinityQ, AInfinityMorphismObstruction, AInfinityMorphismQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[AInfinityAlgebra]()[*degrees*, *products*]</code> builds an A-infinity algebra on a finite-dimensional graded space.

## Details & Options

*degrees* is an Association from basis elements to their **shifted** degrees. *products* is a function of a list of basis elements giving $m_k$ on it, as a linear combination of basis elements, and $0$ on the arities it does not define.

The result is a plain Association with keys `"Degrees"`, `"Basis"` and `"Products"`, so it can be inspected and edited like any other expression.

Unlike the Maurer-Cartan and BD layer, which takes a pairing and works over an arbitrary alphabet without assuming finite dimensions, an A-infinity algebra here is its own object and **is** finite-dimensional: its operations are structure constants on a basis.

The convention is the shifted one throughout. A strictly associative algebra concentrated in degree $0$ becomes, after the shift, one whose basis elements have degree $-1$; at that degree the relation reads as associativity, whereas at degree $0$ it would demand anti-associativity.

The algebra displays as a summary box: its basis with the shifted degrees, and the products under the opener.

## Basic Examples

A strictly associative algebra on two generators, as an A-infinity algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
Keys[assoc]
```

---

Its single nonzero operation:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
{AInfinityOperation[assoc, {u, v}], AInfinityOperation[assoc, {u, v, u}]}
```
