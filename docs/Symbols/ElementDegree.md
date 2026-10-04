---
Template: Symbol
Name: ElementDegree
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/ElementDegree
Keywords: [degree, grading, bar degree, exterior degree, symmetric degree, HBar, Planck degree, BD action, cyclic word]
SeeAlso: [CyclicWord, GradedPairing, ExteriorProduct, SymmetricProduct, HBar, KoszulSign, MaurerCartanBasis]
RelatedGuides: [CanonicalLieBialgebra]
---

## Usage

<code>[ElementDegree]()[*x*, *pairing*, "Bar"]</code> gives the degree of *x* in the bar grading $\lvert-\rvert$, the sum of the degrees of its letters.

<code>[ElementDegree]()[*x*, *pairing*, "Exterior"]</code> gives the degree of *x* in the exterior grading $[-]$, the grading of [ExteriorProduct]().

<code>[ElementDegree]()[*x*, *pairing*, "Symmetric"]</code> gives the degree of *x* in the symmetric grading $[-]_1 = [-]-1$, the grading of [SymmetricProduct]().

<!-- #| annotation: 26.09.30: Design review - one degree function for everything the paclet builds, which replaced CyclicWordDegree and PlanckDegree in R5f, on 2026-09-30, with no aliases. The grading is always given and has no default: the old two-argument CyclicWordDegree meant the bar degree, and with the grading explicit each use says which of the three degrees it reads, as the rule of explicit names asks; a default of "Bar" would have been one more rule. HBar has a degree only in the symmetric grading, 2(n - 3), the degree that makes the operator of the Beilinson-Drinfeld algebra homogeneous of degree -1; in the exterior grading q110 and q120 already differ in degree, so no degree of HBar would mean anything there, and HBar returns unevaluated in the other two gradings. A letter has the degree of the word made of it alone, as the paper writes [x] = -2 on the circle, and a scalar multiple of a letter counts only when the scalar contains no letter, since letters may be monomials such as y z. An Association of degrees is accepted in the bar grading only, which the normalization of CyclicWord and GenerateCyclicWords relies on. Prior art: the Wolfram Language has no degree function on graded words; Exponent and VertexDegree measure other degrees. T12/paclet-element-degree pins the three gradings against the degBar, degC and degC1 of the engine the verification suites load, on every word to length 5 in both conventions. -->

## Details & Options

- *x* is a letter, a [CyclicWord]() or the list of its letters, a product of cyclic words, [HBar](), or a sum of these of one degree.
- The pairing supplies the degrees of the letters and the degree $n - 2$ of the pairing, where $n$ is the degree of the Poincaré duality algebra. <code>*pairing*["Degree"]</code> gives $n - 2$.
- The degrees in the three gradings are the following:

| *x* | `"Bar"` | `"Exterior"` | `"Symmetric"` |
|---|---|---|---|
| a cyclic word $w$ | $\lvert w\rvert$, the sum of the letter degrees | $[w] = \lvert w\rvert + n - 2$ | $[w]_1 = \lvert w\rvert + n - 3$ |
| a letter $p$ | the degree of the word $p$ | the same | the same |
| a product $u_1 \cdots u_k$ | $\sum_i \lvert u_i\rvert$ | $\sum_i [u_i]$ | $\sum_i [u_i]_1$ |
| [HBar]() | none | none | $2(n-3)$ |

- The empty word <code>[CyclicWord]()[{}]</code> has bar degree $0$.
- [HBar]() has a degree only in the symmetric grading, the grading of the Beilinson-Drinfeld algebra. It is the degree that makes the operator $\Delta = q_{110} + q_{120} + \hbar\,q_{210}$ homogeneous of degree $-1$.
- A BD action has the degree $2(n-3)$ of [HBar](), which is the degree [MaurerCartanBasis]() and [MaurerCartanAnsatz]() use when none is given.
- A scalar multiple has the degree of what it multiplies, a power $\hbar^g$ has $g$ times the degree of [HBar](), and a sum has a degree when all its terms have the same one.
- A scalar multiple of a letter counts only when the scalar contains no letter.
- The letters of the dual alphabet of a pairing object have their degrees too.
- In the bar grading *pairing* may also be an association from letters to degrees.
- A sum of mixed degree, `0`, a bare scalar, a letter outside the alphabet, and [HBar]() in the bar or exterior grading return unevaluated.

## Basic Examples

The bar degree of a word of the circle, where $n = 1$:

```wl
ElementDegree[{x, y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Bar"]
```

<!-- => -1 -->

---

Its exterior degree:

```wl
ElementDegree[{x, y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Exterior"]
```

<!-- => -2 -->

---

Its symmetric degree:

```wl
ElementDegree[{x, y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Symmetric"]
```

<!-- => -3 -->

---

The degree of [HBar]() on the circle is $2(1-3)$:

```wl
ElementDegree[HBar, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Symmetric"]
```

<!-- => -4 -->

## Scope

A [CyclicWord]() may be given instead of a list:

```wl
ElementDegree[CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Bar"]
```

<!-- => -1 -->

---

In the bar grading an association of degrees may stand in for the pairing object:

