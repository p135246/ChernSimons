---
Template: TechNote
Name: FromASullivanModelToAnIBLAlgebra
Title: From a Sullivan Model to an IBL Algebra
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/tutorial/FromASullivanModelToAnIBLAlgebra
Keywords: [Sullivan model, Poincare duality, Hodge type, nondegenerate quotient, Maurer-Cartan, IBL infinity, complex projective space]
RelatedGuides: [ChernSimons]
RelatedTutorials: [HodgeTypeAndTheNondegenerateQuotient, TheCanonicalIBLAlgebraOfTheCircle]
---

The dIBL algebra of a closed oriented $n$-manifold $X$ lives on the cyclic words of a graded alphabet, and the alphabet is a basis of $H^*(X)$ shifted by one, with the pairing that Poincaré duality gives it. This tutorial builds that alphabet without ever mentioning $X$: it starts from a Sullivan minimal model, puts the natural volume form on it, checks that the resulting oriented PDGA is of Hodge type, passes to the nondegenerate quotient, and reads the canonical Maurer-Cartan element off the triple product of the quotient. The running example is $\mathbb{CP}^2$.

Five steps, and each one is a single function.

## The minimal model

A Sullivan minimal model is a free graded commutative algebra $\Lambda U$ with a differential. For $\mathbb{CP}^m$ it has two generators: $a$ in degree $2$ with $\mathrm{d}a = 0$, and $b$ in degree $2m+1$ with $\mathrm{d}b = a^{m+1}$.

```wl
model = SullivanModel["ComplexProjectiveSpace"[2]];
Normal[model["Generators"]]
```

<!-- => {a -> 2, b -> 5} -->

The differential is stored on the generators and extended as a derivation. It raises degree by one:

```wl
{SullivanModelDifferential[b, model], SullivanModelDifferential[a b, model]}
```

<!-- => {a^3, a^4} -->

A monomial is written as a product of generators, read in the order the model declares them. [SullivanModelBasis]() lists the monomials of one degree; the algebra is infinite-dimensional, one or two monomials in every degree from here up.

```wl
Table[SullivanModelBasis[model, k], {k, 0, 8}]
```

<!-- => {{1}, {}, {a}, {}, {a^2}, {b}, {a^3}, {a b}, {a^4}} -->

## The volume form, and the pairing it defines

The cohomology of this model is $\mathbb{R}[a]/(a^3)$, so the top class is $a^2$ in degree $4$. Take that monomial as the *volume form* and let the orientation $\mathcal{O}$ be the coefficient of it — the projection onto the volume form. That is what `model["Volume"]` records, as the list of the generators of the monomial.

```wl
{model["Volume"], model["Degree"]}
```

<!-- => {{a, a}, 4} -->

[SullivanModelOrientation]() applies it. Everything outside degree $4$ is killed, and inside degree $4$ only the volume monomial survives:

```wl
{SullivanModelOrientation[a^2, model], SullivanModelOrientation[a^3, model], SullivanModelOrientation[b, model]}
```

<!-- => {1, 0, 0} -->

The pairing is $\langle v_1, v_2\rangle = \mathcal{O}(v_1 v_2)$ — the projection of the product onto the volume form. On $1, a, a^2$ it is the antidiagonal, which is Poincaré duality:

```wl
Table[SullivanModelPairing[a^i, a^j, model], {i, 0, 2}, {j, 0, 2}] // MatrixForm
```

This is an *orientation* in the sense of Lambrechts-Stanley: it has degree $4$, it kills the image of the differential, and it does not vanish on the kernel. Together with the perfect pairing it induces on cohomology, that makes $(\Lambda U, \mathrm{d}, \mathcal{O})$ an oriented PDGA of degree $4$.

## Is it of Hodge type?

The pairing is *not* perfect on chain level: the whole of $\Lambda U$ above degree $4$ is paired to zero with everything, because the orientation only sees degree $4$. Those elements form the *degenerate subspace* $V_{\mathrm{deg}}$.

