---
Template: Symbol
Name: DegenerateSubspace
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/DegenerateSubspace
Keywords: [degenerate subspace, radical, perpendicular, differential graded ideal]
SeeAlso: [SullivanModelPairing, NondegenerateQuotient, HodgeTypeQ, HodgeTypeReport]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[DegenerateSubspace]()[*model*, *k*]</code> gives a basis of the degree-*k* part of the degenerate subspace $V_{\mathrm{deg}} = \{v\mid v\perp V\}$ of a [SullivanModel]().

<code>[DegenerateSubspace]()[*complex*, *k*]</code> gives a basis of the degree-*k* part of the degenerate subspace of a [CochainComplexWithPairing]().

<!-- #| annotation: 26.09.30: Design review - the function takes the space and one degree, because a Sullivan model is infinite-dimensional and the degenerate subspace is wanted degree by degree, and it gives a basis as a list of linear combinations of basis monomials, the form every other function of the Hodge layer takes and gives. Since the pairing has degree n, only degree n-k tests degree k, so the basis is the null space of one pairing matrix, computed with NullSpace; in a degree with nothing to pair against, such as every degree above n of a model, it is the whole monomial basis. The name and the two forms were not reviewed by Pavel in R5g, and no alternative was recorded. Prior art: the Wolfram Language has no degenerate subspace of a graded pairing; NullSpace is the linear algebra it rests on. The engine of the verification suites computes the same basis, and T17 pins the function against it in degrees 0 to n+2 on the thirteen catalogue models and the Kodaira-Thurston model. -->

## Details & Options

- An element is degenerate when it pairs to zero with everything.
- Since the pairing has degree $n$, only degree $n-k$ tests degree $k$, and the basis is the null space of one pairing matrix.
- The basis elements are linear combinations of the basis monomials of degree *k*.
- In a degree with no basis elements of degree $n-k$, the whole degree is degenerate. For a model this holds in every degree above $n$.
- $V_{\mathrm{deg}}$ is closed under the differential, because $\langle\mathrm{d}v_1,v_2\rangle = \pm\langle v_1,\mathrm{d}v_2\rangle$.
- When there is a product, $V_{\mathrm{deg}}$ is an ideal, because $\langle v_1v_2,v_3\rangle = \langle v_1,v_2v_3\rangle$. It is then a differential graded ideal, and the quotient by it is again a differential graded algebra, [NondegenerateQuotient]().

## Basic Examples

The degenerate subspace of the model of $\mathbb{CP}^2$ in degree $5$:

```wl
DegenerateSubspace[SullivanModel["ComplexProjectiveSpace"[2]], 5]
```

<!-- => {b} -->

---

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

Nothing is degenerate up to degree $4$, and everything is degenerate above it:

```wl
Table[DegenerateSubspace[model, k], {k, 0, 7}]
```

<!-- => {{}, {}, {}, {}, {}, {b}, {a^3}, {a b}} -->

## Scope

The model of a nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1, of degree 3 -->

It has no degenerate elements: the pairing is already perfect, so the model is its own nondegenerate quotient:

```wl
Table[DegenerateSubspace[model, k], {k, 0, 4}]
```

<!-- => {{}, {}, {}, {}, {}} -->

---

The degree-$4$ obstruction:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, dc = 0 and da = c, of degree 4, truncated above degree 4 -->

It has a degenerate element in degree $3$:

```wl
DegenerateSubspace[model, 3]
```

<!-- => {c} -->

The element is closed, which is why the model is not of Hodge type:

```wl
SullivanModelDifferential[c, model]
```

<!-- => 0 -->

---

A complex of degree $3$ with $\langle a, \mathrm{d}a\rangle = \langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

In degree $2$ the degenerate subspace is spanned by a combination of basis elements:

```wl
DegenerateSubspace[complex, 2]
```

<!-- => {b - da} -->

In degree $3$ it is spanned by $\mathrm{d}b$:

```wl
DegenerateSubspace[complex, 3]
```

<!-- => {db} -->

## Properties and Relations

The model of $\mathbb{CP}^2$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 5, of degree 4 -->

The dimensions of the degenerate subspace:

```wl
Table[Length[DegenerateSubspace[model, k]], {k, 0, 7}]
```

<!-- => {0, 0, 0, 0, 0, 1, 1, 1} -->

They are the third column of [HodgeTypeReport]():

```wl
Normal[Values[HodgeTypeReport[model][All, "Degenerate"]]]
```

<!-- => {0, 0, 0, 0, 0, 1, 1, 1} -->

---

The model of the three-torus:

```wl
model = SullivanModel["Torus"[3]]
```

<!-- => a SullivanModel object with generators v1, v2, v3 of degree 1 and zero differential, of degree 3 -->

Nothing is degenerate in the degrees $0$ to $3$, where the model has dimensions $1, 3, 3, 1$:

```wl
Table[{Length[SullivanModelBasis[model, k]], Length[DegenerateSubspace[model, k]]}, {k, 0, 3}]
```

<!-- => {{1, 0}, {3, 0}, {3, 0}, {1, 0}} -->
