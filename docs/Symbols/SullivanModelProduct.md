---
Template: Symbol
Name: SullivanModelProduct
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelProduct
Keywords: [product, graded commutative, Koszul sign, truncation]
SeeAlso: [SullivanModel, SullivanModelBasis, SullivanModelDifferential, SullivanModelPairing, SullivanModelOrientation]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[SullivanModelProduct]()[$e_1$, $e_2$, …, *model*]</code> gives the graded commutative product of the elements $e_1$, $e_2$, … of the Sullivan model *model*.

<!-- #| annotation: 26.09.30: Design review - an element is a polynomial in the generators, and a monomial is read in the order the model declares its generators, because Times is orderless: x y and y x are one expression, so the sign of the graded commutative product can only come from the order of the arguments. The product takes any number of elements before the model and applies the truncations, so a product never leaves a truncated model. Alternative name considered: ModelProduct, the name until 2026-09-21, renamed because "Model" alone is generic. Prior art: the Wolfram Language multiplies polynomials with Times, which is commutative, and GrassmannAlgebra is the exterior algebra on its generators; neither has generators of both parities or a truncation. The engine the verification suites load multiplies monomials given as lists of generators by a bubble sort with Koszul signs, and the suites pin this function against it on every pair of monomials of degree at most 4 of the catalogue and of Kodaira-Thurston. -->

## Details & Options

- The product is graded commutative: $e_1e_2 = (-1)^{\lvert e_1\rvert\lvert e_2\rvert}e_2e_1$ for homogeneous elements, and a generator of odd degree squares to zero.
- An element is a polynomial in the generators, a linear combination of monomials, and the product is linear in each argument.
- A monomial written as a product of generators is read in the order the model declares them, so the order of the arguments carries the sign, not the way a monomial is typed.
- A monomial of the product whose part in a truncated group of generators lies above the degree of the truncation is $0$.
- With more than two elements the product is taken from the left. A single element gives the element itself, expanded and truncated.
- An argument that is not a polynomial in the generators returns unevaluated.

## Basic Examples

Two generators of degree $1$ of the Heisenberg nilmanifold, multiplied:

```wl
SullivanModelProduct[x, y, SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => x y -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

The two generators anticommute:

```wl
SullivanModelProduct[y, x, model]
```

<!-- => -x y -->

An odd generator squares to zero:

```wl
SullivanModelProduct[x, x, model]
```

<!-- => 0 -->

The product of three generators:

```wl
SullivanModelProduct[x, y, z, model]
```

<!-- => x y z -->

In the reverse order it changes sign:

```wl
SullivanModelProduct[z, y, x, model]
```

<!-- => -x y z -->

## Scope

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

An even generator is polynomial, and the model is not truncated, so its powers keep going:

```wl
SullivanModelProduct[a^2, a^3, model]
```

<!-- => a^5 -->

The product is linear in each argument:

```wl
SullivanModelProduct[a + b, a - b, model]
```

<!-- => a^2 -->

Coefficients may be symbolic:

```wl
SullivanModelProduct[s a, t b, model]
```

<!-- => a b s t -->

---

The truncated model of Example 6.3 of arXiv:2004.07362:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, of degree 4, truncated above 4 -->

The square of $a$ has degree $4$:

```wl
SullivanModelProduct[a, a, model]
```

<!-- => a^2 -->

The cube lies above the truncation and is $0$:

```wl
SullivanModelProduct[a, a, a, model]
```

<!-- => 0 -->

---

A single element gives itself:

```wl
SullivanModelProduct[3 a + b, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => 3 a + b -->

## Properties and Relations

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

The differential of the product $ab$:

```wl
SullivanModelDifferential[SullivanModelProduct[a, b, model], model]
```

<!-- => a^4 -->

The Leibniz rule gives the same, with the sign $(-1)^{\lvert a\rvert} = 1$:

```wl
SullivanModelProduct[SullivanModelDifferential[a, model], b, model] + (-1)^2 SullivanModelProduct[a, SullivanModelDifferential[b, model], model]
```

<!-- => a^4 -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

The pairing of $x$ and $yz$:

```wl
SullivanModelPairing[x, y z, model]
```

<!-- => 1 -->

It is the orientation of the product:

```wl
SullivanModelOrientation[SullivanModelProduct[x, y z, model], model]
```

<!-- => 1 -->

## Possible Issues

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

A monomial typed as `y x` is the expression `x y`, so it carries no sign:

```wl
SullivanModelProduct[y x, model]
```

<!-- => x y -->

The sign comes from the order of the arguments:

```wl
SullivanModelProduct[y, x, model]
```

<!-- => -x y -->

---

An argument that is not a polynomial in the generators returns unevaluated:

```wl
SullivanModelProduct[Sin[a], a, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => the input, unevaluated -->
