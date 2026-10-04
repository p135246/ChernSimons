---
Template: Symbol
Name: NondegenerateQuotient
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/NondegenerateQuotient
Keywords: [nondegenerate quotient, Poincare duality algebra, dPD model, triple product]
SeeAlso: [DegenerateSubspace, HodgeTypeQ, GradedPairing, CyclicHochschildDifferential, CanonicalMaurerCartan, SullivanModel, HodgeExtension]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[NondegenerateQuotient]()[*model*]</code> gives the quotient of a [SullivanModel]() by its degenerate subspace, as a [PoincareDualityAlgebra]().

<code>[NondegenerateQuotient]()[*complex*]</code> gives the quotient of a [CochainComplexWithPairing]() by its degenerate subspace, as a [CochainComplexWithPairing]() with a perfect pairing.

<!-- #| annotation: 26.09.30: Design review - on a model the function gives a PoincareDualityAlgebra, the object GradedPairing reads an alphabet from and CanonicalMaurerCartan reads the triple product from, so the AlgebraicModels part hands the ChernSimons part one object and the dependency runs one way (R5c). On a complex it gives a complex, so that the functions of the Hodge layer compose: the quotient of the complex of a model is the complex of the quotient of the model, identically, which T17 pins on the fourteen catalogue models. The representatives are monomials, the first monomials of each degree whose rows of the pairing matrix are independent, not an orthogonalized basis, so the letters of the alphabet are monomials of the model. The quotient is taken whether or not the space is of Hodge type; HodgeTypeQ decides whether it is still a model of the space. Its row of the names doc was left untouched in R5g, and no alternative was recorded. Prior art: the Wolfram Language has no quotient of a graded algebra by the radical of a pairing. The engine of the verification suites computes the same quotient, and T17 pins every key but the basis against it, and the basis as monomials, on the thirteen catalogue models and the Kodaira-Thurston model. -->

## Details & Options

- For a model, the result is a [PoincareDualityAlgebra]() object, read with *quotient*[*key*] and [Normal](). It has the following keys:

| Key | Value |
|---|---|
| `"Degree"` | the Poincaré duality degree $n$ |
| `"Basis"` | monomial representatives, in nondecreasing degree |
| `"Degrees"` | their degrees |
| `"Pairing"` | the Gram matrix $\mathcal{O}(e_ie_j)$, invertible |
| `"DifferentialPairing"` | the nonzero values of $\langle \mathrm{d}e_i,e_j\rangle$, on index pairs |
| `"Differential"` | the matrix of the induced differential in the basis |
| `"Triple"` | the nonzero values of $\mathcal{O}(e_ie_je_k)$, on index triples |
| `"Model"` | the model it came from |

- The representatives of degree $k$ are the first monomials of degree $k$ whose rows of the pairing matrix against degree $n-k$ are independent.
- The quotient is nonzero only in degrees $0$ to $n$, and the pairing on it is perfect, so it is a differential Poincaré duality algebra.
- When the model is of Hodge type the quotient map is a quasi-isomorphism, and the quotient is then a differential Poincaré duality model of the model; see [HodgeTypeQ]().
- The triple products are well defined on the quotient because the degenerate subspace is an ideal for the pairing. [CanonicalMaurerCartan]() is built from them.
- [GradedPairing]() attaches the quotient to the alphabet as its `"Algebra"` key, and [CyclicHochschildDifferential]() reads the matrix of the differential from there, the operation $\mathfrak{q}_{1,1,0}$.
- For a complex, the result is a [CochainComplexWithPairing]() on representative basis elements. It keeps the pairing, gives the differential of each element as its class in the quotient, and keeps the product when the complex has one.
- The quotient is taken whether or not the space is of Hodge type.

## Basic Examples

The quotient of the model of $\mathbb{CP}^2$:

