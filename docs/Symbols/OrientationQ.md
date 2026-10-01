---
Template: Symbol
Name: OrientationQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/OrientationQ
Keywords: [orientation, predicate, top degree, cocycle, oriented PDGA]
SeeAlso: [SullivanModel, SullivanModelOrientation, PoincareDualityQ, SullivanModelBasis]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[OrientationQ]()[*values*, *model*]</code> tests whether the Association *values* on monomials of one degree $n$ defines an orientation of the Sullivan model *model*.

<code>[OrientationQ]()[*values*, *complex*]</code> tests whether *values* on basis elements of one degree $n$ defines an orientation of the [CochainComplexWithPairing]() *complex*.

<!-- #| annotation: 26.09.30: Design review - the predicate came with the orientation given by values (H1, 2026-09-24): SullivanModel builds its model and then checks the values with it, and CochainComplexWithPairing does the same for a complex. It takes the values first and the space second, and it reads only the algebra and the differential of the space, never an orientation the space already carries, so the same test serves a model under construction and any other set of values. The values must be numbers, and a symbolic value returns unevaluated, since the answer may depend on it; the predicate answers True or False otherwise. Prior art: the Wolfram Language has no orientation of a cochain complex; the two conditions are linear algebra, the cocycles of degree n being a NullSpace. The engine the verification suites load orients a model by one volume monomial and has no such test; the suites pin this predicate on S^2 x S^2, with six sets of values, and on T^2 oriented in degree 1. -->

## Details & Options

- An orientation of degree $n$ is a linear map $\mathcal{O}\colon V^n\to\mathbb{K}$, extended by zero to the other degrees, such that $\mathcal{O}\circ\mathrm{d} = 0$ and $\mathcal{O}(z)\neq 0$ for some cocycle $z$ of degree $n$. It then induces a nonzero map on cohomology.
- *values* gives $\mathcal{O}$ on the basis elements of degree $n$ that [SullivanModelBasis]() lists; a basis element left out has the value $0$, and zero values are ignored.
- The degree $n$ is the degree of the first key with a nonzero value.
- Values that are all zero, keys of different degrees, and keys that are not basis elements give `False`.
- The values must be numbers. With a symbol among them the answer may depend on it, and [OrientationQ]() returns unevaluated.
- Only the algebra and the differential of *model* or *complex* are used: an orientation it carries plays no part.

## Basic Examples

The orientation of the model of $\mathbb{CP}^2$, $1$ on $a^2$:

```wl
OrientationQ[<|a^2 -> 1|>, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => True -->

---

The model of $S^2\times S^2$:

```wl
square = SullivanModel[{SullivanModel["Sphere"[2], {p, q}], SullivanModel["Sphere"[2], {r, s}]}]
```

<!-- => a SullivanModel object with generators p, r of degree 2 and q, s of degree 3, of degree 4 -->

The value $1$ on $pr$ is an orientation:

```wl
OrientationQ[<|p r -> 1|>, square]
```

<!-- => True -->

So is the value $3$:

```wl
OrientationQ[<|p r -> 3|>, square]
```

<!-- => True -->

The monomial $p^2 = \mathrm{d}q$ is a boundary, so an orientation must vanish on it:

```wl
OrientationQ[<|p^2 -> 1|>, square]
```

<!-- => False -->

The value on $pr$ does not help:

```wl
OrientationQ[<|p^2 -> 1, p r -> 1|>, square]
```

<!-- => False -->

## Scope

The model of $S^2\times S^2$:

```wl
square = SullivanModel[{SullivanModel["Sphere"[2], {p, q}], SullivanModel["Sphere"[2], {r, s}]}]
```

<!-- => a SullivanModel object with generators p, r of degree 2 and q, s of degree 3, of degree 4 -->

In degree $3$ no nonzero element is closed, since $\mathrm{d}q = p^2$:

```wl
SullivanModelDifferential[q, square]
```

<!-- => p^2 -->

So a functional on degree $3$ that kills the image of the differential still fails, by vanishing on every cocycle:

```wl
OrientationQ[<|q -> 1|>, square]
```

<!-- => False -->

---

The model of the torus $T^2$:

```wl
torus = SullivanModel["Torus"[2]]
```

<!-- => a SullivanModel object with generators v1, v2 of degree 1, of degree 2 -->

An orientation need not sit in the top degree of the cohomology: the value $1$ on the generator $v_1$ is one, of degree $1$:

```wl
OrientationQ[<|v1 -> 1|>, torus]
```

<!-- => True -->

The value $1$ on $v_1 v_2$ is one of degree $2$:

```wl
OrientationQ[<|v1 v2 -> 1|>, torus]
```

<!-- => True -->

Keys of different degrees give `False`:

```wl
OrientationQ[<|v1 -> 1, v1 v2 -> 1|>, torus]
```

<!-- => False -->

Values that are all zero give `False`:

```wl
OrientationQ[<|v1 v2 -> 0|>, torus]
```

<!-- => False -->

---

The complex of the model of $\mathbb{CP}^2$:

```wl
complex = CochainComplexWithPairing[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a CochainComplexWithPairing object of degree 4 -->

The value $1$ on $a^2$ is an orientation of the complex:

```wl
OrientationQ[<|a^2 -> 1|>, complex]
```

<!-- => True -->

The value $1$ on $b$ is not, since there is no cocycle in degree $5$:

```wl
OrientationQ[<|b -> 1|>, complex]
```

<!-- => False -->

## Properties and Relations

[SullivanModel]() builds a model only from an orientation, and otherwise gives a [Failure]() whose message says so:

```wl
SullivanModel[<|a -> 1, b -> 2|>, <|a -> b|>, b]["Message"]
```

<!-- => "The values do not define an orientation." -->

---

The model of $\mathbb{CP}^2$, oriented by $1$ on $a^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

Other values are tested on the algebra, whatever the orientation of the model:

```wl
OrientationQ[<|a^2 -> 5|>, model]
```

<!-- => True -->

---

The model of the torus $T^2$:

```wl
torus = SullivanModel["Torus"[2]]
```

<!-- => a SullivanModel object with generators v1, v2 of degree 1, of degree 2 -->

Oriented in degree $1$ by $v_1$, the model does not satisfy Poincaré duality, the further question [PoincareDualityQ]() answers:

```wl
PoincareDualityQ[SullivanModel[torus["Generators"], <||>, v1]]
```

<!-- => False -->

Oriented in degree $2$, it does:

```wl
PoincareDualityQ[torus]
```

<!-- => True -->

## Possible Issues

A symbolic value may decide the answer, and the input returns unevaluated:

```wl
OrientationQ[<|a^2 -> t|>, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => the input, unevaluated -->
