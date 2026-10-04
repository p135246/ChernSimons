---
Template: Symbol
Name: CanonicalMaurerCartan
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CanonicalMaurerCartan
Keywords: [canonical Maurer-Cartan element, triple product, reversal sign, Hochschild differential]
SeeAlso: [MaurerCartanElement, Obstruction, RelationsQ, NondegenerateQuotient, GradedPairing, TwistedDifferential, ElementDegree]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[CanonicalMaurerCartan]()[*pairing*]</code> gives the canonical Maurer-Cartan element of the Poincaré duality algebra that *pairing* carries, a [MaurerCartanElement]() with the one part $\mathfrak{m}_{1,0}$.

<!-- #| annotation: 26.09.30: Design review - the function reads everything off the pairing object: the degrees of the letters from the pairing, and the degree n and the "Triple" key from its "Algebra" key, which GradedPairing[algebra] supplies, so the element is built over whatever letter names the pairing gives. On a pairing without an algebra it returns unevaluated; before R3 it issued GradedPairing::algebra and aborted the whole evaluation, and the message is gone. Since R5d it gives a MaurerCartanElement with the one part m_{1,0} rather than a bare BD action, and since R5c it lives in the ChernSimons part beside GradedPairing[algebra], so that ChernSimons reads the PoincareDualityAlgebra of the algebraic models and the dependency runs one way. It is the one function of the paclet that produces a Maurer-Cartan element rather than taking one as given; the geometric element, with ribbon graphs and configuration-space integrals, is not implemented. Prior art: the Wolfram Language has no Poincare duality algebras or cyclic words; the engine the verification suites load computes the element as pdCanonicalMC, and T17/canonical-element-is-the-engine-element pins this function against it over the catalogue and Kodaira-Thurston, with the words brought to the paclet's canonical rotation. No alternative interface was recorded. -->

## Details & Options

- The triple product of a Poincaré duality algebra $(H, \mathcal{O})$ of degree $n$ is a cyclic three-cochain on $H[1]$, hence an element of the cyclic words of length three.
- In a basis $(e_i)$ the element is $\mathfrak{m}^{\mathrm{can}}_{1,0} = (-1)^{n-2}\frac{1}{3}\sum_{i,j,k} \pm\,(-1)^{\deg e_j}\,\mathcal{O}(e_i\cdot e_j\cdot e_k)\; e^ie^je^k$, with $\pm$ the reversal sign $(-1)^{\lvert e^k\rvert(\lvert e^i\rvert+\lvert e^j\rvert)+\lvert e^j\rvert\lvert e^i\rvert}$.
- In the degrees $a$, $b$, $c$ of the three letters the sign of a summand is $(-1)^{n-1+b+ab+bc+ca}$.
- The summand is invariant under cyclic rotation. A cyclic word with three distinct rotations is produced three times and has the full coefficient; a word $e^ie^ie^i$ is produced once and keeps the factor $\tfrac13$.
- *pairing* must carry an `"Algebra"` key, which <code>[GradedPairing]()[*algebra*]</code> supplies.
- The degrees of the letters are read off *pairing*, and the degree $n$ and the `"Triple"` key off the algebra.
- On a pairing without an algebra [CanonicalMaurerCartan]() returns unevaluated.
- The element carries only the product, in its part <code>*m*[{1, 0}]</code>, and it carries *pairing*.
- When the algebra has a nonzero differential, the canonical dIBL structure of a cyclic cochain complex carries it in $\mathfrak{q}_{1,1,0}$, which is [CyclicHochschildDifferential](); see [NondegenerateQuotient]().
- The element is the algebraic one of a Poincaré duality algebra. The geometric element, with ribbon graphs, their combinatorial coefficients and the configuration-space integrals, is not computed.

## Basic Examples

The canonical element of the circle:

```wl
m = CanonicalMaurerCartan[GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}]]
```

<!-- => a MaurerCartanElement object with the one part {1, 0} -> CyclicWord[{x, x, y}], over the letters x and y, in the symmetric convention -->

Its one part is the element $x^2y$ the paper's Section 2 starts from:

```wl
m["Parts"]
```

<!-- => <|{1, 0} -> CyclicWord[{x, x, y}]|> -->

It solves the Maurer-Cartan equation; on a word of length three the equation reduces to $\mathfrak{q}_{2,1,0}(\mathfrak{m}\odot\mathfrak{m}) = 0$, which is associativity in these coordinates:

