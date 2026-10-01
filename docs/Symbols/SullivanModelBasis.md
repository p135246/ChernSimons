---
Template: Symbol
Name: SullivanModelBasis
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelBasis
Keywords: [basis, monomials, graded, degree]
SeeAlso: [SullivanModel, SullivanModelProduct, SullivanModelDifferential, DegenerateSubspace]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[SullivanModelBasis]()[*model*, *k*]</code> gives the monomials of degree *k* of the Sullivan model *model*.

<code>[SullivanModelBasis]()[*complex*, *k*]</code> gives the basis elements of degree *k* of the [CochainComplexWithPairing]() *complex*.

<!-- #| annotation: 26.09.30: Design review - the basis is a list of monomials, each a product of generators, because the elements every function of the model takes are polynomials in the generators; since Times is orderless a monomial has one spelling, and a sign arises only in SullivanModelProduct. The second argument is one degree, so an untruncated model with a generator of even degree, which is infinite-dimensional, still has a finite basis in each degree. The same name gives the basis of a CochainComplexWithPairing, whose basis elements are monomials too. Alternative name considered: ModelBasis, the name until 2026-09-21, renamed because "Model" alone is generic. Prior art: the exponent vectors of the monomials of degree k are the solutions of a Frobenius equation, which the built-in FrobeniusSolve enumerates, and the function keeps those allowed by the odd generators and the truncations. The engine the verification suites load lists the same monomials as lists of generators, and the suites pin this function against it in degrees 0 to n+2 on the catalogue and on Kodaira-Thurston. -->

## Details & Options

- Each monomial is written as a product of generators, in the order the model declares them. The empty monomial is `1`.
- A generator of odd degree occurs at most once in a monomial, and one of even degree any number of times.
- A monomial whose part in a truncated group of generators lies above the degree of the truncation is left out.
- The monomials are listed in increasing order of their exponent vectors.
- The list is empty in a negative degree.
- A model whose generators of even degree are all truncated has finitely many monomials. Otherwise there are monomials in infinitely many degrees.
- For a complex, the basis elements of degree *k* are listed in the order of the complex.

## Basic Examples

The monomials of degree $4$ in the model of $\mathbb{CP}^2$:

```wl
SullivanModelBasis[SullivanModel["ComplexProjectiveSpace"[2]], 4]
```

<!-- => {a^2} -->

---

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

It has one monomial in every even degree, and from degree $5$ on also one in every odd degree, coming from $b$:

```wl
Table[SullivanModelBasis[model, k], {k, 0, 8}]
```

<!-- => {{1}, {}, {a}, {}, {a^2}, {b}, {a^3}, {a b}, {a^4}} -->

---

The monomials of degree $2$ of the three-torus:

```wl
SullivanModelBasis[SullivanModel["Torus"[3]], 2]
```

<!-- => {v2 v3, v1 v3, v1 v2} -->

---

The model of the three-torus:

```wl
model = SullivanModel["Torus"[3]]
```

<!-- => a SullivanModel object with generators v1, v2, v3 of degree 1, of degree 3 -->

It is the exterior algebra, finite-dimensional, with the binomial dimensions:

```wl
Table[SullivanModelBasis[model, k], {k, 0, 4}]
```

<!-- => {{1}, {v3, v2, v1}, {v2 v3, v1 v3, v1 v2}, {v1 v2 v3}, {}} -->

## Scope

The model of $S^4$:

```wl
model = SullivanModel["Sphere"[4]]
```

<!-- => a SullivanModel object with generators v of degree 4 and w of degree 7, of degree 4 -->

Its generators sit in degrees $4$ and $7$:

```wl
Table[SullivanModelBasis[model, k], {k, 0, 8}]
```

<!-- => {{1}, {}, {}, {}, {v}, {}, {}, {w}, {v^2}} -->

---

The truncated model of Example 6.3 of arXiv:2004.07362:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, of degree 4, truncated above 4 -->

Its monomials stop above degree $4$:

```wl
Table[SullivanModelBasis[model, k], {k, 0, 6}]
```

<!-- => {{1}, {}, {a}, {c}, {a^2}, {}, {}} -->

---

The complex of the model of $\mathbb{CP}^2$:

```wl
complex = CochainComplexWithPairing[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a CochainComplexWithPairing object of degree 4 -->

Its basis stops above degree $6$:

```wl
Table[SullivanModelBasis[complex, k], {k, 0, 7}]
```

<!-- => {{1}, {}, {a}, {}, {a^2}, {b}, {a^3}, {}} -->

---

A complex built from its basis, its product and its orientation:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, u -> 1, w -> 1|>, <||>, <||>, u]
```

<!-- => a CochainComplexWithPairing object of degree 1 -->

Its basis in degree $1$:

```wl
SullivanModelBasis[complex, 1]
```

<!-- => {u, w} -->

## Properties and Relations

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

The dimensions of its degrees:

```wl
Table[Length[SullivanModelBasis[model, k]], {k, 0, 7}]
```

<!-- => {1, 0, 1, 0, 1, 1, 1, 1} -->

They are the column `"Dimension"` of [HodgeTypeReport]():

```wl
Normal[HodgeTypeReport[model][All, "Dimension"]]
```

<!-- => <|0 -> 1, 1 -> 0, 2 -> 1, 3 -> 0, 4 -> 1, 5 -> 1, 6 -> 1, 7 -> 1|> -->

## Possible Issues

The list is empty in a negative degree:

```wl
SullivanModelBasis[SullivanModel["ComplexProjectiveSpace"[2]], -1]
```

<!-- => {} -->

---

The list follows the order of the exponent vectors, which reverses the order in which the generators are declared:

```wl
SullivanModelBasis[SullivanModel["Torus"[3]], 1]
```

<!-- => {v3, v2, v1} -->
