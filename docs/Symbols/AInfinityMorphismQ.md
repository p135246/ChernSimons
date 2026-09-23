---
Template: Symbol
Name: AInfinityMorphismQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityMorphismQ
Keywords: [morphism, test, predicate]
SeeAlso: [AInfinityOperation, AInfinityObstruction, AInfinityQ, AInfinityMorphismObstruction, AInfinityMorphismQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[AInfinityMorphismQ]()[*source*, *target*, *f*, *n*]</code> tests the morphism relations on every tuple of basis elements of the source of length at most *n*.

## Details & Options

A finite check, like [AInfinityQ]().

## Basic Examples

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
AInfinityMorphismQ[assoc, assoc, t |-> If[Length[t] === 1, First[t], 0], 4]
```

---

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
AInfinityMorphismQ[assoc, assoc, t |-> If[Length[t] === 1, v, 0], 3]
```
