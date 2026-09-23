---
Template: Symbol
Name: SullivanModelQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelQ
Keywords: [Sullivan model, predicate, minimal model, recognizer]
SeeAlso: [SullivanModel, $SullivanModels, GradedPairingQ, PoincareDualityAlgebraQ]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[SullivanModelQ]()[*expr*]</code> tests whether *expr* is a model built by [SullivanModel]().

## Details & Options

A structure of this paclet is a tagged object, not a bare Association, so that it can be recognized, dispatched on and printed as itself. The predicate answers the recognition question only: it does not check that the data inside is consistent.

Every operation accepts the tagged object and unwraps it, so the predicate is never needed to call anything. It is for the caller writing their own definitions.

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
