---
Template: Symbol
Name: SullivanModel
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModel
Keywords: [Sullivan model, minimal model, free graded commutative algebra, volume form, oriented PDGA]
SeeAlso: [$SullivanModels, SullivanModelBasis, SullivanModelProduct, SullivanModelDifferential, SullivanModelOrientation, HodgeTypeQ, NondegenerateQuotient]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[SullivanModel]()[*name*]</code> gives a Sullivan minimal model with a volume form from the catalogue [$SullivanModels]().

<code>[SullivanModel]()[*name*, *generators*]</code> uses the given generator symbols instead of the default ones.

<code>[SullivanModel]()[*degrees*, *differential*, *volume*]</code> builds a model from an Association of generators to their degrees, an Association giving the differential on the generators, and a volume monomial.

<code>[SullivanModel]()[*degrees*, *differential*, *volume*, *truncation*]</code> quotients by the monomials above degree *truncation*.

<code>[SullivanModel]()[{*model*1, *model*2, …}]</code> is the tensor product.

## Details & Options

The result is a plain [Association]() with five keys, so it can be inspected and edited like any other expression.

| key | value |
|---|---|
| `"Generators"` | the *degrees* Association, verbatim; every degree must be at least $1$ |
| `"Differential"` | one element per generator, as an Association from monomials to coefficients |
| `"Volume"` | the volume monomial, as the list of its generators |
| `"Degree"` | the degree of the volume monomial — the Poincaré duality degree $n$ |
| `"Truncation"` | the degree above which the algebra is zero, [Infinity]() by default |

The underlying algebra is the free graded commutative algebra on the generators: a generator of even degree is polynomial, one of odd degree squares to zero. A monomial is written as a product of generators and is read **in the order the model declares them**, so `x y` and `y x` are the same expression and denote the same monomial; the sign of a reordering is produced by [SullivanModelProduct]() and not by the way a monomial is typed.

*volume* determines the orientation $\mathcal{O}\colon V\to\mathbb{K}$: it is the coefficient of that monomial, so it has degree $n$ and kills every other degree. That makes $(V,\mathrm{d},\mathcal{O})$ an oriented PDGA of degree $n$ whenever the pairing $\langle v_1,v_2\rangle = \mathcal{O}(v_1v_2)$ is perfect on cohomology, which is the case for every model in the catalogue.

The differential may be given either as a monomial expression or as an Association from monomials to coefficients. A generator not mentioned is closed.

The default generator symbols are created in the caller's context — `a`, `b` for a projective space, `x`, `y`, `z` for the Heisenberg nilmanifold, and so on. Pass *generators* to choose them, which is also how a collision is avoided when two models are tensored.

A truncation is legitimate because the span of the monomials above any degree is a differential graded ideal, the differential raising degree by one.

The model displays as a summary box: its generators with their degrees and the Poincaré duality degree, with the differential, the volume monomial and the truncation under the opener.

## Basic Examples

The minimal model of $\mathbb{CP}^2$: a generator of degree $2$ and one of degree $5$ whose differential is its cube.

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
Normal[model["Generators"]]
```

<!-- => {a -> 2, b -> 5} -->

---

The volume monomial and the degree it fixes:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
{model["Volume"], model["Degree"]}
```

<!-- => {{a, a}, 4} -->

---

The differential, on the generators:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
Normal[model["Differential"]]
```

<!-- => {a -> <||>, b -> <|{a, a, a} -> 1|>} -->

## Scope

The same model with the generators renamed:

```wl
Normal[SullivanModel["ComplexProjectiveSpace"[2], {u, w}]["Generators"]]
```

<!-- => {u -> 2, w -> 5} -->

---

Built by hand rather than from the catalogue, it is the same algebra:

```wl
own = SullivanModel[<|u -> 2, w -> 5|>, <|w -> u^3|>, u^2];
{own["Degree"], NondegenerateQuotient[own]["Basis"]}
```

<!-- => {4, {1, u, u^2}} -->

---

A tensor product, of $S^2$ and $S^3$; the generators have to be disjoint, so they are named:

```wl
product = SullivanModel[{SullivanModel["Sphere"[2], {p, q}], SullivanModel["Sphere"[3], {r}]}];
{Normal[product["Generators"]], product["Volume"], product["Degree"]}
```

<!-- => {{p -> 2, q -> 3, r -> 3}, {p, r}, 5} -->

---

The truncated polynomial algebra $\mathbb{K}[u]/(u^3)$ with $\lvert u\rvert = 2$ — the cohomology of $\mathbb{CP}^2$, presented as a model with zero differential:

```wl
truncated = SullivanModel[<|u -> 2|>, <||>, u^2, 4];
Table[SullivanModelBasis[truncated, k], {k, 0, 6}]
```

<!-- => {{1}, {}, {u}, {}, {u^2}, {}, {}} -->

## Properties and Relations

A model with a volume form is the input to the whole chain: [HodgeTypeQ]() decides whether the quotient map loses cohomology, [NondegenerateQuotient]() takes the quotient, [GradedPairing]() turns it into an alphabet, and [CanonicalMaurerCartan]() reads off the element.

```wl
model = SullivanModel["Sphere"[4]];
pairing = GradedPairing[NondegenerateQuotient[model]];
{HodgeTypeQ[model], CanonicalMaurerCartan[pairing]}
```

<!-- => {True, -CyclicWord[{1, 1, v}]} -->

## Possible Issues

`"Volume"` is stored as the list of the generators of the monomial, not as a product, because that is the form the engine works in. Every other function takes and returns products.

```wl
SullivanModel["SpecialUnitaryGroup"[3]]["Volume"]
```

<!-- => {h3, h5} -->