```wl
{DegenerateSubspace[model, 5], DegenerateSubspace[model, 6], DegenerateSubspace[model, 7]}
```

<!-- => {{b}, {a^3}, {a b}} -->

The oriented PDGA is *of Hodge type* when it admits a Hodge decomposition $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ with $C\perp C\oplus\mathcal{H}$. Over a field of characteristic $\neq 2$ and for a quotient of finite type, that happens exactly when $V_{\mathrm{deg}}$ is acyclic — equivalently, exactly when the quotient map onto the nondegenerate quotient is a quasi-isomorphism. So the test is one cohomology computation.

```wl
HodgeTypeQ[model]
```

<!-- => True -->

[HodgeTypeReport]() shows why, degree by degree. The fourth column is the cohomology of the degenerate subspace, and it vanishes throughout. Here the second and fifth columns agree as well, which says more: the quotient carries no differential, so it *is* the cohomology — $\mathbb{CP}^2$ is formal. A Hodge-type model whose quotient keeps a differential has `Cohomology` strictly below `Quotient`, and the next tutorial shows one.

```wl
HodgeTypeReport[model]
```

Here $V_{\mathrm{deg}}$ is spanned by $b, ab, a^2b, \dots$ together with $a^3, a^4, \dots$, and $\mathrm{d}(a^kb) = a^{k+3}$ matches them up in pairs — that is the acyclicity, in closed form.

## The nondegenerate quotient

Dividing by $V_{\mathrm{deg}}$ leaves a finite-dimensional algebra on which the pairing is perfect: a Poincaré duality algebra, and — because the quotient map is a quasi-isomorphism — a differential Poincaré duality model of the original PDGA.

```wl
pd = NondegenerateQuotient[model];
{pd["Basis"], pd["Degrees"]}
```

<!-- => {{1, a, a^2}, {0, 2, 4}} -->

For $\mathbb{CP}^2$ the quotient is the cohomology ring itself, with zero differential — as it must be, $\mathbb{CP}^2$ being formal. The pairing is stored as a matrix in that basis, and it is invertible:

```wl
pd["Pairing"] // MatrixForm
```

And the differential vanishes:

```wl
pd["Differential"] // MatrixForm
```

The triple products $\mathcal{O}(e_ie_je_k)$ are what the Maurer-Cartan element below is built from; they are kept as an Association on the index triples, the zero ones dropped.

```wl
Normal[pd["Triple"]]
```

<!-- => {{1, 1, 3} -> 1, {1, 2, 2} -> 1, {1, 3, 1} -> 1, {2, 1, 2} -> 1, {2, 2, 1} -> 1, {3, 1, 1} -> 1} -->

## The dual pairing, and the alphabet

Shifting the quotient down by one turns the graded symmetric pairing of degree $n$ into a graded antisymmetric pairing of degree $n-2$, which is what the IBL operations want. [GradedPairing]() applied to the algebra does exactly that, taking the basis monomials as the particles of the alphabet.

```wl
pairing = GradedPairing[pd];
Normal[pairing["Degrees"]]
```

<!-- => {1 -> -1, a -> 1, a^2 -> 3} -->

```wl
{pairing["Degree"], pd["Degree"] - 2}
```

<!-- => {2, 2} -->

```wl
Normal[pairing["Values"]]
```

From here on this is an ordinary alphabet, and the whole IBL layer applies to it. The quotient itself rides along as the `"Algebra"` key of the pairing object, which is where [CyclicDifferential]() reads the chain-level differential from; for $\mathbb{CP}^2$ that differential is zero, the model being formal, and the next tutorial shows the alphabet where it is not. The cyclic words of length two, for instance — three of them, because $1\cdot 1$, $a\cdot a$ and $a^2\cdot a^2$ are cyclically antisymmetric and so vanish:

