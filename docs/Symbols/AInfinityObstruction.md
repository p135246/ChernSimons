---
Template: Symbol
Name: AInfinityObstruction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityObstruction
Keywords: [A-infinity relation, obstruction, associativity up to homotopy]
SeeAlso: [AInfinityOperation, AInfinityObstruction, AInfinityQ, AInfinityMorphismObstruction, AInfinityMorphismQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[AInfinityObstruction]()[*algebra*, {*e*1, …, *en*}]</code> gives the obstruction of the A-infinity relation on those elements; $0$ means the relation holds there.

## Details & Options

The convention is the shifted one: the term whose inner operation takes arguments $r+1$ through $r+s$ carries the sign of the sum of the shifted degrees of the first $r$ arguments,
$$\sum_{r+s+t=n} (-1)^{|e_1|+\cdots+|e_r|}\, m_{r+1+t}(e_1,\dots,e_r, m_s(e_{r+1},\dots,e_{r+s}), \dots, e_n).$$

## Basic Examples

On a strictly associative algebra the relation is associativity, and holds:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]];
{AInfinityObstruction[assoc, {u, v, u}], AInfinityObstruction[assoc, {v, v, v}]}
```

---

A product that is not associative fails it:

```wl
bad = AInfinityAlgebra[<|u -> -1, v -> -1|>,
   t |-> If[Length[t] === 2, Switch[t, {u, u}, v, {u, v}, u, _, 0], 0]];
AInfinityObstruction[bad, {u, u, v}]
```
