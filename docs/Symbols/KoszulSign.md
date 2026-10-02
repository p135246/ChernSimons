---
Template: Symbol
Name: KoszulSign
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/KoszulSign
Keywords: [Koszul sign, permutation, graded, parity, transposition]
SeeAlso: [ElementDegree, ExteriorProduct, SymmetricProduct, SymmetricToExterior, Signature]
RelatedGuides: [CanonicalLieBialgebras]
---

## Usage

<code>[KoszulSign]()[*perm*, *degrees*, *parity*]</code> gives the sign of bringing objects of the given *degrees* into the order *perm*, each pair that crosses contributing the product of their degrees plus *parity* to the exponent of $-1$.

<!-- #| annotation: 26.09.30: Design review - the sign is exported because the products and the derivation extensions all sort with it, and the rule of the rewrite shares between exports only functions that are themselves exports with a mathematical name. One function with a parity argument serves both pictures, parity 0 for the graded symmetric sign of the symmetric product and parity 1 for the graded antisymmetric sign of the exterior product, rather than two functions; the signature is that of the engine's koszulSign[perm, degs, parity], which follows the Hypergraph clone. Before the tests were rewritten in R1 it was checked against the engine the verification suites load on every permutation to length 5, and T12/paclet-products-and-shift pins the two products that sort with it against the engine's odot and wedge. Prior art: the Wolfram Language has Signature, the sign of a permutation, which is the case of degrees 0 and parity 1; it has no graded version. -->

## Details & Options

- *perm* is a permutation given as a list of positions: the objects are brought into the order $o_{\mathit{perm}_1}, o_{\mathit{perm}_2}, \ldots$.
- The sign is $(-1)^N$ with $N = \sum (d_{\mathit{perm}_i} d_{\mathit{perm}_j} + \mathit{parity})$, the sum over the pairs $i < j$ with $\mathit{perm}_i > \mathit{perm}_j$, where $d$ is the list *degrees*.
- With *parity* $0$ this is the graded symmetric Koszul sign. With *parity* $1$ it is the graded antisymmetric sign, the Koszul sign times the signature of the permutation.
- *degrees* may be longer than *perm*; only the entries that *perm* addresses take part.
- [ExteriorProduct]() sorts its factors with this sign at the exterior degrees and *parity* $1$, and [SymmetricProduct]() at the symmetric degrees and *parity* $0$.

## Basic Examples

The identity permutation has sign $+1$:

```wl
KoszulSign[{1, 2}, {-1, 0}, 0]
```

<!-- => 1 -->

---

The transposition of an odd and an even object has the graded symmetric sign $+1$:

```wl
KoszulSign[{2, 1}, {-1, 0}, 0]
```

<!-- => 1 -->

---

The same transposition with *parity* $1$ has sign $-1$:

```wl
KoszulSign[{2, 1}, {-1, 0}, 1]
```

<!-- => -1 -->

## Scope

Two odd objects anticommute with *parity* $0$:

```wl
KoszulSign[{2, 1}, {1, 1}, 0]
```

<!-- => -1 -->

---

They commute with *parity* $1$:

```wl
KoszulSign[{2, 1}, {1, 1}, 1]
```

<!-- => 1 -->

---

A cyclic permutation of three objects:

```wl
KoszulSign[{2, 3, 1}, {-1, 0, -1}, 0]
```

<!-- => -1 -->

---

The signs of all the permutations of three objects:

```wl
# -> KoszulSign[#, {-1, 0, -1}, 0] & /@ Permutations[Range[3]]
```

<!-- => {{1, 2, 3} -> 1, {1, 3, 2} -> 1, {2, 1, 3} -> 1, {2, 3, 1} -> -1, {3, 1, 2} -> -1, {3, 2, 1} -> -1} -->

---

Degrees that *perm* does not address are ignored:

```wl
KoszulSign[{2, 1}, {-1, 0, 5}, 0]
```

<!-- => 1 -->

## Properties and Relations

With degrees $0$ and *parity* $1$ the sign is the signature of the permutation:

```wl
KoszulSign[{2, 1, 3}, {0, 0, 0}, 1]
```

<!-- => -1 -->

It agrees with <code>[Signature]()</code>:

```wl
Signature[{2, 1, 3}]
```

<!-- => -1 -->

---

Undoing a permutation, with the degrees in their new order, gives the same sign again, so the product is $1$:

```wl
KoszulSign[{2, 3, 1}, {1, 1, 0}, 0] KoszulSign[InversePermutation[{2, 3, 1}], {1, 1, 0}[[{2, 3, 1}]], 0]
```

<!-- => 1 -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

[ExteriorProduct]() sorts at the exterior degrees with *parity* $1$:

```wl
ExteriorProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

Its sign is this one:

```wl
KoszulSign[{2, 1}, {ElementDegree[{y}, pairing, "Exterior"], ElementDegree[{x}, pairing, "Exterior"]}, 1]
```

<!-- => -1 -->

[SymmetricProduct]() sorts the same factors at the symmetric degrees with *parity* $0$:

```wl
SymmetricProduct[CyclicWord[{y}], CyclicWord[{x}], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

Its sign is this one:

```wl
KoszulSign[{2, 1}, {ElementDegree[{y}, pairing, "Symmetric"], ElementDegree[{x}, pairing, "Symmetric"]}, 0]
```

<!-- => 1 -->

## Possible Issues

The sign depends on which object carries which degree, so a permutation and its inverse have different signs in general:

```wl
KoszulSign[{2, 3, 1}, {1, 1, 0}, 0]
```

<!-- => -1 -->

The inverse permutation, with the same list of degrees:

```wl
KoszulSign[{3, 1, 2}, {1, 1, 0}, 0]
```

<!-- => 1 -->
