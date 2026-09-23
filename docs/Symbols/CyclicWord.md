---
Template: Symbol
Name: CyclicWord
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CyclicWord
Keywords: [cyclic word, canonical rotation, Koszul sign, graded alphabet]
SeeAlso: [CyclicWords, WordDegree, GradedPairing, ExteriorProduct, SymmetricProduct]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[CyclicWord]()[*w*]</code> represents the cyclic word whose particles are the list *w*.

<code>[CyclicWord]()[*w*, *data*]</code> gives the canonical rotation of *w* together with its Koszul sign, or $0$ if the word is cyclically antisymmetric.

## Details & Options

[CyclicWord]() with one argument is inert: it is the normal form in which every operation of the paclet returns its words, and it carries no grading of its own.

*data* is either a pairing object built by [GradedPairing](), or a bare association from particles to degrees. Only the degrees are read, so the two are interchangeable here.

A cyclic word is a word up to rotation, and rotating past a particle of odd degree costs a Koszul sign. The canonical rotation is the least one in the paclet's internal order; the sign relating *w* to it is returned as a scalar coefficient.

A word fixed by a rotation of odd total sign equals its own negative and is therefore $0$. This is why the alphabet of the circle has no word $xx$ and no word $xyxy$.

The two-argument form is a normalization, not a constructor: it is idempotent, and applying it to a word already in canonical form returns that word unchanged.

<code>[CyclicWord]()[{}]</code> is the empty word, a word of degree $0$ that the paper's positive-length convention does not have and the empty-word extension does.

A word displays as its letters in parentheses, $(x\,y\,y)$, and the empty word as $\epsilon$. A letter that is not a symbol is set in its own parentheses, so juxtaposition always says where one letter ends and the next begins. The displayed form is the word itself: copying it back into an input cell gives the same expression, and <code>[InputForm]()</code> and <code>[OutputForm]()</code> are untouched.

| option | default | effect |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether <code>[CyclicWord]()[{}, *data*]</code> is the empty word rather than $0$ |

## Basic Examples

Rotating a word into canonical form:

```wl
CyclicWord[{y, x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => CyclicWord[{x, y}] -->

---

A cyclically antisymmetric word vanishes:

```wl
CyclicWord[{x, x}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

The one-argument form is inert, and is the shape every operation returns:

```wl
CyclicWord[{x, y, y}]
```

<!-- => CyclicWord[{x, y, y}] -->

## Scope

A bare association of degrees works in place of a pairing object:

```wl
CyclicWord[{y, y, x}, <|x -> -1, y -> 0|>]
```

<!-- => CyclicWord[{x, y, y}] -->

---

Longer words are normalized the same way:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
CyclicWord[#, pairing] & /@ {{y, x}, {y, y, x}, {y, x, y, y}}
```

<!-- => {CyclicWord[{x, y}], CyclicWord[{x, y, y}], CyclicWord[{x, y, y, y}]} -->

---

Every word that a rotation sends to minus itself is $0$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
CyclicWord[#, pairing] & /@ {{x, x}, {x, y, x, y}, {y, x, y, x}}
```

<!-- => {0, 0, 0} -->

---

The empty word is $0$ in the paper's convention and a word in the extension:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{CyclicWord[{}, pairing], CyclicWord[{}, pairing, "EmptyWord" -> True], WordDegree[{}, pairing, "Symmetric"]}
```

<!-- => {0, CyclicWord[{}], -2} -->

## Properties and Relations

[CyclicWords]() enumerates exactly the words that the two-argument [CyclicWord]() does not send to $0$:

```wl
CyclicWords[2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {CyclicWord[{x, y}], CyclicWord[{y, y}]} -->

---

Normalization is idempotent:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
CyclicWord[{y, y, x}, pairing] === CyclicWord[{x, y, y}, pairing]
```

<!-- => True -->

## Possible Issues

The one-argument form does no normalization at all, so two inert words that are rotations of one another are different expressions. Normalize with the two-argument form before comparing.

```wl
CyclicWord[{y, x}] === CyclicWord[{x, y}]
```

<!-- => False -->
