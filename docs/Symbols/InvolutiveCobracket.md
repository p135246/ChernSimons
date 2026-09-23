---
Template: Symbol
Name: InvolutiveCobracket
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/InvolutiveCobracket
Keywords: [cobracket, co-Lie, co-derivation, involutive bi-Lie algebra]
SeeAlso: [InvolutiveBracket, ChordContraction, CoJacobiObstruction, InvolutivityObstruction, DrinfeldObstruction, SymmetricProduct, ExteriorProduct, GradedPairing]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[InvolutiveCobracket]()[*w*, *pairing*]</code> gives the co-bracket of a cyclic word *w*, a product of two words, in the convention carried by *pairing*.

<code>[InvolutiveCobracket]()[*p*, *pairing*]</code> applies the extension of the co-bracket as a co-derivation to a product *p*.

## Details & Options

The co-bracket is the operation $q_{1,2,0}$ of the involutive bi-Lie structure: it takes one cyclic word and returns a product of two, cutting the word at a pair of positions and contracting the two removed particles against the pairing.

The convention key of *pairing* selects the picture: the result is a [SymmetricProduct]() under `"Symmetric"` and an [ExteriorProduct]() under `"Exterior"`.

A word too short to be cut in two, or one whose cuts all cancel, has co-bracket $0$. Over the alphabet of the circle the first nonzero co-bracket appears in length $4$.

On a product the result is the co-derivation extension $\hat q_{1,2,0}$: the co-bracket is applied to each factor in turn, with the Koszul sign of the shuffle. The extension raises the number of factors by one. On a single cyclic word the extension is the co-bracket itself, so there is one function here and not two.

The extension is linear in its argument: it distributes over sums and pulls scalars out. That is what lets it be composed, with the products, whose normalized form carries a sign whenever the factors have to be reordered, and with itself.

The co-bracket is one half of the sum of [ChordContraction]() over every ordered pair of distinct positions. A word may be given as the list of its particles.

| option | default | effect |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether a cut next to a contracted particle is kept, with the empty word <code>CyclicWord[{}]</code> as its empty arc, rather than dropped |

Without the option only cuts with two nonempty arcs count, which is the positive-length convention of the paper. With it the co-bracket is that of the empty-word extension; the co-bracket of the empty word itself is $0$ in both conventions.

The identities the co-bracket satisfies are the business of [CoJacobiObstruction](), [DrinfeldObstruction]() and [InvolutivityObstruction]().

## Basic Examples

The first nonzero co-bracket over the alphabet of the circle:

```wl
InvolutiveCobracket[CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

---

A word too short to cut has co-bracket $0$:

```wl
InvolutiveCobracket[CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

The same computation in the exterior picture, where the answer lands in an [ExteriorProduct]():

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
InvolutiveCobracket[CyclicWord[{x, y, y, y}], exterior]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Scope

Over the whole alphabet up to length $5$, only two words have a nonzero co-bracket:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
DeleteCases[Map[# -> InvolutiveCobracket[#, pairing] &, CyclicWords[5, pairing, "UpTo" -> True]], _ -> 0]
```

<!-- => {CyclicWord[{x, y, y, y}] -> -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]], CyclicWord[{x, y, y, y, y}] -> -2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]]} -->

---

The co-derivation extension raises the number of factors by one:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
InvolutiveCobracket[SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y, y, y}], pairing], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{y}]] -->

---

With the empty word kept, the cuts next to the contracted particles survive; the shortest word then has a nonzero co-bracket:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{InvolutiveCobracket[{x, y}, pairing, "EmptyWord" -> True], InvolutiveCobracket[{x, y, y, y}, pairing, "EmptyWord" -> True]}
```

<!-- => {-SymmetricProduct[CyclicWord[{}], CyclicWord[{}]], -2 SymmetricProduct[CyclicWord[{}], CyclicWord[{y, y}]] - SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]]} -->

## Properties and Relations

The co-bracket squares to zero — the co-Jacobi identity — throughout the enumerated range:

```wl
words[n_] := CyclicWords[n, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True];
DeleteDuplicates[Map[w |-> Expand[CoJacobiObstruction[w, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]], words[5]]]
```

<!-- => {0} -->

---

Composing it with [InvolutiveBracket]() gives zero as well, which is involutivity:

```wl
words[n_] := CyclicWords[n, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True];
DeleteDuplicates[Map[w |-> Expand[InvolutivityObstruction[w, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]], words[5]]]
```

<!-- => {0} -->

---

[ShiftIsomorphism]() is the map that intertwines [InvolutiveBracket]() and [InvolutiveCobracket]() between the two pictures:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
exterior = Append[pairing, "Convention" -> "Exterior"];
{InvolutiveCobracket[CyclicWord[{x, y, y, y}], pairing], InvolutiveCobracket[CyclicWord[{x, y, y, y}], exterior]}
```

<!-- => {-SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]], ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]]} -->

---

Because the extension is linear it may be applied twice, and the co-Jacobi identity is the statement that doing so gives zero. The intermediate result is a signed product, so this composition is exactly what linearity buys:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
w = CyclicWord[{x, y, y, y, y}];
{InvolutiveCobracket[w, pairing], InvolutiveCobracket[InvolutiveCobracket[w, pairing], pairing]}
```

<!-- => {-2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]], 0} -->

## Possible Issues

**The convention of *pairing* must match the head of the product.** The extension is defined for a [SymmetricProduct]() under `"Symmetric"` and for an [ExteriorProduct]() under `"Exterior"`, so handing one to the other leaves the call unevaluated instead of returning a product of cyclic words. Rebuild the product with the pairing it is to be used with.

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
exterior = Append[pairing, "Convention" -> "Exterior"];
Head[InvolutiveCobracket[SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y, y, y}], pairing], exterior]]
```

<!-- => InvolutiveCobracket -->
