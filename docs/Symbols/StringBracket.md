---
Template: Symbol
Name: StringBracket
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/StringBracket
Keywords: [bracket, Lie bracket, derivation, involutive bi-Lie algebra, empty word]
SeeAlso: [StringCobracket, ChordContraction, StringAlgebra, Obstruction, SymmetricProduct, ExteriorProduct, GradedPairing]
RelatedGuides: [StringAlgebras]
---

## Usage

<code>[StringBracket]()[*u*, *v*, *pairing*]</code> gives the bracket $[u,v]$ of the cyclic words *u* and *v*, in the convention of *pairing*.

<code>[StringBracket]()[*p*, *pairing*]</code> gives the extension of the bracket as a derivation, applied to a product *p* of cyclic words.

<!-- #| annotation: 26.09.30: Design review - the bracket is the sum of ChordContraction over every pair of positions, and ChordContraction is exported because it is the one term the bracket and the co-bracket share and the published notebook shows the chord sum term by term. The function reads the degrees and the pairing values off the GradedPairing object and carries its own linearity rules, so a scalar multiple or a sum of products, the natural output of the products, composes without a wrapper. A product whose head disagrees with the convention of the pairing returns unevaluated rather than being coerced, since coercing would reinterpret a symmetric product as an exterior one and change signs. A single remaining factor is the word itself, never a one-factor product, the rule every product of the paclet follows. Alternative name considered: InvolutiveBracket, the name until 2026-09-30. Prior art: the Wolfram Language has no cyclic words or involutive bi-Lie structures; the engine the verification suites load computes the same bracket from letter strings and pins this function on every pair of words to total length 7. -->

## Details & Options

- The bracket is the operation $\mathfrak{q}_{2,1,0}$ of the involutive bi-Lie structure. It gives, for two cyclic words, the sum over one particle of each of the pairing value of the two particles, times a Koszul sign, times the cyclic word made of the two remainders.
- The bracket is the sum of [ChordContraction]() over every pair of positions.
- The convention of *pairing* selects the picture: `"Symmetric"` gives the bracket of the [SymmetricProduct]() grading, `"Exterior"` that of the [ExteriorProduct]() grading. The two differ by signs, not by the contraction.
- In the two-argument form the bracket is applied to each pair of factors of *p* in turn, with the Koszul sign of the shuffle, and the other factors are carried along. The extension lowers the number of factors by one, so it is $0$ on a single cyclic word, and a single remaining factor is the word itself.
- Both forms are linear: they distribute over sums and pull out scalars.
- A word may be given as the list of its particles.
- A product whose head disagrees with the convention of *pairing* returns unevaluated.
- [StringBracket]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the contraction of two one-particle words is the empty word <code>[CyclicWord]()[{}]</code> rather than $0$ |

- With `"EmptyWord" -> False` the bracket is that of the positive-length convention. With `"EmptyWord" -> True` it is that of the empty-word extension, in which the empty word has degree $0$ and is central, so its bracket with any word is $0$.
- The identities of the bracket, `"Jacobi"` and `"Drinfeld"`, are relations of the [StringAlgebra]() of *pairing*, computed by [Obstruction]().

## Basic Examples

The bracket of two words of the circle:

```wl
StringBracket[CyclicWord[{x}], CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -CyclicWord[{x}] -->

---

Multiplicities show up as integer coefficients:

```wl
StringBracket[CyclicWord[{x, y}], CyclicWord[{y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -2 CyclicWord[{y, y}] -->

---

The bracket of a word with itself may vanish:

```wl
StringBracket[CyclicWord[{x, y}], CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

## Scope

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The extension on a product of two words gives the remaining word:

```wl
StringBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing], pairing]
```

<!-- => -CyclicWord[{x}] -->

On three factors it sums over the pairs, with the shuffle signs:

```wl
StringBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], pairing], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] - 2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y}]] -->

---

The alphabet of the circle in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1, in the exterior convention -->

The extension on an exterior product:

```wl
StringBracket[ExteriorProduct[CyclicWord[{x}], CyclicWord[{x, y}], exterior], exterior]
```

<!-- => -CyclicWord[{x}] -->

---

Words may be given as lists of particles:

```wl
StringBracket[{x}, {x, y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -CyclicWord[{x}] -->

---

The whole bracket table of the words of length at most $2$:

```wl
Outer[StringBracket[#1, #2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]] &, GenerateCyclicWords[2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True], GenerateCyclicWords[2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True]]
```

<!-- => {{0, 0, -CyclicWord[{x}], -2 CyclicWord[{y}]}, {0, 0, -CyclicWord[{y}], 0}, {CyclicWord[{x}], -CyclicWord[{y}], 0, -2 CyclicWord[{y, y}]}, {-2 CyclicWord[{y}], 0, -2 CyclicWord[{y, y}], 0}} -->

## Options

### EmptyWord

The bracket of two one-particle words is $0$ in the positive-length convention:

```wl
StringBracket[{x}, {y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

With `"EmptyWord" -> True` it is the empty word:

```wl
StringBracket[{x}, {y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "EmptyWord" -> True]
```

<!-- => -CyclicWord[{}] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The sum of [ChordContraction]() over all pairs of positions:

```wl
Total[Table[ChordContraction[CyclicWord[{x, y}], CyclicWord[{x, y, y}], {i, j}, pairing], {i, 2}, {j, 3}], 2]
```

<!-- => -CyclicWord[{x, y, y}] -->

It is the bracket:

```wl
StringBracket[CyclicWord[{x, y}], CyclicWord[{x, y, y}], pairing]
```

<!-- => -CyclicWord[{x, y, y}] -->

---

On two cyclic words the exterior convention gives the same bracket here:

```wl
StringBracket[CyclicWord[{x}], CyclicWord[{x, y}], Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]]
```

<!-- => -CyclicWord[{x}] -->

---

The bracket satisfies the graded Jacobi identity on all triples of words of length at most $3$:

```wl
DeleteDuplicates[Obstruction[StringAlgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], "Jacobi", #] & /@ Tuples[GenerateCyclicWords[3, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True], 3]]
```

<!-- => {0} -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

A product of three words:

```wl
p = SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}]] -->

The extension of the bracket gives a signed sum of products of two words:

```wl
StringBracket[p, pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] - 2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y}]] -->

Since the extension is linear it applies again, and the Jacobi identity says the result is $0$:

```wl
StringBracket[StringBracket[p, pairing], pairing]
```

<!-- => 0 -->

## Possible Issues

The alphabet of the circle in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1, in the exterior convention -->

A symmetric product under an exterior pairing returns unevaluated, since the extension is defined for a [SymmetricProduct]() under `"Symmetric"` and for an [ExteriorProduct]() under `"Exterior"`:

```wl
StringBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}]], exterior]
```

<!-- => the input with exterior in place, unevaluated -->

---

The extension lowers the number of factors by one, so on a single cyclic word it is $0$. A forgotten second word therefore gives $0$:

```wl
StringBracket[CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

On two factors the extension gives the remaining word:

```wl
StringBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing], pairing]
```

<!-- => -CyclicWord[{x}] -->

It is a cyclic word, not a product of one factor:

```wl
MatchQ[StringBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing], pairing], -CyclicWord[_]]
```

<!-- => True -->