```wl
ElementDegree[{x, y, y, y}, <|x -> -1, y -> 0|>, "Bar"]
```

<!-- => -1 -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The words of length at most $2$, with their degrees in the three gradings:

```wl
(w |-> w -> (ElementDegree[w, pairing, #] & /@ {"Bar", "Exterior", "Symmetric"})) /@ GenerateCyclicWords[2, pairing, "UpTo" -> True]
```

<!-- => {CyclicWord[{x}] -> {-1, -2, -3}, CyclicWord[{y}] -> {0, -1, -2}, CyclicWord[{x, y}] -> {-1, -2, -3}, CyclicWord[{y, y}] -> {0, -1, -2}} -->

A product has the sum of the degrees of its factors, in each grading:

```wl
ElementDegree[SymmetricProduct[{x}, {x, y}, pairing], pairing, #] & /@ {"Bar", "Exterior", "Symmetric"}
```

<!-- => {-2, -4, -6} -->

A letter has the degree of the word made of it alone:

```wl
ElementDegree[x, pairing, "Symmetric"]
```

<!-- => -3 -->

A sum of multiples of a letter has the degree of the letter:

```wl
ElementDegree[2 x + c x, pairing, "Bar"]
```

<!-- => -1 -->

A power of [HBar]() times a word:

```wl
ElementDegree[3 HBar^2 CyclicWord[{x, y}], pairing, "Symmetric"]
```

<!-- => -11 -->

A BD action is homogeneous, of the degree of [HBar](), unknown coefficients included:

```wl
ElementDegree[MaurerCartanAnsatz[c, pairing, 4]["BDAction"], pairing, "Symmetric"]
```

<!-- => -4 -->

---

The letters of a dual alphabet have their degrees:

```wl
ElementDegree[a, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>], "Bar"]
```

<!-- => -1 -->

---

The alphabet of the three-sphere, where $n = 3$:

```wl
sphere = GradedPairing[NondegenerateQuotient[SullivanModel["Sphere"[3]]]]
```

<!-- => a GradedPairing object with letters 1 and v, of pairing degree 1 -->

The degree of [HBar]() depends on $n$, and for the three-sphere it is $0$:

```wl
ElementDegree[HBar, sphere, "Symmetric"]
```

<!-- => 0 -->

So a power of [HBar]() does not change the degree of a word:

```wl
ElementDegree[HBar^2 CyclicWord[{1, 1, 1}], sphere, "Symmetric"]
```

<!-- => -3 -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The symmetric grading is the exterior one shifted down by $1$, and the exterior grading is the bar grading shifted by the degree of the pairing:

```wl
AllTrue[GenerateCyclicWords[4, pairing, "UpTo" -> True], ElementDegree[#, pairing, "Symmetric"] === ElementDegree[#, pairing, "Exterior"] - 1 === ElementDegree[#, pairing, "Bar"] + pairing["Degree"] - 1 &]
```

<!-- => True -->

A product of two words:

```wl
p = SymmetricProduct[{x, y, y, y}, {x, y}, pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{x, y}], CyclicWord[{x, y, y, y}]] -->

Its symmetric degree:

```wl
ElementDegree[p, pairing, "Symmetric"]
```

<!-- => -6 -->

The operator [CanonicalBeilinsonDrinfeldOperator]() on it, with a term in [HBar]():

```wl
CanonicalBeilinsonDrinfeldOperator[p, pairing]
```

<!-- => 2*HBar*CyclicWord[{x, y, y, y}] - SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

The operator lowers the symmetric degree by $1$, its term in [HBar]() included:

```wl
ElementDegree[CanonicalBeilinsonDrinfeldOperator[p, pairing], pairing, "Symmetric"]
```

<!-- => -7 -->

---

The alphabet of the circle, built from its minimal model:

```wl
circle = GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1, with its algebra -->

The canonical element of the circle has the degree of a BD action, $-4$:

```wl
ElementDegree[CanonicalMaurerCartan[circle]["BDAction"], circle, "Symmetric"]
```

<!-- => -4 -->

## Possible Issues

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

A sum of terms of different degrees has no degree and returns unevaluated:

```wl
ElementDegree[CyclicWord[{x}] + CyclicWord[{y}], pairing, "Bar"]
```

<!-- => the input with the pairing object in place, unevaluated -->

[HBar]() has no exterior degree:

```wl
ElementDegree[HBar, pairing, "Exterior"]
```

<!-- => the input with the pairing object in place, unevaluated -->

The zero element has no degree:

```wl
ElementDegree[0, pairing, "Bar"]
```

<!-- => the input with the pairing object in place, unevaluated -->

A letter outside the alphabet has no degree:

```wl
ElementDegree[{x, z}, pairing, "Bar"]
```

<!-- => the input with the pairing object in place, unevaluated -->

---

An association of degrees carries no degree of the pairing, so it gives only the bar degree:

```wl
ElementDegree[{x, y}, <|x -> -1, y -> 0|>, "Exterior"]
```

<!-- => ElementDegree[{x, y}, <|x -> -1, y -> 0|>, "Exterior"] -->
