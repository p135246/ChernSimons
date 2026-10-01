---
Template: Symbol
Name: HarmonicProjection
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HarmonicProjection
Keywords: [harmonic projection, harmonic subspace, orthogonal projection, special propagator, Hodge decomposition]
SeeAlso: [SpecialPropagator, FindHodgeDecomposition, FindPreHodgeDecomposition, FindHarmonicSubspace, HodgeDecomposition, PreHodgeDecomposition]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[HarmonicProjection]()[*decomposition*]</code> gives the projection $\pi$ onto the harmonic subspace $\mathcal{H}$ of a [HodgeDecomposition]() or a [PreHodgeDecomposition]() $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ along $\mathrm{im}\,\mathrm{d}\oplus C$, as an Association from degrees to the images of the basis.

<code>[HarmonicProjection]()[*propagator*]</code> gives $\pi = \mathrm{Id} + \mathrm{d}P + P\mathrm{d}$ for a [SpecialPropagator]() $P$.

<code>[HarmonicProjection]()[*e*, *decomposition*]</code> gives $\pi(e)$ for an element *e*.

<code>[HarmonicProjection]()[*e*, *propagator*]</code> gives $\pi(e)$ for an element *e*.

<!-- #| annotation: 26.10.01: Design review - built in HodgeDecompositions H5 from the blueprint of H4, whose ten choices Pavel kept in H4a. The projection is returned in the shape of the "Images" of a SpecialPropagator, degree to basis element to image, so the two read alike; the forms with an element apply it. It takes a pre-Hodge decomposition as well as a Hodge one, beyond the Spec's blueprint, which names decompositions and propagators: the projection onto H along im d + C is the orthogonal projection onto H for both, since C and im d are perpendicular to H, and when the pairing on cohomology is perfect it is the unique harmonic projection with image H (arXiv:2004.07362, Lemma 4.3), so the Hodge twist does not change it. For a propagator it is Id + d P + P d, which is the same map as for its decomposition by Lemma 3.18. No form takes a space: the projection depends on the harmonic subspace, which FindHarmonicSubspace chooses, so it is read off a decomposition, and HarmonicProjection[space] returns unevaluated. The harmonic subspace of a propagator is FindHodgeDecomposition[p]["Harmonic"], so there is no HarmonicSubspace of a propagator. Prior art: the Wolfram Language has Projection onto a vector, not a projection of a cochain complex onto its harmonic subspace. The engine of the verification suites has no counterpart. -->

## Details & Options

- A harmonic projection of a cochain complex with a pairing $(V, \mathrm{d}, \langle-,-\rangle)$ is a linear projection $\pi$ of degree $0$ with $\ker\mathrm{d} = \mathrm{im}\,\pi\oplus\mathrm{im}\,\mathrm{d}$, $\mathrm{im}\,\mathrm{d}\subset\ker\pi$ and $\langle\pi v, w\rangle = \langle v, \pi w\rangle$ (arXiv:2004.07362, Definition 3.16).
- For a decomposition $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ the projection onto $\mathcal{H}$ along $\mathrm{im}\,\mathrm{d}\oplus C$ is a harmonic projection, the orthogonal projection onto $\mathcal{H}$, since $\mathrm{im}\,\mathrm{d}$ and $C$ are perpendicular to $\mathcal{H}$.
- When the pairing on cohomology is perfect, $\mathcal{H}$ has exactly one harmonic projection onto it (arXiv:2004.07362, Lemma 4.3), so a pre-Hodge and a Hodge decomposition with the same harmonic subspace have the same projection.
- For a special propagator $P$ the map $\mathrm{Id} + \mathrm{d}P + P\mathrm{d}$ is a harmonic projection with $P\pi = \pi P = 0$, and for the propagator of a Hodge decomposition it is the projection of that decomposition (arXiv:2004.07362, Lemma 3.18).
- The result is an Association from degrees to Associations from basis elements to their images, the shape of the `"Images"` of a [SpecialPropagator]().
- In the forms with an element, *e* is a linear combination of basis elements of the complex, and anything else returns unevaluated.
- For a [SullivanModel]() the complex is <code>[CochainComplexWithPairing]()[*model*]</code>.
- A space returns unevaluated.

## Basic Examples

