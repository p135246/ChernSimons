---
Template: Symbol
Name: DualPairing
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/DualPairing
Keywords: [dual pairing, evaluation, dual alphabet, cyclic word]
SeeAlso: [ProductPairing, Pairing, CyclicWord, KoszulSign]
---

## Usage

<code>[DualPairing]()[*f*, *e*, *pairing*]</code> evaluates a cyclic word *f* of particles on a cyclic word *e* of dual particles.

## Details & Options

*pairing* must carry a `"Dual"` key, so it has to be built with the four-argument form <code>[Pairing]()[*degrees*, *spec*, *dualDegrees*, *evaluation*]</code>. Without it [DualPairing]() issues `Pairing::dual` and aborts.

The value is a number: the sum over all matchings of the particles of *f* against the dual particles of *e*, each weighted by the Koszul sign of the rotation that produces it and by the entries of the *evaluation* association.

Words of different lengths evaluate to $0$, since no matching exists.

Because a cyclic word is a word up to rotation, a word of length $k$ generally has $k$ matchings against a dual word of the same length, and the value counts them all. This is why the diagonal entries can be larger than $1$.

The extension of this evaluation to products of words is [ProductPairing]().

## Basic Examples

A dual alphabet with $\langle x,a\rangle=1$ and $\langle y,b\rangle=1$, and the evaluation of $xy$ on $ab$:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
DualPairing[CyclicWord[{x, y}], CyclicWord[{a, b}], dual]
```

<!-- => 1 -->

---

A word whose two rotations both match counts both:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
DualPairing[CyclicWord[{y, y}], CyclicWord[{b, b}], dual]
```

<!-- => 2 -->

---

Words of different lengths do not pair:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
DualPairing[CyclicWord[{x, y}], CyclicWord[{a, b, b}], dual]
```

<!-- => 0 -->

## Scope

The pairing is on cyclic words, so a rotation of the dual word gives the same value:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
{DualPairing[CyclicWord[{x, y}], CyclicWord[{a, b}], dual], DualPairing[CyclicWord[{x, y}], CyclicWord[{b, a}], dual]}
```

<!-- => {1, 1} -->

---

The full evaluation table in length $2$:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
Outer[DualPairing[#1, #2, dual] &, {CyclicWord[{x, y}], CyclicWord[{y, y}]}, {CyclicWord[{a, b}], CyclicWord[{b, b}]}]
```

<!-- => {{1, 0}, {0, 2}} -->

## Properties and Relations

[ProductPairing]() extends the evaluation to products of equal length:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
ProductPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], dual], SymmetricProduct[CyclicWord[{a}], CyclicWord[{b}], dual], dual]
```

<!-- => 1/2 -->

## Possible Issues

A pairing object built with two arguments carries no dual alphabet, and [DualPairing]() aborts on it with `Pairing::dual`. Check for the key before evaluating.

```wl
KeyExistsQ[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Dual"]
```

<!-- => False -->
