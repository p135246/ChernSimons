---
Template: TechNote
Name: HodgeTypeAndTheNondegenerateQuotient
Title: Hodge Type and the Nondegenerate Quotient
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/tutorial/HodgeTypeAndTheNondegenerateQuotient
Keywords: [Hodge decomposition, Hodge type, degenerate subspace, nondegenerate quotient, differential Poincare duality model, nilmanifold, counterexample]
RelatedGuides: [ChernSimons]
RelatedTutorials: [FromASullivanModelToAnIBLAlgebra, TheCanonicalIBLAlgebraOfTheCircle]
---

An oriented PDGA $(V,\mathrm{d},\mathcal{O})$ satisfies Poincaré duality on cohomology but almost never on chain level. The construction that repairs this divides out the part of $V$ that the pairing cannot see, and the question is whether the division loses cohomology. It does not exactly when $V$ is *of Hodge type*. This tutorial is about that test: what it computes, in which degrees, and what it looks like when it fails.

The reference is [arXiv:2004.07362](https://arxiv.org/abs/2004.07362), *Hodge decompositions and Poincaré duality models*.

## Three subspaces

Write $\langle v_1,v_2\rangle = \mathcal{O}(v_1v_2)$. A *Hodge decomposition* is a splitting

$$V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C,\qquad C\perp C\oplus\mathcal{H},$$

with $\mathcal{H}$ a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$ and $C$ a complement of $\ker\mathrm{d}$ in $V$. Dropping the condition $C\perp C$ leaves a *pre-Hodge* decomposition, and one of those exists for any PDGA; the whole difficulty is the isotropy of $C$.

The *degenerate subspace* is $V_{\mathrm{deg}} = \{v \mid v\perp V\}$ and the *nondegenerate quotient* is $\mathcal{Q}(V) = V/V_{\mathrm{deg}}$. Because $\langle \mathrm{d}v_1,v_2\rangle = \pm\langle v_1,\mathrm{d}v_2\rangle$ and $\langle v_1v_2,v_3\rangle = \langle v_1,v_2v_3\rangle$, the degenerate subspace is a differential graded ideal, so the quotient is again a CDGA with an orientation, and the pairing on it is nondegenerate by construction.

Two facts tie the notions together, both from the reference and both used here:

- if $V$ is of Hodge type and the pairing on $H(V)$ is nondegenerate, then $\pi_{\mathcal{Q}}\colon V\to\mathcal{Q}(V)$ is a quasi-isomorphism;
- conversely, in characteristic $\neq 2$, if $\pi_{\mathcal{Q}}$ is a quasi-isomorphism and $\mathcal{Q}(V)$ is of finite type, then $V$ is of Hodge type.

And $\pi_{\mathcal{Q}}$ is a quasi-isomorphism exactly when its kernel $V_{\mathrm{deg}}$ is acyclic. So the computable form of "of Hodge type" is: **$H(V_{\mathrm{deg}}) = 0$**. That is what [HodgeTypeQ]() tests.

## In which degrees

$V_{\mathrm{deg}}$ is infinite-dimensional whenever $V$ is, so the test needs a degree range. It needs a short one. Above degree $n$ the orientation sees nothing, so $V^k_{\mathrm{deg}} = V^k$ for every $k > n$; hence for $k \ge n+2$ both $V^{k-1}_{\mathrm{deg}}$ and $V^k_{\mathrm{deg}}$ are the whole of $V$ in their degrees, and

$$H^k(V_{\mathrm{deg}}) = H^k(V) = 0 \qquad (k\ge n+2),$$

the last equality because the cohomology of a PDGA of degree $n$ is concentrated in degrees $0$ to $n$. Degree $n+1$ is the one degree where the two differ, since $V^n_{\mathrm{deg}}$ is generally a proper subspace of $V^n$. So checking degrees $0$ through $n+1$ settles it, and that is the default.

```wl
model = SullivanModel["ComplexProjectiveSpace"[3]];
{model["Degree"], HodgeTypeQ[model], HodgeTypeQ[model, "MaxDegree" -> 30]}
```

<!-- => {6, True, True} -->

The report tells the same story in columns. `Degenerate` grows to fill `Dimension` past degree $n$, and `DegenerateCohomology` stays zero — that is the quasi-isomorphism. `Cohomology` and `Quotient` also agree here, which is a further fact: the quotient carries no differential, so it is the cohomology. In general the quasi-isomorphism only gives `Cohomology` $\le$ `Quotient`, the two agreeing exactly when the quotient's differential vanishes.

```wl
HodgeTypeReport[model]
```

## When it fails

Example 6.3 of the reference is a $1$-connected PDGA of degree $4$ that is not of Hodge type. Take one generator $a$ of degree $2$ and one generator $c$ of degree $3$ with $\mathrm{d}a = c$, and truncate everything above degree $4$; the orientation is the coefficient of $a^2$.

```wl
bad = SullivanModel["Degree4Obstruction"];
{Normal[bad["Generators"]], bad["Volume"], bad["Truncation"]}
```

<!-- => {{a -> 2, c -> 3}, {a, a}, 4} -->

The truncation is what makes this finite: the ideal of monomials above degree $4$ is a differential graded ideal, so the quotient is a CDGA, and it is four-dimensional.

```wl
Table[SullivanModelBasis[bad, k], {k, 0, 5}]
```

<!-- => {{1}, {}, {a}, {c}, {a^2}, {}} -->

Its cohomology is $\mathbb{R}$ in degree $0$ and $\mathbb{R}\{a^2\}$ in degree $4$ — the cohomology of $S^4$ — and the pairing on it is perfect, so this is an oriented PDGA of degree $4$. But $\langle a,a\rangle = \mathcal{O}(a^2) = 1$, and $a$ spans the whole of degree $2$, so the coexact part in degree $2$ can only be $\mathbb{R}\{a\}$, which is not isotropic. No Hodge decomposition exists.

```wl
{SullivanModelPairing[a, a, bad], HodgeTypeQ[bad]}
```

<!-- => {1, False} -->

The obstruction is visible in the report, in degree $3$: the degenerate subspace is $\mathbb{R}\{c\}$, and $c$ is closed and is not the differential of anything degenerate, so `DegenerateCohomology` is $1$ there.

```wl
HodgeTypeReport[bad]
```

```wl
DegenerateSubspace[bad, 3]
```

<!-- => {c} -->

The consequence is exactly what the theory predicts: the quotient is *not* quasi-isomorphic to the model. It is three-dimensional with zero differential — the cohomology of $\mathbb{CP}^2$, not of $S^4$.

```wl
quotient = NondegenerateQuotient[bad];
{quotient["Basis"], quotient["Differential"], Total[Values[HodgeTypeReport[bad][All, "Cohomology"]]]}
```

<!-- => {{1, a, a^2}, {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}}, 2} -->

