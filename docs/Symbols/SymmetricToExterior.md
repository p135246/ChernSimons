---
Template: Symbol
Name: SymmetricToExterior
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/SymmetricToExterior
Keywords: [shift isomorphism, decalage, reversal rule, position rule, sign convention]
SeeAlso: [ExteriorToSymmetric, SymmetricProduct, ExteriorProduct, StringBracket, StringCobracket, ElementDegree, KoszulSign]
RelatedGuides: [StringAlgebras]
---

## Usage

<code>[SymmetricToExterior]()[*e*, *pairing*]</code> gives the exterior product that corresponds to the symmetric product *e*, with the sign of the reversal rule.

<code>[SymmetricToExterior]()[*e*, *pairing*, *rule*]</code> gives it with the sign of *rule*, `"Reversal"` or `"Position"`.

<!-- #| annotation: 26.09.30: Design review - SymmetricToExterior and ExteriorToSymmetric replace ShiftIsomorphism and its "Inverse" option (Pavel, 2026-09-30), so that each name says which way it converts. The direction is set by the function, never by the "Convention" key of the pairing, so both take any pairing, and a product of the other head returns unevaluated. The sign rule is the option "Rule", and the positional third argument of ShiftIsomorphism stays as a shortcut for it. The reversal rule is the default because it is the rule that intertwines StringBracket and StringCobracket in every arity; the position rule is kept so that the difference between the two can be examined rather than assumed. The rules are "Reversal" and "Position", in the third argument and in the option; since R7 (Pavel, 2026-10-01) any other value returns unevaluated, where before every string but "Position" gave the reversal sign. A cyclic word is a product of one factor, the rule every product of the paclet follows. Alternative name considered: ShiftIsomorphism. Prior art: the Wolfram Language has Wedge and TensorWedge but no graded symmetric algebra of cyclic words and no decalage isomorphism; the engine the verification suites load pins both rules on every tuple of words to length 3. -->

## Details & Options

- The symmetric and the exterior products are graded by $[-]_1$ and $[-]$, one apart, and the decalage isomorphism between them carries a sign.
- The map sends $f_1 \odot \cdots \odot f_k$ to $\pm f_1 \wedge \cdots \wedge f_k$, with the sign $(-1)^{\sum_i (k - i) [f_i]}$ of the reversal rule or $(-1)^{\sum_i i [f_i]}$ of the position rule, $[f]$ being the exterior degree of $f$.
- The reversal rule intertwines [StringBracket]() and [StringCobracket]() in every arity; the position rule does not.
- The two rules differ by the sign $(-1)^{k \sum_i [f_i]}$. They agree on every product of an even number of factors, and on an odd number of factors they differ exactly when the total exterior degree is odd.
- The map is linear, and `HBar` is a scalar to it.
- A cyclic word is taken as a product of one factor, and a word may be given as the list of its particles.
- The direction is set by the function alone, not by the `"Convention"` key of *pairing*. An [ExteriorProduct]() returns unevaluated.
- [ExteriorToSymmetric]() is the inverse map, with either rule.
- [SymmetricToExterior]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"Rule"</code> | <code>"Reversal"</code> | the sign rule, <code>"Reversal"</code> or <code>"Position"</code> |

- The third argument *rule* is the same as the option `"Rule" -> rule`.
- A *rule* other than `"Reversal"` and `"Position"`, in the third argument or in the option, returns unevaluated.

## Basic Examples

A two-factor symmetric product in the exterior picture:

```wl
SymmetricToExterior[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

On three factors the shift costs a sign:

```wl
SymmetricToExterior[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

---

The position rule, given as the third argument, gives the other sign here:

```wl
SymmetricToExterior[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Position"]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

A product of three words:

```wl
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

[ExteriorToSymmetric]() gives back the original:

```wl
ExteriorToSymmetric[SymmetricToExterior[e, pairing], pairing] === e
```

<!-- => True -->

## Scope

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

A cyclic word is a product of one factor:

```wl
SymmetricToExterior[CyclicWord[{y}], pairing]
```

<!-- => CyclicWord[{y}] -->

A word may be given as the list of its particles:

```wl
SymmetricToExterior[{y}, pairing]
```

<!-- => CyclicWord[{y}] -->

The map is linear, and a sum of products with scalar coefficients, `HBar` among them, is sent term by term:

```wl
SymmetricToExterior[CyclicWord[{x, x, y}] + kappa SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], pairing] + HBar SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing], pairing]
```

<!-- => CyclicWord[{x, x, y}] + HBar ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] - kappa ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

---

Over every product of at most four words of length at most $3$, the two rules agree on the even numbers of factors and disagree on some products of the odd ones:

```wl
Table[k -> Tally[Table[SameQ[SymmetricToExterior[SymmetricProduct @@ Append[tuple, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], SymmetricToExterior[SymmetricProduct @@ Append[tuple, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Position"]], {tuple, Tuples[GenerateCyclicWords[3, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "UpTo" -> True], k]}]], {k, 4}]
```

<!-- => {1 -> {{True, 4}, {False, 4}}, 2 -> {{True, 64}}, 3 -> {{True, 304}, {False, 208}}, 4 -> {{True, 4096}}} -->

## Options

### Rule

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

A single factor of even symmetric degree:

```wl
ElementDegree[{y}, pairing, "Symmetric"]
```

<!-- => -2 -->

The reversal rule keeps its sign:

```wl
SymmetricToExterior[CyclicWord[{y}], pairing]
```

<!-- => CyclicWord[{y}] -->

The position rule changes it:

```wl
SymmetricToExterior[CyclicWord[{y}], pairing, "Rule" -> "Position"]
```

<!-- => -CyclicWord[{y}] -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

A product of two words:

```wl
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

On two factors the two rules agree:

```wl
SymmetricToExterior[e, pairing] === SymmetricToExterior[e, pairing, "Rule" -> "Position"]
```

<!-- => True -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

A product of three words:

```wl
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

The reversal rule:

```wl
SymmetricToExterior[e, pairing]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

The position rule, given as an option:

```wl
SymmetricToExterior[e, pairing, "Rule" -> "Position"]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

The option and the third argument are the same:

```wl
SymmetricToExterior[e, pairing, "Rule" -> "Position"] === SymmetricToExterior[e, pairing, "Position"]
```

<!-- => True -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The symmetric co-bracket of $xyyy$ in the exterior picture:

```wl
SymmetricToExterior[StringCobracket[CyclicWord[{x, y, y, y}], pairing], pairing]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

It is the exterior co-bracket, so the reversal rule intertwines the co-brackets of the two pictures:

```wl
StringCobracket[CyclicWord[{x, y, y, y}], Append[pairing, "Convention" -> "Exterior"]]
```

<!-- => ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Possible Issues

An exterior product returns unevaluated, since the direction is set by the function alone:

```wl
SymmetricToExterior[ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the input, unevaluated -->

---

A rule other than `"Reversal"` and `"Position"` returns unevaluated:

```wl
SymmetricToExterior[CyclicWord[{y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Positional"]
```

<!-- => the input with the pairing in place, unevaluated -->
