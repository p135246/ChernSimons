---
Template: Symbol
Name: TwistedDifferential
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/TwistedDifferential
Keywords: [twisted differential, Maurer-Cartan, q110, Hochschild]
SeeAlso: [TwistedCobracket, MaurerCartanEquation, InvolutiveBracket, InvolutiveCobracket]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[TwistedDifferential]()[*m*, *w*, *pairing*]</code> gives the differential $q^{\mathfrak{m}}_{1,1,0}$ twisted by the element *m*, applied to the cyclic word *w*.

## Details & Options

The twisted differential is [CyclicDifferential]() plus the bracket with *m*, the bracket taken up to the sign of the symmetric degree. On a formal alphabet the first summand vanishes and the twist is the bracket alone. Twisting by a Maurer-Cartan element gives a differential; twisting by anything else does not.

Both this and [TwistedCobracket]() are written in the exterior picture, the one the paper states them in, regardless of the convention carried by *pairing*.

## Basic Examples

Twisting by the canonical element of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
TwistedDifferential[CyclicWord[{x, x, y}], CyclicWord[{x, y, y}], pairing]
```

---

On the shorter words of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[w |-> TwistedDifferential[CyclicWord[{x, x, y}], w, pairing], CyclicWords[2, pairing]]
```
