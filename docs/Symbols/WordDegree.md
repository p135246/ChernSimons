---
Template: Symbol
Name: WordDegree
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/WordDegree
Keywords: [degree, grading, shift, Koszul degree, cyclic word]
SeeAlso: [CyclicWord, CyclicWords, GradedPairing, ExteriorProduct, SymmetricProduct, KoszulSign]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[WordDegree]()[*w*, *data*]</code> gives the degree of the cyclic word *w*, the sum of the degrees of its particles.

<code>[WordDegree]()[*w*, *pairing*, "Exterior"]</code> gives its degree in the exterior grading $[-]$.

<code>[WordDegree]()[*w*, *pairing*, "Symmetric"]</code> gives its degree in the symmetric grading $[-]_1 = [-]-1$.

## Details & Options

*w* is a [CyclicWord]() or a bare list of particles; the two are interchangeable.

The two-argument form reads only degrees, so *data* may be a pairing object or a bare association from particles to degrees.

The three-argument forms shift by the degree of the pairing and therefore need a real pairing object.

| grading | value |
|---|---|
| plain | $\lvert w\rvert$, the sum of the particle degrees |
| `"Exterior"` | $[w] = \lvert w\rvert + \lvert\langle\cdot,\cdot\rangle\rvert$, the Koszul degree carried by [ExteriorProduct]() |
| `"Symmetric"` | $[w]_1 = [w] - 1$, the Koszul degree carried by [SymmetricProduct]() |

The two shifted gradings are what make the sign bookkeeping of the two pictures differ, and choosing between them is the whole content of the `"Convention"` key of the pairing object. The symmetric grading is one lower than the exterior one, uniformly.

## Basic Examples

The three degrees of a word of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{WordDegree[{x, y}, pairing], WordDegree[{x, y}, pairing, "Exterior"], WordDegree[{x, y}, pairing, "Symmetric"]}
```

<!-- => {-1, -2, -3} -->

---

The plain degree is just the sum of the particle degrees:

```wl
WordDegree[{x, y, y, y}, <|x -> -1, y -> 0|>]
```

<!-- => -1 -->

---

A [CyclicWord]() may be given instead of a list:

```wl
WordDegree[CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -1 -->

## Scope

Over the whole alphabet of the circle in length at most $3$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[# -> WordDegree[#, pairing] &, CyclicWords[3, pairing, "UpTo" -> True]]
```

<!-- => {CyclicWord[{x}] -> -1, CyclicWord[{y}] -> 0, …} -->

---

The two shifted gradings, side by side:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[# -> {WordDegree[#, pairing, "Exterior"], WordDegree[#, pairing, "Symmetric"]} &, CyclicWords[2, pairing, "UpTo" -> True]]
```

<!-- => {CyclicWord[{x}] -> {-2, -3}, CyclicWord[{y}] -> {-1, -2}, …} -->

## Properties and Relations

The symmetric grading is the exterior one shifted down by $1$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
AllTrue[CyclicWords[4, pairing, "UpTo" -> True], WordDegree[#, pairing, "Symmetric"] === WordDegree[#, pairing, "Exterior"] - 1 &]
```

<!-- => True -->

---

The exterior grading is the plain degree shifted by the degree of the pairing:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
AllTrue[CyclicWords[4, pairing, "UpTo" -> True], WordDegree[#, pairing, "Exterior"] === WordDegree[#, pairing] + pairing["Degree"] &]
```

<!-- => True -->
