---
Template: Symbol
Name: SullivanModelOrientation
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelOrientation
Keywords: [orientation, integration, Poincare duality degree]
SeeAlso: [SullivanModel, OrientationQ, SullivanModelPairing, SullivanModelProduct, SullivanModelDifferential, NondegenerateQuotient]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[SullivanModelOrientation]()[*e*, *model*]</code> gives the orientation of the Sullivan model *model* applied to the element *e*.

<!-- #| annotation: 26.09.30: Design review - the model keeps its orientation as values on the monomials of degree n, under the key "Orientation", so that an orientation may take other values than 1 and on several monomials, as the request of 2026-09-23 asked; this function expands e in monomials and weights each coefficient by its value. Alternative name considered: ModelOrientation, the name until 2026-09-21, renamed because "Model" alone is generic. Prior art: the Wolfram Language integrates functions with Integrate and has no algebraic orientation of a graded algebra. The engine the verification suites load orients a model by one volume monomial and reads its coefficient; the suites pin this function over the catalogue, where it kills the image of the differential and is 1 on the volume monomial, and through the pairing and the triple product of the nondegenerate quotient, which they compare with the engine's. -->

## Details & Options

- An orientation of degree $n$ on a cochain complex $(V,\mathrm{d})$ is a linear map $\mathcal{O}\colon V\to\mathbb{K}$ that vanishes outside degree $n$, satisfies $\mathcal{O}\circ\mathrm{d} = 0$, and induces a nonzero map on cohomology.
- The model stores the values of $\mathcal{O}$ on the monomials of degree $n$ under the key `"Orientation"`. [SullivanModelOrientation]() gives the sum of the coefficients of *e* on those monomials, weighted by their values.
- It is linear, and it is $0$ on every monomial that has no value.
- [SullivanModel]() checks with [OrientationQ]() that the values define an orientation when it builds a model.
- For the de Rham algebra of a closed oriented manifold $X$ the corresponding map is integration, $\omega\mapsto\int_X\omega$.
- A monomial is read in the order the model declares its generators, so a reordering carries no sign; the sign comes from [SullivanModelProduct]().
- An element that is not a polynomial in the generators returns unevaluated.

## Basic Examples

The orientation of the model of $\mathbb{CP}^2$ is $1$ on $a^2$:

```wl
SullivanModelOrientation[a^2, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => 1 -->

---

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

It is $0$ outside degree $4$:

```wl
SullivanModelOrientation[a^3, model]
```

<!-- => 0 -->

It is $0$ on $b$ as well:

```wl
SullivanModelOrientation[b, model]
```

<!-- => 0 -->

It is linear, so a coefficient comes out:

```wl
SullivanModelOrientation[3 a^2 + 5 b, model]
```

<!-- => 3 -->

## Scope

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

The orientation is $1$ on $xyz$:

```wl
SullivanModelOrientation[SullivanModelProduct[x, y, z, model], model]
```

<!-- => 1 -->

The sign of a reordering shows in the product:

```wl
SullivanModelOrientation[SullivanModelProduct[z, y, x, model], model]
```

<!-- => -1 -->

---

On $S^2\times S^2$ an orientation given by its value on $pr$:

```wl
square = SullivanModel[<|p -> 2, q -> 3, r -> 2, s -> 3|>, <|q -> p^2, s -> r^2|>, <|p r -> 3|>]
```

<!-- => a SullivanModel object with generators p, r of degree 2 and q, s of degree 3, of degree 4 -->

It is $3$ on $pr$:

```wl
SullivanModelOrientation[p r, square]
```

<!-- => 3 -->

It is $0$ on the boundaries $p^2$ and $r^2$:

```wl
SullivanModelOrientation[p^2 + r^2, square]
```

<!-- => 0 -->

---

Coefficients may be symbolic:

```wl
SullivanModelOrientation[t a^2, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => t -->

## Properties and Relations

The model of the Kodaira-Thurston manifold:

```wl
model = SullivanModel["KodairaThurston"]
```

<!-- => a SullivanModel object with generators x, y, z, t of degree 1, of degree 4 -->

The orientation kills the image of the differential:

```wl
Union[(e |-> SullivanModelOrientation[SullivanModelDifferential[e, model], model]) /@ SullivanModelBasis[model, 3]]
```

<!-- => {0} -->

---

The model of $\mathbb{CP}^3$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[3]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 7, of degree 6 -->

The pairing of $a$ and $a^2$:

```wl
SullivanModelPairing[a, a^2, model]
```

<!-- => 1 -->

It is the orientation of the product:

```wl
SullivanModelOrientation[SullivanModelProduct[a, a^2, model], model]
```

<!-- => 1 -->

---

The values of the orientation are the key `"Orientation"` of the model:

```wl
SullivanModel["ComplexProjectiveSpace"[3]]["Orientation"]
```

<!-- => <|a^3 -> 1|> -->

## Possible Issues

An element that is not a polynomial in the generators returns unevaluated:

```wl
SullivanModelOrientation[Sin[a], SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => the input, unevaluated -->
