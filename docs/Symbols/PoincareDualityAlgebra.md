---
Template: Symbol
Name: PoincareDualityAlgebra
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/PoincareDualityAlgebra
Keywords: [Poincare duality algebra, nondegenerate quotient, Gram matrix, triple product]
SeeAlso: [NondegenerateQuotient, PoincareDualityAlgebraQ, GradedPairing, HodgeTypeQ, CanonicalMaurerCartan]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[PoincareDualityAlgebra]()[*data*]</code> is the finite-dimensional Poincare duality algebra that [NondegenerateQuotient]() returns.

## Details & Options

It is built by [NondegenerateQuotient](), not by hand, and it is the object the rational homotopy layer hands to the dIBL layer: <code>[GradedPairing]()[*algebra*]</code> reads the alphabet off it, and [CanonicalMaurerCartan]() reads the canonical element off its triple product.

| key | |
|---|---|
| `"Degree"` | the Poincare duality degree $n$ |
| `"Basis"` | the basis, as monomials of the model |
| `"Degrees"` | their degrees |
| `"Pairing"` | the Gram matrix, invertible |
| `"DifferentialPairing"` | the pairing of the differential |
| `"Differential"` | the induced differential in the basis |
| `"Triple"` | the triple product, which carries the canonical Maurer-Cartan element |
| `"Model"` | the model it is a quotient of |

A key is read with curried access, as on any of this paclet's objects.

The quotient map is a quasi-isomorphism exactly when the model is of Hodge type, which [HodgeTypeQ]() decides; on a model that is not, the algebra is still built and is still a Poincare duality algebra, but it no longer carries the model's homotopy type.

The algebra displays as a summary box: its basis and its degree, with the degrees, the Gram matrix, the differential and the model under the opener.

## Basic Examples

The quotient of the model of $\mathbb{CP}^2$:

```wl
NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]["Basis"]
```

<!-- => {1, a, a^2} -->

---

Its Poincare duality degree:

```wl
NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]["Degree"]
```

<!-- => 4 -->
