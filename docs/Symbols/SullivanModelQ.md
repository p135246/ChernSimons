---
Template: Symbol
Name: SullivanModelQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelQ
Keywords: [Sullivan model, predicate, minimal model, recognizer]
SeeAlso: [SullivanModel, $SullivanModels, GradedPairingQ, PoincareDualityAlgebraQ]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[SullivanModelQ]()[*expr*]</code> gives `True` if *expr* is a [SullivanModel]() object, and `False` otherwise.

<!-- #| annotation: 26.09.30: Design review - the recognizer came with the tagged head, when the model stopped being a plain Association (T0b, 2026-09-21), under the rule that every object of the paclet is one head with a Q predicate. It tests the head and the Association inside it only, and does not check the data, which the constructor has already checked; whether the recognizers should validate the mathematics, as PureMath's ChainComplexQ does, is recorded as open in the HodgeDecompositions hand-off. Prior art: the Wolfram Language has no Sullivan models; the engine the verification suites load keeps a model as a plain Association and has no recognizer. -->

## Details & Options

- A SullivanModel object is the tagged object that [SullivanModel]() gives, a head wrapping an Association.
- [SullivanModelQ]() tests the form of *expr* only: it does not check that the data inside is consistent.
- [SullivanModelQ]() gives `True` or `False` for every expression.
- Every function of the model takes the object itself, so [SullivanModelQ]() is needed only as a pattern test, as in `_?SullivanModelQ`.

## Basic Examples

A model from the catalogue is recognized:

```wl
SullivanModelQ[SullivanModel["Circle"]]
```

<!-- => True -->

---

Its name is not the model:

```wl
SullivanModelQ["Circle"]
```

<!-- => False -->

## Scope

A model built by hand is recognized:

```wl
SullivanModelQ[SullivanModel[<|u -> 2, w -> 5|>, <|w -> u^3|>, u^2]]
```

<!-- => True -->

---

The Association a model wraps is not a model:

```wl
SullivanModelQ[Normal[SullivanModel["Circle"]]]
```

<!-- => False -->

---

When the data is not an orientation, [SullivanModel]() gives a [Failure](), which is not a model:

```wl
SullivanModelQ[SullivanModel[<|a -> 1, b -> 2|>, <|a -> b|>, b]]
```

<!-- => False -->

## Properties and Relations

The nondegenerate quotient of a model is a [PoincareDualityAlgebra](), not a model:

```wl
SullivanModelQ[NondegenerateQuotient[SullivanModel["Circle"]]]
```

<!-- => False -->

---

It is recognized by [PoincareDualityAlgebraQ]():

```wl
PoincareDualityAlgebraQ[NondegenerateQuotient[SullivanModel["Circle"]]]
```

<!-- => True -->

## Possible Issues

The head around any Association is recognized, since the data is not checked:

```wl
SullivanModelQ[SullivanModel[<||>]]
```

<!-- => True -->
