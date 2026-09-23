---
Template: Symbol
Name: HodgeTypeQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HodgeTypeQ
Keywords: [Hodge type, Hodge decomposition, acyclic, quasi-isomorphism, degenerate subspace]
SeeAlso: [HodgeTypeReport, DegenerateSubspace, NondegenerateQuotient, SullivanModel]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[HodgeTypeQ]()[*model*]</code> tests whether the oriented model is of Hodge type.

## Details & Options

A *Hodge decomposition* of $(V,\mathrm{d},\langle-,-\rangle)$ is a splitting $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ with $\mathcal{H}$ a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$, $C$ a complement of $\ker\mathrm{d}$ in $V$, and $C\perp C\oplus\mathcal{H}$. A model admitting one is *of Hodge type*.

The test is not a search for a decomposition. Over a field of characteristic $\neq 2$, and for a nondegenerate quotient of finite type, being of Hodge type is equivalent to the degenerate subspace being acyclic — equivalently, to the quotient map $\pi_{\mathcal{Q}}\colon V\to\mathcal{Q}(V)$ being a quasi-isomorphism. So what is computed is $H^k(V_{\mathrm{deg}})$, degree by degree.

| option | default | |
|---|---|---|
| `"MaxDegree"` | [Automatic]() | the last degree tested; `Automatic` is $n+1$ |

The default range is complete, not a truncation, provided the cohomology of the model vanishes above degree $n$ — which is part of being a PDGA of degree $n$. Above degree $n$ the degenerate subspace is the whole of the model, so for $k\ge n+2$ both $V^{k-1}_{\mathrm{deg}}$ and $V^k_{\mathrm{deg}}$ are everything and $H^k(V_{\mathrm{deg}}) = H^k(V) = 0$. Degree $n+1$ is the one degree above $n$ where the two can differ, and it is tested.

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

## Options

Testing further than the default changes nothing, as the argument above says it should not:

```wl
model = SullivanModel["ComplexProjectiveSpace"[3]];
{model["Degree"], HodgeTypeQ[model], HodgeTypeQ[model, "MaxDegree" -> 30]}
```

<!-- => {6, True, True} -->

## Properties and Relations

Everything in the catalogue but the last name is of Hodge type:

```wl
Map[name |-> name -> HodgeTypeQ[SullivanModel[name]],
  {"Circle", "Sphere"[2], "Sphere"[3], "ComplexProjectiveSpace"[2],
   "QuaternionicProjectiveSpace"[2], "Torus"[3], "SpecialUnitaryGroup"[3],
   "HeisenbergNilmanifold", "KodairaThurston", "Degree4Obstruction"}]
```

---

When the test fails, the quotient map has lost cohomology and the quotient is no longer a model of the algebra it came from. For the degree-$4$ obstruction the quotient is three-dimensional where the cohomology is two-dimensional:

```wl
model = SullivanModel["Degree4Obstruction"];
{Total[Values[HodgeTypeReport[model][All, "Cohomology"]]],
 Length[NondegenerateQuotient[model]["Basis"]]}
```

<!-- => {2, 3} -->
