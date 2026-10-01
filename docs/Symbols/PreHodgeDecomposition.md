---
Template: Symbol
Name: PreHodgeDecomposition
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/PreHodgeDecomposition
Keywords: [pre-Hodge decomposition, harmonic subspace, coexact part, harmonic projection, Hodge decomposition]
SeeAlso: [FindPreHodgeDecomposition, HodgeDecomposition, FindHarmonicSubspace, Relations, RelationsQ, CochainComplexWithPairing]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[PreHodgeDecomposition]()[*data*]</code> is a pre-Hodge decomposition $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ of a [CochainComplexWithPairing](), with the keys `"Harmonic"`, `"Coexact"` and `"Complex"`, the result of [FindPreHodgeDecomposition]().

<!-- #| annotation: 26.09.30: Design review - since R5g (design 4 of the names doc) the head is the result of FindPreHodgeDecomposition and no longer a constructor: the forms PreHodgeDecomposition[space, ...] and the recognizer PreHodgeDecompositionQ went with no alias, and a head given a space is inert. The object is an Association of the harmonic subspace and the coexact part, each from degrees to bases, and the complex decomposed, which for a model is the complex of the model. decomposition["Harmonic", k] and decomposition["Coexact", k] read one degree and give {} where the decomposition has none; the second form replaced CoexactSubspace[d, k], without which one degree of the coexact part would need Lookup. The axioms are relations: those of the complex, followed by "Harmonic", "Coexact" and "Perpendicular", each of arity 0, since they are conditions on subspaces in every degree rather than identities on arguments, and Obstruction of such an axiom is 0 or the list of the degrees where it fails, as the Failure of FindPreHodgeDecomposition names degrees (R5g, kept by Pavel). A loop over Relations still runs, since Tuples of a basis of length 0 is one empty tuple. Prior art: the Wolfram Language has no Hodge decompositions of a cochain complex. The engine of the verification suites has no counterpart; T17 pins the failing degrees of each axiom on modified decompositions. -->

## Details & Options

- A pre-Hodge decomposition of $(V, \mathrm{d}, \langle-,-\rangle)$ is a splitting $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ with $\mathcal{H}$ a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$, $C$ a complement of $\ker\mathrm{d}$, and $\mathcal{H}\perp C$ (arXiv:2004.07362, Definition 4.1).
- The object is found, not constructed: [FindPreHodgeDecomposition]() gives it.
- It is read with *decomposition*[*key*] and [Normal](). It has the following keys:

| Key | Value |
|---|---|
| `"Harmonic"` | the harmonic subspace $\mathcal{H}$, a basis in each degree |
| `"Coexact"` | the coexact part $C$, a basis in each degree |
| `"Complex"` | the [CochainComplexWithPairing]() decomposed; for a model, <code>[CochainComplexWithPairing]()[*model*]</code> |

- *decomposition*[`"Harmonic"`, *k*] and *decomposition*[`"Coexact"`, *k*] give the basis of degree *k*, and `{}` in a degree the decomposition does not have.
- <code>[Relations]()[*decomposition*]</code> gives the relations of its complex and three axioms of arity $0$: `"Harmonic"`, $\mathcal{H}$ is a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$; `"Coexact"`, $C$ is a complement of $\ker\mathrm{d}$; and `"Perpendicular"`, $C\perp\mathcal{H}$.
- [RelationsQ]() tests all of them.
- <code>[Obstruction]()[*decomposition*, *axiom*, {}]</code> of one of the three axioms is $0$ when it holds in every degree, and otherwise the list of the degrees where it fails.
- The object displays as a summary box: the dimensions of the harmonic subspace and of the coexact part, with their bases and the complex under the opener.
- The head applied to anything but such an Association is inert.

## Basic Examples

A pre-Hodge decomposition of the Heisenberg nilmanifold, found by [FindPreHodgeDecomposition]():

```wl
decomposition = FindPreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 1: 2, 2: 2, 3: 1 and coexact dimensions 1: 1 -->

Its harmonic subspace of degree $1$:

```wl
decomposition["Harmonic", 1]
```

<!-- => {y, x} -->

Its coexact part of degree $1$:

```wl
decomposition["Coexact", 1]
```

<!-- => {z} -->

Its keys:

```wl
Keys[decomposition]
```

<!-- => {"Harmonic", "Coexact", "Complex"} -->

## Scope

A pre-Hodge decomposition of the model of $\mathbb{CP}^2$:

```wl
decomposition = FindPreHodgeDecomposition[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 2: 1, 4: 1 and coexact dimensions 5: 1 -->

The complex it decomposes is the complex of the model:

```wl
decomposition["Complex"]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 2: 1, 4: 1, 5: 1, 6: 1, of degree 4, with a product -->

The coexact part of degree $5$:

```wl
decomposition["Coexact", 5]
```

<!-- => {b} -->

A degree the decomposition does not have gives the empty basis:

```wl
decomposition["Harmonic", 3]
```

<!-- => {} -->

## Properties and Relations

A pre-Hodge decomposition of the Heisenberg nilmanifold:

```wl
decomposition = FindPreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 1: 2, 2: 2, 3: 1 and coexact dimensions 1: 1 -->

It has the eleven relations of its complex and three of its own:

```wl
Length[Relations[decomposition]]
```

<!-- => 14 -->

Its own axioms come after the relations of the complex, each of arity $0$:

```wl
KeyTake[Relations[decomposition], {"Harmonic", "Coexact", "Perpendicular"}]
```

<!-- => <|"Harmonic" -> 0, "Coexact" -> 0, "Perpendicular" -> 0|> -->

They hold:

```wl
RelationsQ[decomposition]
```

<!-- => True -->

---

A pre-Hodge decomposition of the Heisenberg nilmanifold:

```wl
decomposition = FindPreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 1: 2, 2: 2, 3: 1 and coexact dimensions 1: 1 -->

Changing the data can break an axiom. Here $z + x$ pairs with $xz$:

```wl
changed = PreHodgeDecomposition[Append[Normal[decomposition], "Coexact" -> <|1 -> {z + x}|>]]
```

<!-- => a PreHodgeDecomposition object with harmonic dimensions 0: 1, 1: 2, 2: 2, 3: 1 and coexact dimensions 1: 1 -->

The changed data is no pre-Hodge decomposition:

```wl
RelationsQ[changed]
```

<!-- => False -->

The coexact part is no longer perpendicular to the harmonic subspace in degree $1$:

```wl
Obstruction[changed, "Perpendicular", {}]
```

<!-- => {1} -->

## Possible Issues

The head does not decompose a space. Given one, it is inert:

```wl
PreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"]]
```

<!-- => the expression returns unevaluated -->

---

It is no decomposition, so it has no relations to test, and the expression returns unevaluated:

```wl
RelationsQ[PreHodgeDecomposition[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => the expression returns unevaluated -->
