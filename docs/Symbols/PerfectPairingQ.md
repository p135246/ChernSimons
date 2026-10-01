---
Template: Symbol
Name: PerfectPairingQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/PerfectPairingQ
Keywords: [perfect pairing, dPD algebra, chain-level Poincare duality, cyclic cochain complex, predicate]
SeeAlso: [PoincareDualityQ, DegenerateSubspace, NondegenerateQuotient, SullivanModelPairing, SullivanModel]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[PerfectPairingQ]()[*model*]</code> tests whether the pairing of the Sullivan model *model* is perfect on chain level.

<code>[PerfectPairingQ]()[*complex*]</code> tests whether the pairing of the [CochainComplexWithPairing]() *complex* is perfect on chain level.

<!-- #| annotation: 26.09.30: Design review - the predicate is the chain-level counterpart of PoincareDualityQ and, unlike it, exact on a model: a model is finite-dimensional exactly when every generator of even degree is truncated, so the answer is False when one is not, and otherwise every degree up to the finite top is checked (H1, 2026-09-24). A True makes a model a dPD algebra and a complex a cyclic cochain complex, and the name says the property rather than either structure; no alternative name was recorded. Prior art: the Wolfram Language has no pairing on a graded algebra; the test is the MatrixRank of the Gram matrix between degree k and degree n-k. The engine the verification suites load has no such test; the suites pin this predicate over the catalogue, where exactly the exterior algebras have a perfect pairing on chain level, and on T^2 oriented in degree 1. -->

## Details & Options

- The pairing $\langle v,w\rangle = \mathcal{O}(vw)$ of a model of degree $n$ is perfect on chain level when the model vanishes above degree $n$ and pairs degree $k$ nondegenerately with degree $n-k$ for every $k$. The model is then a dPD algebra.
- A model with a generator of even degree that no truncation bounds is infinite-dimensional, and the answer is `False`. Otherwise the model is finite-dimensional, every degree is checked, and the test is exact.
- A complex of degree $n$ has a perfect pairing when it pairs degree $k$ nondegenerately with degree $n-k$ for every $k$. It is then a cyclic cochain complex, and a dPD algebra when it carries a product.
- A perfect pairing on chain level has no degenerate subspace, so the model or complex is its own nondegenerate quotient.
- A perfect pairing on chain level induces one on cohomology, so a `True` here implies a `True` from [PoincareDualityQ]().

## Basic Examples

The model of the Heisenberg nilmanifold is an exterior algebra, and its pairing is perfect on chain level:

```wl
PerfectPairingQ[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => True -->

---

The model of $\mathbb{CP}^2$ is polynomial in its generator of degree $2$, and its pairing is not perfect:

```wl
PerfectPairingQ[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => False -->

## Scope

A truncation can make a polynomial algebra finite-dimensional. The truncated algebra $\mathbb{K}[u]/(u^3)$ with $\lvert u\rvert = 2$, the cohomology of $\mathbb{CP}^2$, has a perfect pairing:

```wl
PerfectPairingQ[SullivanModel[<|u -> 2|>, <||>, u^2, 4]]
```

<!-- => True -->

---

The model of $S^2$ truncated above degree $2$ is its cohomology $\mathbb{K}[v]/(v^2)$, and its pairing is perfect:

```wl
PerfectPairingQ[SullivanModel[<|v -> 2, w -> 3|>, <|w -> v^2|>, v, 2]]
```

<!-- => True -->

---

The truncated model of Example 6.3 of arXiv:2004.07362:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, of degree 4, truncated above 4 -->

It is finite-dimensional, but it has nothing in degree $1$:

```wl
SullivanModelBasis[model, 1]
```

<!-- => {} -->

So $c$, of degree $3$, pairs with nothing:

```wl
SullivanModelBasis[model, 3]
```

<!-- => {c} -->

The pairing is not perfect:

```wl
PerfectPairingQ[model]
```

<!-- => False -->

---

The exterior algebra of $T^2$ oriented in degree $1$ does not vanish above its degree, and its pairing is not perfect:

```wl
PerfectPairingQ[SullivanModel[<|v1 -> 1, v2 -> 1|>, <||>, v1]]
```

<!-- => False -->

---

The complex of the model of $\mathbb{CP}^2$:

```wl
complex = CochainComplexWithPairing[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a CochainComplexWithPairing object of degree 4 -->

Its pairing is not perfect:

```wl
PerfectPairingQ[complex]
```

<!-- => False -->

That of its nondegenerate quotient is:

```wl
PerfectPairingQ[NondegenerateQuotient[complex]]
```

<!-- => True -->

## Properties and Relations

The model of the three-torus:

```wl
model = SullivanModel["Torus"[3]]
```

<!-- => a SullivanModel object with generators v1, v2, v3 of degree 1, of degree 3 -->

Its pairing is perfect on chain level:

```wl
PerfectPairingQ[model]
```

<!-- => True -->

It has no degenerate subspace in any degree:

```wl
Union[Table[DegenerateSubspace[model, k], {k, 0, 3}]]
```

<!-- => {{}} -->

Its nondegenerate quotient has dimension $8$:

```wl
Length[NondegenerateQuotient[model]["Basis"]]
```

<!-- => 8 -->

That is the dimension of the model itself:

```wl
Total[Table[Length[SullivanModelBasis[model, k]], {k, 0, 3}]]
```

<!-- => 8 -->

---

The model of $SU(3)$:

```wl
model = SullivanModel["SpecialUnitaryGroup"[3]]
```

<!-- => a SullivanModel object with generators h3 of degree 3 and h5 of degree 5, of degree 8 -->

Its pairing is perfect on chain level:

```wl
PerfectPairingQ[model]
```

<!-- => True -->

So it satisfies Poincaré duality:

```wl
PoincareDualityQ[model]
```

<!-- => True -->

## Possible Issues

The model of $S^2$ has a generator of even degree that no truncation bounds, so its pairing is not perfect on chain level:

```wl
PerfectPairingQ[SullivanModel["Sphere"[2]]]
```

<!-- => False -->

