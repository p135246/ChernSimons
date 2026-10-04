---
Template: Symbol
Name: CanonicalBeilinsonDrinfeldBracket
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CanonicalBeilinsonDrinfeldBracket
Keywords: [BD bracket, Beilinson-Drinfeld, Poisson bracket, derived bracket]
SeeAlso: [CanonicalBeilinsonDrinfeldOperator, CanonicalLieBracket, MaurerCartanElement, Obstruction, ElementDegree, HBar]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[CanonicalBeilinsonDrinfeldBracket]()[*f*, *g*, *pairing*]</code> gives the Beilinson-Drinfeld bracket $\{f, g\}$ of *f* and *g*.

<!-- #| annotation: 26.09.30: Design review - the bracket is the one of the BD axiom as the paper writes it, with an explicit HBar in front, so it carries no HBar itself. The engine's bvBracket is instead the derived bracket of the operator, the BV bracket of the localization, which is HBar times this one; the paclet computes the bracket from its cross terms, CanonicalLieBracket of one factor of each argument with the Koszul sign of bringing the pair to the front, rather than dividing the derived bracket by HBar. A pairing in the exterior convention returns unevaluated, for the reason the operator does: the BD algebra is the symmetric algebra. Alternative name considered: BeilinsonDrinfeldBracket, the name until 2026-09-30. Prior art: the Wolfram Language has no Poisson or BD brackets on graded words. T12/paclet-bd-operator-and-bracket pins HBar times this bracket against the bvBracket of the engine the verification suites load on all pairs of words to length 4, and that it is free of HBar there. -->

## Details & Options

- The bracket is the one of the BD axiom satisfied by [CanonicalBeilinsonDrinfeldOperator]():
$$\Delta(f g) = \Delta(f) g + (-1)^{|f|} f \Delta(g) + (-1)^{|f|}\hbar\,\{f, g\},$$
with $|f|$ the symmetric degree of $f$.
- For products $f = u_1 \odot \cdots \odot u_k$ and $g = v_1 \odot \cdots \odot v_l$ it is $(-1)^{|f|}$ times the sum over a factor $u_i$ of $f$ and a factor $v_j$ of $g$ of the Koszul sign of bringing $u_i$ and $v_j$ to the front, times $[u_i, v_j]$ of [CanonicalLieBracket]() times the product of the other factors.
- On two cyclic words it is $\{u, v\} = (-1)^{|u|}[u, v]$.
- It is already present on the symmetric powers of cyclic words before $\hbar$ is adjoined, and carries no $\hbar$ itself.
- The derived bracket of $\Delta$, the failure of $\Delta$ to be a derivation, is $\hbar$ times this bracket. That derived bracket is the BV bracket of the localization at $\hbar$.
- *f* and *g* are cyclic words, symmetric products of cyclic words, lists of letters, or linear combinations of these. The bracket is bilinear.
- A pairing object in the exterior convention returns unevaluated.
- [CanonicalBeilinsonDrinfeldBracket]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the bracket is that of the extension by the empty word, in which the bracket of two one-letter words is the empty word |

## Basic Examples

The bracket of two cyclic words of the circle:

```wl
CanonicalBeilinsonDrinfeldBracket[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -2 CyclicWord[{x, y, y, y}] -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

On two words it is [CanonicalLieBracket]() up to the sign of the symmetric degree of the first word:

```wl
CanonicalLieBracket[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing]
```

<!-- => 2 CyclicWord[{x, y, y, y}] -->

The symmetric degree of the first word is odd:

```wl
ElementDegree[CyclicWord[{x, y, y, y}], pairing, "Symmetric"]
```

<!-- => -3 -->

## Scope

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The bracket of a product and a word:

```wl
CanonicalBeilinsonDrinfeldBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}], pairing], CyclicWord[{x, y}], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] -->

Words may be given as lists of letters:

```wl
CanonicalBeilinsonDrinfeldBracket[{x, y, y, y}, {x, y}, pairing]
```

<!-- => -2 CyclicWord[{x, y, y, y}] -->

The bracket is bilinear:

```wl
CanonicalBeilinsonDrinfeldBracket[3 CyclicWord[{x, y, y, y}], CyclicWord[{x, y}] + CyclicWord[{y, y}], pairing]
```

<!-- => -6 CyclicWord[{x, y, y, y}] + 6 CyclicWord[{y, y, y, y}] -->

## Options

### EmptyWord

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The bracket of two one-letter words is $0$ in the positive-length convention:

```wl
CanonicalBeilinsonDrinfeldBracket[CyclicWord[{x}], CyclicWord[{y}], pairing]
```

<!-- => 0 -->

With `"EmptyWord" -> True` it is the empty word:

```wl
CanonicalBeilinsonDrinfeldBracket[CyclicWord[{x}], CyclicWord[{y}], pairing, "EmptyWord" -> True]
```

<!-- => CyclicWord[{}] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The bracket is free of $\hbar$:

```wl
FreeQ[CanonicalBeilinsonDrinfeldBracket[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], HBar]
```

<!-- => True -->

It is the bracket of the BD axiom of [CanonicalBeilinsonDrinfeldOperator](), which holds on two words:

```wl
With[{u = CyclicWord[{x, y, y, y}], v = CyclicWord[{x, y}]}, {s = (-1)^ElementDegree[u, pairing, "Symmetric"]}, Expand[CanonicalBeilinsonDrinfeldOperator[SymmetricProduct[u, v, pairing], pairing] - SymmetricProduct[CanonicalBeilinsonDrinfeldOperator[u, pairing], v, pairing] - s SymmetricProduct[u, CanonicalBeilinsonDrinfeldOperator[v, pairing], pairing] - s HBar CanonicalBeilinsonDrinfeldBracket[u, v, pairing]]]
```

<!-- => 0 -->

## Possible Issues

The alphabet of the circle in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1, in the exterior convention -->

The bracket lives in the symmetric picture, so an exterior pairing returns unevaluated:

```wl
CanonicalBeilinsonDrinfeldBracket[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], exterior]
```

<!-- => the input with exterior in place, unevaluated -->
