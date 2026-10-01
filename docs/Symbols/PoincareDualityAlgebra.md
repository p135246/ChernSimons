---
Template: Symbol
Name: PoincareDualityAlgebra
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/PoincareDualityAlgebra
Keywords: [Poincare duality algebra, nondegenerate quotient, Gram matrix, triple product]
SeeAlso: [NondegenerateQuotient, PoincareDualityAlgebraQ, CochainComplexWithPairing, PerfectPairingQ, GradedPairing, HodgeTypeQ, CanonicalMaurerCartan]
RelatedGuides: [HodgeDecompositions, BeilinsonDrinfeldFormalism]
---

## Usage

<code>[PoincareDualityAlgebra]()[*complex*]</code> gives the finite-dimensional Poincaré duality algebra of a [CochainComplexWithPairing]() that carries a product and has a perfect pairing.

<code>[PoincareDualityAlgebra]()[*data*]</code> is a finite-dimensional Poincaré duality algebra given by an Association *data* of its basis, degrees, Gram matrix, differential and triple products, the object [NondegenerateQuotient]() gives.

<!-- #| annotation: 26.09.30: Design review - the algebra is the object the AlgebraicModels part hands to the ChernSimons part: GradedPairing[algebra] reads the alphabet off it, and CanonicalMaurerCartan reads the canonical element off its triple product, so the dependency runs one way (R5c). It is built from data by PoincareDualityAlgebra[complex], from a CochainComplexWithPairing with a product, and not by a new constructor from degrees, Gram matrix and product, which an earlier report proposed: the four-argument CochainComplexWithPairing already takes that data and validates it, and the conversion is the inverse of CochainComplexWithPairing[algebra], so no new data shape enters the API (R3, kept by Pavel). A pairing that is not perfect gives a Failure, and a complex without a product returns unevaluated, since it has no triple product. The usage message sits beside the constructor from a complex since R5b. Prior art: the Wolfram Language has no Poincare duality algebras. T17 pins the two conversions as inverse to each other, and the algebra of the quotient of the complex of a model as the quotient of the model, on the fourteen catalogue models; the quotient itself is pinned against the engine of the verification suites. -->

## Details & Options

- The result is a tagged object, read with *algebra*[*key*] and [Normal](). For a basis $b_1, \dots, b_N$ of degrees $\lvert b_i\rvert$ and the pairing $\langle -, - \rangle$ of degree $n$ it has the following keys:

| Key | Value |
|---|---|
| `"Degree"` | the Poincaré duality degree $n$ |
| `"Basis"` | the basis $b_1, \dots, b_N$ |
| `"Degrees"` | the list of their degrees |
| `"Pairing"` | the Gram matrix $G_{ij} = \langle b_i, b_j\rangle$, invertible |
| `"DifferentialPairing"` | the index pairs $\{i, j\}$ with $\lvert b_i\rvert + \lvert b_j\rvert = n - 1$ and $\langle \mathrm{d} b_i, b_j\rangle \neq 0$, to that value |
| `"Differential"` | the matrix $D$ with $\mathrm{d} b_i = \sum_j D_{ij} b_j$ |
| `"Triple"` | the index triples $\{i, j, k\}$ with $\lvert b_i\rvert + \lvert b_j\rvert + \lvert b_k\rvert = n$ and $\langle b_i b_j, b_k\rangle \neq 0$, to that value |
| `"Model"` | for a quotient, the model it is a quotient of |

- <code>[GradedPairing]()[*algebra*]</code> reads the alphabet off the algebra, and [CanonicalMaurerCartan]() reads the canonical element off its triple product.
- [NondegenerateQuotient]() builds the algebra of a Sullivan model, the quotient by its degenerate subspace.
- <code>[PoincareDualityAlgebra]()[*complex*]</code> builds it from a complex with a product, such as one written down from its degrees, its product and its orientation by the four-argument form of [CochainComplexWithPairing](). It keeps the basis of the complex in its order and has no `"Model"` key.
- <code>[PoincareDualityAlgebra]()[*complex*]</code> is the inverse of <code>[CochainComplexWithPairing]()[*algebra*]</code>.
- <code>[PoincareDualityAlgebra]()[*complex*]</code> is a [Failure]() when the pairing of the complex is not perfect, and returns unevaluated when the complex has no product.
- The quotient map of a model is a quasi-isomorphism exactly when the model is of Hodge type, which [HodgeTypeQ]() decides. On a model that is not, the algebra is still built and is still a Poincaré duality algebra, but it no longer carries the model's homotopy type.
- The algebra displays as a summary box: its basis and its degree, with the degrees, the Gram matrix, the differential and the model under the opener.

