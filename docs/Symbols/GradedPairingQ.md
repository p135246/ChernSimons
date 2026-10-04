---
Template: Symbol
Name: GradedPairingQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/GradedPairingQ
Keywords: [pairing, predicate, graded alphabet, recognizer]
SeeAlso: [GradedPairing, SullivanModelQ, PoincareDualityAlgebraQ, AInfinityAlgebraQ]
RelatedGuides: [CanonicalLieBialgebra]
---

## Usage

<code>[GradedPairingQ]()[*expr*]</code> tests whether *expr* is a pairing object built by [GradedPairing]().

<!-- #| annotation: 26.09.30: Design review - the recognizer came with the tagged head in T0b, when the four plain Associations GradedPairing, SullivanModel, PoincareDualityAlgebra and AInfinityAlgebra became tagged objects, each with a recognizer named after it. Until R7 it tested the head and the Association inside and nothing more, so GradedPairing[<|x -> -1|>] was recognized. Since R7 (Pavel, 2026-10-01: "fix all") it tests the keys the constructor always writes, "Degrees" and "Values" holding Associations, "Degree", and "Convention" holding "Symmetric" or "Exterior", so it is True exactly on what GradedPairing builds, also after an Append, and no stricter than the operations, which read those four keys. PoincareDualityAlgebraQ got the same fix. It gives True or False on every input and does not check that the values are consistent with the degrees. Prior art: the Wolfram Language names its structural tests the same way (AssociationQ, MatrixQ), and AssociationQ gives False on the tagged object, since the head is GradedPairing. The engine the verification suites load has no pairing object and so no recognizer. -->

## Details & Options

- [GradedPairingQ]() gives `True` for an expression <code>[GradedPairing]()[*assoc*]</code> whose association *assoc* has the keys the constructor writes: `"Degrees"` and `"Values"` holding associations, `"Degree"`, and `"Convention"` holding `"Symmetric"` or `"Exterior"`. It gives `False` for every other expression.
- It tests the form of the expression. It does not check that the values are consistent with the degrees.
- A bare association with the keys of a pairing object gives `False`.
- Every operation takes the pairing object itself. The predicate serves as a pattern test, as in `f[p_?GradedPairingQ]`.

## Basic Examples

A pairing object is recognized:

```wl
GradedPairingQ[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => True -->

---

A bare association is not, even one with the keys of a pairing object:

```wl
GradedPairingQ[Normal[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]]
```

<!-- => False -->

---

The head around an association without the keys of a pairing object is not recognized:

```wl
GradedPairingQ[GradedPairing[<|x -> -1|>]]
```

<!-- => False -->

## Scope

A pairing object in the exterior convention is recognized:

```wl
GradedPairingQ[Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]]
```

<!-- => True -->

---

The pairing object of a Poincaré duality algebra is recognized:

```wl
GradedPairingQ[GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]]]]
```

<!-- => True -->

---

An alphabet whose values have no common degree gives no pairing object:

```wl
GradedPairingQ[GradedPairing[<|x -> -1, y -> 0, z -> 0|>, <|{x, y} -> 1, {y, z} -> 1|>]]
```

<!-- => False -->

## Properties and Relations

The tagged object is not an association:

```wl
AssociationQ[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => False -->

---

As a pattern test it selects the pairing objects of a list:

```wl
Select[{GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], <|x -> -1, y -> 0|>, x}, GradedPairingQ]
```

<!-- => a list of one GradedPairing object, with letters x and y, of pairing degree -1 -->
