---
Template: Symbol
Name: SpecialPropagator
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SpecialPropagator
Keywords: [special propagator, homotopy operator, Hodge decomposition, harmonic projection, deformation retract]
SeeAlso: [FindHodgeDecomposition, HodgeDecomposition, HarmonicProjection, Relations, RelationsQ, CochainComplexWithPairing]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[SpecialPropagator]()[*decomposition*]</code> gives the special propagator $P$ of a [HodgeDecomposition]() $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$, with $P(\mathrm{d}c) = -c$ for $c\in C$ and $P = 0$ on $\mathcal{H}\oplus C$.

<code>[SpecialPropagator]()[*data*]</code> is a special propagator given by an Association with the keys `"Images"` and `"Decomposition"`.

<!-- #| annotation: 26.10.01: Design review - built in HodgeDecompositions H5 from the blueprint of H4, whose ten choices Pavel kept in H4a. The propagator is computed once and applied many times, so it is an inert object that applies to an element as a LinearSolveFunction does, p[e]; SpecialPropagator[e, decomposition], computing P again for each element, was the alternative. The object carries the decomposition it came from, as a decomposition carries its complex, so its relations are those of the propagator followed by those of the decomposition; carrying only the complex, from which FindHodgeDecomposition[p] recovers the decomposition, was the alternative. The four relations of Definition 3.16 are conditions on the operator in every degree, so they have arity 0 and Obstruction lists the degrees where they fail, as for the axioms of a decomposition; identities on one and on two elements, arities 1, 1, 1 and 2 as for a complex, were the alternative. There is no SpecialPropagatorQ: RelationsQ tests the relations. A pre-Hodge decomposition gives a special homotopy operator without the symmetry (arXiv:2004.07362, Remark 4.2), not a propagator, so SpecialPropagator of one returns unevaluated. A decomposition whose parts are not a basis in some degree has no propagator and returns unevaluated as well; data whose images miss a basis element, or send an element of degree k outside the span of the basis of degree k - 1, is not a propagator, and Relations, Obstruction, RelationsQ and the application return unevaluated on it. The images are found by one inverse matrix per degree, of the frame of the decomposition in the basis. Prior art: the Wolfram Language has no homotopy operators of a cochain complex. In homological perturbation theory P is the homotopy of a special deformation retract onto the harmonic subspace, with the side conditions hh = 0, hi = 0 and ph = 0, which are P^2 = 0 and P pi = pi P = 0; the symmetry with respect to the pairing is what a propagator adds. The engine of the verification suites has no counterpart. -->

## Details & Options

- A special propagator of a cochain complex with a pairing $(V, \mathrm{d}, \langle-,-\rangle)$ is a linear map $P\colon V\to V$ of degree $-1$ with $\mathrm{d}P\mathrm{d} = -\mathrm{d}$, $P\mathrm{d}P = -P$, $P^2 = 0$ and $\langle Pv, w\rangle = (-1)^{\lvert v\rvert}\langle v, Pw\rangle$ (arXiv:2004.07362, Definition 3.16).
- Special propagators and Hodge decompositions correspond one to one: the propagator of a decomposition is $-c$ on $\mathrm{d}c$ for $c\in C$ and $0$ on $\mathcal{H}\oplus C$, and a propagator gives back $\mathcal{H} = \mathrm{im}\,\pi$ and $C = \mathrm{im}\,P$ with $\pi = \mathrm{Id} + \mathrm{d}P + P\mathrm{d}$ (arXiv:2004.07362, Lemma 3.18).
- In each degree $k$ the images of the basis of $V^k$ come from writing it in the basis $\mathcal{H}^k\cup\mathrm{d}C^{k-1}\cup C^k$ of the decomposition.
- The result is a [SpecialPropagator]() object, read with *p*[*key*] and [Normal](). It has the following keys:

| Key | Value |
|---|---|
| `"Images"` | the images of the basis, an Association from degrees to Associations from basis elements to their images |
| `"Decomposition"` | the [HodgeDecomposition]() whose propagator it is |