Example 6.1 of arXiv:2004.07362 over $\mathbb{Q}$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 1, 4: 1, of degree 4 -->

The harmonic projection of its Hodge decomposition, the identity on $1$ and $v$ and zero on the rest:

```wl
HarmonicProjection[FindHodgeDecomposition[complex]]
```

<!-- => <|0 -> <|1 -> 1|>, 1 -> <|a -> 0|>, 2 -> <|da -> 0, b -> 0|>, 3 -> <|db -> 0|>, 4 -> <|v -> v|>|> -->

---

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

A Hodge decomposition with the harmonic element $v + \mathrm{d}b$:

```wl
decomposition = FindHodgeDecomposition[complex, <|0 -> {1}, 3 -> {v + db}|>]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 3: 1 and coexact dimensions 1: 1, 2: 1 -->

The projection of $v$:

```wl
HarmonicProjection[v, decomposition]
```

<!-- => db + v -->

The projection of the exact element $\mathrm{d}b$:

```wl
HarmonicProjection[db, decomposition]
```

<!-- => 0 -->

## Scope

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

The propagator of a Hodge decomposition with the harmonic element $v + \mathrm{d}b$:

```wl
p = SpecialPropagator[FindHodgeDecomposition[complex, <|0 -> {1}, 3 -> {v + db}|>]]
```

<!-- => a SpecialPropagator object with nonzero images 2: 2, 3: 2 -->

Its harmonic projection $\mathrm{Id} + \mathrm{d}P + P\mathrm{d}$:

```wl
HarmonicProjection[p]
```

<!-- => <|0 -> <|1 -> 1|>, 1 -> <|a -> 0|>, 2 -> <|da -> 0, b -> 0|>, 3 -> <|db -> 0, v -> db + v|>|> -->

Applied to $v$:

```wl
HarmonicProjection[v, p]
```

<!-- => db + v -->

---

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

The harmonic projection of a pre-Hodge decomposition, with the harmonic subspace $\{1\}, \{v\}$:

```wl
HarmonicProjection[FindPreHodgeDecomposition[complex]]
```

<!-- => <|0 -> <|1 -> 1|>, 1 -> <|a -> 0|>, 2 -> <|da -> 0, b -> 0|>, 3 -> <|db -> 0, v -> v|>|> -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1 and dz = x y, of degree 3 -->

The projection keeps the harmonic element $xz$ and kills the exact element $xy$:

```wl
HarmonicProjection[x z + x y, FindHodgeDecomposition[model]]
```

<!-- => x z -->

## Properties and Relations

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

A Hodge decomposition with the harmonic element $v + \mathrm{d}b$:

```wl
decomposition = FindHodgeDecomposition[complex, <|0 -> {1}, 3 -> {v + db}|>]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 3: 1 and coexact dimensions 1: 1, 2: 1 -->

The projection of the decomposition is $\mathrm{Id} + \mathrm{d}P + P\mathrm{d}$ for its propagator:

```wl
HarmonicProjection[decomposition] === HarmonicProjection[SpecialPropagator[decomposition]]
```

<!-- => True -->

It is a projection:

```wl
HarmonicProjection[HarmonicProjection[v, decomposition], decomposition]
```

<!-- => db + v -->

The propagator vanishes on its image:

```wl
SpecialPropagator[decomposition][HarmonicProjection[v, decomposition]]
```

<!-- => 0 -->

---

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

Its pre-Hodge and its Hodge decomposition differ in the coexact part $b$ against $b - \mathrm{d}a$ and share the harmonic subspace, so they have the same projection:

```wl
HarmonicProjection[FindPreHodgeDecomposition[complex]] === HarmonicProjection[FindHodgeDecomposition[complex]]
```

<!-- => True -->

## Possible Issues

The projection depends on the harmonic subspace, and a space has many, so a space returns unevaluated:

```wl
HarmonicProjection[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => the expression returns unevaluated -->

---

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

With the harmonic subspace of [FindHarmonicSubspace](), $v$ is harmonic:

```wl
HarmonicProjection[v, FindHodgeDecomposition[complex]]
```

<!-- => v -->

With the harmonic element $v + \mathrm{d}b$ it is not:

```wl
HarmonicProjection[v, FindHodgeDecomposition[complex, <|0 -> {1}, 3 -> {v + db}|>]]
```

<!-- => db + v -->