```wl
RelationsQ[m]
```

<!-- => True -->

---

For $\mathbb{CP}^2$ there are two cyclic words, with the default letters being the basis monomials:

```wl
CanonicalMaurerCartan[GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]]][{1, 0}]
```

<!-- => -CyclicWord[{1, 1, a^2}] - CyclicWord[{1, a, a}] -->

## Scope

The letters can be named anything; the element is the same up to the relabelling:

```wl
CanonicalMaurerCartan[GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]], {e0, e1, e2}]][{1, 0}]
```

<!-- => -CyclicWord[{e0, e0, e2}] - CyclicWord[{e0, e1, e1}] -->

---

On $\mathbb{CP}^3$ the word $a^3$ has a single rotation and keeps the factor $\tfrac13$:

```wl
CanonicalMaurerCartan[GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[3]]]]][{1, 0}]
```

<!-- => -CyclicWord[{1, 1, a^3}] - CyclicWord[{1, a, a^2}] - CyclicWord[{1, a^2, a}] - CyclicWord[{a, a, a}]/3 -->

---

The algebra can be written down by hand, from its degrees, its product and its orientation, without a Sullivan model. The circle's is the unit and a volume class of degree one:

```wl
circle = PoincareDualityAlgebra[CochainComplexWithPairing[<|1 -> 0, v -> 1|>, <||>, <||>, v]]
```

<!-- => a PoincareDualityAlgebra object with the basis 1 and v, of degree 1 -->

Its canonical element:

```wl
CanonicalMaurerCartan[GradedPairing[circle, {x, y}]][{1, 0}]
```

<!-- => CyclicWord[{x, x, y}] -->

---

In the exterior convention the element is the same:

```wl
CanonicalMaurerCartan[Append[GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}], "Convention" -> "Exterior"]]["Parts"]
```

<!-- => <|{1, 0} -> CyclicWord[{x, x, y}]|> -->

---

It solves the Maurer-Cartan equation for every model in the catalogue, including the two whose quotient carries a differential:

```wl
AssociationMap[name |-> RelationsQ[CanonicalMaurerCartan[GradedPairing[NondegenerateQuotient[SullivanModel[name]]]]], {"Sphere"[3], "ComplexProjectiveSpace"[3], "QuaternionicProjectiveSpace"[2], "Torus"[3], "SpecialUnitaryGroup"[3], "HeisenbergNilmanifold", "KodairaThurston"}]
```

<!-- => <|"Sphere"[3] -> True, "ComplexProjectiveSpace"[3] -> True, "QuaternionicProjectiveSpace"[2] -> True, "Torus"[3] -> True, "SpecialUnitaryGroup"[3] -> True, "HeisenbergNilmanifold" -> True, "KodairaThurston" -> True|> -->

## Properties and Relations

The alphabet of $\mathbb{CP}^2$:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]]
```

<!-- => a GradedPairing object with letters 1, a and a^2, of pairing degree 2, carrying the algebra of CP^2, of degree 4 -->

The symmetric degree of a word of the element is $2(n-3)$:

```wl
ElementDegree[CyclicWord[{1, 1, a^2}], pairing, "Symmetric"]
```

<!-- => 2 -->

That is the degree of [HBar](), and so of a BD action:

```wl
ElementDegree[HBar, pairing, "Symmetric"]
```

<!-- => 2 -->

---

The canonical element of the circle:

```wl
m = CanonicalMaurerCartan[GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}]]
```

<!-- => a MaurerCartanElement object with the one part {1, 0} -> CyclicWord[{x, x, y}], over the letters x and y, in the symmetric convention -->

Twisting $\mathfrak{q}_{2,1,0}$ by it gives the dual of the cyclic Hochschild differential. On the circle that operator inserts one letter $x$:

```wl
TwistedDifferential[m, CyclicWord[{x, y, y}]]
```

<!-- => CyclicWord[{x, x, y, y}] -->

It vanishes on a word with an even number of letters $x$:

```wl
TwistedDifferential[m, CyclicWord[{x, x, y}]]
```

<!-- => 0 -->

## Possible Issues

A pairing built from degrees and values carries no algebra, so there is no triple product to read, and the expression returns unevaluated:

```wl
CanonicalMaurerCartan[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->
