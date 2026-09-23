---
Template: Symbol
Name: SullivanModelOrientation
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelOrientation
Keywords: [orientation, volume form, integration, Poincare duality degree]
SeeAlso: [SullivanModel, SullivanModelPairing, SullivanModelProduct, SullivanModelDifferential, NondegenerateQuotient]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[SullivanModelOrientation]()[*e*, *model*]</code> is the coefficient of the volume monomial in *e*.

## Details & Options

An *orientation* of degree $n$ on a cochain complex $(V,\mathrm{d})$ is a linear map $\mathcal{O}\colon V\to\mathbb{K}$ such that $\mathcal{O}$ vanishes outside degree $n$, $\mathcal{O}\circ\mathrm{d} = 0$, and the induced map on cohomology is nonzero. Projecting onto a single monomial of degree $n$ satisfies the first condition by construction; the other two hold for every model in [$SullivanModels]().

For the de Rham algebra of a closed oriented manifold the corresponding map is integration, so this is the algebraic stand-in for $\omega\mapsto\int_X\omega$.

## Basic Examples

The volume monomial of the model of $\mathbb{CP}^2$ is $a^2$, and the orientation sees nothing else:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
{SullivanModelOrientation[a^2, model], SullivanModelOrientation[a^3, model], SullivanModelOrientation[b, model]}
```

<!-- => {1, 0, 0} -->

---

It is linear, so a coefficient comes out:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
SullivanModelOrientation[3 a^2 + 5 b, model]
```

<!-- => 3 -->

## Scope

On the Heisenberg nilmanifold the volume monomial is $xyz$, and the sign of a reordering is visible:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
{SullivanModelOrientation[SullivanModelProduct[x, y, z, model], model],
 SullivanModelOrientation[SullivanModelProduct[z, y, x, model], model]}
```

<!-- => {1, -1} -->

## Properties and Relations

It kills the image of the differential:

```wl
model = SullivanModel["KodairaThurston"];
Union[Map[e |-> SullivanModelOrientation[SullivanModelDifferential[e, model], model], SullivanModelBasis[model, 3]]]
```

<!-- => {0} -->

---

The pairing of the model is the orientation of the product:

```wl
model = SullivanModel["ComplexProjectiveSpace"[3]];
{SullivanModelPairing[a, a^2, model], SullivanModelOrientation[SullivanModelProduct[a, a^2, model], model]}
```

<!-- => {1, 1} -->
