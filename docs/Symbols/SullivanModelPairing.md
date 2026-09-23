---
Template: Symbol
Name: SullivanModelPairing
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelPairing
Keywords: [pairing, intersection pairing, Poincare duality, graded symmetric]
SeeAlso: [SullivanModelOrientation, SullivanModelProduct, DegenerateSubspace, NondegenerateQuotient, GradedPairing]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[SullivanModelPairing]()[*e*1, *e*2, *model*]</code> is <code>[SullivanModelOrientation]()[[SullivanModelProduct]()[*e*1, *e*2, *model*], *model*]</code>, the chain-level pairing of the oriented model.

## Details & Options

The pairing has degree $n$, the model's degree: $\langle e_1,e_2\rangle\neq 0$ forces $\lvert e_1\rvert + \lvert e_2\rvert = n$. It is graded symmetric, and it satisfies the two conditions a pairing on a DGA must:

$$\langle \mathrm{d}e_1,e_2\rangle = (-1)^{\lvert e_1\rvert+1}\langle e_1,\mathrm{d}e_2\rangle,\qquad \langle e_1e_2,e_3\rangle = \langle e_1,e_2e_3\rangle.$$

It is almost never nondegenerate on chain level — that is what [DegenerateSubspace]() measures and [NondegenerateQuotient]() repairs. On cohomology it is perfect, which is what makes the model a PDGA.

## Basic Examples

On $1, a, a^2$ in the model of $\mathbb{CP}^2$ the pairing is the antidiagonal — Poincaré duality:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
Table[SullivanModelPairing[a^i, a^j, model], {i, 0, 2}, {j, 0, 2}] // MatrixForm
```

---

Graded symmetry, with $\lvert x\rvert = 1$ and $\lvert yz\rvert = 2$:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
{SullivanModelPairing[x, y z, model], SullivanModelPairing[y z, x, model]}
```

<!-- => {1, 1} -->

---

The sign is the one the product carries:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
{SullivanModelPairing[y, x z, model], SullivanModelPairing[z, x y, model]}
```

<!-- => {-1, 1} -->

## Properties and Relations

Compatibility with the differential, at a degree where both sides are nonzero:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
{SullivanModelPairing[SullivanModelDifferential[z, model], z, model],
 (-1)^(1 + 1) SullivanModelPairing[z, SullivanModelDifferential[z, model], model]}
```

<!-- => {1, 1} -->

## Possible Issues

The pairing being nonzero on an element does not make it nondegenerate: in the model of the degree-$4$ obstruction $\langle a,a\rangle = 1$ while the whole of degree $3$ is degenerate, and that is exactly why the model is not of Hodge type.

```wl
model = SullivanModel["Degree4Obstruction"];
{SullivanModelPairing[a, a, model], DegenerateSubspace[model, 3], HodgeTypeQ[model]}
```

<!-- => {1, {c}, False} -->
