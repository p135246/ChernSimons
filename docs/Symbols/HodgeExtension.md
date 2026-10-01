---
Template: Symbol
Name: HodgeExtension
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HodgeExtension
Keywords: [extension of Hodge type, Hodge decomposition, Hodge twist, acyclic extension, differential Poincare duality model, PDGA retraction]
SeeAlso: [HodgeTypeQ, FindHodgeDecomposition, FindPreHodgeDecomposition, NondegenerateQuotient, SullivanModel, CochainComplexWithPairing]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[HodgeExtension]()[*space*, *k*]</code> gives the extension of a [SullivanModel]() or a [CochainComplexWithPairing]() of degree $n$ by an acyclic pair $x_\alpha$, $y_\alpha = \mathrm{d}x_\alpha$ of degrees $k-1$ and $k$ for each basis element $c_\alpha$ of its coexact part of degree $n-k$, with $\langle y_\alpha, c_\beta\rangle = \delta_{\alpha\beta}$, which retracts onto *space*.

<code>[HodgeExtension]()[*space*]</code> gives an extension of Hodge type that retracts onto *space*: the step in the middle degree when $n$ is even and that degree has no Hodge decomposition, then the steps in the degrees $k = \lfloor n/2\rfloor + 1, \dots, n-1$.

<!-- #| annotation: 26.10.01: Design review - built in HodgeDecompositions H6 from the blueprint of H4, whose ten choices Pavel kept in H4a. One step adjoins a pair for every basis element of the coexact part of degree n-k, as arXiv:2609.14221, Remark 2.2, does above the middle degree and Proposition 2.1 in it, Pavel's choice of 2026-09-23, so each degree is done in one step; Lemma 4.8's variant on a basis of the nondegenerate quotient Q^(n-k)(C) is smaller and leaves a space of Hodge type unchanged, at the price of repeated steps at fixed k in the connected case, and would be an option if wanted. The full extension goes outward from the middle degree, as arXiv:2004.07362, Proposition 4.13, does, because the step in degree k keeps the degrees n-k+1 to k-1 and adds the degrees n-k and k (Lemma 4.8, property (dagger dagger)); the Spec's order, from n-1 down, has no such proof, though on the model of the Heisenberg nilmanifold times T^2 a kernel run gives a space of Hodge type in both orders. The step in degree n/2 + 1 reads the middle degree through its Hodge decomposition, Lemma 4.8, condition (star star); a kernel run of the full extension of Degree4Obstruction with the pre-Hodge decomposition there is not of Hodge type. The middle step of the full extension is taken only when the middle degree has no Hodge decomposition: on KodairaThurston the adaptedness condition of Proposition 2.1 fails for every harmonic subspace, all of degree 3 being closed, while the middle degree is Hodge already; taking the step every time, as the Spec does, would make that full extension a Failure, and taking it without the adaptedness check gives, in a kernel, a space of Hodge type that no theorem covers. The single step in the middle degree is literal and gives the Failure. The new generators are the formal symbols FormalX[j] and FormalY[j], numbered on, which no input can collide with; names given by the user were the alternative. A failure of FindPreHodgeDecomposition passes through with its own tag, as for FindHodgeDecomposition. The coefficients are rational, where Lambda(x, dx) is acyclic (Lemma 4.7), so the acyclic extension of positive characteristic is not needed. Prior art: the Wolfram Language has no extensions of differential graded algebras; Lambrechts and Stanley construct Poincare duality models by a related extension with a twisted differential, which arXiv:2004.07362 replaces by the tensor product. The step reads the frames of the degrees n-k and n-k+1 of the decomposition, H, dC and C, in one inverse matrix each; the middle step puts a basis of V^1 H^m first in its coexact part of degree m+1 and completes it from the pre-Hodge one, and the step in degree n/2 + 1 twists the middle coexact part alone, so the other degrees need not be Hodge yet. A step in degree n/2 + 1 whose middle degree has no Hodge decomposition, and a full extension of degree 2 whose degree 1 has none, where no step can help (arXiv:2609.14221, Example 4.2), give the Failure of FindHodgeDecomposition. A complex with a product is extended as V tensor Lambda with Lambda a SullivanModel of the new generators, and it needs the unit 1 among its basis elements to read the orientation. The engine of the verification suites has no counterpart. -->

