---
Template: Symbol
Name: PoincareDualityAlgebraQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/PoincareDualityAlgebraQ
Keywords: [Poincare duality, predicate, nondegenerate quotient, recognizer]
SeeAlso: [PoincareDualityAlgebra, NondegenerateQuotient, HodgeTypeQ, GradedPairingQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[PoincareDualityAlgebraQ]()[*expr*]</code> tests whether *expr* is the algebra [NondegenerateQuotient]() returns.

## Details & Options

A structure of this paclet is a tagged object, not a bare Association, so that it can be recognized, dispatched on and printed as itself. The predicate answers the recognition question only: it does not check that the data inside is consistent.

Every operation accepts the tagged object and unwraps it, so the predicate is never needed to call anything. It is for the caller writing their own definitions.

## Basic Examples

The quotient of a model is recognized:

```wl
PoincareDualityAlgebraQ[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]]
```

<!-- => True -->

---

The model it came from is not:

```wl
PoincareDualityAlgebraQ[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => False -->
