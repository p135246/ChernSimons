---
Template: Symbol
Name: TwistedCobracket
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/TwistedCobracket
Keywords: [twisted cobracket, Maurer-Cartan, q120]
SeeAlso: [TwistedDifferential, InvolutiveCobracket, MaurerCartanEquation]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[TwistedCobracket]()[*m*, *w*, *pairing*]</code> gives the co-bracket $q^{\mathfrak{m}}_{1,2,0}$ twisted by the element *m*, applied to the cyclic word *w*.

## Details & Options

The untwisted co-bracket plus the insertion of *m*, so the result is a sum of a cyclic word and a product of two.

Written in the exterior picture, like [TwistedDifferential](), regardless of the convention carried by *pairing*.

## Basic Examples

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
TwistedCobracket[CyclicWord[{x, x, y}], CyclicWord[{x, y, y, y}], pairing]
```

---

The two summands are of different shapes — one word, and a product of two:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[Head, List @@ TwistedCobracket[CyclicWord[{x, x, y}], CyclicWord[{x, y, y, y}], pairing]]
```
