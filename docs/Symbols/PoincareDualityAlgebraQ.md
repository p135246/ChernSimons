---
Template: Symbol
Name: PoincareDualityAlgebraQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/PoincareDualityAlgebraQ
Keywords: [Poincare duality, predicate, nondegenerate quotient, recognizer]
SeeAlso: [PoincareDualityAlgebra, NondegenerateQuotient, HodgeTypeQ, GradedPairingQ]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[PoincareDualityAlgebraQ]()[*expr*]</code> gives `True` if *expr* is a [PoincareDualityAlgebra]() object, and `False` otherwise.

<!-- #| annotation: 26.09.30: Design review - the recognizer came with the tagged head, when the eight-key result of NondegenerateQuotient became the PoincareDualityAlgebra object (T0b, 2026-09-21), under the rule that every object of the paclet is one head with a Q predicate; the object is what the algebraic models hand to GradedPairing. Until R7 it tested the head and the Association inside it only, so PoincareDualityAlgebra[<||>] was recognized; since R7 (Pavel, 2026-10-01) it tests the keys of the data and their kinds, and is True exactly on what PoincareDualityAlgebra[complex] and NondegenerateQuotient build, so it is no stricter than GradedPairing[algebra] and CochainComplexWithPairing[algebra], which take those objects. It does not validate the mathematics, as PureMath's ChainComplexQ does; that is recorded as open in the HodgeDecompositions hand-off. Prior art: the Wolfram Language has no Poincaré duality algebras; the engine the verification suites load keeps the quotient as a plain Association and has no recognizer. -->

## Details & Options

- A PoincareDualityAlgebra object is the tagged object that [NondegenerateQuotient]() gives on a model and that [PoincareDualityAlgebra]() gives, a head wrapping an Association.
- [PoincareDualityAlgebraQ]() tests the form of *expr*: an Association with the keys `"Degree"`, `"Basis"`, `"Degrees"`, `"Pairing"`, `"DifferentialPairing"`, `"Differential"` and `"Triple"`, of the kinds the constructors give.
- It does not check that the data inside is consistent.
- [PoincareDualityAlgebraQ]() gives `True` or `False` for every expression.
- Every function of the algebra takes the object itself, so [PoincareDualityAlgebraQ]() is needed only as a pattern test, as in `_?PoincareDualityAlgebraQ`.

## Basic Examples

The nondegenerate quotient of a model is recognized:

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

## Scope

The algebra of a cochain complex with a product and a perfect pairing is recognized:

```wl
PoincareDualityAlgebraQ[PoincareDualityAlgebra[CochainComplexWithPairing[<|1 -> 0, v -> 1|>, <||>, <||>, v]]]
```

<!-- => True -->

---

The complex itself is not:

```wl
PoincareDualityAlgebraQ[CochainComplexWithPairing[<|1 -> 0, v -> 1|>, <||>, <||>, v]]
```

<!-- => False -->

---

The nondegenerate quotient of a complex is a complex again, not an algebra:

```wl
PoincareDualityAlgebraQ[NondegenerateQuotient[CochainComplexWithPairing[SullivanModel["ComplexProjectiveSpace"[2]]]]]
```

<!-- => False -->

---

The head around an Association without the data of an algebra is not recognized:

```wl
PoincareDualityAlgebraQ[PoincareDualityAlgebra[<||>]]
```

<!-- => False -->

## Properties and Relations

[GradedPairing]() takes the algebra and gives the alphabet of the geometry, which is not an algebra:

```wl
PoincareDualityAlgebraQ[GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]]]]
```

<!-- => False -->

