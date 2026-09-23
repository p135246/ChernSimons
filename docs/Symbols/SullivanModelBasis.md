---
Template: Symbol
Name: SullivanModelBasis
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelBasis
Keywords: [basis, monomials, graded, degree]
SeeAlso: [SullivanModel, SullivanModelProduct, SullivanModelDifferential, DegenerateSubspace]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[SullivanModelBasis]()[*model*, *k*]</code> lists the monomials of degree *k* in the model.

## Details & Options

Each monomial is written as a product of generators in the order the model declares them, the empty monomial being `1`. A generator of odd degree occurs at most once; one of even degree may occur any number of times.

The list is empty for a negative degree and above the model's truncation degree. The model is otherwise infinite-dimensional whenever it has a generator of even degree.

## Basic Examples

The model of $\mathbb{CP}^2$ has one monomial in every even degree and one in every degree $5$ and above coming from $b$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
Table[SullivanModelBasis[model, k], {k, 0, 8}]
```

<!-- => {{1}, {}, {a}, {}, {a^2}, {b}, {a^3}, {a b}, {a^4}} -->

---

The exterior algebra of the three-torus is finite-dimensional, with the binomial dimensions:

```wl
model = SullivanModel["Torus"[3]];
Table[SullivanModelBasis[model, k], {k, 0, 4}]
```

<!-- => {{1}, {v3, v2, v1}, {v2 v3, v1 v3, v1 v2}, {v1 v2 v3}, {}} -->

## Scope

The model of $S^4$ has generators in degrees $4$ and $7$:

```wl
model = SullivanModel["Sphere"[4]];
Table[SullivanModelBasis[model, k], {k, 0, 8}]
```

<!-- => {{1}, {}, {}, {}, {v}, {}, {}, {w}, {v^2}} -->

---

A truncated model stops:

```wl
model = SullivanModel["Degree4Obstruction"];
Table[SullivanModelBasis[model, k], {k, 0, 5}]
```

<!-- => {{1}, {}, {a}, {c}, {a^2}, {}} -->

## Properties and Relations

The dimensions are the first column of [HodgeTypeReport]():

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
{Table[Length[SullivanModelBasis[model, k]], {k, 0, 7}],
 Normal[Values[HodgeTypeReport[model][All, "Dimension"]]]}
```
