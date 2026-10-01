---
Template: Symbol
Name: AInfinityAlgebraQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityAlgebraQ
Keywords: [A-infinity, predicate, recognizer, graded algebra]
SeeAlso: [AInfinityAlgebra, RelationsQ, AInfinityOperation, GradedPairingQ]
RelatedGuides: [HomotopyAlgebras]
---

## Usage

<code>[AInfinityAlgebraQ]()[*expr*]</code> tests whether *expr* is an [AInfinityAlgebra]() object.

<!-- #| annotation: 26.09.30: Design review - an algebra of the paclet is a tagged object, AInfinityAlgebra around one Association, not a bare Association, so that it can be recognized, dispatched on and printed as itself; the predicate answers the recognition question only and reads nothing inside the Association. Every operation takes the object itself, so no operation needs the predicate; it is there for definitions of one's own that pattern on an algebra. Whether the relations hold is a separate question, answered by RelationsQ, which since R5e (2026-09-30) also replaces the old AInfinityQ. The string algebra, the A-infinity morphism and the Maurer-Cartan element have no recognizer, since the design lists none (R5d, R5e). No alternative name was recorded. Prior art: the predicate is the analogue of the built-in AssociationQ for this head, and of GradedPairingQ, SullivanModelQ and PoincareDualityAlgebraQ in the paclet. -->

## Details & Options

- [AInfinityAlgebraQ]() gives `True` for an [AInfinityAlgebra]() object and `False` for any other expression.
- It does not test that the data inside the object is consistent, nor that the relations hold. [RelationsQ]() tests the relations.
- An input to [AInfinityAlgebra]() that returns unevaluated builds no algebra, and the predicate gives `False` on it.

## Basic Examples

An algebra is recognized:

```wl
AInfinityAlgebraQ[AInfinityAlgebra[<|a -> 0|>, 0 &]]
```

<!-- => True -->

---

A bare Association is not:

```wl
AInfinityAlgebraQ[<|"Degrees" -> <|a -> 0|>|>]
```

<!-- => False -->

## Scope

An algebra whose product is not associative:

```wl
bad = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, v, {u, v}, u, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

It is recognized:

```wl
AInfinityAlgebraQ[bad]
```

<!-- => True -->

It fails the relation:

```wl
RelationsQ[bad, 3]
```

<!-- => False -->

## Properties and Relations

The Association of an algebra is not an algebra:

```wl
AInfinityAlgebraQ[Normal[AInfinityAlgebra[<|a -> 0|>, 0 &]]]
```

<!-- => False -->

## Possible Issues

A degree that is not an integer builds no algebra:

```wl
AInfinityAlgebraQ[AInfinityAlgebra[<|u -> 1/2|>, 0 &]]
```

<!-- => False -->
