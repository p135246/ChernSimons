---
Template: Symbol
Name: AInfinityMorphism
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityMorphism
Keywords: [A-infinity morphism, morphism, components, structure]
SeeAlso: [AInfinityAlgebra, AInfinityOperation, Obstruction, Relations, RelationsQ]
RelatedGuides: [HomotopyAlgebras]
---

## Usage

<code>[AInfinityMorphism]()[*source*, *target*, *f*]</code> is the collection of multilinear maps $f_k$ from the [AInfinityAlgebra]() *source* to the [AInfinityAlgebra]() *target* given by *f*.

<!-- #| annotation: 26.09.30: Design review - the morphism is AInfinityMorphism around one Association with the keys "Source", "Target" and "Components", the rule R5d set for the Maurer-Cartan element and R5e extended to this object and to the string algebra (2026-09-30): an input whose source or target is not an AInfinityAlgebra object returns unevaluated, so a construction that built nothing never looks like a morphism, and the summary box attaches only to the built one. "Components" names the f_k as "Products" names the m_k of an AInfinityAlgebra, and f is one function of a list of basis elements, as the products are. The object is not required to satisfy the morphism relations: it is the data, and Obstruction and RelationsQ test it, which is why it has no recognizer; the old AInfinityMorphismQ was the test of the relations, now RelationsQ. No alternative name was recorded. Prior art: the Wolfram Language has no A-infinity algebras or morphisms; the verification suites build the engine's morphism f of the circle, from its twisted A-infinity structure to the algebra of the product of words, as an AInfinityMorphism and pin its obstruction against the engine's on every tuple of length at most 4. -->

## Details & Options

- *f* is a function of a list of basis elements of *source* that gives $f_k$ on it, as a linear combination of basis elements of *target*.
- In the morphism relation *f* is extended multilinearly, like the products of an algebra, so it takes the output of an inner operation.
- The result is [AInfinityMorphism]() around one Association. For such a morphism *g*, <code>*g*["*key*"]</code> gives the value of a key:

| Key | Value |
|---|---|
| <code>"Source"</code> | the source algebra |
| <code>"Target"</code> | the target algebra |
| <code>"Components"</code> | the function *f* |

- The morphism is not required to satisfy the morphism relations: [Obstruction]() gives their obstruction and [RelationsQ]() tests them.
- Its one relation is `"AInfinityMorphism"`.
- An input whose source or target is not an [AInfinityAlgebra]() object returns unevaluated.
- The morphism displays as a summary box: the bases of the source and the target, and their degrees and the components under the opener.

## Basic Examples

The identity of a strictly associative algebra:

```wl
identity = AInfinityMorphism[AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]], AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]], t |-> If[Length[t] === 1, First[t], 0]]
```

<!-- => an AInfinityMorphism object from the algebra on u and v to itself -->

It is a morphism:

```wl
RelationsQ[identity, 4]
```

<!-- => True -->

## Scope

A strictly associative algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

A map that sends every element to $v$:

```wl
g = AInfinityMorphism[assoc, assoc, t |-> If[Length[t] === 1, v, 0]]
```

<!-- => an AInfinityMorphism object from the algebra on u and v to itself -->

It is not a morphism, and its obstruction on $(u, u)$ is not $0$:

```wl
Obstruction[g, {u, u}]
```

<!-- => v -->

Its components read back:

```wl
g["Components"][{u}]
```

<!-- => v -->

Its source is the algebra:

```wl
g["Source"] === assoc
```

<!-- => True -->

Its target is the algebra too:

```wl
g["Target"] === assoc
```

<!-- => True -->

## Possible Issues

A strictly associative algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

The source and the target must be [AInfinityAlgebra]() objects; with the Association of the data as the source the expression returns unevaluated:

```wl
AInfinityMorphism[Normal[assoc], assoc, First]
```

<!-- => the input with the Association of the source in place, unevaluated -->
