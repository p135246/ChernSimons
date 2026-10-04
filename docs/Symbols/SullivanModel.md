---
Template: Symbol
Name: SullivanModel
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModel
Keywords: [Sullivan model, minimal model, free graded commutative algebra, orientation, oriented PDGA, truncation]
SeeAlso: [$SullivanModels, SullivanModelBasis, SullivanModelProduct, SullivanModelDifferential, SullivanModelOrientation, OrientationQ, PoincareDualityQ, HodgeTypeQ, NondegenerateQuotient]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[SullivanModel]()[*name*]</code> gives the Sullivan model *name* of the catalogue [$SullivanModels](), with its orientation.

<code>[SullivanModel]()[*name*, *generators*]</code> gives the same model on the list of symbols *generators*.

<code>[SullivanModel]()[*degrees*, *differential*, *orientation*]</code> gives the Sullivan model whose generators have the degrees *degrees*, with the differential *differential* on the generators and the orientation *orientation*.

<code>[SullivanModel]()[*degrees*, *differential*, *orientation*, *truncation*]</code> gives its quotient by the monomials above degree *truncation*.

<code>[SullivanModel]()[{$model_1$, $model_2$, …}]</code> gives the tensor product of the models.

<!-- #| annotation: 26.09.30: Design review - a model is a tagged SullivanModel object wrapping an Association with the keys "Generators", "Differential", "Orientation", "Degree" and "Truncation", so that SullivanModelQ recognizes it and it prints as a summary box, while the upvalues for Normal, Keys and Lookup keep it readable as the Association it wraps (T0b, 2026-09-21). The constructor takes the data a reader writes down for a model: an Association of generators to degrees, the differential on the generators as polynomials, and an orientation given either as one monomial or as values on the monomials of degree n, the second form coming from the request of 2026-09-23 that introduced the orientation. Data of the wrong shape returns unevaluated; data of the right shape that fails the mathematics, a differential that does not raise the degree by one or does not square to zero or values that are not an orientation, gives a Failure without a message (H1, 2026-09-24); no alternative was recorded. A truncation is kept as a group of generators with a degree, so that a tensor product keeps the truncation of each factor, and the generator symbols of a catalogue model can be chosen so that two models can be tensored. Prior art: the Wolfram Language has no Sullivan models and no differential graded algebras; GrassmannAlgebra is the exterior algebra on its generators, the case in which every generator has odd degree and the differential is zero. The engine the verification suites load builds the same nine catalogue models as plain Associations, with the orientation as one volume monomial, and the suites pin the basis, the product and the differential of this object against it on the catalogue and on Kodaira-Thurston. -->

## Details & Options

- The result is a SullivanModel object, displayed as a summary box. Its data is read with *model*[*key*] and [Normal]():

| Key | Value |
|---|---|
| `"Generators"` | the *degrees* Association, each degree at least $1$ |
| `"Differential"` | the image of each generator, as a polynomial in the generators |
| `"Orientation"` | the nonzero values of the orientation, on monomials of degree $n$ |
| `"Degree"` | the degree $n$ of the orientation, the Poincaré duality degree |
| `"Truncation"` | groups of generators with the degree above which their part of a monomial vanishes; empty when nothing is truncated |

- The underlying algebra is the free graded commutative algebra on the generators: a generator of even degree is polynomial, and one of odd degree squares to zero.
- A monomial is written as a product of generators and is read in the order the model declares them, so `x y` and `y x` are the same expression and denote the same monomial. The sign of a reordering is produced by [SullivanModelProduct](), not by the way a monomial is typed.
- *orientation* is either a monomial of degree $n$, meaning the functional that is $1$ on it and $0$ on the other monomials of degree $n$, or an Association of numeric values on monomials of degree $n$. Zero values are dropped.
- The orientation must be one in the sense of [OrientationQ](): it vanishes on the image of the differential and is nonzero on some cocycle of degree $n$.
- The result is a [Failure]() when the differential does not raise the degree by one or does not square to zero, and when the values do not define an orientation.
- The default generator symbols are created in the current context: `v` for the circle, `a` and `b` for a projective space, `x`, `y` and `z` for the Heisenberg nilmanifold, and so on. *generators* chooses them, which is also how a collision is avoided when two models are tensored.
- *truncation* is an integer, or [Infinity]() for no truncation, the default. The monomials above any degree span a differential graded ideal, since the differential raises the degree by one, so the quotient is again a differential graded algebra.
- In a tensor product the generators of the factors must be disjoint. The differentials and the truncations are joined, the orientations multiplied and the degrees added; each truncation stays with the generators of its factor.
- Input of another shape returns unevaluated: a generator of degree $0$, a differential that is not a polynomial in the generators, a non-numeric orientation value, a tensor product whose factors share a generator, a catalogue parameter out of range.

## Basic Examples

The model of $\mathbb{CP}^2$, with a generator of degree $2$ and one of degree $5$ whose differential is its cube:

