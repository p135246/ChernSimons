---
Template: Symbol
Name: AInfinityOperation
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityOperation
Keywords: [m_k, operation, multilinear extension]
SeeAlso: [AInfinityAlgebra, AInfinityMorphism, Obstruction, RelationsQ]
RelatedGuides: [HomotopyAlgebras]
---

## Usage

<code>[AInfinityOperation]()[*algebra*, {$e_1$, …, $e_k$}]</code> gives the operation $m_k$ of *algebra* applied to the elements $e_1, \dots, e_k$.

<!-- #| annotation: 26.09.30: Design review - the operation takes the AInfinityAlgebra object and the list of its arguments, whose length is the arity k, so one function gives every m_k. The products of the algebra are given on basis elements only, and this function is their multilinear extension to linear combinations: it is what lets an operation take the output of another, and it is the only function the A-infinity obstructions share, each of them expanding its own arguments otherwise. The coordinates of an argument are read with CoefficientRules in the variables of the basis, and an argument outside the span of the basis returns unevaluated; before R3 (2026-09-29) a symbol outside the basis was silently read as 0. No alternative name was recorded. Prior art: the Wolfram Language has no A-infinity algebras; on the engine's twisted A-infinity structure of the circle the verification suites pin m_2(a, b) = c_{0,1} b against the engine. -->

## Details & Options

- Each $e_i$ is a linear combination of basis elements of *algebra*, with numeric or symbolic coefficients.
- The result is the multilinear extension of the products of *algebra*, a linear combination of basis elements.
- The multilinear extension lets an operation take the output of another operation as an argument, as the relations do.
- An argument that is not a linear combination of basis elements returns unevaluated.

## Basic Examples

The operation $m_2$ of a strictly associative algebra on two basis elements:

```wl
AInfinityOperation[AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]], {u, u}]
```

<!-- => u -->

---

A strictly associative algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

The operation on the other pair:

```wl
AInfinityOperation[assoc, {u, v}]
```

<!-- => v -->

The operation is multilinear, so a combination of basis elements is expanded:

```wl
AInfinityOperation[assoc, {2 u + 3 v, v}]
```

<!-- => 2 v -->

## Scope

A strictly associative algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

The coefficients may be symbolic:

```wl
AInfinityOperation[assoc, {lambda u + mu v, u}]
```

<!-- => lambda u + mu v -->

An operation takes the output of another as an argument:

```wl
AInfinityOperation[assoc, {AInfinityOperation[assoc, {u, v}], u}]
```

<!-- => v -->

The operations the products do not define are $0$:

```wl
AInfinityOperation[assoc, {u, v, u}]
```

<!-- => 0 -->

## Possible Issues

A strictly associative algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

A symbol that is not a basis element is not in the span, and the expression returns unevaluated:

```wl
AInfinityOperation[assoc, {w, v}]
```

<!-- => the input, unevaluated -->

A symbol that multiplies a basis element is read as a coefficient:

```wl
AInfinityOperation[assoc, {w u, v}]
```

<!-- => v w -->
