---
Template: Symbol
Name: ChordContraction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/ChordContraction
Keywords: [chord, contraction, joining, cutting, bracket term, co-bracket term, empty word]
SeeAlso: [InvolutiveBracket, InvolutiveCobracket, KoszulSign, CyclicWord, GradedPairing]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[ChordContraction]()[*u*, *v*, {*i*, *j*}, *pairing*]</code> gives the term of the bracket of the cyclic words *u* and *v* in which particle *i* of *u* is contracted against particle *j* of *v*.

<code>[ChordContraction]()[*w*, {*i*, *j*}, *pairing*]</code> gives the term of the co-bracket of the cyclic word *w* in which particles *i* and *j* are contracted and the word is cut into two arcs.

## Details & Options

A chord joins two particles whose pairing value is nonzero. Between two words it joins the two circles into one: the two contracted particles are removed and the two remainders are concatenated, each read cyclically from the particle after the contracted one. On one word it cuts the circle into two: the arc from *i* to *j* and the arc from *j* to *i*, each without its endpoints.

The value is the pairing of the two particles, times the Koszul sign of the convention of *pairing*, times the resulting word, or product of two words, in canonical form. The `"Convention"` key of *pairing* selects the symmetric or the exterior sign.

[InvolutiveBracket]() is the sum over every pair *{i, j}* of positions, and [InvolutiveCobracket]() is one half of the sum over every ordered pair of distinct positions.

| option | default | effect |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether an empty remainder or an empty arc is kept as the empty word <code>CyclicWord[{}]</code> rather than set to $0$ |

Without the option the value is the term of the positive-length convention of the paper. With it the contraction of two one-particle words is the empty word, and a cut next to a contracted particle survives with the empty word as one arc. These are the boundary terms of the empty-word extension.

The words are given as [CyclicWord]() expressions; positions count from $1$ along the list of particles.

## Basic Examples

Of the two chords between $x$ and $xy$ only the one meeting $y$ pairs to something nonzero:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{ChordContraction[CyclicWord[{x}], CyclicWord[{x, y}], {1, 1}, pairing], ChordContraction[CyclicWord[{x}], CyclicWord[{x, y}], {1, 2}, pairing]}
```

<!-- => {0, -CyclicWord[{x}]} -->

---

Cutting $xyyy$ between its first and its third particle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ChordContraction[CyclicWord[{x, y, y, y}], {1, 3}, pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Scope

Contracting two one-particle words leaves nothing, which is $0$ in the paper's convention and the empty word in the extension:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{ChordContraction[CyclicWord[{x}], CyclicWord[{y}], {1, 1}, pairing], ChordContraction[CyclicWord[{x}], CyclicWord[{y}], {1, 1}, pairing, "EmptyWord" -> True]}
```

<!-- => {0, -CyclicWord[{}]} -->

---

A cut next to the contracted particle has an empty arc:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{ChordContraction[CyclicWord[{x, y, y, y}], {1, 2}, pairing], ChordContraction[CyclicWord[{x, y, y, y}], {1, 2}, pairing, "EmptyWord" -> True]}
```

<!-- => {0, -SymmetricProduct[CyclicWord[{}], CyclicWord[{y, y}]]} -->

---

The exterior convention changes the sign, not the chord:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
ChordContraction[CyclicWord[{x, y, y, y}], {1, 3}, exterior]
```

## Properties and Relations

The bracket is the sum of the chord contractions over all pairs of positions:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
u = CyclicWord[{x, y}]; v = CyclicWord[{x, y, y}];
{Total[Table[ChordContraction[u, v, {i, j}, pairing], {i, 2}, {j, 3}], 2], InvolutiveBracket[u, v, pairing]}
```

<!-- => {-CyclicWord[{x, y, y}], -CyclicWord[{x, y, y}]} -->

---

The co-bracket is one half of the sum over ordered pairs of distinct positions; each chord is counted once in each orientation:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
w = CyclicWord[{x, y, y, y, y}];
{Total[Map[pair |-> ChordContraction[w, pair, pairing], Select[Tuples[Range[5], 2], pair |-> First[pair] =!= Last[pair]]]]/2, InvolutiveCobracket[w, pairing]}
```

<!-- => {-2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]], -2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]]} -->

## Possible Issues

**A position outside the word, or two equal positions in the cutting form, match no definition.** The expression stays unevaluated rather than returning $0$; only chords between two distinct particles are contractions.

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ChordContraction[CyclicWord[{x, y}], {1, 1}, pairing]
```
