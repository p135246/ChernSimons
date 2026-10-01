---
Template: Symbol
Name: FindHarmonicSubspace
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/FindHarmonicSubspace
Keywords: [harmonic subspace, cocycles, cohomology, Hodge decomposition, pre-Hodge decomposition, discrete harmonic]
SeeAlso: [FindPreHodgeDecomposition, FindHodgeDecomposition, PreHodgeDecomposition, DegenerateSubspace, SullivanModelBasis, HodgeTypeReport]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[FindHarmonicSubspace]()[*space*]</code> finds a harmonic subspace of a [SullivanModel]() or a [CochainComplexWithPairing](), a complement of the image of the differential in the cocycles, as an Association from degrees to bases.

<code>[FindHarmonicSubspace]()[*space*, *k*]</code> gives the basis of degree *k* of that subspace.

<!-- #| annotation: 26.09.30: Design review - design 4 of the names doc (R5g), which Pavel asked for on 2026-09-30 ("we should be also able to find a harmonic subspace in some canonical way") and left to the session. The subspace is found, not constructed: as with FindRoot, the answer is one of many, so the name says Find and the Method says which one. "BasisOrder", the default, is the rule of the former export: it keeps monomials as representatives and every value the suite pinned before. "Adjoint" is the choice free of the order of the basis that canonical can also mean, the kernel of d intersected with the kernel of its transpose in the monomial basis, at the price of representatives that are sums of monomials. The result is an Association from the degrees of the complex to bases, the shape FindPreHodgeDecomposition and FindHodgeDecomposition take as their second argument, so either rule reaches the decompositions without their taking a Method. For a model the computation runs on the complex of the model, which agrees with it up to degree n+1. Alternative name considered: HarmonicSubspace, the export until 2026-09-30. Prior art: the Wolfram Language has no harmonic subspace of a cochain complex; NullSpace and MatrixRank are the linear algebra it rests on. The engine of the verification suites has no counterpart; T17 pins the default rule on the catalogue and the adjoint rule as a complement of im d with the Betti dimensions, unchanged when the basis is listed backwards. -->

## Details & Options

- A harmonic subspace $\mathcal{H}$ is a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$, so that $\mathcal{H}^k$ maps isomorphically onto $H^k$ in each degree. There are many, and the method says which one is found.
- The Association has one key per degree of the complex, and its value is a basis of $\mathcal{H}^k$, a list of linear combinations of basis elements.
- For a model the computation runs on <code>[CochainComplexWithPairing]()[*model*]</code>, which agrees with the model up to degree $n+1$. The keys are the degrees of that complex.
- [FindHarmonicSubspace]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>[Method]()</code> | <code>"BasisOrder"</code> | the rule that picks the subspace |

- The possible settings for [Method]() are:

| Method | Subspace |
|---|---|
| `"BasisOrder"` | the first cocycles, closed basis elements first, that are independent modulo $\mathrm{im}\,\mathrm{d}$ |
| `"Adjoint"` | $\ker\mathrm{d}\cap\ker\mathrm{d}^{\mathsf T}$, with $\mathrm{d}^{\mathsf T}$ the transpose of $\mathrm{d}$ in the basis |

- The rule `"BasisOrder"` depends on the order of the basis, and it keeps basis elements as representatives where it can.
- The rule `"Adjoint"` takes the orthogonal complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$ for the inner product in which the basis is orthonormal, the discrete harmonic elements. That subspace does not depend on the order of the basis, but its elements may be sums of basis elements.
- Any other setting of [Method]() returns unevaluated.

## Basic Examples

The model of $\mathbb{CP}^2$ has its cohomology in degrees $0$, $2$ and $4$:

