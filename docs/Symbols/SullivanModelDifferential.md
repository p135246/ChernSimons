---
Template: Symbol
Name: SullivanModelDifferential
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelDifferential
Keywords: [differential, derivation, Leibniz, Sullivan model]
SeeAlso: [SullivanModel, SullivanModelProduct, SullivanModelOrientation, HodgeTypeReport, DegenerateSubspace]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[SullivanModelDifferential]()[*e*, *model*]</code> applies the model's differential to an element.

## Details & Options

The differential is given on the generators and extended as a derivation of degree $1$:

$$\mathrm{d}(g_1\cdots g_k) = \sum_i (-1)^{\lvert g_1\rvert+\dots+\lvert g_{i-1}\rvert}\,g_1\cdots \mathrm{d}g_i\cdots g_k.$$

It is linear, it squares to zero, and it is zero into a degree above the model's truncation.

## Basic Examples

In the model of $\mathbb{CP}^2$ the differential of the degree-$5$ generator is $a^3$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
{SullivanModelDifferential[a, model], SullivanModelDifferential[b, model]}
```

<!-- => {0, a^3} -->

---

Extended as a derivation:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
{SullivanModelDifferential[a b, model], SullivanModelDifferential[a^2 b, model]}
```

<!-- => {a^4, a^5} -->

---

In the Heisenberg nilmanifold the only generator that moves is $z$:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
{SullivanModelDifferential[z, model], SullivanModelDifferential[x z, model], SullivanModelDifferential[x y z, model]}
```

<!-- => {x y, 0, 0} -->

## Properties and Relations

It squares to zero:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
SullivanModelDifferential[SullivanModelDifferential[z, model], model]
```

<!-- => 0 -->

---

The orientation kills its image, which is one of the three conditions making $\mathcal{O}$ an orientation:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
Map[e |-> SullivanModelOrientation[SullivanModelDifferential[e, model], model], SullivanModelBasis[model, 2]]
```

<!-- => {0, 0, 0} -->

## Possible Issues

The differential of a truncated model is zero wherever the answer would leave the truncation, so it need not agree with the differential of the untruncated free algebra:

```wl
model = SullivanModel["Degree4Obstruction"];
{SullivanModelDifferential[a, model], SullivanModelDifferential[a^2, model]}
```

<!-- => {c, 0} -->
