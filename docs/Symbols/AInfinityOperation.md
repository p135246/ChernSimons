---
Template: Symbol
Name: AInfinityOperation
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityOperation
Keywords: [m_k, operation, multilinear extension]
SeeAlso: [AInfinityOperation, AInfinityObstruction, AInfinityQ, AInfinityMorphismObstruction, AInfinityMorphismQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[AInfinityOperation]()[*algebra*, {*e*1, …, *ek*}]</code> gives $m_k$ applied to the elements.

## Details & Options

Each argument is a linear combination of basis elements, and the result is the multilinear extension of the algebra's structure constants. That extension is what lets an operation take the output of another operation as an argument, which is what the relations do.

## Basic Examples

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
{AInfinityOperation[assoc, {u, u}], AInfinityOperation[assoc, {u, v}]}
```

---

It is multilinear, so a combination of basis elements is expanded:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
AInfinityOperation[assoc, {2 u + 3 v, v}]
```