```wl
quotient = NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, a, a^2, of degree 4 -->

It is the cohomology ring, with basis:

```wl
quotient["Basis"]
```

<!-- => {1, a, a^2} -->

The degrees of the basis:

```wl
quotient["Degrees"]
```

<!-- => {0, 2, 4} -->

The pairing is the antidiagonal:

```wl
MatrixForm[quotient["Pairing"]]
```

<!-- => MatrixForm[{{0, 0, 1}, {0, 1, 0}, {1, 0, 0}}] -->

The differential is zero:

```wl
quotient["Differential"]
```

<!-- => {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}} -->

The triple products, one per index triple with a nonzero value:

```wl
Normal[quotient["Triple"]]
```

<!-- => {{1, 1, 3} -> 1, {1, 2, 2} -> 1, {1, 3, 1} -> 1, {2, 1, 2} -> 1, {2, 2, 1} -> 1, {3, 1, 1} -> 1} -->

## Scope

The minimal model of $S^4$ is infinite-dimensional; its quotient is two-dimensional:

```wl
quotient = NondegenerateQuotient[SullivanModel["Sphere"[4]]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, v, of degree 4 -->

Its basis:

```wl
quotient["Basis"]
```

<!-- => {1, v} -->

The degrees of the basis:

```wl
quotient["Degrees"]
```

<!-- => {0, 4} -->

Its Poincaré duality degree:

```wl
quotient["Degree"]
```

<!-- => 4 -->

---

The quotient of a nilmanifold model:

```wl
quotient = NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, z, y, x, y z, x z, x y, x y z, of degree 3 -->

Its basis, where $z$ is the second vector and $xy$ the seventh:

```wl
quotient["Basis"]
```

<!-- => {1, z, y, x, y z, x z, x y, x y z} -->

The quotient carries a nonzero differential, $\mathrm{d}z = xy$, the model not being formal. Its one nonzero pairing is $\langle \mathrm{d}z, z\rangle = 1$:

```wl
Normal[quotient["DifferentialPairing"]]
```

<!-- => {{2, 2} -> 1} -->

---

The quotient of the complex of the model of $\mathbb{CP}^2$:

```wl
quotient = NondegenerateQuotient[CochainComplexWithPairing[SullivanModel["ComplexProjectiveSpace"[2]]]]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 2: 1, 4: 1, of degree 4, with a product -->

It keeps the basis elements up to degree $4$:

```wl
quotient["Degrees"]
```

<!-- => <|1 -> 0, a -> 2, a^2 -> 4|> -->

Its pairing is perfect:

```wl
PerfectPairingQ[quotient]
```

<!-- => True -->

## Properties and Relations

The alphabet of the quotient of $\mathbb{CP}^2$:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]]
```

<!-- => a GradedPairing object with letters 1, a and a^2, of pairing degree 2 -->

The degrees of the letters are shifted:

```wl
Normal[pairing["Degrees"]]
```

<!-- => {1 -> -1, a -> 1, a^2 -> 3} -->

The canonical Maurer-Cartan element follows from the triple products:

```wl
CanonicalMaurerCartan[pairing][{1, 0}]
```

<!-- => -CyclicWord[{1, 1, a^2}] - CyclicWord[{1, a, a}] -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1 and dz = x y, of degree 3 -->

The quotient of its complex is the complex of its quotient:

```wl
NondegenerateQuotient[CochainComplexWithPairing[model]] === CochainComplexWithPairing[NondegenerateQuotient[model]]
```

<!-- => True -->

## Possible Issues

The degree-$4$ obstruction:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, dc = 0 and da = c, of degree 4, truncated above degree 4 -->

It is not of Hodge type:

```wl
HodgeTypeQ[model]
```

<!-- => False -->

The quotient is still taken, and is still a Poincaré duality algebra. It is the cohomology of $\mathbb{CP}^2$:

```wl
NondegenerateQuotient[model]["Basis"]
```

<!-- => {1, a, a^2} -->

The model has the cohomology of $S^4$, so the quotient is not quasi-isomorphic to it:

```wl
Total[Values[HodgeTypeReport[model][All, "Cohomology"]]]
```

<!-- => 2 -->
