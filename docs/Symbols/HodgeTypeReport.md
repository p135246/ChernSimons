---
Template: Symbol
Name: HodgeTypeReport
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HodgeTypeReport
Keywords: [report, Betti numbers, degenerate subspace, quasi-isomorphism, Dataset]
SeeAlso: [HodgeTypeQ, DegenerateSubspace, NondegenerateQuotient, SullivanModelBasis]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[HodgeTypeReport]()[*model*]</code> is a [Dataset]() with one row per degree, showing where the model is of Hodge type and where it is not.

## Details & Options

| column | value in degree $k$ |
|---|---|
| `"Dimension"` | $\dim V^k$ |
| `"Cohomology"` | $\dim H^k(V)$ |
| `"Degenerate"` | $\dim V^k_{\mathrm{deg}}$ |
| `"DegenerateCohomology"` | $\dim H^k(V_{\mathrm{deg}})$ |
| `"Quotient"` | $\dim \mathcal{Q}^k(V)$ |

The model is of Hodge type exactly when the fourth column vanishes throughout; the quotient map is then a quasi-isomorphism, so the second column is the cohomology of the quotient and is at most the fifth. The two agree exactly when the quotient carries no differential, which is to say when the quotient *is* the cohomology and the model is formal.

| option | default | |
|---|---|---|
| `"MaxDegree"` | [Automatic]() | the last degree shown; `Automatic` is $n+3$ |

## Basic Examples

For $\mathbb{CP}^2$ the fourth column is zero, so the model is of Hodge type; and the `Cohomology` and `Quotient` columns coincide, because $\mathbb{CP}^2$ is formal and the quotient is its cohomology, $1,0,1,0,1$:

```wl
HodgeTypeReport[SullivanModel["ComplexProjectiveSpace"[2]]]
```

---

For the degree-$4$ obstruction the fourth column is $1$ in degree $3$, and the two other columns disagree there and in degree $2$:

```wl
HodgeTypeReport[SullivanModel["Degree4Obstruction"]]
```

## Scope

The minimal model of the Heisenberg nilmanifold has nothing degenerate, so it is its own quotient — an eight-dimensional differential Poincaré duality algebra with Betti numbers $1,2,2,1$. It is of Hodge type, and yet `Cohomology` falls short of `Quotient`: the nilmanifold is not formal, and the quotient keeps a differential.

```wl
HodgeTypeReport[SullivanModel["HeisenbergNilmanifold"]]
```

## Options

A longer range, showing the degenerate subspace filling every degree above $n$:

```wl
HodgeTypeReport[SullivanModel["Sphere"[4]], "MaxDegree" -> 12]
```

## Properties and Relations

The `Cohomology` column is symmetric about $n/2$, which is Poincaré duality on cohomology:

```wl
model = SullivanModel["Torus"[4]];
Normal[Values[HodgeTypeReport[model, "MaxDegree" -> 4][All, "Cohomology"]]]
```

<!-- => {1, 4, 6, 4, 1} -->