- *p*[`"Images"`, *k*] gives the images of the basis of degree *k*, and `<||>` in a degree the complex does not have.
- *p*[*e*] gives $P(e)$ for an element *e*, a linear combination of basis elements of the complex, and returns unevaluated on anything else.
- For a [SullivanModel]() the complex is <code>[CochainComplexWithPairing]()[*model*]</code>, the model up to degree $n+1$ with the image of $\mathrm{d}$ in degree $n+2$.
- <code>[Relations]()[*p*]</code> gives four relations of arity $0$, followed by the relations of the decomposition:

| Relation | Condition |
|---|---|
| `"Chain"` | $\mathrm{d}P\mathrm{d} = -\mathrm{d}$ |
| `"Projector"` | $P\mathrm{d}P = -P$ |
| `"Square"` | $P^2 = 0$ |
| `"Symmetry"` | $\langle Pv, w\rangle = (-1)^{\lvert v\rvert}\langle v, Pw\rangle$ |

- [RelationsQ]() tests all of them.
- <code>[Obstruction]()[*p*, *relation*, {}]</code> of one of the four is $0$ when it holds, and otherwise the list of the degrees $\lvert v\rvert$ of the basis elements $v$ where it fails.
- <code>[FindHodgeDecomposition]()[*p*]</code> gives the Hodge decomposition with $\mathcal{H} = \mathrm{im}\,\pi$ and $C = \mathrm{im}\,P$, and <code>[HarmonicProjection]()[*p*]</code> gives $\pi$.
- The object displays as a summary box: the number of basis elements with a nonzero image in each degree, with the nonzero images and the decomposition under the opener.
- A [PreHodgeDecomposition]() or a space returns unevaluated.

## Basic Examples

Example 6.1 of arXiv:2004.07362 over $\mathbb{Q}$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 1, 4: 1, of degree 4 -->

Its Hodge decomposition, with the coexact elements $a$ and $b - \tfrac12\mathrm{d}a$:

```wl
decomposition = FindHodgeDecomposition[complex]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 4: 1 and coexact dimensions 1: 1, 2: 1 -->

Its special propagator:

```wl
p = SpecialPropagator[decomposition]
```

<!-- => a SpecialPropagator object with nonzero images 2: 2, 3: 1 -->

The images of the basis:

```wl
p["Images"]
```

<!-- => <|0 -> <|1 -> 0|>, 1 -> <|a -> 0|>, 2 -> <|da -> -a, b -> -a/2|>, 3 -> <|db -> -b + da/2|>, 4 -> <|v -> 0|>|> -->

$P$ sends $\mathrm{d}b$, the differential of the coexact element $b - \tfrac12\mathrm{d}a$, to minus that element:

```wl
p[db]
```

<!-- => -b + da/2 -->

$P$ vanishes on the coexact part:

```wl
p[b - da/2]
```

<!-- => 0 -->

## Scope

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1 and dz = x y, of degree 3 -->

The propagator of its Hodge decomposition:

```wl
p = SpecialPropagator[FindHodgeDecomposition[model]]
```

<!-- => a SpecialPropagator object with nonzero images 2: 1 -->

It sends $\mathrm{d}z = xy$ to $-z$:

```wl
p[SullivanModelDifferential[z, model]]
```

<!-- => -z -->

In degree $1$ every basis element is harmonic or coexact, and $P$ vanishes there:

```wl
p["Images", 1]
```

<!-- => <|z -> 0, y -> 0, x -> 0|> -->

The decomposition it came from:

```wl
p["Decomposition"]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 1: 2, 2: 2, 3: 1 and coexact dimensions 1: 1 -->

---

The propagator of the model of $\mathbb{CP}^2$, whose complex reaches degree $n+2 = 6$:

```wl
p = SpecialPropagator[FindHodgeDecomposition[SullivanModel["ComplexProjectiveSpace"[2]]]]
```

<!-- => a SpecialPropagator object with nonzero images 6: 1 -->

