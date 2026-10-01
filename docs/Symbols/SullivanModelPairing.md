---
Template: Symbol
Name: SullivanModelPairing
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SullivanModelPairing
Keywords: [pairing, intersection pairing, Poincare duality, graded symmetric]
SeeAlso: [SullivanModelOrientation, SullivanModelProduct, DegenerateSubspace, NondegenerateQuotient, GradedPairing]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[SullivanModelPairing]()[$e_1$, $e_2$, *model*]</code> gives the pairing of the elements $e_1$ and $e_2$ of the Sullivan model *model*, the orientation of their product.

<!-- #| annotation: 26.09.30: Design review - the pairing is by definition the orientation of the product, and it takes its two elements before the model, as SullivanModelProduct does. It is the chain-level pairing from which DegenerateSubspace, NondegenerateQuotient, PoincareDualityQ and PerfectPairingQ compute. Alternative name considered: ModelPairing, the name until 2026-09-21, renamed because "Model" alone is generic. Prior art: the Wolfram Language pairs vectors with Dot and Inner and has no pairing on a graded algebra. The engine the verification suites load defines its pairing the same way, as the orientation of its product, and the suites pin this function through the degenerate subspace and the Gram matrix of the nondegenerate quotient, which they compare with the engine's on the catalogue and on Kodaira-Thurston. -->

## Details & Options

- The pairing is `SullivanModelOrientation[SullivanModelProduct[e1, e2, model], model]`.
- It has degree $n$, the degree of the model: $\langle e_1,e_2\rangle\neq 0$ forces $\lvert e_1\rvert + \lvert e_2\rvert = n$.
- It is graded symmetric, $\langle e_1,e_2\rangle = (-1)^{\lvert e_1\rvert\lvert e_2\rvert}\langle e_2,e_1\rangle$, and bilinear.
- It satisfies the two conditions of a pairing on a differential graded algebra:

$$\langle \mathrm{d}e_1,e_2\rangle = (-1)^{\lvert e_1\rvert+1}\langle e_1,\mathrm{d}e_2\rangle,\qquad \langle e_1e_2,e_3\rangle = \langle e_1,e_2e_3\rangle.$$

- On chain level it is in general degenerate. [DegenerateSubspace]() gives its kernel and [NondegenerateQuotient]() the quotient by it.
- It descends to cohomology, where it is perfect exactly when [PoincareDualityQ]() gives `True`.

## Basic Examples

The pairing of $a$ with itself in the model of $\mathbb{CP}^2$:

```wl
SullivanModelPairing[a, a, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => 1 -->

---

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

On $1$, $a$, $a^2$ the pairing is antidiagonal, which is Poincaré duality:

```wl
Table[SullivanModelPairing[a^i, a^j, model], {i, 0, 2}, {j, 0, 2}]
```

<!-- => {{0, 0, 1}, {0, 1, 0}, {1, 0, 0}} -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

The pairing of $x$, of degree $1$, and $yz$, of degree $2$:

```wl
SullivanModelPairing[x, y z, model]
```

<!-- => 1 -->

Graded symmetry with $(-1)^{1\cdot 2} = 1$:

```wl
SullivanModelPairing[y z, x, model]
```

<!-- => 1 -->

The sign is the one the product carries:

```wl
SullivanModelPairing[y, x z, model]
```

<!-- => -1 -->

With $z$ first:

```wl
SullivanModelPairing[z, x y, model]
```

<!-- => 1 -->

## Scope

The model of the torus $T^2$:

```wl
torus = SullivanModel["Torus"[2]]
```

<!-- => a SullivanModel object with generators v1, v2 of degree 1, of degree 2 -->

The pairing of the two generators:

```wl
SullivanModelPairing[v1, v2, torus]
```

<!-- => 1 -->

Two elements of degree $1$ pair antisymmetrically:

```wl
SullivanModelPairing[v2, v1, torus]
```

<!-- => -1 -->

---

On $S^2\times S^2$ an orientation given by its value $3$ on $pr$:

```wl
square = SullivanModel[<|p -> 2, q -> 3, r -> 2, s -> 3|>, <|q -> p^2, s -> r^2|>, <|p r -> 3|>]
```

<!-- => a SullivanModel object with generators p, r of degree 2 and q, s of degree 3, of degree 4 -->

The pairing of $p$ and $r$ is that value:

```wl
SullivanModelPairing[p, r, square]
```

<!-- => 3 -->

---

The pairing is bilinear:

```wl
SullivanModelPairing[a + b, 2 a, SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => 2 -->

## Properties and Relations

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

The pairing of $\mathrm{d}z$ with $z$:

```wl
SullivanModelPairing[SullivanModelDifferential[z, model], z, model]
```

<!-- => 1 -->

It equals $(-1)^{\lvert z\rvert+1}\langle z,\mathrm{d}z\rangle$:

```wl
(-1)^(1 + 1) SullivanModelPairing[z, SullivanModelDifferential[z, model], model]
```

<!-- => 1 -->

The pairing of $xy$ with $z$:

```wl
SullivanModelPairing[SullivanModelProduct[x, y, model], z, model]
```

<!-- => 1 -->

It equals the pairing of $x$ with $yz$:

```wl
SullivanModelPairing[x, SullivanModelProduct[y, z, model], model]
```

<!-- => 1 -->

## Possible Issues

The truncated model of Example 6.3 of arXiv:2004.07362:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, of degree 4, truncated above 4 -->

The pairing of $a$ with itself is nonzero:

```wl
SullivanModelPairing[a, a, model]
```

<!-- => 1 -->

Yet the whole of degree $3$ is degenerate:

```wl
DegenerateSubspace[model, 3]
```

<!-- => {c} -->

The degenerate subspace is not acyclic, since $c$ is closed and $a$, with $\mathrm{d}a = c$, is not degenerate, so the model is not of Hodge type:

```wl
HodgeTypeQ[model]
```

<!-- => False -->