```wl
FindHarmonicSubspace[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => <|0 -> {1}, 2 -> {a}, 4 -> {a^2}, 5 -> {}, 6 -> {}|> -->

---

In the Heisenberg nilmanifold $xy = \mathrm{d}z$ is exact, so the harmonic subspace of degree $2$ is spanned by the two other monomials:

```wl
FindHarmonicSubspace[SullivanModel["HeisenbergNilmanifold"], 2]
```

<!-- => {y z, x z} -->

## Scope

A complex given by its data, Example 6.1 of arXiv:2004.07362, has cohomology in degrees $0$ and $4$ only:

```wl
FindHarmonicSubspace[CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]]
```

<!-- => <|0 -> {1}, 1 -> {}, 2 -> {}, 3 -> {}, 4 -> {v}|> -->

---

One degree of a complex:

```wl
FindHarmonicSubspace[CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>], 4]
```

<!-- => {v} -->

## Options

### Method

A complex with $\mathrm{d}e = p + q$, so that $p$ and $q$ are cohomologous:

```wl
complex = CochainComplexWithPairing[<|e -> 0, p -> 1, q -> 1, w -> 2|>, <|e -> p + q|>, <|{e, w} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 2, 2: 1, of degree 2 -->

The default takes the one listed first:

```wl
FindHarmonicSubspace[complex, 1]
```

<!-- => {p} -->

The adjoint rule takes the element orthogonal to $p + q$:

```wl
FindHarmonicSubspace[complex, 1, Method -> "Adjoint"]
```

<!-- => {-p + q} -->

---

The same complex with the basis listed the other way round:

```wl
reversed = CochainComplexWithPairing[<|w -> 2, q -> 1, p -> 1, e -> 0|>, <|e -> p + q|>, <|{e, w} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 2, 2: 1, of degree 2 -->

The default choice changes:

```wl
FindHarmonicSubspace[reversed, 1]
```

<!-- => {q} -->

The adjoint choice does not, up to a scalar:

```wl
FindHarmonicSubspace[reversed, 1, Method -> "Adjoint"]
```

<!-- => {p - q} -->

## Properties and Relations

The model of the Kodaira-Thurston nilmanifold:

```wl
model = SullivanModel["KodairaThurston"]
```

<!-- => a SullivanModel object with generators x, y, z, t of degree 1 and dz = x y, of degree 4 -->

The dimensions of the harmonic subspace in degrees $0$ to $4$:

```wl
Length /@ Values[KeyTake[FindHarmonicSubspace[model], Range[0, 4]]]
```

<!-- => {1, 3, 4, 3, 1} -->

They are the Betti numbers:

```wl
Lookup[Normal[HodgeTypeReport[model][All, "Cohomology"]], Range[0, 4]]
```

<!-- => {1, 3, 4, 3, 1} -->

It is the harmonic subspace of the decompositions found from the space:

```wl
FindHodgeDecomposition[model]["Harmonic"] === FindHarmonicSubspace[model]
```

<!-- => True -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1 and dz = x y, of degree 3 -->

Its adjoint harmonic subspace:

```wl
FindHarmonicSubspace[model, Method -> "Adjoint"]
```

<!-- => <|0 -> {1}, 1 -> {x, y}, 2 -> {x z, y z}, 3 -> {x y z}|> -->

Either choice can be handed to [FindPreHodgeDecomposition]() and [FindHodgeDecomposition]():

```wl
FindHodgeDecomposition[model, FindHarmonicSubspace[model, Method -> "Adjoint"]]["Harmonic"]
```

<!-- => <|0 -> {1}, 1 -> {x, y}, 2 -> {x z, y z}, 3 -> {x y z}|> -->

## Possible Issues

For a model the subspace is that of its complex, which stops at degree $n+2$. Further up the basis is empty:

```wl
FindHarmonicSubspace[SullivanModel["ComplexProjectiveSpace"[2]], 8]
```

<!-- => {} -->

---

An unknown method returns unevaluated:

```wl
FindHarmonicSubspace[CochainComplexWithPairing[<|e -> 0, p -> 1, q -> 1, w -> 2|>, <|e -> p + q|>, <|{e, w} -> 1|>], Method -> "Orthogonal"]
```

<!-- => the expression returns unevaluated -->
