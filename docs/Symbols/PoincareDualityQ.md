---
Template: Symbol
Name: PoincareDualityQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/PoincareDualityQ
Keywords: [Poincare duality, oriented PDGA, cohomology pairing, perfect pairing, predicate]
SeeAlso: [PerfectPairingQ, OrientationQ, HodgeTypeQ, HodgeTypeReport, SullivanModelPairing, SullivanModel]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[PoincareDualityQ]()[*model*]</code> tests whether the pairing that the orientation of the Sullivan model *model* induces on cohomology is perfect, checking the degrees $0$ to $n+1$.

<code>[PoincareDualityQ]()[*complex*]</code> tests whether the pairing of the [CochainComplexWithPairing]() *complex* is perfect on cohomology.

<!-- #| annotation: 26.09.30: Design review - the predicate answers the hypothesis under which HodgeTypeQ decides Hodge type, and HodgeTypeQ is guarded by it (H2, 2026-09-24). On a model it computes the cohomology degree by degree, and an untruncated model with a generator of even degree is infinite-dimensional, so the test stops at a degree: n+1 by default, with the option "MaxDegree" as in HodgeTypeQ. Since R7 (Pavel, 2026-10-01) a value below n returns unevaluated, since duality needs every degree from 0 to n; before, it was read as n and changed nothing. Beyond that degree it cannot see, which the page shows on the model with generators of degrees 2, 3 and 6 (H1, 2026-09-24). On a complex, which is finite-dimensional, it checks every degree, is exact and takes no option. Prior art: the Wolfram Language has no cohomology of cochain complexes; the cocycles, the boundaries and the rank of the pairing on them are NullSpace and MatrixRank computations. The engine the verification suites load has no Poincaré duality test; the suites pin this predicate over the catalogue, all of whose models are oriented PDGAs, and on T^2 oriented in degree 1, which is not. -->

## Details & Options

- The pairing $\langle v,w\rangle = \mathcal{O}(vw)$ vanishes when one of $v$, $w$ is a boundary and the other a cocycle, so it descends to cohomology.
- A model of degree $n$ is an oriented PDGA when the pairing $H^k\times H^{n-k}\to\mathbb{K}$ is nondegenerate for $0\le k\le n$ and $H^k = 0$ for $k > n$.
- For a model the test runs in the degrees $0$ to $n+1$ by default and does not look further up.
- For a complex every degree is checked, and the test is exact. The complex form takes no option.
- [PoincareDualityQ]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"MaxDegree"</code> | <code>[Automatic]()</code> | the last degree of a model that is checked; <code>[Automatic]()</code> is $n+1$ |

- A value of `"MaxDegree"` below $n$ returns unevaluated, since duality needs every degree from $0$ to $n$.
- It is the hypothesis under which [HodgeTypeQ]() decides Hodge type. Poincaré duality on chain level is the stronger [PerfectPairingQ]().

## Basic Examples

The model of $\mathbb{CP}^3$ is an oriented PDGA:

```wl
PoincareDualityQ[SullivanModel["ComplexProjectiveSpace"[3]]]
```

<!-- => True -->

---

Models of the catalogue are oriented PDGAs:

```wl
AllTrue[{"Circle", "Sphere"[2], "ComplexProjectiveSpace"[3], "Torus"[3], "HeisenbergNilmanifold", "Degree4Obstruction"}, name |-> PoincareDualityQ[SullivanModel[name]]]
```

<!-- => True -->

---

The torus $T^2$ oriented in degree $1$ is not: its cohomology in degree $1$ has dimension $2$ and pairs with the one-dimensional degree $0$:

```wl
PoincareDualityQ[SullivanModel[<|v1 -> 1, v2 -> 1|>, <||>, v1]]
```

<!-- => False -->

## Scope

The truncated model of Example 6.3 of arXiv:2004.07362:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, of degree 4, truncated above 4 -->

It satisfies Poincaré duality:

```wl
PoincareDualityQ[model]
```

<!-- => True -->

It is not of Hodge type:

```wl
HodgeTypeQ[model]
```

<!-- => False -->

---

A tensor product of oriented PDGAs is one:

```wl
PoincareDualityQ[SullivanModel[{SullivanModel["Degree4Obstruction"], SullivanModel["Circle", {v}]}]]
```

<!-- => True -->

---

The complex of the model of $\mathbb{CP}^2$ satisfies Poincaré duality, as the model does:

```wl
PoincareDualityQ[CochainComplexWithPairing[SullivanModel["ComplexProjectiveSpace"[2]]]]
```

<!-- => True -->

---

A complex with two classes in degree $1$ and one in degree $0$ does not:

```wl
PoincareDualityQ[CochainComplexWithPairing[<|1 -> 0, u -> 1, w -> 1|>, <||>, <||>, u]]
```

<!-- => False -->

## Options

### MaxDegree

The model $\Lambda(v, w, z)$ with $\lvert v\rvert = 2$, $\mathrm{d}w = v^2$ and a closed generator $z$ of degree $6$:

```wl
model = SullivanModel[<|v -> 2, w -> 3, z -> 6|>, <|w -> v^2|>, v]
```

<!-- => a SullivanModel object with generators v of degree 2, w of degree 3 and z of degree 6, of degree 2 -->

The default test stops at degree $3$:

```wl
PoincareDualityQ[model]
```

<!-- => True -->

Checking up to degree $6$ finds the class of $z$:

```wl
PoincareDualityQ[model, "MaxDegree" -> 6]
```

<!-- => False -->

---

A range that stops below the degree of the model returns unevaluated. The model of $S^1$ has degree $1$:

```wl
PoincareDualityQ[SullivanModel["Circle"], "MaxDegree" -> 0]
```

<!-- => the input, unevaluated -->

## Properties and Relations

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

It is an oriented PDGA:

```wl
PoincareDualityQ[model]
```

<!-- => True -->

Its Betti numbers, from [HodgeTypeReport](), are symmetric about degree $2$ and vanish above $4$:

```wl
Normal[HodgeTypeReport[model][All, "Cohomology"]]
```

<!-- => <|0 -> 1, 1 -> 0, 2 -> 1, 3 -> 0, 4 -> 1, 5 -> 0, 6 -> 0, 7 -> 0|> -->

Its pairing is not perfect on chain level:

```wl
PerfectPairingQ[model]
```

<!-- => False -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

Its pairing is perfect on chain level:

```wl
PerfectPairingQ[model]
```

<!-- => True -->

So it is perfect on cohomology:

```wl
PoincareDualityQ[model]
```

<!-- => True -->

## Possible Issues

The model $\Lambda(v, w, z)$ with $\lvert v\rvert = 2$, $\mathrm{d}w = v^2$ and a closed generator $z$ of degree $6$:

```wl
model = SullivanModel[<|v -> 2, w -> 3, z -> 6|>, <|w -> v^2|>, v]
```

<!-- => a SullivanModel object with generators v of degree 2, w of degree 3 and z of degree 6, of degree 2 -->

Cohomology above degree $n+1 = 3$ is not examined by default, so the answer is `True`:

```wl
PoincareDualityQ[model]
```

<!-- => True -->

Yet $z$ is a cocycle of degree $6$, and no element of degree $5$ has it as differential:

```wl
SullivanModelDifferential[z, model]
```

<!-- => 0 -->
