---
Template: Symbol
Name: ProductPairing
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/ProductPairing
Keywords: [product pairing, evaluation, matchings, dual alphabet, factorial weight]
SeeAlso: [DualPairing, Pairing, SymmetricProduct, ExteriorProduct, KoszulSign]
---

## Usage

<code>[ProductPairing]()[*f*, *e*, *pairing*]</code> evaluates a product *f* of cyclic words on a product *e* of dual cyclic words of the same number of factors.

## Details & Options

[ProductPairing]() extends [DualPairing]() from words to products. It sums over all matchings of the factors of *f* with the factors of *e*, each term the product of the factorwise [DualPairing]() values times the Koszul sign of the permutation that realizes the matching.

The convention key of *pairing* decides both the product it expects and the weight it applies:

| convention | argument | weight |
|---|---|---|
| `"Symmetric"` | [SymmetricProduct]() | $1/k!$ on $k$ factors |
| `"Exterior"` | [ExteriorProduct]() | none |

*pairing* must carry a `"Dual"` key, so it has to be built with the four-argument form of [Pairing](). Without it [ProductPairing]() issues `Pairing::dual` and aborts.

Products of different numbers of factors pair to $0$.

The $1/k!$ in the symmetric convention is what makes the pairing agree with the exterior one after the shift, and it is the reason the two pictures return different rational numbers on the same underlying data.

## Basic Examples

Two one-factor-each products, in the symmetric convention with its $1/2!$:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
ProductPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], dual], SymmetricProduct[CyclicWord[{a}], CyclicWord[{b}], dual], dual]
```

<!-- => 1/2 -->

---

The same data in the exterior convention, which carries no factorial weight:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
exterior = Append[dual, "Convention" -> "Exterior"];
ProductPairing[ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], exterior], ExteriorProduct[CyclicWord[{a}], CyclicWord[{b}], exterior], exterior]
```

<!-- => 1 -->

## Scope

On one factor each the pairing is just [DualPairing]():

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
{ProductPairing[SymmetricProduct[CyclicWord[{x, y}], dual], SymmetricProduct[CyclicWord[{a, b}], dual], dual], DualPairing[CyclicWord[{x, y}], CyclicWord[{a, b}], dual]}
```

<!-- => {1, 1} -->

---

Products of different lengths pair to $0$:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
ProductPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], dual], SymmetricProduct[CyclicWord[{a}], dual], dual]
```

<!-- => 0 -->

## Properties and Relations

The two conventions differ by exactly the factorial weight on this data:

```wl
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];
exterior = Append[dual, "Convention" -> "Exterior"];
2 ProductPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], dual], SymmetricProduct[CyclicWord[{a}], CyclicWord[{b}], dual], dual] ===
  ProductPairing[ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], exterior], ExteriorProduct[CyclicWord[{a}], CyclicWord[{b}], exterior], exterior]
```

<!-- => True -->

## Possible Issues

A pairing object built with two arguments carries no dual alphabet, and [ProductPairing]() aborts on it with `Pairing::dual`. Check for the key before evaluating.

```wl
KeyExistsQ[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Dual"]
```

<!-- => False -->