## Basic Examples

The cohomology of the circle, written down by hand: the unit and a volume class of degree one, with the orientation on the volume class:

```wl
circle = PoincareDualityAlgebra[CochainComplexWithPairing[<|1 -> 0, v -> 1|>, <||>, <||>, v]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, v, of degree 1 -->

Its Gram matrix:

```wl
circle["Pairing"]
```

<!-- => {{0, 1}, {1, 0}} -->

Its triple products:

```wl
circle["Triple"]
```

<!-- => <|{1, 1, 2} -> 1, {1, 2, 1} -> 1, {2, 1, 1} -> 1|> -->

---

The quotient of the model of $\mathbb{CP}^2$:

```wl
algebra = NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, a, a^2, of degree 4 -->

Its basis:

```wl
algebra["Basis"]
```

<!-- => {1, a, a^2} -->

Its Poincaré duality degree:

```wl
algebra["Degree"]
```

<!-- => 4 -->

## Scope

The torus, from its product $p \cdot q = pq$ and the orientation on $pq$:

```wl
torus = PoincareDualityAlgebra[
   CochainComplexWithPairing[<|1 -> 0, p -> 1, q -> 1, p q -> 2|>, <||>, <|{p, q} -> p q|>, p q]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, p, q, p q, of degree 2 -->

Its alphabet carries the canonical element:

```wl
CanonicalMaurerCartan[GradedPairing[torus]][{1, 0}]
```

<!-- => -CyclicWord[{1, 1, p q}] - CyclicWord[{1, p, q}] + CyclicWord[{1, q, p}] -->

---

The quotient of a model that is not formal carries a differential:

```wl
heisenberg = NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, z, y, x, y z, x z, x y, x y z, of degree 3 -->

For the Heisenberg nilmanifold the differential sends $z$ to $xy$:

```wl
heisenberg["Differential"] . heisenberg["Basis"]
```

<!-- => {0, x y, 0, 0, 0, 0, 0, 0} -->

The pairing of $\mathrm{d}z$ with $z$ is the one nonzero entry of the differential pairing:

```wl
heisenberg["DifferentialPairing"]
```

<!-- => <|{2, 2} -> 1|> -->

## Properties and Relations

The quotient of the model of $\mathbb{CP}^2$:

```wl
quotient = NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, a, a^2, of degree 4 -->

The complex of the algebra gives the algebra back:

```wl
PoincareDualityAlgebra[CochainComplexWithPairing[quotient]] === KeyDrop[quotient, "Model"]
```

<!-- => True -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1 and dz = x y, of degree 3 -->

The algebra of the nondegenerate quotient of the complex of the model is the quotient of the model:

```wl
PoincareDualityAlgebra[NondegenerateQuotient[CochainComplexWithPairing[model]]] === KeyDrop[NondegenerateQuotient[model], "Model"]
```

<!-- => True -->

## Possible Issues

The complex of the degree-$4$ obstruction:

```wl
complex = CochainComplexWithPairing[SullivanModel["Degree4Obstruction"]]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 2: 1, 3: 1, 4: 1, of degree 4, with a product -->

Its pairing is not perfect, so it is not a Poincaré duality algebra, and the result is a [Failure](), whose message says so:

```wl
PoincareDualityAlgebra[complex]["Message"]
```

<!-- => "The pairing is not perfect." -->

The nondegenerate quotient of the complex is one:

```wl
PoincareDualityAlgebra[NondegenerateQuotient[complex]]
```

<!-- => a PoincareDualityAlgebra object with basis 1, a, a^2, of degree 4 -->

---

A complex without a product has no triple product, and the expression returns unevaluated:

```wl
PoincareDualityAlgebra[CochainComplexWithPairing[<|1 -> 0, v -> 1|>, <||>, <|{1, v} -> 1|>]]
```

<!-- => the expression returns unevaluated -->

---

The result is then not a Poincaré duality algebra:

```wl
PoincareDualityAlgebraQ[PoincareDualityAlgebra[CochainComplexWithPairing[<|1 -> 0, v -> 1|>, <||>, <|{1, v} -> 1|>]]]
```

<!-- => False -->