## Details & Options

- An extension $V\subset\hat V$ of oriented PDGAs is an injective DGA morphism that preserves the orientation. A retraction $\hat V\to V$ that is a PDGA morphism is a quasi-isomorphism, and $\hat V$ is an extension of Hodge type when $\hat V$ is of Hodge type (arXiv:2609.14221, Section 2).
- The step in degree $k$, for $n/2\le k\le n$ and $k\ge 2$, takes the basis $c_\alpha$ of the coexact part $C^{n-k}$ of [FindPreHodgeDecomposition]() with its coordinate functionals $\varphi_\alpha$, and sets $\hat V = V\otimes\Lambda(x_\alpha, y_\alpha)$ with $\mathrm{d}x_\alpha = y_\alpha$ and the tensor product differential.
- The orientation is $\hat{\mathcal{O}} = \mathcal{O}$ on $V$, $\hat{\mathcal{O}}(x_\alpha v) = (-1)^k\varphi_\alpha(c)$ and $\hat{\mathcal{O}}(y_\alpha v) = \varphi_\alpha(c')$ for $v = h + \mathrm{d}c + c'$ with $h\in\mathcal{H}$ and $c, c'\in C$, and $0$ on monomials with two new generators (arXiv:2609.14221, Proposition 2.1 and Remark 2.2). Then $\langle y_\alpha, c_\beta\rangle = \delta_{\alpha\beta}$.
- Over $\mathbb{Q}$ the algebra $\Lambda(x_\alpha, y_\alpha)$ is acyclic (arXiv:2004.07362, Lemma 4.7), so $V\to\hat V$ is a quasi-isomorphism, and the map that kills the new generators is a retraction that preserves the orientation.
- The new generators are `\[FormalX][j]` of degree $k-1$ and `\[FormalY][j]` $= \mathrm{d}x_j$ of degree $k$, with $j$ numbered on from those *space* already has.
- A [SullivanModel]() comes back as a [SullivanModel]() with the new generators after the old ones, its orientation the values of $\hat{\mathcal{O}}$ on the monomials of degree $n$ in that order, and the truncation of the model.
- A [CochainComplexWithPairing]() with a product comes back as the complex of $V\otimes\Lambda$ up to degree $n+1$ with the image of $\mathrm{d}$ in degree $n+2$, as <code>[CochainComplexWithPairing]()[*model*]</code> is for a model.
- A [CochainComplexWithPairing]() without a product comes back as $V\oplus\mathrm{span}\{x_\alpha, y_\alpha\}$, the pairing of $x_\alpha$ and $y_\alpha$ with $V$ given by the same formulas with $v$ in place of $x_\alpha v$ and $y_\alpha v$.
- Above the middle degree, $k > n/2$, the map $\mu(u) = -\sum_\alpha\langle u, c_\alpha\rangle y_\alpha$ on the coexact part of degree $k$ satisfies the Hodge twist condition $\langle u + \mu u, c_\beta\rangle = 0$ (arXiv:2609.14221, Remark 2.2). If *space* is of Hodge type in the degrees $n-k+1$ to $k-1$, the extension is of Hodge type in the degrees $n-k$ to $k$ (arXiv:2004.07362, Lemma 4.8).
- The step in degree $n/2 + 1$ reads the middle degree through its Hodge decomposition, the graph of the twist [FindHodgeDecomposition]() finds there (arXiv:2004.07362, Lemma 4.8), and gives the [Failure]() of [FindHodgeDecomposition]() when there is none.
- In the middle degree, $n = 2m$, the map $\mu(c + z) = -\sum_\alpha\langle\tfrac12 c + z, c_\alpha\rangle y_\alpha$ on $\hat C^m = C^m\oplus Z$, $Z = X\cdot V^1$, satisfies the middle-degree twist condition, so the extension is of Hodge type in degree $m$ (arXiv:2609.14221, Proposition 2.1).
- The middle step needs the adaptedness condition $V^1\mathcal{H}^m\subset C^{m+1}$. It takes a coexact part of degree $m+1$ that contains $V^1\mathcal{H}^m$, which exists exactly when $V^1\mathcal{H}^m$ meets the cocycles only in $0$ and is perpendicular to $\mathcal{H}^{m-1}$. Otherwise the result is a [Failure]() whose `"Degrees"` are $\{m\}$. When $V^1 = 0$ the condition is empty.
- When $C^{n-k} = 0$ the step adjoins nothing, and *space* comes back unchanged.
- The full extension takes the middle step when $n$ is even and the middle degree has no Hodge decomposition, and then the steps $k = \lfloor n/2\rfloor + 1, \dots, n-1$ in this order, each on the result of the one before. For a connected space of finite type with Poincare duality on cohomology the result is of Hodge type (arXiv:2609.14221, Proposition 2.1 and Remark 2.2; arXiv:2004.07362, Proposition 4.13).
- A space of Hodge type is extended too. [HodgeTypeQ]() decides Hodge type without extending.
- When *space* has no pre-Hodge decomposition, the result is the [Failure]() of [FindPreHodgeDecomposition](), with its tag.
- For $n = 2$ there is no middle step, and a space whose degree $1$ has no Hodge decomposition gives the [Failure]() of [FindHodgeDecomposition]().
- A degree $k$ below $n/2$ or above $n$, or $k = 1$, returns unevaluated, and so does a complex with a product but without the unit $1$.

## Basic Examples

The degree-$4$ obstruction of Example 6.3 of arXiv:2004.07362:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, of degree 4, truncated above 4 -->

It is not of Hodge type:

```wl
HodgeTypeQ[model]
```

<!-- => False -->

Its extension in the middle degree, by a generator of degree $1$ and its differential:

```wl
extension = HodgeExtension[model, 2]
```

<!-- => a SullivanModel object with generators a of degree 2, c of degree 3, \[FormalX][1] of degree 1 and \[FormalY][1] of degree 2, da = c and d\[FormalX][1] = \[FormalY][1], of degree 4, with a and c truncated above 4 -->

Its orientation, with $\langle y_1, a\rangle = 1$:

```wl
extension["Orientation"]
```

<!-- => <|a^2 -> 1, c \[FormalX][1] -> -1, a \[FormalY][1] -> 1|> -->

The extension is of Hodge type:

```wl
HodgeTypeQ[extension]
```

<!-- => True -->

---

The model of the Heisenberg nilmanifold, of degree $3$:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object with generators x, y, z of degree 1 and dz = x y, of degree 3 -->

Its extension in degree $2$, dual to the coexact element $z$:

```wl
extension = HodgeExtension[model, 2]
```

<!-- => a SullivanModel object with generators x, y, z, \[FormalX][1] of degree 1 and \[FormalY][1] of degree 2, dz = x y and d\[FormalX][1] = \[FormalY][1], of degree 3 -->

Its orientation:

```wl
extension["Orientation"]
```

<!-- => <|x y z -> 1, x y \[FormalX][1] -> 1, z \[FormalY][1] -> 1|> -->

The new exact element is dual to $z$:

```wl
SullivanModelPairing[\[FormalY][1], z, extension]
```

<!-- => 1 -->

## Scope

The full extension of the degree-$4$ obstruction:

```wl
extension = HodgeExtension[SullivanModel["Degree4Obstruction"]]
```

<!-- => a SullivanModel object with generators a of degree 2, c of degree 3, \[FormalX][1] of degree 1, \[FormalY][1] of degree 2, \[FormalX][2] of degree 2 and \[FormalY][2] of degree 3, of degree 4, with a and c truncated above 4 -->

The second step reads $a = (a - \tfrac12 y_1) + \mathrm{d}(\tfrac12 x_1)$ through the Hodge decomposition of the middle degree:

```wl
extension["Orientation"]
```

<!-- => <|a^2 -> 1, c \[FormalX][1] -> -1, a \[FormalY][1] -> 1, \[FormalX][2] \[FormalY][1] -> -1, a \[FormalX][2] -> -1/2, \[FormalX][1] \[FormalY][2] -> -1|> -->

It is of Hodge type:

```wl
HodgeTypeQ[extension]
```

<!-- => True -->

---

The model of the Kodaira-Thurston nilmanifold is of Hodge type, and its middle degree has a Hodge decomposition, so the full extension takes the one step in degree $3$:

```wl
extension = HodgeExtension[SullivanModel["KodairaThurston"]]
```

<!-- => a SullivanModel object with generators x, y, z, t of degree 1, \[FormalX][1] of degree 2 and \[FormalY][1] of degree 3, dz = x y and d\[FormalX][1] = \[FormalY][1], of degree 4 -->

The extension is of Hodge type:

```wl
HodgeTypeQ[extension]
```

<!-- => True -->

---

A complex of degree $4$ without a product, with $\langle b, b\rangle = \langle c, c\rangle = 1$ and $\langle b, c\rangle = 0$ in the middle degree:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, c -> 2, db -> 3, dc -> 3, v -> 4|>,
   <|a -> da, b -> db, c -> dc|>, <|{1, v} -> 1, {a, db} -> 1, {a, dc} -> 1, {da, b} -> 1, {da, c} -> 1, {b, b} -> 1, {c, c} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 3, 3: 2, 4: 1, of degree 4 -->

It is not of Hodge type:

```wl
HodgeTypeQ[complex]
```

<!-- => False -->

Its extension in the middle degree, by one pair for each of $b$ and $c$:

```wl
extension = HodgeExtension[complex, 2]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 3, 2: 5, 3: 2, 4: 1, of degree 4 -->

The new exact element $y_1$ is dual to $b$:

```wl
extension["Pairing"][{\[FormalY][1], b}]
```

<!-- => 1 -->

The extension is of Hodge type:

```wl
HodgeTypeQ[extension]
```

<!-- => True -->

## Properties and Relations

The degree-$4$ obstruction:

```wl
model = SullivanModel["Degree4Obstruction"]
```

<!-- => a SullivanModel object with generators a of degree 2 and c of degree 3, of degree 4, truncated above 4 -->

Its extension in the middle degree:

```wl
extension = HodgeExtension[model, 2]
```

<!-- => a SullivanModel object with generators a of degree 2, c of degree 3, \[FormalX][1] of degree 1 and \[FormalY][1] of degree 2, da = c and d\[FormalX][1] = \[FormalY][1], of degree 4, with a and c truncated above 4 -->

The extension retracts onto the model, so the cohomology is the same:

```wl
Normal[HodgeTypeReport[extension][All, "Cohomology"]] === Normal[HodgeTypeReport[model][All, "Cohomology"]]
```

<!-- => True -->

The coexact part of degree $2$ of its Hodge decomposition is the graph of $\mu(a) = -\tfrac12\langle a, a\rangle y_1$:

```wl
FindHodgeDecomposition[extension]["Coexact", 2]
```

<!-- => {a - \[FormalY][1]/2} -->

Its nondegenerate quotient is a differential Poincare duality model of $S^4$, of dimensions $1, 1, 2, 1, 1$:

```wl
NondegenerateQuotient[extension]["Degrees"]
```

<!-- => {0, 1, 2, 2, 3, 4} -->

## Possible Issues

On the model of the Kodaira-Thurston nilmanifold every element of degree $3$ is closed, so no coexact part of degree $3$ contains $V^1\mathcal{H}^2$, and the step in the middle degree gives a [Failure]() naming the degree:

```wl
HodgeExtension[SullivanModel["KodairaThurston"], 2]["Degrees"]
```

<!-- => {2} -->

Its message:

```wl
HodgeExtension[SullivanModel["KodairaThurston"], 2]["Message"]
```

<!-- => "No coexact part of degree 3 contains the products of the elements of degree 1 with the harmonic subspace of degree 2, so the extension in the middle degree does not apply." -->

---

Example 4.3 of arXiv:2609.14221 has no pre-Hodge decomposition:

```wl
model = SullivanModel[<|a5 -> 5, a9 -> 9, a15 -> 15, a17 -> 17, a21 -> 21, a23 -> 23|>,
   <|a21 -> a5 a17, a23 -> a9 a15|>, a5 a9 a21 a23]
```

<!-- => a SullivanModel object with generators a5, a9, a15, a17, a21, a23 of degrees 5, 9, 15, 17, 21, 23, da21 = a5 a17 and da23 = a9 a15, of degree 58 -->

The extension stops there, and the [Failure]() carries the tag of the pre-Hodge step:

```wl
HodgeExtension[model]["Tag"]
```

<!-- => "FindPreHodgeDecomposition" -->

---

A degree below the middle returns unevaluated:

```wl
HodgeExtension[SullivanModel["HeisenbergNilmanifold"], 1]
```

<!-- => the expression returns unevaluated -->