It sends $a^3 = \mathrm{d}b$ to $-b$:

```wl
p["Images", 6]
```

<!-- => <|a^3 -> -b|> -->

---

On the circle nothing is exact, and the propagator vanishes:

```wl
SpecialPropagator[FindHodgeDecomposition[SullivanModel["Circle"]]]["Images"]
```

<!-- => <|0 -> <|1 -> 0|>, 1 -> <|v -> 0|>|> -->

---

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

A Hodge decomposition with the harmonic element $v + \mathrm{d}b$ of one's own choice:

```wl
decomposition = FindHodgeDecomposition[complex, <|0 -> {1}, 3 -> {v + db}|>]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 3: 1 and coexact dimensions 1: 1, 2: 1 -->

Its propagator is nonzero on $v = (v + \mathrm{d}b) - \mathrm{d}b$:

```wl
SpecialPropagator[decomposition]["Images", 3]
```

<!-- => <|db -> -b + da, v -> b - da|> -->

## Properties and Relations

Example 6.1 of arXiv:2004.07362 over $\mathbb{Q}$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 1, 4: 1, of degree 4 -->

Its Hodge decomposition:

```wl
decomposition = FindHodgeDecomposition[complex]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 4: 1 and coexact dimensions 1: 1, 2: 1 -->

Its propagator:

```wl
p = SpecialPropagator[decomposition]
```

<!-- => a SpecialPropagator object with nonzero images 2: 2, 3: 1 -->

The first four relations are those of the propagator, each of arity $0$:

```wl
Take[Relations[p], 4]
```

<!-- => <|"Chain" -> 0, "Projector" -> 0, "Square" -> 0, "Symmetry" -> 0|> -->

The relations of the decomposition follow, five of its complex and four of its own:

```wl
Length[Relations[p]]
```

<!-- => 13 -->

They hold:

```wl
RelationsQ[p]
```

<!-- => True -->

The decomposition of the propagator is the decomposition it came from:

```wl
FindHodgeDecomposition[p] === decomposition
```

<!-- => True -->

---

Example 6.1 of arXiv:2004.07362 over $\mathbb{Q}$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 1, 4: 1, of degree 4 -->

The propagator of its Hodge decomposition:

```wl
p = SpecialPropagator[FindHodgeDecomposition[complex]]
```

<!-- => a SpecialPropagator object with nonzero images 2: 2, 3: 1 -->

The same data with the image of $b$ set to $0$:

```wl
changed = SpecialPropagator[Append[Normal[p], "Images" -> ReplacePart[p["Images"], {Key[2], Key[b]} -> 0]]]
```

<!-- => a SpecialPropagator object with nonzero images 2: 1, 3: 1 -->

It still satisfies $\mathrm{d}P\mathrm{d} = -\mathrm{d}$:

```wl
Obstruction[changed, "Chain", {}]
```

<!-- => 0 -->

But $P^2\,\mathrm{d}b = -\tfrac12 a$, so $P^2 = 0$ fails in degree $3$:

```wl
Obstruction[changed, "Square", {}]
```

<!-- => {3} -->

And the symmetry fails for $b$ and for $\mathrm{d}b$:

```wl
Obstruction[changed, "Symmetry", {}]
```

<!-- => {2, 3} -->

## Possible Issues

A pre-Hodge decomposition gives an operator without the symmetry, and the expression returns unevaluated:

```wl
SpecialPropagator[FindPreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => the expression returns unevaluated -->

---

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

Its pre-Hodge decomposition under the head [HodgeDecomposition](), whose coexact part is not isotropic:

```wl
candidate = HodgeDecomposition[Normal[FindPreHodgeDecomposition[complex]]]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 3: 1 and coexact dimensions 1: 1, 2: 1 -->

The operator it gives is not symmetric, in degrees $1$, $2$ and $3$:

```wl
Obstruction[SpecialPropagator[candidate], "Symmetry", {}]
```

<!-- => {1, 2, 3} -->
