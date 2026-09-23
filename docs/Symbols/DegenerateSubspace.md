---
Template: Symbol
Name: DegenerateSubspace
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/DegenerateSubspace
Keywords: [degenerate subspace, radical, perpendicular, differential graded ideal]
SeeAlso: [SullivanModelPairing, NondegenerateQuotient, HodgeTypeQ, HodgeTypeReport]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[DegenerateSubspace]()[*model*, *k*]</code> gives a basis of the degree-*k* part of the degenerate subspace $V_{\mathrm{deg}} = \{v\mid v\perp V\}$.

## Details & Options

An element is degenerate when it pairs to zero with everything. Since the pairing has degree $n$, only degree $n-k$ can test degree $k$, so the computation is the kernel of one matrix per degree.

$V_{\mathrm{deg}}$ is a differential graded ideal — it is closed under the differential because $\langle\mathrm{d}v_1,v_2\rangle = \pm\langle v_1,\mathrm{d}v_2\rangle$, and under multiplication because $\langle v_1v_2,v_3\rangle = \langle v_1,v_2v_3\rangle$ — so the quotient by it is again a CDGA. That quotient is [NondegenerateQuotient]().

Above the model's degree the orientation sees nothing, so the whole of each degree is degenerate.

## Basic Examples

In the model of $\mathbb{CP}^2$ nothing is degenerate up to degree $4$, and everything is degenerate above it:

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
Table[DegenerateSubspace[model, k], {k, 0, 7}]
```

<!-- => {{}, {}, {}, {}, {}, {b}, {a^3}, {a b}} -->

## Scope

The minimal model of a nilmanifold has no degenerate elements at all: the pairing is already perfect, so the model is its own nondegenerate quotient.

```wl
model = SullivanModel["HeisenbergNilmanifold"];
Table[DegenerateSubspace[model, k], {k, 0, 4}]
```

<!-- => {{}, {}, {}, {}, {}} -->

---

The one interesting degenerate element in the catalogue sits in degree $3$ of the degree-$4$ obstruction, and it is closed, which is why the model is not of Hodge type:

```wl
model = SullivanModel["Degree4Obstruction"];
{DegenerateSubspace[model, 3], SullivanModelDifferential[c, model]}
```

<!-- => {{c}, 0} -->

## Properties and Relations

The dimensions are the third column of [HodgeTypeReport]():

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
{Table[Length[DegenerateSubspace[model, k]], {k, 0, 7}],
 Normal[Values[HodgeTypeReport[model][All, "Degenerate"]]]}
```

---

The dimension of the model is the dimension of the degenerate subspace plus that of the quotient:

```wl
model = SullivanModel["Torus"[3]];
Table[{Length[SullivanModelBasis[model, k]], Length[DegenerateSubspace[model, k]]}, {k, 0, 3}]
```

<!-- => {{1, 0}, {3, 0}, {3, 0}, {1, 0}} -->
