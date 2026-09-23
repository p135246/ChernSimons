---
Template: Symbol
Name: SullivanModelProduct
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelProduct
Keywords: [product, graded commutative, Koszul sign, truncation]
SeeAlso: [SullivanModel, SullivanModelBasis, SullivanModelDifferential, SullivanModelPairing, SullivanModelOrientation]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[SullivanModelProduct]()[*e*1, *e*2, …, *model*]</code> multiplies elements of the model.

## Details & Options

The product is graded commutative: $e_1e_2 = (-1)^{\lvert e_1\rvert\lvert e_2\rvert}e_2e_1$, and a generator of odd degree squares to zero. It is linear in each argument, so an argument may be any linear combination of monomials.

A monomial written as a product of generators is read in the order the model declares them, so the **order of the arguments** is what carries the sign, not the way each monomial is typed.

Anything landing above the model's truncation degree is zero.

## Basic Examples

Two generators of degree $1$ anticommute:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
{SullivanModelProduct[x, y, model], SullivanModelProduct[y, x, model]}
```

<!-- => {x y, -x y} -->

---

An odd generator squares to zero:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
SullivanModelProduct[x, x, model]
```

<!-- => 0 -->

---

Any number of factors:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
{SullivanModelProduct[x, y, z, model], SullivanModelProduct[z, y, x, model]}
```

<!-- => {x y z, -x y z} -->

## Scope

An even generator is polynomial, and the model is not truncated, so its powers keep going:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
SullivanModelProduct[a^2, a^3, model]
```

<!-- => a^5 -->

---

In a truncated model the same product is zero:

```wl
model = SullivanModel["Degree4Obstruction"];
{SullivanModelProduct[a, a, model], SullivanModelProduct[a, a, a, model]}
```

<!-- => {a^2, 0} -->

## Properties and Relations

The Leibniz identity, on a case where both terms are nonzero:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
{SullivanModelDifferential[SullivanModelProduct[a, b, model], model],
 SullivanModelProduct[SullivanModelDifferential[a, model], b, model] +
   (-1)^2 SullivanModelProduct[a, SullivanModelDifferential[b, model], model]}
```

<!-- => {a^4, a^4} -->

---

The pairing is the orientation of the product:

```wl
model = SullivanModel["HeisenbergNilmanifold"];
{SullivanModelPairing[x, y z, model], SullivanModelOrientation[SullivanModelProduct[x, y z, model], model]}
```

<!-- => {1, 1} -->
