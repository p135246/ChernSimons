---
Template: Symbol
Name: ExteriorToSymmetric
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/ExteriorToSymmetric
Keywords: [shift isomorphism, decalage, reversal rule, position rule, sign convention, inverse]
SeeAlso: [SymmetricToExterior, ExteriorProduct, SymmetricProduct, CanonicalLieBracket, CanonicalLieCobracket, ElementDegree]
RelatedGuides: [CanonicalLieBialgebra]
---

## Usage

<code>[ExteriorToSymmetric]()[*e*, *pairing*]</code> gives the symmetric product that corresponds to the exterior product *e*, with the sign of the reversal rule.

<code>[ExteriorToSymmetric]()[*e*, *pairing*, *rule*]</code> gives it with the sign of *rule*, `"Reversal"` or `"Position"`.

<!-- #| annotation: 26.09.30: Design review - ExteriorToSymmetric is what ShiftIsomorphism did with "Inverse" -> True, and SymmetricToExterior what it did by default; the split (Pavel, 2026-09-30) lets each name say which way it converts, instead of an option. Both carry their own linearity rules and the option "Rule", with the positional third argument kept as a shortcut. The direction is set by the function, never by the "Convention" key of the pairing, and a product of the other head returns unevaluated. The rules are "Reversal" and "Position", in the third argument and in the option; since R7 (Pavel, 2026-10-01) any other value returns unevaluated, where before every string but "Position" gave the reversal sign. Alternative name considered: ShiftIsomorphism with "Inverse" -> True. Prior art: the Wolfram Language has Wedge and TensorWedge but no graded symmetric algebra of cyclic words and no decalage isomorphism; the engine the verification suites load pins both rules on every tuple of words to length 3. -->

## Details & Options

- The map sends $f_1 \wedge \cdots \wedge f_k$ to $\pm f_1 \odot \cdots \odot f_k$, with the sign $(-1)^{\sum_i (k - i) [f_i]}$ of the reversal rule or $(-1)^{\sum_i i [f_i]}$ of the position rule, $[f]$ being the exterior degree of $f$.
- Each rule inverts the rule of the same name of [SymmetricToExterior]().
- The reversal rule intertwines [CanonicalLieBracket]() and [CanonicalLieCobracket]() of the two pictures.
- The map is linear, and `HBar` is a scalar to it.
- A cyclic word is taken as a product of one factor, and a word may be given as the list of its letters.
- The direction is set by the function alone, not by the `"Convention"` key of *pairing*. A [SymmetricProduct]() returns unevaluated.
- [ExteriorToSymmetric]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"Rule"</code> | <code>"Reversal"</code> | the sign rule, <code>"Reversal"</code> or <code>"Position"</code> |

- The third argument *rule* is the same as the option `"Rule" -> rule`.
- A *rule* other than `"Reversal"` and `"Position"`, in the third argument or in the option, returns unevaluated.

## Basic Examples

A two-factor exterior product in the symmetric picture:

```wl
ExteriorToSymmetric[ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

On three factors the shift costs a sign:

```wl
ExteriorToSymmetric[ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

---

The position rule, given as the third argument, gives the other sign here:

```wl
ExteriorToSymmetric[ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Position"]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

## Scope

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

A cyclic word is a product of one factor:

```wl
ExteriorToSymmetric[CyclicWord[{y}], pairing]
```

<!-- => CyclicWord[{y}] -->

A word may be given as the list of its letters:

```wl
ExteriorToSymmetric[{y}, pairing]
```

<!-- => CyclicWord[{y}] -->

The map is linear, and `HBar` is a scalar to it:

```wl
ExteriorToSymmetric[CyclicWord[{x, x, y}] + HBar ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}], pairing], pairing]
```

<!-- => CyclicWord[{x, x, y}] - HBar SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

---

Both rules invert [SymmetricToExterior]() on every nonzero product of at most three words of length at most $3$:

```wl
Union[(e |-> {SymmetricToExterior[ExteriorToSymmetric[e, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]] === e, SymmetricToExterior[ExteriorToSymmetric[e, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Position"], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Position"] === e}) /@ DeleteCases[Catenate[Table[ExteriorProduct @@ Append[tuple, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], {k, 3}, {tuple, Tuples[GenerateCyclicWords[3, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True], k]}]], 0]]
```

<!-- => {{True, True}} -->

## Options

### Rule

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

A product of three words:

```wl
e = ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}], pairing]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

The reversal rule:

```wl
ExteriorToSymmetric[e, pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

The position rule, given as an option:

```wl
ExteriorToSymmetric[e, pairing, "Rule" -> "Position"]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

It inverts the position rule of [SymmetricToExterior]():

```wl
SymmetricToExterior[ExteriorToSymmetric[e, pairing, "Rule" -> "Position"], pairing, "Position"] === e
```

<!-- => True -->

## Properties and Relations

The alphabet of the circle in the exterior picture:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1, in the exterior convention -->

A product of three words:

```wl
e = ExteriorProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}], exterior]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}]] -->

The exterior bracket of the product, sent to the symmetric picture:

```wl
ExteriorToSymmetric[CanonicalLieBracket[e, exterior], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] - 2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y}]] -->

It is the symmetric bracket of the image of the product, so the reversal rule intertwines the brackets of the two pictures:

```wl
CanonicalLieBracket[ExteriorToSymmetric[e, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y, y}]] - 2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y}]] -->

## Possible Issues

A symmetric product returns unevaluated, since the direction is set by the function alone:

```wl
ExteriorToSymmetric[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->

---

A rule other than `"Reversal"` and `"Position"` returns unevaluated:

```wl
ExteriorToSymmetric[CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Positional"]
```

<!-- => the input with the pairing in place, unevaluated -->
