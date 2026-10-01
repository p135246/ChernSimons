---
Template: Symbol
Name: FindHodgeDecomposition
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/FindHodgeDecomposition
Keywords: [Hodge decomposition, harmonic subspace, coexact part, Hodge type, Hodge twist, special propagator]
SeeAlso: [HodgeDecomposition, FindPreHodgeDecomposition, FindHarmonicSubspace, RelationsQ, HodgeTypeQ, CochainComplexWithPairing, SpecialPropagator]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[FindHodgeDecomposition]()[*space*]</code> finds a Hodge decomposition $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ with $C\perp C\oplus\mathcal{H}$ of a [SullivanModel]() or a [CochainComplexWithPairing](), with the harmonic subspace <code>[FindHarmonicSubspace]()[*space*]</code>.

<code>[FindHodgeDecomposition]()[*space*, *harmonic*]</code> finds one with the given harmonic subspace, an Association from degrees to bases.

<code>[FindHodgeDecomposition]()[*propagator*]</code> gives the Hodge decomposition of a [SpecialPropagator]() $P$, with $\mathcal{H}$ the image of $\mathrm{Id} + \mathrm{d}P + P\mathrm{d}$ and $C$ the image of $P$.

<!-- #| annotation: 26.09.30: Design review - design 4 of the names doc (R5g), which Pavel asked for on 2026-09-30 ("We dont need HodgeTwist, do we?") and left to the session: the decomposition is found, and the function solves for the Hodge twist itself, so the twist is private and the export HodgeTwist, the recognizer HodgeDecompositionQ and the constructor forms HodgeDecomposition[space] and HodgeDecomposition[pre, twist] went with no alias. As with FindRoot the answer is one of many and there may be none, so a failure is a Failure naming the degrees. The function takes no Method: the harmonic subspace is its second argument, as for FindPreHodgeDecomposition. It starts from FindPreHodgeDecomposition with the same subspace, and a failure there passes through with its own tag, FindPreHodgeDecomposition, so the tag says at which step the search stopped; a failure of the twist is tagged FindHodgeDecomposition and its message ends with this harmonic subspace, since the subspace may be one's own. The twist of degree n is one exact linear system per pair of degrees, solved by LinearSolve after a rank comparison; the twist of a lower degree had no use and went with the export. Prior art: the Wolfram Language has no Hodge decompositions of a cochain complex; LinearSolve and MatrixRank are the linear algebra. The engine of the verification suites has no counterpart; T17 pins that a decomposition is found exactly where HodgeTypeQ is True on the catalogue, and the twist above and in the middle degree on three hand-built complexes. The form with a SpecialPropagator came with it in HodgeDecompositions H5 (2026-10-01), the converse half of Lemma 3.18: nothing is solved, and the bases are the first independent images in the order of the basis. The subspaces are always those of the decomposition the propagator came from; on the catalogue, with the default harmonic subspace, so are the bases, and the decomposition comes back identical, while with Method -> "Adjoint" it does not on the tori and the nilmanifolds. -->

## Details & Options

- A Hodge decomposition of $(V, \mathrm{d}, \langle-,-\rangle)$ is a splitting $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ with $\mathcal{H}$ a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$, $C$ a complement of $\ker\mathrm{d}$, and $C\perp C\oplus\mathcal{H}$ (arXiv:2004.07362, Definition 3.9).
- A space admitting one is of Hodge type, which [HodgeTypeQ]() decides without finding one.
- The result is a [HodgeDecomposition]() object, with keys `"Harmonic"`, `"Coexact"` and `"Complex"`.
- [FindHodgeDecomposition]() takes [FindPreHodgeDecomposition]() with the same harmonic subspace and replaces its coexact part $C$ by the graph $\{c + \rho(c)\}$ of a Hodge twist $\rho\colon C\to\mathrm{im}\,\mathrm{d}$ (arXiv:2004.07362, Definition 4.4).
- The twist has degree $0$, vanishes below degree $n/2$, and makes the graph isotropic: $\langle\rho c, c'\rangle + \langle c, \rho c'\rangle + \langle c, c'\rangle = 0$ for $c, c'\in C$.
- Above the middle degree the condition reads $\langle\rho c, c'\rangle + \langle c, c'\rangle = 0$ for $c\in C^i$, $c'\in C^{n-i}$.
- Each pair of degrees is one exact linear system, and the twist is the solution [LinearSolve]() gives.
- When the pairing on cohomology is perfect, a twist exists exactly when the space is of Hodge type, since any harmonic subspace then extends to a Hodge decomposition (arXiv:2004.07362, Remark 3.13).
- When [FindPreHodgeDecomposition]() gives a [Failure](), the result is that [Failure](), with its tag.
- When the twist condition has no solution, the result is a [Failure]() whose `"Degrees"` name the degrees.
- <code>[FindHodgeDecomposition]()[*p*]</code> takes $\mathcal{H}^k$ spanned by the images $\pi(e)$ and $C^k$ by the elements $-P(e)$, for $e$ in the basis of degrees $k$ and $k+1$, the first independent ones in the order of the basis (arXiv:2004.07362, Lemma 3.18).

## Basic Examples

A Hodge decomposition of the Kodaira-Thurston nilmanifold:

