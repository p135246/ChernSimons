---
Template: Symbol
Name: HodgeTypeReport
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HodgeTypeReport
Keywords: [report, Betti numbers, degenerate subspace, quasi-isomorphism, Dataset]
SeeAlso: [HodgeTypeQ, DegenerateSubspace, NondegenerateQuotient, SullivanModelBasis]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[HodgeTypeReport]()[*model*]</code> gives a [Dataset]() with one row per degree of a [SullivanModel](): the dimensions of the space, of its cohomology, of the degenerate subspace, of the cohomology of the degenerate subspace and of the nondegenerate quotient.

<code>[HodgeTypeReport]()[*complex*]</code> gives the same [Dataset]() for a [CochainComplexWithPairing](), over all of its degrees.

<!-- #| annotation: 26.09.30: Design review - the report shows the numbers behind HodgeTypeQ, one row per degree: the dimensions of the three terms of the short exact sequence from the degenerate subspace through the space to the nondegenerate quotient, and the cohomology of the first two, so that where a model fails to be of Hodge type can be read off: the quotient map is a quasi-isomorphism exactly where the column "DegenerateCohomology" vanishes. It is a Dataset of Associations keyed by degree, so a column is read with a Dataset query and Normal gives the plain data. For a model the default last degree is n+3, beyond the range n+1 that HodgeTypeQ needs, and "MaxDegree" sets it, at least n since R7 (Pavel, 2026-10-01), the rule of HodgeTypeQ and PoincareDualityQ; the complex is finite, so every degree from its lowest to its highest is shown and that form takes no option. The report does not ask PoincareDualityQ, since it decides nothing. No alternative interface was recorded. Prior art: the Wolfram Language has no such report; Dataset is its display. The engine of the verification suites computes the same table, and T17 pins Normal of the report against it to degree n+3 on the thirteen catalogue models and the Kodaira-Thurston model. -->

## Details & Options

- The report has one row per degree $k$ and the following columns:

| Column | Value in degree $k$ |
|---|---|
| `"Dimension"` | $\dim V^k$ |
| `"Cohomology"` | $\dim H^k(V)$ |
| `"Degenerate"` | $\dim V^k_{\mathrm{deg}}$ |
| `"DegenerateCohomology"` | $\dim H^k(V_{\mathrm{deg}})$ |
| `"Quotient"` | $\dim \mathcal{Q}^k(V)$ |

- `"Dimension"` is the sum of `"Degenerate"` and `"Quotient"` in every degree.
- The quotient map $V\to\mathcal{Q}(V)$ is a quasi-isomorphism exactly when `"DegenerateCohomology"` vanishes throughout. With Poincaré duality on cohomology, that is exactly when the space is of Hodge type, as [HodgeTypeQ]() decides.
- When the quotient map is a quasi-isomorphism, `"Cohomology"` is the cohomology of the quotient and is at most `"Quotient"` in each degree.
- The two agree in every degree exactly when the quotient carries no differential. The quotient is then the cohomology, and the model is formal.
- The report is computed whether or not the pairing on cohomology is perfect.
- A value of `"MaxDegree"` below $n$ returns unevaluated, as it does for [HodgeTypeQ]() and [PoincareDualityQ]().
- For a complex, the rows run from its lowest to its highest degree, and that form takes no option.
- [HodgeTypeReport]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"MaxDegree"</code> | <code>[Automatic]()</code> | the last degree shown for a model; <code>Automatic</code> is $n+3$ |

## Basic Examples

The report of the model of $\mathbb{CP}^2$. The column `"DegenerateCohomology"` is zero, so the model is of Hodge type; the columns `"Cohomology"` and `"Quotient"` coincide, because $\mathbb{CP}^2$ is formal and the quotient is its cohomology, $1, 0, 1, 0, 1$:

```wl
HodgeTypeReport[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a Dataset of the degrees 0 to 7, with Dimension 1, 0, 1, 0, 1, 1, 1, 1, Cohomology 1, 0, 1, 0, 1, 0, 0, 0, Degenerate 0, 0, 0, 0, 0, 1, 1, 1, DegenerateCohomology all 0 and Quotient 1, 0, 1, 0, 1, 0, 0, 0 -->

---

For the degree-$4$ obstruction the column `"DegenerateCohomology"` is $1$ in degree $3$, and `"Cohomology"` and `"Quotient"` disagree there and in degree $2$:

```wl
HodgeTypeReport[SullivanModel["Degree4Obstruction"]]
```

<!-- => a Dataset of the degrees 0 to 7 with DegenerateCohomology 1 in degree 3 and 0 elsewhere, Cohomology 1, 0, 0, 0, 1, 0, 0, 0 and Quotient 1, 0, 1, 0, 1, 0, 0, 0 -->

## Scope

The minimal model of the Heisenberg nilmanifold has nothing degenerate, so it is its own quotient, an eight-dimensional differential Poincaré duality algebra with Betti numbers $1, 2, 2, 1$. It is of Hodge type, and yet `"Cohomology"` falls short of `"Quotient"`: the nilmanifold is not formal, and the quotient keeps a differential:

```wl
HodgeTypeReport[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => a Dataset of the degrees 0 to 6 with Dimension 1, 3, 3, 1, 0, 0, 0, Cohomology 1, 2, 2, 1, 0, 0, 0, Degenerate all 0 and Quotient 1, 3, 3, 1, 0, 0, 0 -->

---

The report of a complex given by its data, Example 6.1 of arXiv:2004.07362, over its degrees $0$ to $4$:

```wl
HodgeTypeReport[CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]]
```

<!-- => a Dataset of the degrees 0 to 4 with Dimension 1, 1, 2, 1, 1, Cohomology 1, 0, 0, 0, 1, Degenerate and DegenerateCohomology all 0, and Quotient 1, 1, 2, 1, 1 -->

## Options

### MaxDegree

A longer range for the model of $S^4$, showing the degenerate subspace filling every degree above $n$:

```wl
HodgeTypeReport[SullivanModel["Sphere"[4]], "MaxDegree" -> 12]
```

<!-- => a Dataset of the degrees 0 to 12 with Cohomology 1 in degrees 0 and 4 and Degenerate equal to Dimension in every degree above 4 -->

## Properties and Relations

The model of the four-torus:

```wl
model = SullivanModel["Torus"[4]]
```

<!-- => a SullivanModel object with generators v1, v2, v3, v4 of degree 1 and zero differential, of degree 4 -->

The column `"Cohomology"` is symmetric about $n/2$, which is Poincaré duality on cohomology:

```wl
Normal[Values[HodgeTypeReport[model, "MaxDegree" -> 4][All, "Cohomology"]]]
```

<!-- => {1, 4, 6, 4, 1} -->

---

The column `"Dimension"` is the sum of `"Degenerate"` and `"Quotient"` in every degree:

```wl
Union[Normal[Values[HodgeTypeReport[SullivanModel["ComplexProjectiveSpace"[2]]][All, #Dimension - #Degenerate - #Quotient &]]]]
```

<!-- => {0} -->
