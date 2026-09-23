---
Template: Symbol
Name: NondegenerateQuotient
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/NondegenerateQuotient
Keywords: [nondegenerate quotient, Poincare duality algebra, dPD model, triple product]
SeeAlso: [DegenerateSubspace, HodgeTypeQ, GradedPairing, CyclicDifferential, CanonicalMaurerCartan, SullivanModel]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[NondegenerateQuotient]()[*model*]</code> is the quotient of the model by its degenerate subspace.

## Details & Options

The result is a plain [Association]() describing a finite-dimensional Poincaré duality algebra:

| key | value |
|---|---|
| `"Degree"` | the Poincaré duality degree $n$ |
| `"Basis"` | monomial representatives, in nondecreasing degree |
| `"Degrees"` | their degrees |
| `"Pairing"` | the Gram matrix $\mathcal{O}(e_ie_j)$, invertible |
| `"DifferentialPairing"` | the nonzero values of $\langle \mathrm{d}e_i,e_j\rangle$, on index pairs |
| `"Differential"` | the matrix of the induced differential in the basis |
| `"Triple"` | the nonzero values of $\mathcal{O}(e_ie_je_k)$, on index triples |
| `"Model"` | the model it came from |

The quotient is nonzero only in degrees $0$ to $n$, and the pairing on it is perfect, so it is a differential Poincaré duality algebra. When the model is of Hodge type the quotient map is a quasi-isomorphism, and the quotient is then a **differential Poincaré duality model** of the model — see [HodgeTypeQ]().

The triple products are what [CanonicalMaurerCartan]() is built from, and they are well defined on the quotient because the degenerate subspace is an ideal for the pairing. The differential data is what [CyclicDifferential]() consumes: [GradedPairing]() attaches the quotient to the alphabet as its `"Algebra"` key, and the operation $\mathfrak{q}_{1,1,0}$ reads the matrix from there.

## Basic Examples

For $\mathbb{CP}^2$ the quotient is the cohomology ring, with zero differential:

```wl
quotient = NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]];
{quotient["Basis"], quotient["Degrees"]}
```

<!-- => {{1, a, a^2}, {0, 2, 4}} -->

---

The pairing is the antidiagonal:

```wl
NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]["Pairing"] // MatrixForm
```

---

The triple products, one per index triple with a nonzero value:

```wl
Normal[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]["Triple"]]
```

<!-- => {{1, 1, 3} -> 1, {1, 2, 2} -> 1, {1, 3, 1} -> 1, {2, 1, 2} -> 1, {2, 2, 1} -> 1, {3, 1, 1} -> 1} -->

## Scope

The minimal model of $S^4$ is infinite-dimensional; its quotient is two-dimensional:

```wl
quotient = NondegenerateQuotient[SullivanModel["Sphere"[4]]];
{quotient["Basis"], quotient["Degrees"], quotient["Degree"]}
```

<!-- => {{1, v}, {0, 4}, 4} -->

---

The quotient of a nilmanifold model carries a nonzero differential, the model not being formal — the data that [CyclicDifferential]() turns into the operation $\mathfrak{q}_{1,1,0}$ of the alphabet. Here $\mathrm{d}z = xy$, $z$ being the second basis vector and $xy$ the seventh:

```wl
quotient = NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]];
{quotient["Basis"], Normal[quotient["DifferentialPairing"]]}
```

<!-- => {{1, z, y, x, y z, x z, x y, x y z}, {{2, 2} -> 1}} -->

## Properties and Relations

The quotient is the input to the IBL layer: [GradedPairing]() reads the alphabet off it, and the element follows.

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]];
{Normal[pairing["Degrees"]], CanonicalMaurerCartan[pairing]}
```

<!-- => {{1 -> -1, a -> 1, a^2 -> 3}, -CyclicWord[{1, 1, a^2}] - CyclicWord[{1, a, a}]} -->

## Possible Issues

The quotient is taken whether or not the model is of Hodge type. When it is not, the quotient is still a Poincaré duality algebra but is **not** quasi-isomorphic to the model — for the degree-$4$ obstruction it is the cohomology of $\mathbb{CP}^2$ where the model has the cohomology of $S^4$.

```wl
model = SullivanModel["Degree4Obstruction"];
{HodgeTypeQ[model], NondegenerateQuotient[model]["Basis"],
 Total[Values[HodgeTypeReport[model][All, "Cohomology"]]]}
```

<!-- => {False, {1, a, a^2}, 2} -->
