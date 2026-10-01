---
Template: Symbol
Name: SullivanModelDifferential
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelDifferential
Keywords: [differential, derivation, Leibniz, Sullivan model]
SeeAlso: [SullivanModel, SullivanModelProduct, SullivanModelOrientation, HodgeTypeReport, DegenerateSubspace]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[SullivanModelDifferential]()[*e*, *model*]</code> gives the differential of the Sullivan model *model* applied to the element *e*.

<!-- #| annotation: 26.09.30: Design review - the model stores the differential on the generators only, the data a reader writes down, and this function extends it as a derivation with the Koszul signs of the declared order of the generators, each term a SullivanModelProduct, so that the truncations are applied. SullivanModel checks through this function that the differential squares to zero. Alternative name considered: ModelDifferential, the name until 2026-09-21, renamed because "Model" alone is generic. Prior art: the Wolfram Language has no differential graded algebras; the built-in D is a derivation of degree 0, with no signs. The engine the verification suites load extends the differential in the same way on monomials given as lists of generators, and the suites pin this function against it on every monomial of degree at most n+2 of the catalogue and of Kodaira-Thurston. -->

## Details & Options

- The differential is given on the generators and extended as a derivation of degree $1$:

$$\mathrm{d}(g_1\cdots g_k) = \sum_i (-1)^{\lvert g_1\rvert+\dots+\lvert g_{i-1}\rvert}\,g_1\cdots \mathrm{d}g_i\cdots g_k.$$

- It is linear, and it squares to zero.
- In a truncated model a term whose monomial lies above the truncation is $0$.
- An element that is not a polynomial in the generators returns unevaluated.

## Basic Examples

In the model of $\mathbb{CP}^2$ the differential of the generator of degree $5$ is $a^3$:

```wl
SullivanModelDifferential[b, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a^3 -->

---

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

The generator of degree $2$ is closed:

```wl
SullivanModelDifferential[a, model]
```

<!-- => 0 -->

On a product the differential acts as a derivation:

```wl
SullivanModelDifferential[a b, model]
```

<!-- => a^4 -->

On a power of $a$ times $b$:

```wl
SullivanModelDifferential[a^2 b, model]
```

<!-- => a^5 -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

The only generator that moves is $z$:

```wl
SullivanModelDifferential[z, model]
```

<!-- => x y -->

The differential of $xz$ is $-x\,xy = 0$:

```wl
SullivanModelDifferential[x z, model]
```

<!-- => 0 -->

The top monomial is closed:

```wl
SullivanModelDifferential[x y z, model]
```

<!-- => 0 -->

## Scope

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

The differential is linear:

```wl
SullivanModelDifferential[a + 3 b, model]
```

<!-- => 3 a^3 -->

Coefficients may be symbolic:

```wl
SullivanModelDifferential[t b, model]
```

<!-- => a^3 t -->

---

The model of the Kodaira-Thurston manifold:

```wl
model = SullivanModel["KodairaThurston"]
```

<!-- => a SullivanModel object with generators x, y, z, t of degree 1, of degree 4 -->

The differential of $zt$:

```wl
SullivanModelDifferential[z t, model]
```

<!-- => t x y -->

## Properties and Relations

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

The differential squares to zero:

```wl
SullivanModelDifferential[SullivanModelDifferential[z, model], model]
```

<!-- => 0 -->

The orientation kills its image, one of the conditions for an orientation:

```wl
(e |-> SullivanModelOrientation[SullivanModelDifferential[e, model], model]) /@ SullivanModelBasis[model, 2]
```

<!-- => {0, 0, 0} -->

## Possible Issues

The truncated model of Example 6.3 of arXiv:2004.07362:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, of degree 4, truncated above 4 -->

The differential of $a$ is $c$:

```wl
SullivanModelDifferential[a, model]
```

<!-- => c -->

The differential of $a^2$ would be $2ac$, of degree $5$, above the truncation, so it is $0$ and differs from that of the untruncated algebra:

```wl
SullivanModelDifferential[a^2, model]
```

<!-- => 0 -->

---

An element that is not a polynomial in the generators returns unevaluated:

```wl
SullivanModelDifferential[Sin[a], SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => the input, unevaluated -->
