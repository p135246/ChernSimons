---
Template: Symbol
Name: AInfinityAlgebraQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityAlgebraQ
Keywords: [A-infinity, predicate, recognizer, graded algebra]
SeeAlso: [AInfinityAlgebra, AInfinityQ, AInfinityOperation, GradedPairingQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[AInfinityAlgebraQ]()[*expr*]</code> tests whether *expr* is an algebra built by [AInfinityAlgebra]().

## Details & Options

A structure of this paclet is a tagged object, not a bare Association, so that it can be recognized, dispatched on and printed as itself. The predicate answers the recognition question only: it does not check that the data inside is consistent.

Every operation accepts the tagged object and unwraps it, so the predicate is never needed to call anything. It is for the caller writing their own definitions.

It is the recognition question, not the axiom: [AInfinityQ]() asks whether the relations hold.

## Basic Examples

An algebra is recognized whether or not it satisfies the relations:

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