```wl
FindHodgeDecomposition[SullivanModel["KodairaThurston"]]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 1: 3, 2: 4, 3: 3, 4: 1 and coexact dimensions 1: 1, 2: 1 -->

---

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

The harmonic subspace:

```wl
decomposition["Harmonic"]
```

<!-- => <|0 -> {1}, 1 -> {}, 2 -> {}, 3 -> {}, 4 -> {v}|> -->

The coexact element $b$ has $\langle b, b\rangle = 1$ and $\langle \mathrm{d}a, b\rangle = 1$, so the twist is $\rho(b) = -\tfrac12\mathrm{d}a$ and the decomposition replaces $b$ by $b - \tfrac12\mathrm{d}a$:

```wl
decomposition["Coexact"]
```

<!-- => <|0 -> {}, 1 -> {a}, 2 -> {b - da/2}, 3 -> {}, 4 -> {}|> -->

## Scope

A model of a formal space:

```wl
decomposition = FindHodgeDecomposition[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 2: 1, 4: 1 and coexact dimensions 5: 1 -->

The harmonic subspace is the cohomology ring:

```wl
decomposition["Harmonic"]
```

<!-- => <|0 -> {1}, 2 -> {a}, 4 -> {a^2}, 5 -> {}, 6 -> {}|> -->

The coexact part is what the differential does not kill:

```wl
decomposition["Coexact"]
```

<!-- => <|0 -> {}, 2 -> {}, 4 -> {}, 5 -> {b}, 6 -> {}|> -->

---

Above the middle degree: a complex with $n = 3$ and $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

The pre-Hodge decomposition has the coexact element $b$ in degree $2$:

```wl
FindPreHodgeDecomposition[complex]["Coexact", 2]
```

<!-- => {b} -->

The twist $\rho(b) = -\mathrm{d}a$ makes the coexact part isotropic:

```wl
FindHodgeDecomposition[complex]["Coexact", 2]
```

<!-- => {b - da} -->

---

The model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1 and dz = x y, of degree 3 -->

A harmonic subspace of one's own choice is kept:

```wl
FindHodgeDecomposition[model, <|0 -> {1}, 1 -> {x, y}, 2 -> {x z, y z}, 3 -> {x y z}|>]["Harmonic", 1]
```

<!-- => {x, y} -->

## Properties and Relations

Over the catalogue a Hodge decomposition is found exactly where [HodgeTypeQ]() is True:

```wl
AllTrue[{"Sphere"[2], "ComplexProjectiveSpace"[3], "Torus"[3], "HeisenbergNilmanifold", "Degree4Obstruction"},
  name |-> HodgeTypeQ[SullivanModel[name]] === ! FailureQ[FindHodgeDecomposition[SullivanModel[name]]]]
```

<!-- => True -->

---

Each decomposition found satisfies its relations:

```wl
AllTrue[{"Sphere"[2], "ComplexProjectiveSpace"[3], "Torus"[3], "HeisenbergNilmanifold"},
  name |-> RelationsQ[FindHodgeDecomposition[SullivanModel[name]]]]
```

<!-- => True -->

---

The model of the Kodaira-Thurston nilmanifold:

```wl
model = SullivanModel["KodairaThurston"]
```

<!-- => a SullivanModel object with generators x, y, z, t of degree 1 and dz = x y, of degree 4 -->

It needs no twist: its pre-Hodge decomposition is already a Hodge decomposition:

```wl
FindHodgeDecomposition[model]["Coexact"] === FindPreHodgeDecomposition[model]["Coexact"]
```

<!-- => True -->

---

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

Its special propagator:

```wl
p = SpecialPropagator[decomposition]
```

<!-- => a SpecialPropagator object with nonzero images 2: 2, 3: 1 -->

The decomposition of the propagator is the decomposition it came from:

```wl
FindHodgeDecomposition[p] === decomposition
```

<!-- => True -->

## Possible Issues

The degree-$4$ obstruction of Example 6.3 of arXiv:2004.07362 has $\langle a, a\rangle = 1$ with $a$ spanning the whole of degree $2$ and nothing exact there, so the middle-degree condition has no solution. The result is a [Failure]() naming the degree:

```wl
FindHodgeDecomposition[SullivanModel["Degree4Obstruction"]]["Degrees"]
```

<!-- => {2} -->

Its message:

```wl
FindHodgeDecomposition[SullivanModel["Degree4Obstruction"]]["Message"]
```

<!-- => "The twist condition has no solution in degrees {2}, so there is no Hodge decomposition with this harmonic subspace." -->

---

Example 4.3 of arXiv:2609.14221 has a degenerate pairing on cohomology:

```wl
model = SullivanModel[<|a5 -> 5, a9 -> 9, a15 -> 15, a17 -> 17, a21 -> 21, a23 -> 23|>,
   <|a21 -> a5 a17, a23 -> a9 a15|>, a5 a9 a21 a23]
```

<!-- => a SullivanModel object with generators a5, a9, a15, a17, a21, a23 of degrees 5, 9, 15, 17, 21, 23, da21 = a5 a17 and da23 = a9 a15, of degree 58 -->

The search stops before the twist, and the [Failure]() carries the tag of the pre-Hodge step:

```wl
FindHodgeDecomposition[model]["Tag"]
```

<!-- => "FindPreHodgeDecomposition" -->
