---
Template: Symbol
Name: GradedPairingQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/GradedPairingQ
Keywords: [pairing, predicate, graded alphabet, recognizer]
SeeAlso: [GradedPairing, SullivanModelQ, PoincareDualityAlgebraQ, AInfinityAlgebraQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[GradedPairingQ]()[*expr*]</code> tests whether *expr* is a pairing object built by [GradedPairing]().

## Details & Options

A structure of this paclet is a tagged object, not a bare Association, so that it can be recognized, dispatched on and printed as itself. The predicate answers the recognition question only: it does not check that the data inside is consistent.

Every operation accepts the tagged object and unwraps it, so the predicate is never needed to call anything. It is for the caller writing their own definitions.

## Basic Examples

A pairing object is recognized:

```wl
GradedPairingQ[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => True -->

---

A bare Association is not, even one with the right keys:

```wl
GradedPairingQ[<|"Degrees" -> <|x -> -1|>|>]
```

<!-- => False -->
