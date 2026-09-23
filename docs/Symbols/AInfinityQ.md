---
Template: Symbol
Name: AInfinityQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityQ
Keywords: [A-infinity, test, predicate, relations]
SeeAlso: [AInfinityOperation, AInfinityObstruction, AInfinityQ, AInfinityMorphismObstruction, AInfinityMorphismQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[AInfinityQ]()[*algebra*, *n*]</code> tests the A-infinity relations on every tuple of basis elements of length at most *n*.

## Details & Options

A finite check: it says the relations hold up to arity *n*, not that they hold. For an algebra whose operations vanish above some arity, a large enough *n* is conclusive.

## Basic Examples

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
AInfinityQ[assoc, 4]
```

---

The same algebra with unshifted degrees fails, since at degree $0$ the relation asks for anti-associativity:

```wl
AInfinityQ[AInfinityAlgebra[<|u -> 0, v -> 0|>,
  t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]], 3]
```
