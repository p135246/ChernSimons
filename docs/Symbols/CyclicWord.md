---
Template: Symbol
Name: CyclicWord
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CyclicWord
Keywords: [cyclic word, canonical rotation, Koszul sign, graded alphabet]
SeeAlso: [GenerateCyclicWords, ElementDegree, GradedPairing, ExteriorProduct, SymmetricProduct]
RelatedGuides: [CanonicalLieBialgebra]
---

## Usage

<code>[CyclicWord]()[*w*]</code> is the cyclic word whose particles are the list *w*.

<code>[CyclicWord]()[*w*, *pairing*]</code> gives the canonical rotation of *w* times its Koszul sign, or $0$ when a rotation sends *w* to minus itself.

<!-- #| annotation: 26.09.30: Design review - a word is a list of particles, not a string, since the engine switched from strings on 2026-07-03: lists allow alphabets of arbitrary expressions, multi-character names and the basis monomials of a Poincare duality algebra among them, and use RotateLeft and Tuples directly. The one-argument form is inert, the normal form every operation gives its words in, and carries no grading, so the degrees always come from the pairing object passed beside it. The normalization is exported as the two-argument form because it is one of the few functions every operation shares, and the rule of the rewrite shares only exported functions with a mathematical name. Only the degrees are read, so an Association of degrees may stand in for the pairing object. The canonical rotation is the least rotation in the canonical order of Sort; it is not always the representative the engine picks, as on the Kodaira-Thurston alphabet. The empty word returns 0 by default, the positive-length convention of the paper, and is a word with "EmptyWord" -> True. Prior art: the Wolfram Language has no cyclic-word or necklace type; the engine the verification suites load normalizes the same words with its own cyc, and T12 compares the operations of the two on the words GenerateCyclicWords lists. -->

## Details & Options

- [CyclicWord]() with one argument is inert: it is the normal form in which every operation gives its words, and it carries no grading of its own.
- *pairing* is a pairing object built by [GradedPairing](), or an association from particles to degrees. Only the degrees are read.
- A cyclic word is a word up to rotation. Moving the first particle $p$ of $w$ to the end costs the Koszul sign $(-1)^{\lvert p\rvert(\lvert w\rvert - \lvert p\rvert)}$.
- The canonical rotation is the least rotation in the canonical order of <code>[Sort]()</code>. The sign relating *w* to it is a scalar coefficient in front of the word.
- A word that a rotation sends to minus itself is $0$. The alphabet of the circle has no word $xx$ and no word $xyxy$.
- The two-argument form is a normalization: a word already in canonical rotation is its own normal form.
- <code>[CyclicWord]()[{}]</code> is the empty word, of bar degree $0$.
- A word displays as its particles in parentheses, $(x\,y\,y)$, and the empty word as $\epsilon$. A particle that is not a symbol is set in its own parentheses, so juxtaposition always says where one particle ends and the next begins. <code>[InputForm]()</code> shows the expression itself.
- [CyclicWord]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether <code>[CyclicWord]()[{}, *pairing*]</code> is the empty word rather than $0$ |

## Basic Examples

Rotating a word into canonical form:

```wl
CyclicWord[{y, x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => CyclicWord[{x, y}] -->

---

A word that a rotation sends to minus itself vanishes:

```wl
CyclicWord[{x, x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

The one-argument form is inert, and is the form every operation gives:

```wl
CyclicWord[{x, y, y}]
```

<!-- => CyclicWord[{x, y, y}] -->

## Scope

An association of degrees works in place of a pairing object:

```wl
CyclicWord[{y, y, x}, <|x -> -1, y -> 0|>]
```

<!-- => CyclicWord[{x, y, y}] -->

---

A rotation past an odd particle can cost a sign:

```wl
CyclicWord[{x, y, x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -CyclicWord[{x, x, y}] -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

Longer words are normalized the same way:

```wl
CyclicWord[#, pairing] & /@ {{y, x}, {y, y, x}, {y, x, y, y}}
```

<!-- => {CyclicWord[{x, y}], CyclicWord[{x, y, y}], CyclicWord[{x, y, y, y}]} -->

Every word that a rotation sends to minus itself is $0$:

```wl
CyclicWord[#, pairing] & /@ {{x, x}, {x, y, x, y}, {y, x, y, x}}
```

<!-- => {0, 0, 0} -->

## Options

### EmptyWord

The empty word is $0$ in the positive-length convention:

```wl
CyclicWord[{}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

With `"EmptyWord" -> True` it is a word:

```wl
CyclicWord[{}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "EmptyWord" -> True]
```

<!-- => CyclicWord[{}] -->

## Properties and Relations

[GenerateCyclicWords]() enumerates exactly the words that the two-argument [CyclicWord]() does not send to $0$:

```wl
GenerateCyclicWords[2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {CyclicWord[{x, y}], CyclicWord[{y, y}]} -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

Two rotations of one word normalize to the same word:

```wl
CyclicWord[{y, y, x}, pairing] === CyclicWord[{y, x, y}, pairing]
```

<!-- => True -->

A word in canonical rotation is its own normal form:

```wl
CyclicWord[{x, y, y}, pairing]
```

<!-- => CyclicWord[{x, y, y}] -->

The empty word has bar degree $0$:

```wl
ElementDegree[CyclicWord[{}], pairing, "Bar"]
```

<!-- => 0 -->

Its symmetric degree is the degree of the pairing minus $1$:

```wl
ElementDegree[CyclicWord[{}], pairing, "Symmetric"]
```

<!-- => -2 -->

## Possible Issues

The one-argument form does no normalization, so two inert words that are rotations of one another are different expressions:

```wl
CyclicWord[{y, x}] === CyclicWord[{x, y}]
```

<!-- => False -->

Normalized with a pairing they agree:

```wl
CyclicWord[{y, x}, <|x -> -1, y -> 0|>] === CyclicWord[{x, y}, <|x -> -1, y -> 0|>]
```

<!-- => True -->
