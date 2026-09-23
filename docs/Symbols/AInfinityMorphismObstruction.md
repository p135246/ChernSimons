---
Template: Symbol
Name: AInfinityMorphismObstruction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityMorphismObstruction
Keywords: [morphism, A-infinity morphism, obstruction, compositions]
SeeAlso: [AInfinityOperation, AInfinityObstruction, AInfinityQ, AInfinityMorphismObstruction, AInfinityMorphismQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[AInfinityMorphismObstruction]()[*source*, *target*, *f*, {*e*1, …, *en*}]</code> gives the obstruction of the morphism relation for the collection *f*; $0$ means it holds there.

## Details & Options

*f* is a function of a list of source basis elements giving $f_k$ on it, as an element of the target. It is extended multilinearly, like an algebra's own products, so it can take the output of an inner operation.

The left-hand side carries the same shifted signs as [AInfinityObstruction](). The right-hand side sums over **all** compositions of the arguments into blocks, so a target with operations beyond $m_2$ is handled; when the target is a strictly associative algebra only the two-block terms survive.

## Basic Examples

The identity is a morphism, so the obstruction vanishes:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
AInfinityMorphismObstruction[assoc, assoc, t |-> If[Length[t] === 1, First[t], 0], {u, v, u}]
```

---

A map that is not one does not:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
AInfinityMorphismObstruction[assoc, assoc, t |-> If[Length[t] === 1, v, 0], {u, u}]
```