```wl
CyclicWords[2, pairing]
```

<!-- => {CyclicWord[{1, a}], CyclicWord[{1, a^2}], CyclicWord[{a^2, a}]} -->

The bracket glues two words by pairing one letter of each:

```wl
InvolutiveBracket[CyclicWord[{1, a}], CyclicWord[{a^2, a}], pairing]
```

The four defining identities of an involutive bi-Lie algebra hold, as they must for any alphabet with a graded antisymmetric pairing:

```wl
With[{u = CyclicWord[{1, a}], v = CyclicWord[{a^2, a}]},
 {JacobiObstruction[u, v, u, pairing], CoJacobiObstruction[u, pairing], DrinfeldObstruction[u, v, pairing], InvolutivityObstruction[u, pairing]}]
```

<!-- => {0, 0, 0, 0} -->

## The canonical Maurer-Cartan element

The triple product of the Poincaré duality algebra is a cyclic three-cochain, so it is an element of the cyclic words of length three. Written in a basis it is

$$\mathfrak{m}^{\mathrm{can}}_{1,0} = (-1)^{n-2}\frac{1}{3}\sum_{i,j,k} \pm\,(-1)^{\deg e_j}\,\mathcal{O}(e_i e_j e_k)\; e^ie^je^k,$$

the $\pm$ being the reversal sign. [CanonicalMaurerCartan]() evaluates it.

```wl
m = CanonicalMaurerCartan[pairing]
```

<!-- => -CyclicWord[{1, 1, a^2}] - CyclicWord[{1, a, a}] -->

Its symmetric degree is $2(n-3)$, which is the degree of $\HBar$ and so of a BD action:

```wl
{WordDegree[CyclicWord[{1, 1, a^2}], pairing, "Symmetric"], PlanckDegree[pairing]}
```

<!-- => {2, 2} -->

And it solves the Maurer-Cartan equation. That is not a formality: on a word of length three the equation reduces to $\mathfrak{q}_{2,1,0}(\mathfrak{m}\odot\mathfrak{m}) = 0$, which is associativity of the algebra written in these coordinates.

```wl
MaurerCartanQ[m, pairing]
```

<!-- => True -->

Twisting by it gives the dIBL algebra of $\mathbb{CP}^2$: the operations $\mathfrak{q}^{\mathfrak{m}}_{1,1,0}$, $\mathfrak{q}_{2,1,0}$, $\mathfrak{q}_{1,2,0}$, whose twisted homology is the cyclic cohomology of the Poincaré duality algebra. When the quotient keeps a differential, the chain-level operation $\mathfrak{q}_{1,1,0}$ — [CyclicDifferential]() — is nonzero before any twisting, and $\mathfrak{q}^{\mathfrak{m}}_{1,1,0}$ stacks the bracket with the element on top of it; $\mathbb{CP}^2$, being formal, has none.

## The whole catalogue

Every model in [$SullivanModels]() runs through the same five steps. The one exception is the last row, and it is the point of the next tutorial.

```wl
row[spec_] := With[{md = SullivanModel[spec]},
   With[{pq = NondegenerateQuotient[md]},
     With[{pr = GradedPairing[pq]},
       <|"Model" -> spec, "n" -> md["Degree"], "Hodge type" -> HodgeTypeQ[md],
         "dim Q" -> Length[pq["Basis"]],
         "Maurer-Cartan" -> MaurerCartanQ[CanonicalMaurerCartan[pr], pr]|>]]];
Dataset[Map[row, {"Circle", "Sphere"[2], "Sphere"[3], "ComplexProjectiveSpace"[2],
   "ComplexProjectiveSpace"[3], "QuaternionicProjectiveSpace"[2], "Torus"[3],
   "SpecialUnitaryGroup"[3], "HeisenbergNilmanifold", "KodairaThurston",
   "Degree4Obstruction"}]]
```