```wl
SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

The same model, bound to a name:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

Its generators with their degrees:

```wl
model["Generators"]
```

<!-- => <|a -> 2, b -> 5|> -->

The differential on the generators:

```wl
model["Differential"]
```

<!-- => <|a -> 0, b -> a^3|> -->

The orientation, $1$ on $a^2$:

```wl
model["Orientation"]
```

<!-- => <|a^2 -> 1|> -->

The degree it fixes:

```wl
model["Degree"]
```

<!-- => 4 -->

## Scope

The same model on generators named `u` and `w`:

```wl
SullivanModel["ComplexProjectiveSpace"[2], {u, w}]["Generators"]
```

<!-- => <|u -> 2, w -> 5|> -->

---

The model of $\mathbb{CP}^2$ built by hand:

```wl
own = SullivanModel[<|u -> 2, w -> 5|>, <|w -> u^3|>, u^2]
```

<!-- => a SullivanModel object with generators u of degree 2 and w of degree 5, of degree 4 -->

Its degree:

```wl
own["Degree"]
```

<!-- => 4 -->

Its nondegenerate quotient is the cohomology $\mathbb{K}[u]/(u^3)$:

```wl
NondegenerateQuotient[own]["Basis"]
```

<!-- => {1, u, u^2} -->

---

On $S^2\times S^2$ the monomials of degree $4$ are $p^2$, $pr$ and $r^2$, and an orientation may take any nonzero value on $pr$:

```wl
square = SullivanModel[<|p -> 2, q -> 3, r -> 2, s -> 3|>, <|q -> p^2, s -> r^2|>, <|p r -> 3|>]
```

<!-- => a SullivanModel object with generators p, r of degree 2 and q, s of degree 3, of degree 4 -->

The orientation is kept as its values:

```wl
square["Orientation"]
```

<!-- => <|p r -> 3|> -->

It is the pairing of $p$ and $r$:

```wl
SullivanModelPairing[p, r, square]
```

<!-- => 3 -->

---

A tensor product of $S^2$ and $S^3$, with the generators named so that they are disjoint:

```wl
product = SullivanModel[{SullivanModel["Sphere"[2], {p, q}], SullivanModel["Sphere"[3], {r}]}]
```

<!-- => a SullivanModel object with generators p of degree 2 and q, r of degree 3, of degree 5 -->

Its generators:

```wl
product["Generators"]
```

<!-- => <|p -> 2, q -> 3, r -> 3|> -->

The orientation is the product of the orientations:

```wl
product["Orientation"]
```

<!-- => <|p r -> 1|> -->

The degree is the sum of the degrees:

```wl
product["Degree"]
```

<!-- => 5 -->

---

The truncated polynomial algebra $\mathbb{K}[u]/(u^3)$ with $\lvert u\rvert = 2$, the cohomology of $\mathbb{CP}^2$, as a model with zero differential:

```wl
truncated = SullivanModel[<|u -> 2|>, <||>, u^2, 4]
```

<!-- => a SullivanModel object with generator u of degree 2, of degree 4, truncated above 4 -->

Its monomials stop at degree $4$:

```wl
Table[SullivanModelBasis[truncated, k], {k, 0, 6}]
```

<!-- => {{1}, {}, {u}, {}, {u^2}, {}, {}} -->

---

The truncated model of Example 6.3 of arXiv:2004.07362, tensored with the circle:

```wl
product = SullivanModel[{SullivanModel["Degree4Obstruction"], SullivanModel["Circle", {v}]}]
```

<!-- => a SullivanModel object with generators a of degree 2, c of degree 3 and v of degree 1, of degree 5, with a and c truncated above 4 -->

The truncation stays with its factor:

```wl
product["Truncation"]
```

<!-- => <|{a, c} -> 4|> -->

The product has degree $5$:

```wl
product["Degree"]
```

<!-- => 5 -->

Its monomial of degree $5$ is the orientation:

```wl
SullivanModelBasis[product, 5]
```

<!-- => {a^2 v} -->

## Properties and Relations

The model of $S^4$:

```wl
model = SullivanModel["Sphere"[4]]
```

<!-- => a SullivanModel object with generators v of degree 4 and w of degree 7, of degree 4 -->

It is of Hodge type:

```wl
HodgeTypeQ[model]
```

<!-- => True -->

Its nondegenerate quotient gives the alphabet of the sphere:

```wl
pairing = GradedPairing[NondegenerateQuotient[model]]
```

<!-- => a GradedPairing object with letters 1 of degree -1 and v of degree 3, of pairing degree 2 -->

The canonical Maurer-Cartan element of that alphabet, in weight $(1, 0)$:

```wl
CanonicalMaurerCartan[pairing][{1, 0}]
```

<!-- => -CyclicWord[{1, 1, v}] -->

---

A model is recognized by [SullivanModelQ]():

```wl
SullivanModelQ[SullivanModel["Circle"]]
```

<!-- => True -->

---

[Normal]() gives the Association the object wraps:

```wl
Normal[SullivanModel["Circle"]]
```

<!-- => <|"Generators" -> <|v -> 1|>, "Differential" -> <|v -> 0|>, "Orientation" -> <|v -> 1|>, "Degree" -> 1, "Truncation" -> <||>|> -->

## Possible Issues

Not every monomial of top degree is an orientation. Here $\mathrm{d}a = b$, so the functional that is $1$ on $b$ does not vanish on the image of the differential; the result is a [Failure](), whose message says so:

```wl
SullivanModel[<|a -> 1, b -> 2|>, <|a -> b|>, b]["Message"]
```

<!-- => "The values do not define an orientation." -->

---

A differential that does not raise the degree by one gives a [Failure]() too:

```wl
SullivanModel[<|u -> 2|>, <|u -> u|>, u]["Message"]
```

<!-- => "The differential does not raise the degree by one or does not square to zero." -->

---

Two catalogue models on the same default generators have no tensor product, and the input returns unevaluated:

```wl
SullivanModel[{SullivanModel["Circle"], SullivanModel["Circle"]}]
```

<!-- => the input, unevaluated -->

---

A catalogue parameter out of range returns unevaluated:

```wl
SullivanModel["Sphere"[0]]
```

<!-- => SullivanModel["Sphere"[0]] -->
