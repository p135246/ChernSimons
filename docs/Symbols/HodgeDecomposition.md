---
Template: Symbol
Name: HodgeDecomposition
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HodgeDecomposition
Keywords: [Hodge decomposition, harmonic subspace, coexact part, Hodge type, Hodge twist, special propagator]
SeeAlso: [FindHodgeDecomposition, PreHodgeDecomposition, FindHarmonicSubspace, Relations, RelationsQ, HodgeTypeQ, SpecialPropagator]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[HodgeDecomposition]()[*data*]</code> is a Hodge decomposition $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ of a [CochainComplexWithPairing](), a pre-Hodge decomposition with $C\perp C$, the result of [FindHodgeDecomposition]().

<!-- #| annotation: 26.09.30: Design review - since R5g (design 4 of the names doc) the head is the result of FindHodgeDecomposition and no longer a constructor: the forms HodgeDecomposition[space] and HodgeDecomposition[pre, twist], the export HodgeTwist and the recognizer HodgeDecompositionQ went with no alias, and the twist is private to FindHodgeDecomposition. The object has the keys and accessors of PreHodgeDecomposition, so every function that reads a pre-Hodge decomposition reads this one, and its relations are those of a pre-Hodge decomposition followed by "Isotropic", of arity 0, whose Obstruction is 0 or the list of the degrees where the coexact part is not isotropic (R5g, kept by Pavel). The data of a pre-Hodge decomposition may be put under this head to ask whether it is already a Hodge decomposition. Prior art: the Wolfram Language has no Hodge decompositions of a cochain complex. The engine of the verification suites has no counterpart; T17 pins the axioms of the decompositions found on the catalogue, checked directly on the models, and the failing degrees of each axiom on modified decompositions. -->

## Details & Options

- A Hodge decomposition of $(V, \mathrm{d}, \langle-,-\rangle)$ is a pre-Hodge decomposition whose coexact part is isotropic: $\mathcal{H}$ is a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$, $C$ a complement of $\ker\mathrm{d}$, and $C\perp C\oplus\mathcal{H}$ (arXiv:2004.07362, Definition 3.9).
- The object is found, not constructed: [FindHodgeDecomposition]() gives it.
- It has the keys and the accessors of [PreHodgeDecomposition](): `"Harmonic"`, `"Coexact"` and `"Complex"`, and *decomposition*[`"Harmonic"`, *k*] and *decomposition*[`"Coexact"`, *k*] for one degree.
- <code>[Relations]()[*decomposition*]</code> gives those of a pre-Hodge decomposition and one more axiom of arity $0$, `"Isotropic"`: $C\perp C$.
- [RelationsQ]() tests all of them, and [Obstruction]() of an axiom lists the degrees where it fails.
- The object displays as a summary box: the dimensions of the harmonic subspace and of the coexact part, with their bases and the complex under the opener.

## Basic Examples

A Hodge decomposition of the Kodaira-Thurston nilmanifold, found by [FindHodgeDecomposition]():

```wl
decomposition = FindHodgeDecomposition[SullivanModel["KodairaThurston"]]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 1: 3, 2: 4, 3: 3, 4: 1 and coexact dimensions 1: 1, 2: 1 -->

Its coexact part:

```wl
decomposition["Coexact"]
```

<!-- => <|0 -> {}, 1 -> {z}, 2 -> {t z}, 3 -> {}, 4 -> {}|> -->

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

In the middle degree there is no harmonic element:

```wl
decomposition["Harmonic", 2]
```

<!-- => {} -->

The coexact part in the middle degree is twisted:

```wl
decomposition["Coexact", 2]
```

<!-- => {b - da/2} -->

## Properties and Relations

A Hodge decomposition of the Kodaira-Thurston nilmanifold:

```wl
decomposition = FindHodgeDecomposition[SullivanModel["KodairaThurston"]]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 1: 3, 2: 4, 3: 3, 4: 1 and coexact dimensions 1: 1, 2: 1 -->

The last relation is the isotropy of the coexact part:

```wl
Last[Normal[Relations[decomposition]]]
```

<!-- => "Isotropic" -> 0 -->

The relations hold:

```wl
RelationsQ[decomposition]
```

<!-- => True -->

---

A complex of degree $3$ with $\langle a, b\rangle = 1$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>,
   <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 2, of degree 3 -->

Its pre-Hodge decomposition under the head [HodgeDecomposition]():

```wl
candidate = HodgeDecomposition[Normal[FindPreHodgeDecomposition[complex]]]
```

<!-- => a HodgeDecomposition object with harmonic dimensions 0: 1, 3: 1 and coexact dimensions 1: 1, 2: 1 -->

It is a Hodge decomposition exactly when its coexact part is isotropic, and here it is not:

```wl
RelationsQ[candidate]
```

<!-- => False -->

It fails in degrees $1$ and $2$, since $\langle a, b\rangle = 1$:

```wl
Obstruction[candidate, "Isotropic", {}]
```

<!-- => {1, 2} -->

The decomposition [FindHodgeDecomposition]() finds is one:

```wl
RelationsQ[FindHodgeDecomposition[complex]]
```

<!-- => True -->
