---
Template: Symbol
Name: HodgeTypeQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HodgeTypeQ
Keywords: [Hodge type, Hodge decomposition, acyclic, quasi-isomorphism, degenerate subspace]
SeeAlso: [HodgeTypeReport, FindHodgeDecomposition, DegenerateSubspace, NondegenerateQuotient, PoincareDualityQ, SullivanModel, CochainComplexWithPairing, HodgeExtension]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[HodgeTypeQ]()[*model*]</code> tests whether a [SullivanModel]() is of Hodge type.

<code>[HodgeTypeQ]()[*complex*]</code> tests whether a [CochainComplexWithPairing]() is of Hodge type.

<!-- #| annotation: 26.09.30: Design review - HodgeTypeQ is a test on the space, not a search: it computes the cohomology of the degenerate subspace degree by degree, by the criterion of Lemma 3.14 of arXiv:2004.07362, which needs no choice of harmonic subspace and no linear system for a twist; FindHodgeDecomposition is the search. The criterion assumes that the pairing on cohomology is perfect, and without it a degenerate cohomology pairing gives a false negative, so since HodgeDecompositions H2 the function first asks PoincareDualityQ with the same "MaxDegree", and when the answer is False it issues the one message HodgeTypeQ::duality and returns unevaluated, the rule of the paclet for a predicate that cannot decide. Example 4.3 of arXiv:2609.14221 received False for the wrong reason before H2. For a model the default range 0 to n+1 is complete once the model is a PDGA of degree n, so the option exists only to look further, and since R7 (Pavel, 2026-10-01) a value below n returns unevaluated, as in PoincareDualityQ, where it used to test fewer degrees and could miss a failure; T17 checks that the verdict does not change out to degree 4n+8 on the catalogue. A complex is finite, so every degree is tested and that form takes no option. Prior art: the Wolfram Language has no test for Hodge type. The engine of the verification suites has the same test, and T17 pins the function against it on the thirteen catalogue models and the Kodaira-Thurston model. -->

## Details & Options

- A Hodge decomposition of $(V,\mathrm{d},\langle-,-\rangle)$ is a splitting $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ with $\mathcal{H}$ a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$, $C$ a complement of $\ker\mathrm{d}$ in $V$, and $C\perp C\oplus\mathcal{H}$. A space admitting one is of Hodge type.
- The test is not a search for a decomposition; [FindHodgeDecomposition]() finds one.
- Over a field of characteristic $\neq 2$, and for a nondegenerate quotient of finite type, being of Hodge type is equivalent to the degenerate subspace being acyclic, and to the quotient map $\pi_{\mathcal{Q}}\colon V\to\mathcal{Q}(V)$ being a quasi-isomorphism.
- [HodgeTypeQ]() computes $H^k(V_{\mathrm{deg}})$ degree by degree and gives True when it vanishes in every degree tested.
- The equivalence needs Poincaré duality on cohomology. When [PoincareDualityQ]() is False, the message `HodgeTypeQ::duality` is issued and [HodgeTypeQ]() returns unevaluated.
- For a model the degrees $0$ to $n+1$ are tested by default. The range is complete provided the cohomology of the model vanishes above degree $n$, which is part of being a PDGA of degree $n$.
- Above degree $n$ the degenerate subspace is the whole of the model, so for $k\ge n+2$ both $V^{k-1}_{\mathrm{deg}}$ and $V^k_{\mathrm{deg}}$ are everything and $H^k(V_{\mathrm{deg}}) = H^k(V) = 0$. Degree $n+1$ is the one degree above $n$ where the two can differ, and it is tested.
- A value of `"MaxDegree"` below $n$ returns unevaluated, as it does for [PoincareDualityQ]().
- For a complex every degree is tested, and that form takes no option.
- [HodgeTypeQ]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"MaxDegree"</code> | <code>[Automatic]()</code> | the last degree tested for a model; <code>Automatic</code> is $n+1$ |

## Basic Examples

The model of $\mathbb{CP}^2$ is of Hodge type:

```wl
HodgeTypeQ[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => True -->

---

The degree-$4$ obstruction is not:

```wl
HodgeTypeQ[SullivanModel["Degree4Obstruction"]]
```

<!-- => False -->

## Scope

A complex given by its data, Example 6.1 of arXiv:2004.07362 over $\mathbb{Q}$:

```wl
HodgeTypeQ[CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]]
```

<!-- => True -->

---

The complex of a model has the model's Hodge type:

```wl
HodgeTypeQ[CochainComplexWithPairing[SullivanModel["Degree4Obstruction"]]]
```

<!-- => False -->

## Options

### MaxDegree

The model of $\mathbb{CP}^3$:

```wl
model = SullivanModel["ComplexProjectiveSpace"[3]]
```

<!-- => a SullivanModel object with generators a of degree 2 and b of degree 7, of degree 6 -->

Its degree:

```wl
model["Degree"]
```

<!-- => 6 -->

It is of Hodge type in the default range, up to degree $7$:

```wl
HodgeTypeQ[model]
```

<!-- => True -->

Testing further than the default changes nothing:

```wl
HodgeTypeQ[model, "MaxDegree" -> 30]
```

<!-- => True -->

---

A range that stops below the degree $n$ of the model returns unevaluated, since Poincaré duality needs every degree from $0$ to $n$:

```wl
HodgeTypeQ[SullivanModel["Degree4Obstruction"], "MaxDegree" -> 2]
```

<!-- => the input, unevaluated -->

## Properties and Relations

Everything in the catalogue but one model is of Hodge type:

```wl
Select[{"Circle", "Sphere"[2], "Sphere"[3], "ComplexProjectiveSpace"[2],
   "QuaternionicProjectiveSpace"[2], "Torus"[3], "SpecialUnitaryGroup"[3],
   "HeisenbergNilmanifold", "KodairaThurston", "Degree4Obstruction"},
  name |-> ! HodgeTypeQ[SullivanModel[name]]]
```

<!-- => {"Degree4Obstruction"} -->

---

The degree-$4$ obstruction:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, dc = 0 and da = c, of degree 4, truncated above degree 4 -->

When the test fails, the quotient map has lost cohomology. The cohomology is two-dimensional:

```wl
Total[Values[HodgeTypeReport[model][All, "Cohomology"]]]
```

<!-- => 2 -->

The nondegenerate quotient is three-dimensional, so it is no longer a model of the algebra it came from:

```wl
Length[NondegenerateQuotient[model]["Basis"]]
```

<!-- => 3 -->

No Hodge decomposition is found, and the result is a [Failure]() naming the degree where the twist fails:

```wl
FindHodgeDecomposition[model]["Degrees"]
```

<!-- => {2} -->

## Possible Issues

Example 4.3 of arXiv:2609.14221, a minimal Sullivan algebra of degree $58$ with no Hodge decomposition:

```wl
model = SullivanModel[<|a5 -> 5, a9 -> 9, a15 -> 15, a17 -> 17, a21 -> 21, a23 -> 23|>,
   <|a21 -> a5 a17, a23 -> a9 a15|>, a5 a9 a21 a23]
```

<!-- => a SullivanModel object with generators a5, a9, a15, a17, a21, a23 of degrees 5, 9, 15, 17, 21, 23, da21 = a5 a17 and da23 = a9 a15, of degree 58 -->

Its cohomology is not a Poincaré duality algebra, since $H^{58}$ is two-dimensional:

```wl
PoincareDualityQ[model]
```

<!-- => False -->

So the criterion does not apply:

```wl
HodgeTypeQ[model]
```

<!-- => the message HodgeTypeQ::duality is issued and the expression returns unevaluated -->
