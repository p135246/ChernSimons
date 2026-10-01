---
Template: Symbol
Name: FindPreHodgeDecomposition
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/FindPreHodgeDecomposition
Keywords: [pre-Hodge decomposition, harmonic subspace, coexact part, harmonic projection, Hodge decomposition]
SeeAlso: [PreHodgeDecomposition, FindHodgeDecomposition, FindHarmonicSubspace, RelationsQ, CochainComplexWithPairing, PoincareDualityQ]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[FindPreHodgeDecomposition]()[*space*]</code> finds a pre-Hodge decomposition $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ of a [SullivanModel]() or a [CochainComplexWithPairing](), with the harmonic subspace <code>[FindHarmonicSubspace]()[*space*]</code>.

<code>[FindPreHodgeDecomposition]()[*space*, *harmonic*]</code> finds one with the given harmonic subspace, an Association from degrees to bases.

<!-- #| annotation: 26.09.30: Design review - design 4 of the names doc (R5g): a pre-Hodge decomposition is found, not constructed, and as with FindRoot the answer is one of many and there may be none, so a failure is a Failure naming the degrees rather than an expression returned unevaluated. The function takes no Method: the harmonic subspace is its second argument, so a subspace found by either rule of FindHarmonicSubspace, or one's own, reaches it, and the first form is the second with FindHarmonicSubspace[space]. The coexact part is then determined by a basis-order rule inside the perpendicular complement of the harmonic subspace. The given subspace is checked, and a subspace that is not a complement of im d in the cocycles is a Failure of its own. For a model the decomposition is of the complex of the model, which carries its Hodge type, and the result keeps that complex under "Complex". The constructor forms PreHodgeDecomposition[space, ...] and the recognizer PreHodgeDecompositionQ went with no alias; the axioms are the relations of the result. Prior art: the Wolfram Language has no Hodge decompositions of a cochain complex; the Find prefix follows FindRoot and FindInstance. The engine of the verification suites has no counterpart; T17 pins the decomposition with a given harmonic subspace, the failing degrees of each axiom on modified decompositions, and the Failure of Example 4.3 of arXiv:2609.14221 in the degrees 21, 23, 44, 49 and 53. -->

## Details & Options

- A pre-Hodge decomposition of $(V, \mathrm{d}, \langle-,-\rangle)$ is a splitting $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ with $\mathcal{H}$ a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$, $C$ a complement of $\ker\mathrm{d}$, and $\mathcal{H}\perp C$ (arXiv:2004.07362, Definition 4.1).
- A Hodge decomposition asks in addition for $C\perp C$; [FindHodgeDecomposition]() finds one.
- The result is a [PreHodgeDecomposition]() object, with keys `"Harmonic"`, `"Coexact"` and `"Complex"`.
- For a model the decomposition is of <code>[CochainComplexWithPairing]()[*model*]</code>, which is the value of `"Complex"`.
- In degree $k$ the coexact part is the first elements, basis elements perpendicular to $\mathcal{H}^{n-k}$ first, that are independent modulo the cocycles inside the perpendicular complement of $\mathcal{H}^{n-k}$.
- When the pairing on cohomology is perfect, every harmonic subspace admits such a coexact part (arXiv:2004.07362, Lemma 4.3).
- Otherwise a harmonic class can pair nontrivially with an element that is not closed. The result is then a [Failure]() whose `"Degrees"` name the degrees where no coexact part exists.
- The result is also a [Failure]() when the given subspace is not a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$.

## Basic Examples

The Heisenberg nilmanifold, $\Lambda(x, y, z)$ with $\mathrm{d}z = xy$:

```wl
decomposition = FindPreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 1: 2, 2: 2, 3: 1 and coexact dimensions 1: 1 -->

Its harmonic subspace:

```wl
decomposition["Harmonic"]
```

<!-- => <|0 -> {1}, 1 -> {y, x}, 2 -> {y z, x z}, 3 -> {x y z}|> -->

Its coexact part:

```wl
decomposition["Coexact"]
```

<!-- => <|0 -> {}, 1 -> {z}, 2 -> {}, 3 -> {}|> -->

## Scope

A harmonic subspace of one's own choice:

```wl
decomposition = FindPreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"],
   <|0 -> {1}, 1 -> {x, y}, 2 -> {x z, y z}, 3 -> {x y z}|>]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 1: 2, 2: 2, 3: 1 and coexact dimensions 1: 1 -->

It keeps the given subspace:

```wl
decomposition["Harmonic", 1]
```

<!-- => {x, y} -->

It satisfies the axioms of a pre-Hodge decomposition:

```wl
RelationsQ[decomposition]
```

<!-- => True -->

---

A complex given by its data, of degree $3$ with $\langle a, \mathrm{d}a\rangle = \langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

Its pre-Hodge decomposition:

```wl
decomposition = FindPreHodgeDecomposition[complex]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 3: 1 and coexact dimensions 1: 1, 2: 1 -->

The harmonic subspace:

```wl
decomposition["Harmonic"]
```

<!-- => <|0 -> {1}, 1 -> {}, 2 -> {}, 3 -> {v}|> -->

The coexact part $\{a\}, \{b\}$ is perpendicular to the harmonic subspace:

```wl
decomposition["Coexact"]
```

<!-- => <|0 -> {}, 1 -> {a}, 2 -> {b}, 3 -> {}|> -->

## Properties and Relations

The same complex:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

Its pre-Hodge decomposition:

```wl
decomposition = FindPreHodgeDecomposition[complex]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 3: 1 and coexact dimensions 1: 1, 2: 1 -->

It satisfies the axioms [Relations]() names, which [RelationsQ]() tests:

```wl
RelationsQ[decomposition]
```

<!-- => True -->

It is not a Hodge decomposition: its coexact part is not isotropic in degrees $1$ and $2$, since $\langle a, b\rangle = 1$:

```wl
Obstruction[HodgeDecomposition[Normal[decomposition]], "Isotropic", {}]
```

<!-- => {1, 2} -->

[FindHodgeDecomposition]() twists the coexact part until it is:

```wl
FindHodgeDecomposition[complex]["Coexact", 2]
```

<!-- => {b - da} -->

## Possible Issues

A subspace that is not a complement of the exact cocycles in the cocycles is refused. The result is a [Failure](), whose message says so:

```wl
FindPreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"], <|1 -> {x}|>]["Message"]
```

<!-- => "The harmonic subspace is not a complement of the image of the differential in the cocycles." -->

---

Example 4.3 of arXiv:2609.14221, whose pairing on cohomology is degenerate:

```wl
model = SullivanModel[<|a5 -> 5, a9 -> 9, a15 -> 15, a17 -> 17, a21 -> 21, a23 -> 23|>,
   <|a21 -> a5 a17, a23 -> a9 a15|>, a5 a9 a21 a23]
```

<!-- => a SullivanModel object with generators a5, a9, a15, a17, a21, a23 of degrees 5, 9, 15, 17, 21, 23, da21 = a5 a17 and da23 = a9 a15, of degree 58 -->

In degree $21$ its only element $a_{21}$ is not closed, while the class of $a_5a_9a_{23}$ in degree $37$ pairs with it to $1$, so no complement of the cocycles is perpendicular to the harmonic subspace. The result is a [Failure]() naming the degrees:

```wl
FindPreHodgeDecomposition[model]["Degrees"]
```

<!-- => {21, 23, 44, 49, 53} -->
