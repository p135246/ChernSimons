---
Template: Symbol
Name: DualPairing
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/DualPairing
Keywords: [dual pairing, evaluation, dual alphabet, cyclic word, product pairing, matchings, factorial weight]
SeeAlso: [GradedPairing, CyclicWord, SymmetricProduct, ExteriorProduct, KoszulSign]
RelatedGuides: [CanonicalLieBialgebras]
---

## Usage

<code>[DualPairing]()[*u*, *v*, *pairing*]</code> gives the value of the cyclic word *u* of particles on the cyclic word *v* of dual particles.

<code>[DualPairing]()[*p*, *q*, *pairing*]</code> gives the value of the product *p* of cyclic words on the product *q* of dual cyclic words, two symmetric or two exterior products.

<!-- #| annotation: 26.09.30: Design review - DualPairing absorbed ProductPairing on 2026-09-30, on Pavel's proposal, so that one function per concept dispatches on the heads of its arguments: two words, two symmetric products, two exterior products, or a word and a product. Every form needs the "Dual" key of the pairing, so a pairing without a dual alphabet gives the one message GradedPairing::dual and returns unevaluated; before, ProductPairing gave 0 on a word and a product without the key, and on two products issued the message once per pair of factors. A symmetric against an exterior product returns unevaluated, as it did under ProductPairing; no alternative was recorded. Alternative name considered: ProductPairing, the name of the product form until 2026-09-30. Prior art: the Wolfram Language has no cyclic words or dual alphabets; the engine the verification suites load evaluates words and symmetric products, and pins both forms. -->

## Details & Options

- *pairing* must carry a `"Dual"` key, so it is built with the four-argument form <code>[GradedPairing]()[*degrees*, *spec*, *dual*, *evaluation*]</code>. Without the key the message `GradedPairing::dual` is issued and the expression returns unevaluated.
- [DualPairing]() dispatches on the heads of its first two arguments:

| Arguments | Value |
|---|---|
| two [CyclicWord]() | the value of the word on the dual word |
| two [SymmetricProduct]() | the sum over the matchings of the factors, with the weight $1/k!$ on $k$ factors |
| two [ExteriorProduct]() | the sum over the matchings of the factors, with no weight |
| a word and a product | $0$ |

- On two words the value is a number: the sum over the rotations of *v*, each with its Koszul sign, of the product of the values of the *evaluation* association on the matched particles, times the reversal sign of the degrees of *u*.
- A word of length $k$ has up to $k$ rotations matching a dual word, and the value counts them all, so a value may exceed $1$.
- Words of different lengths give $0$.
- On two products the value is the sum over all matchings of the factors of *p* with the factors of *q*: each term is the product of the values on the matched words, times the Koszul sign of the permutation that realizes the matching, times a sign of the degrees of the factors of *p*.
- Products with different numbers of factors give $0$.
- A symmetric product against an exterior product returns unevaluated.
- [DualPairing]() is linear in both arguments, and a word may be given as the list of its particles.

## Basic Examples

The evaluation of $xy$ on $ab$, for a dual alphabet with $\langle x, a \rangle = 1$ and $\langle y, b \rangle = 1$:

```wl
DualPairing[CyclicWord[{x, y}], CyclicWord[{a, b}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]]
```

<!-- => 1 -->

---

A word whose two rotations both match counts both:

```wl
DualPairing[CyclicWord[{y, y}], CyclicWord[{b, b}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]]
```

<!-- => 2 -->

---

The circle with its dual alphabet:

```wl
dual = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y and dual particles a and b, of pairing degree -1 -->

Two symmetric products of two factors each, with the weight $1/2!$:

```wl
DualPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], dual], SymmetricProduct[CyclicWord[{a}], CyclicWord[{b}], dual], dual]
```

<!-- => 1/2 -->

---

The circle with its dual alphabet, in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with particles x and y and dual particles a and b, of pairing degree -1, in the exterior convention -->

The same data as exterior products, which carry no factorial weight:

```wl
DualPairing[ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], exterior], ExteriorProduct[CyclicWord[{a}], CyclicWord[{b}], exterior], exterior]
```

<!-- => 1 -->

## Scope

The circle with its dual alphabet:

```wl
dual = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y and dual particles a and b, of pairing degree -1 -->

The pairing is on cyclic words, so a rotation of the dual word gives the same value:

```wl
DualPairing[CyclicWord[{x, y}], CyclicWord[{b, a}], dual]
```

<!-- => 1 -->

The evaluation table in length $2$:

```wl
Outer[DualPairing[#1, #2, dual] &, {CyclicWord[{x, y}], CyclicWord[{y, y}]}, {CyclicWord[{a, b}], CyclicWord[{b, b}]}]
```

<!-- => {{1, 0}, {0, 2}} -->

Words of different lengths give $0$:

```wl
DualPairing[CyclicWord[{x, y}], CyclicWord[{a, b, b}], dual]
```

<!-- => 0 -->

Products of different numbers of factors give $0$:

```wl
DualPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], dual], SymmetricProduct[CyclicWord[{a}], CyclicWord[{b}], CyclicWord[{b, b}], dual], dual]
```

<!-- => 0 -->

A word against a product gives $0$:

```wl
DualPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], dual], CyclicWord[{a, b}], dual]
```

<!-- => 0 -->

The pairing is linear in both arguments, and a word may be given as a list:

```wl
DualPairing[3 SymmetricProduct[{x}, {y}, dual] + c CyclicWord[{y, y}], SymmetricProduct[{a}, {b}, dual] + CyclicWord[{b, b}], dual]
```

<!-- => 3/2 + 2 c -->

## Properties and Relations

The circle with its dual alphabet:

```wl
dual = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y and dual particles a and b, of pairing degree -1 -->

On two symmetric products of two factors:

```wl
DualPairing[SymmetricProduct[{x, y}, {y}, dual], SymmetricProduct[{a, b}, {b}, dual], dual]
```

<!-- => 1/2 -->

The exterior pairing of their images under [SymmetricToExterior](), divided by $2!$, is the same here:

```wl
DualPairing[SymmetricToExterior[SymmetricProduct[{x, y}, {y}, dual], dual], SymmetricToExterior[SymmetricProduct[{a, b}, {b}, dual], dual], Append[dual, "Convention" -> "Exterior"]]/2
```

<!-- => 1/2 -->

## Possible Issues

A pairing object built with two arguments carries no dual alphabet:

```wl
KeyExistsQ[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Dual"]
```

<!-- => False -->

On such a pairing the message is issued:

```wl
DualPairing[CyclicWord[{x, y}], CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the message GradedPairing::dual is issued and the expression returns unevaluated -->

---

A symmetric product against an exterior product returns unevaluated:

```wl
DualPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]], ExteriorProduct[CyclicWord[{a}], CyclicWord[{b}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]]
```

<!-- => the input, unevaluated -->