Three against two: the quotient map has killed the class of $c$ but not the class $[a]$ that ought to have died with it. The repair in the reference is to *extend* $V$ to a larger PDGA of Hodge type that retracts onto it; the extension adjoins a generator in degree $1$, which is why this example also shows that no $1$-connected extension of Hodge type exists in degree $4$.

## When the model is already a dPD algebra

At the other extreme are models whose pairing is already perfect on chain level, so $V_{\mathrm{deg}} = 0$ and $\mathcal{Q}(V) = V$. The minimal model of a nilmanifold is one: a finite-dimensional exterior algebra on generators of degree $1$, with the differential of the nilpotent Lie algebra.

The three-dimensional Heisenberg nilmanifold has $\Lambda(x,y,z)$ with $\mathrm{d}z = xy$, and the volume form $xyz$.

```wl
heis = SullivanModel["HeisenbergNilmanifold"];
{Normal[heis["Generators"]], heis["Volume"], SullivanModelDifferential[z, heis]}
```

<!-- => {{x -> 1, y -> 1, z -> 1}, {x, y, z}, x y} -->

```wl
HodgeTypeReport[heis]
```

Every row has `Degenerate` zero and `Dimension` equal to `Quotient`: the model *is* its own nondegenerate quotient, an eight-dimensional differential Poincaré duality algebra of degree $3$. The Betti numbers $1,2,2,1$ read off the `Cohomology` column and are symmetric, as Poincaré duality demands.

Unlike $\mathbb{CP}^m$, this quotient carries a nonzero differential, because the nilmanifold is not formal:

```wl
Normal[NondegenerateQuotient[heis]["DifferentialPairing"]]
```

<!-- => {{2, 2} -> 1} -->

That entry is $\langle \mathrm{d}z, z\rangle = \mathcal{O}(xyz) = 1$, the second basis vector being $z$. The differential of the quotient, in the basis, is the same information with the Gram matrix divided out:

```wl
NondegenerateQuotient[heis]["Differential"] // MatrixForm
```

The one nonzero entry sends $z$ to $xy$. In the canonical dIBL structure of a cyclic cochain complex this differential is carried by the operation $\mathfrak{q}_{1,1,0}$, and [CyclicDifferential]() is that operation: dually to $\mathrm{d}z = xy$, it replaces the letter $xy$ by the letter $z$, with the running sign of the letters after the slot.

```wl
With[{pr = GradedPairing[NondegenerateQuotient[heis]]},
   CyclicDifferential[CyclicWord[{x*y, y}], pr]]
```

<!-- => CyclicWord[{y, z}] -->

[CanonicalMaurerCartan]() is unchanged by this: the element of the *product* alone solves the Maurer-Cartan equation of the structure with $\mathfrak{q}_{1,1,0}$, because the operation kills it — the Leibniz rule of the algebra, read on the element that carries its triple product. Twisting by the element then stacks the bracket on top of the differential, so [TwistedDifferential]() is the differential of the dPD algebra with its $\mathrm{d}$, not merely of the underlying Poincaré duality algebra.

```wl
With[{pr = GradedPairing[NondegenerateQuotient[heis]]},
   With[{m = CanonicalMaurerCartan[pr]},
     {CyclicDifferential[m, pr], MaurerCartanQ[m, pr],
      TwistedDifferential[m, CyclicWord[{x*y}], pr]}]]
```

<!-- => {0, True, CyclicWord[{z}]} -->
