---
Template: Symbol
Name: ChordContraction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/ChordContraction
Keywords: [chord, contraction, joining, cutting, bracket term, co-bracket term, empty word]
SeeAlso: [CanonicalLieBracket, CanonicalLieCobracket, KoszulSign, CyclicWord, GradedPairing]
RelatedGuides: [CanonicalLieBialgebra]
---

## Usage

<code>[ChordContraction]()[*u*, *v*, {*i*, *j*}, *pairing*]</code> gives the term of the bracket of the cyclic words *u* and *v* in which letter *i* of *u* is contracted against letter *j* of *v*.

<code>[ChordContraction]()[*w*, {*i*, *j*}, *pairing*]</code> gives the term of the co-bracket of the cyclic word *w* in which letters *i* and *j* are contracted and *w* is cut into two arcs.

<!-- #| annotation: 26.09.30: Design review - ChordContraction is exported because it is the one term the bracket and the co-bracket share, and the published notebook shows the chord sum term by term, which the API could not before the decision of 2026-09-21. The joining and the cutting term share the name and differ in arity, two words against one, each with its position pair. It is the one operation of the paclet that takes no word as the list of its letters, because its position pair is a list too. A position outside the word, or two equal positions in the cutting form, match no definition and return unevaluated; no alternative was recorded. The function reads the pairing value, the degrees and the convention off the GradedPairing object, so CanonicalLieBracket and CanonicalLieCobracket are plain sums of it. Prior art: the Wolfram Language has no cyclic words or chord diagrams; the verification suites pin the chord sums against CanonicalLieBracket and CanonicalLieCobracket, which they pin against the bracket and the co-bracket of the engine. -->

## Details & Options

- A chord joins two letters whose pairing value is nonzero.
- Between two words the chord joins the two circles into one: the two contracted letters are removed, and the two remainders are concatenated, each read cyclically from the letter after the contracted one.
- On one word the chord cuts the circle into two: the arc from *i* to *j* and the arc from *j* to *i*, each without its endpoints.
- The value is the pairing value of the two letters, times the Koszul sign of the convention of *pairing*, times the resulting word, or product of two words, in canonical form.
- The `"Convention"` key of *pairing* selects the sign, and in the cutting form also the head of the product: [SymmetricProduct]() under `"Symmetric"`, [ExteriorProduct]() under `"Exterior"`.
- [CanonicalLieBracket]() is the sum over every pair $\{i, j\}$ of positions, and [CanonicalLieCobracket]() is one half of the sum over every ordered pair of distinct positions.
- The words are given as [CyclicWord]() expressions, and positions count from $1$ along the list of letters.
- [ChordContraction]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether an empty remainder or an empty arc is kept as the empty word <code>[CyclicWord]()[{}]</code> rather than giving $0$ |

- With `"EmptyWord" -> False` the value is the term of the positive-length convention.
- With `"EmptyWord" -> True` the contraction of two one-letter words is the empty word, and a cut next to a contracted letter has the empty word as one arc. These are the boundary terms of the empty-word extension.
- A position outside the word, or two equal positions in the cutting form, return unevaluated.

## Basic Examples

The chord between $x$ and the letter $y$ of $xy$:

```wl
ChordContraction[CyclicWord[{x}], CyclicWord[{x, y}], {1, 2}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -CyclicWord[{x}] -->

---

The chord between $x$ and the letter $x$ of $xy$ pairs to $0$:

```wl
ChordContraction[CyclicWord[{x}], CyclicWord[{x, y}], {1, 1}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

Cutting $xyyy$ between its first and its third letter:

```wl
ChordContraction[CyclicWord[{x, y, y, y}], {1, 3}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Scope

The exterior convention changes the sign and the head of the product, not the chord:

```wl
ChordContraction[CyclicWord[{x, y, y, y}], {1, 3}, Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Options

### EmptyWord

Contracting two one-letter words leaves nothing, which is $0$ in the positive-length convention:

```wl
ChordContraction[CyclicWord[{x}], CyclicWord[{y}], {1, 1}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

With `"EmptyWord" -> True` it is the empty word:

```wl
ChordContraction[CyclicWord[{x}], CyclicWord[{y}], {1, 1}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "EmptyWord" -> True]
```

<!-- => -CyclicWord[{}] -->

---

A cut next to the contracted letter has an empty arc, and gives $0$ by default:

```wl
ChordContraction[CyclicWord[{x, y, y, y}], {1, 2}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

With `"EmptyWord" -> True` the empty arc is the empty word:

```wl
ChordContraction[CyclicWord[{x, y, y, y}], {1, 2}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "EmptyWord" -> True]
```

<!-- => -SymmetricProduct[CyclicWord[{}], CyclicWord[{y, y}]] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

The sum of the chord contractions over all pairs of positions:

```wl
Total[Table[ChordContraction[CyclicWord[{x, y}], CyclicWord[{x, y, y}], {i, j}, pairing], {i, 2}, {j, 3}], 2]
```

<!-- => -CyclicWord[{x, y, y}] -->

It is the bracket:

```wl
CanonicalLieBracket[CyclicWord[{x, y}], CyclicWord[{x, y, y}], pairing]
```

<!-- => -CyclicWord[{x, y, y}] -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

One half of the sum over the ordered pairs of distinct positions, each chord counted once in each orientation:

```wl
Total[(pair |-> ChordContraction[CyclicWord[{x, y, y, y, y}], pair, pairing]) /@ Select[Tuples[Range[5], 2], pair |-> First[pair] =!= Last[pair]]]/2
```

<!-- => -2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]] -->

It is the co-bracket:

```wl
CanonicalLieCobracket[CyclicWord[{x, y, y, y, y}], pairing]
```

<!-- => -2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]] -->

## Possible Issues

Two equal positions in the cutting form match no definition, and the expression returns unevaluated:

```wl
ChordContraction[CyclicWord[{x, y}], {1, 1}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->

---

A position outside the word returns unevaluated as well:

```wl
ChordContraction[CyclicWord[{x}], CyclicWord[{x, y}], {1, 3}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->

---

Words given as lists of letters return unevaluated, since the position pair is a list too:

```wl
ChordContraction[{x}, {x, y}, {1, 2}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->
