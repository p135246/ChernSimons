---
Template: Symbol
Name: InvolutiveBracket
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/InvolutiveBracket
Keywords: [bracket, Lie bracket, derivation, involutive bi-Lie algebra, empty word]
SeeAlso: [InvolutiveCobracket, ChordContraction, JacobiObstruction, DrinfeldObstruction, SymmetricProduct, ExteriorProduct, GradedPairing]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[InvolutiveBracket]()[*u*, *v*, *pairing*]</code> gives the bracket $[u,v]$ of two cyclic words, in the convention carried by *pairing*.

<code>[InvolutiveBracket]()[*p*, *pairing*]</code> applies the extension of the bracket as a derivation to a product *p* of any number of factors.

## Details & Options

The bracket is the operation $q_{2,1,0}$ of the involutive bi-Lie structure: it takes two cyclic words and returns one, contracting one particle of each against the pairing. It is the sum of [ChordContraction]() over every pair of positions.

The convention key of *pairing* selects the picture. `"Symmetric"` gives the bracket of the [SymmetricProduct]() grading, `"Exterior"` that of the [ExteriorProduct]() grading; the two differ by signs, not by the underlying contraction.

In the two-argument form the result is the derivation extension $\hat q_{2,1,0}$: the bracket is applied to each pair of factors in turn, with the Koszul sign of the shuffle, and the remaining factors are carried along. The extension lowers the number of factors by one, and a single remaining factor is returned as the word itself.

Both forms are linear: they distribute over sums and pull scalars out. That is what lets them be composed, with the products, whose normalized form carries a sign whenever the factors have to be reordered, and with each other.

A word may be given as the list of its particles.

| option | default | effect |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the contraction of two one-particle words is kept as the empty word <code>CyclicWord[{}]</code> rather than set to $0$ |

Without the option the bracket is that of the positive-length convention of the paper. With it the bracket is that of the empty-word extension, in which the empty word is a word of degree $0$; the empty word is central, so its bracket with anything is $0$ in both conventions.

The identities the bracket satisfies are the business of [JacobiObstruction]() and [DrinfeldObstruction](), swept over a range of word lengths to search for a counterexample.

## Basic Examples

The bracket of two words of the circle:

```wl
InvolutiveBracket[CyclicWord[{x}], CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -CyclicWord[{x}] -->

---

Multiplicities show up as integer coefficients:

```wl
InvolutiveBracket[CyclicWord[{x, y}], CyclicWord[{y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -2 CyclicWord[{y, y}] -->

---

The bracket of a word with itself may vanish:

```wl
InvolutiveBracket[CyclicWord[{x, y}], CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

## Scope

The derivation extension applied to a two-factor product returns the remaining word:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
InvolutiveBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing], pairing]
```

<!-- => -CyclicWord[{x}] -->

---

On three factors it sums over the pairs, with the shuffle signs:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
InvolutiveBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], pairing], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] - 2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y}]] -->

---

The same in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
InvolutiveBracket[ExteriorProduct[CyclicWord[{x}], CyclicWord[{x, y}], exterior], exterior]
```

<!-- => -CyclicWord[{x}] -->

---

Words may be given as lists of particles:

```wl
InvolutiveBracket[{x}, {x, y}, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -CyclicWord[{x}] -->

---

The bracket of two one-particle words is $0$ in the paper's convention and the empty word in the extension:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{InvolutiveBracket[{x}, {y}, pairing], InvolutiveBracket[{x}, {y}, pairing, "EmptyWord" -> True]}
```

<!-- => {0, -CyclicWord[{}]} -->

---

The whole bracket table in length at most $2$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
words = CyclicWords[2, pairing, "UpTo" -> True];
Outer[InvolutiveBracket[#1, #2, pairing] &, words, words]
```

<!-- => a 4x4 array of cyclic words and 0s -->

## Properties and Relations

On two cyclic words the two conventions agree here, and differ only through the signs the products carry:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
exterior = Append[pairing, "Convention" -> "Exterior"];
{InvolutiveBracket[CyclicWord[{x}], CyclicWord[{x, y}], pairing], InvolutiveBracket[CyclicWord[{x}], CyclicWord[{x, y}], exterior]}
```

<!-- => {-CyclicWord[{x}], -CyclicWord[{x}]} -->

---

The bracket is the sum of [ChordContraction]() over all pairs of positions:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
u = CyclicWord[{x, y}]; v = CyclicWord[{x, y, y}];
{Total[Table[ChordContraction[u, v, {i, j}, pairing], {i, 2}, {j, 3}], 2], InvolutiveBracket[u, v, pairing]}
```

<!-- => {-CyclicWord[{x, y, y}], -CyclicWord[{x, y, y}]} -->

---

The bracket satisfies the graded Jacobi identity throughout the enumerated range:

```wl
words[n_] := CyclicWords[n, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True];
DeleteDuplicates[Map[t |-> JacobiObstruction[t[[1]], t[[2]], t[[3]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], Tuples[words[3], 3]]]
```

<!-- => {0} -->

---

Because the extension is linear it may be applied twice, and the Jacobi identity is the statement that doing so gives zero. The intermediate result is a signed sum of two-factor products, so this composition is exactly what linearity buys:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
p = SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], pairing];
{InvolutiveBracket[p, pairing], InvolutiveBracket[InvolutiveBracket[p, pairing], pairing]}
```

<!-- => {SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] - 2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y}]], 0} -->

## Possible Issues

**The convention of *pairing* must match the head of *p*.** The extension is defined for a [SymmetricProduct]() under `"Symmetric"` and for an [ExteriorProduct]() under `"Exterior"`, so handing one to the other leaves the call unevaluated instead of returning a product of cyclic words. Rebuild the product with the pairing it is to be used with.

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
exterior = Append[pairing, "Convention" -> "Exterior"];
Head[InvolutiveBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing], exterior]]
```

<!-- => InvolutiveBracket -->

---

**The extension lowers the number of factors by one, so on a single cyclic word it is $0$.** A forgotten second argument therefore returns $0$ rather than staying unevaluated: <code>[InvolutiveBracket]()[*u*, *pairing*]</code> is the extension applied to *u*, not the bracket of *u* with something.

```wl
InvolutiveBracket[CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

**On two factors the result is the remaining word, not a one-factor product.** Compare it against a [CyclicWord]().

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
b = InvolutiveBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing], pairing];
{b, b === -CyclicWord[{x}], b === -SymmetricProduct[CyclicWord[{x}]]}
```

<!-- => {-CyclicWord[{x}], True, False} -->
