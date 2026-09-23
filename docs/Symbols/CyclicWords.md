---
Template: Symbol
Name: CyclicWords
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CyclicWords
Keywords: [cyclic words, enumeration, necklaces, graded alphabet]
SeeAlso: [CyclicWord, WordDegree, GradedPairing]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[CyclicWords]()[*n*, *data*]</code> enumerates the nonzero cyclic words of length *n* over the alphabet of *data*.

<code>[CyclicWords]()[*n*, *data*, "UpTo" -> True]</code> gives the nonzero cyclic words of every length up to *n*.

## Details & Options

*data* is either a pairing object built by [GradedPairing](), or a bare association from particles to degrees.

Only canonical representatives are listed, and words that a rotation sends to minus themselves are omitted — those are $0$, not elements of a basis. So the list is a basis of the space of cyclic words in that length, in the paclet's internal order.

The result is a list of inert one-argument [CyclicWord]() expressions, ready to be fed to any operation.

| option | default | effect |
|---|---|---|
| <code>"UpTo"</code> | <code>False</code> | whether to return every length up to *n* rather than the single length *n* |
| <code>"EmptyWord"</code> | <code>False</code> | whether the empty word <code>CyclicWord[{}]</code> counts as the one word of length $0$ |

With `"UpTo" -> True` the lengths come in increasing order, and within each length the internal order is preserved. With `"EmptyWord" -> True` as well, the empty word comes first.

Enumeration is the usual source of the truncation a finite check runs under: a statement verified on <code>[CyclicWords]()[*n*, *pairing*, "UpTo" -> True]</code> is verified for words of length at most *n* and no further.

## Basic Examples

The two cyclic words of length $2$ over the alphabet of the circle:

```wl
CyclicWords[2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {CyclicWord[{x, y}], CyclicWord[{y, y}]} -->

---

Length $3$:

```wl
CyclicWords[3, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {CyclicWord[{x, x, x}], CyclicWord[{x, x, y}], CyclicWord[{x, y, y}], CyclicWord[{y, y, y}]} -->

---

Every length up to $2$ at once:

```wl
CyclicWords[2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True]
```

<!-- => {CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}], CyclicWord[{y, y}]} -->

---

With the empty word, which is the one word of length $0$:

```wl
CyclicWords[1, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True, "EmptyWord" -> True]
```

<!-- => {CyclicWord[{}], CyclicWord[{x}], CyclicWord[{y}]} -->

## Scope

A bare association of degrees works in place of a pairing object:

```wl
CyclicWords[1, <|x -> -1, y -> 0|>]
```

<!-- => {CyclicWord[{x}], CyclicWord[{y}]} -->

---

The count by length over the alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Table[Length[CyclicWords[n, pairing]], {n, 6}]
```

<!-- => {2, 2, 4, 4, 8, 12} -->

---

A three-particle alphabet enumerates the same way:

```wl
CyclicWords[2, GradedPairing[<|alpha -> -1, beta -> 0, gamma -> -1|>, <|{alpha, beta} -> 1, {gamma, beta} -> 1|>]]
```

<!-- => {CyclicWord[{alpha, beta}], CyclicWord[{alpha, gamma}], CyclicWord[{beta, beta}], CyclicWord[{beta, gamma}]} -->

## Properties and Relations

The enumeration omits exactly the words [CyclicWord]() sends to $0$ — there is no $xx$ in length $2$:

```wl
CyclicWord[{x, x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

A sweep of an identity runs over this enumeration, which is what fixes its truncation:

```wl
words[n_] := CyclicWords[n, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True];
DeleteDuplicates[Map[w |-> Expand[CoJacobiObstruction[w, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]], words[4]]]
```

<!-- => {0} -->

## Neat Examples

The words of length $4$, with their degrees in all three gradings:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[# -> {WordDegree[#, pairing], WordDegree[#, pairing, "Exterior"], WordDegree[#, pairing, "Symmetric"]} &, CyclicWords[4, pairing]]
```

<!-- => {CyclicWord[{x, x, x, y}] -> {-3, -4, -5}, CyclicWord[{x, x, y, y}] -> {-2, -3, -4}, CyclicWord[{x, y, y, y}] -> {-1, -2, -3}, CyclicWord[{y, y, y, y}] -> {0, -1, -2}} -->
