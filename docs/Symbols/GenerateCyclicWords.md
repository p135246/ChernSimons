---
Template: Symbol
Name: GenerateCyclicWords
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/GenerateCyclicWords
Keywords: [cyclic words, enumeration, necklaces, graded alphabet]
SeeAlso: [CyclicWord, ElementDegree, GradedPairing, Tuples]
RelatedGuides: [CanonicalLieBialgebra]
---

## Usage

<code>[GenerateCyclicWords]()[*n*, *pairing*]</code> gives the nonzero cyclic words of length *n* over the alphabet of *pairing*, each in its canonical rotation.

<!-- #| annotation: 26.09.30: Design review - the enumeration is the normalization of CyclicWord applied to every tuple of particles, with duplicates and zeros removed, so it lists exactly the representatives the operations give and nothing needs to be compared up to rotation. The length is exact by default and "UpTo" -> True gives every length up to n; the empty word is left out unless "EmptyWord" -> True, the positive-length convention of the paper. Only the degrees are read, so an Association of degrees may stand in for the pairing object. Alternative name considered: CyclicWords, the name until 2026-09-30. Prior art: the Wolfram Language has no enumeration of necklaces or cyclic words, and Tuples gives the linear words the enumeration starts from. The verification suites build their test words from this function, as pacletWords in T12, and compare the operations on them with the engine they load. -->

## Details & Options

- *pairing* is a pairing object built by [GradedPairing](), or an association from particles to degrees.
- Only canonical representatives are listed, and the words that a rotation sends to minus themselves are left out, since they are $0$. The list is a basis of the space of cyclic words of length *n*.
- The words come in the order in which <code>[Tuples]()</code> of the particles first reaches them.
- The result is a list of inert one-argument [CyclicWord]() expressions.
- A negative *n* returns unevaluated.
- [GenerateCyclicWords]() has the following options:

| Option | Default | Description |
|---|---|---|
| <code>"UpTo"</code> | <code>False</code> | whether to give every length up to *n* rather than the single length *n* |
| <code>"EmptyWord"</code> | <code>False</code> | whether the empty word <code>[CyclicWord]()[{}]</code> counts as the one word of length $0$ |

- With `"UpTo" -> True` the lengths come in increasing order. With `"EmptyWord" -> True` as well, the empty word comes first.
- A statement checked on <code>[GenerateCyclicWords]()[*n*, *pairing*, "UpTo" -> True]</code> is checked for the words of length at most *n*.

## Basic Examples

The two cyclic words of length $2$ over the alphabet of the circle:

```wl
GenerateCyclicWords[2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {CyclicWord[{x, y}], CyclicWord[{y, y}]} -->

---

The words of length $3$:

```wl
GenerateCyclicWords[3, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {CyclicWord[{x, x, x}], CyclicWord[{x, x, y}], CyclicWord[{x, y, y}], CyclicWord[{y, y, y}]} -->

## Scope

An association of degrees works in place of a pairing object:

```wl
GenerateCyclicWords[1, <|x -> -1, y -> 0|>]
```

<!-- => {CyclicWord[{x}], CyclicWord[{y}]} -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The number of words by length:

```wl
Table[Length[GenerateCyclicWords[n, pairing]], {n, 6}]
```

<!-- => {2, 2, 4, 4, 8, 12} -->

---

A three-particle alphabet enumerates the same way:

```wl
GenerateCyclicWords[2, GradedPairing[<|alpha -> -1, beta -> 0, gamma -> -1|>, <|{alpha, beta} -> 1, {gamma, beta} -> 1|>]]
```

<!-- => {CyclicWord[{alpha, beta}], CyclicWord[{alpha, gamma}], CyclicWord[{beta, beta}], CyclicWord[{beta, gamma}]} -->

## Options

### UpTo

Every length up to $2$ at once:

```wl
GenerateCyclicWords[2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True]
```

<!-- => {CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}], CyclicWord[{y, y}]} -->

### EmptyWord

In the positive-length convention there is no word of length $0$:

```wl
GenerateCyclicWords[0, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {} -->

---

With `"EmptyWord" -> True` the empty word is the one word of length $0$:

```wl
GenerateCyclicWords[0, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "EmptyWord" -> True]
```

<!-- => {CyclicWord[{}]} -->

---

With both options the empty word comes first:

```wl
GenerateCyclicWords[1, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True, "EmptyWord" -> True]
```

<!-- => {CyclicWord[{}], CyclicWord[{x}], CyclicWord[{y}]} -->

## Properties and Relations

The enumeration leaves out exactly the words [CyclicWord]() sends to $0$, so there is no $xx$ in length $2$:

```wl
CyclicWord[{x, x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

A check of an identity runs over this enumeration, which fixes its truncation. The co-Jacobi identity on all words of length at most $4$:

```wl
DeleteDuplicates[Obstruction[CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], "CoJacobi", {#}] & /@ GenerateCyclicWords[4, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True]]
```

<!-- => {0} -->

## Neat Examples

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The words of length $4$, with their degrees in the three gradings:

```wl
(w |-> w -> (ElementDegree[w, pairing, #] & /@ {"Bar", "Exterior", "Symmetric"})) /@ GenerateCyclicWords[4, pairing]
```

<!-- => {CyclicWord[{x, x, x, y}] -> {-3, -4, -5}, CyclicWord[{x, x, y, y}] -> {-2, -3, -4}, CyclicWord[{x, y, y, y}] -> {-1, -2, -3}, CyclicWord[{y, y, y, y}] -> {0, -1, -2}} -->
