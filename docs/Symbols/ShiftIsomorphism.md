---
Template: Symbol
Name: ShiftIsomorphism
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/ShiftIsomorphism
Keywords: [shift isomorphism, decalage, reversal rule, position rule, sign convention]
SeeAlso: [SymmetricProduct, ExteriorProduct, InvolutiveBracket, InvolutiveCobracket, WordDegree, KoszulSign]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[ShiftIsomorphism]()[*e*, *pairing*]</code> sends a symmetric product *e* to an exterior one by the reversal rule.

<code>[ShiftIsomorphism]()[*e*, *pairing*, "Position"]</code> uses the position rule instead.

## Details & Options

The symmetric and exterior products are graded by $[-]_1$ and $[-]$, one apart, so a product of $k$ factors picks up a sign under the shift that depends on the degrees and on $k$. The map that implements this is the décalage isomorphism, and there is more than one sign convention for it.

| option | default | effect |
|---|---|---|
| <code>"Rule"</code> | <code>"Reversal"</code> | which sign convention to use, <code>"Reversal"</code> or <code>"Position"</code> |
| <code>"Inverse"</code> | <code>False</code> | whether to send an exterior product back to a symmetric one |

The rule may also be given positionally as a third argument, which is the same as setting the `"Rule"` option.

**The reversal rule is the one that matters.** It is the convention that intertwines [InvolutiveBracket]() and [InvolutiveCobracket]() in every arity; the position rule does not, and is provided so that the difference between the two can be examined rather than assumed.

The two rules differ by a sign that depends on the degrees of the factors and on how many there are. Over the alphabet of the circle they coincide on every product of an even number of factors, and differ on some products of every odd number — including on a single factor, where they disagree exactly when its symmetric degree is even.

With `"Inverse" -> True` the map runs the other way, from [ExteriorProduct]() to [SymmetricProduct]().

## Basic Examples

Sending a two-factor symmetric product to the exterior picture:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ShiftIsomorphism[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing], pairing]
```

<!-- => ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] -->

---

On three factors the shift costs a sign:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ShiftIsomorphism[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}], pairing], pairing]
```

<!-- => -ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->

---

Running it backwards returns the original:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}], pairing];
ShiftIsomorphism[ShiftIsomorphism[e, pairing], pairing, "Inverse" -> True] === e
```

<!-- => True -->

## Options

The two rules agree on this two-factor product:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing];
ShiftIsomorphism[e, pairing] === ShiftIsomorphism[e, pairing, "Position"]
```

<!-- => True -->

---

On a single factor of even symmetric degree they already differ by a sign:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
e = CyclicWord[{y}];
{WordDegree[{y}, pairing, "Symmetric"], ShiftIsomorphism[e, pairing], ShiftIsomorphism[e, pairing, "Position"]}
```

<!-- => {-2, CyclicWord[{y}], -CyclicWord[{y}]} -->

---

On three factors they differ by a sign here too:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}], pairing];
{ShiftIsomorphism[e, pairing], ShiftIsomorphism[e, pairing, "Position"]}
```

<!-- => {-ExteriorProduct[…], ExteriorProduct[…]} -->

---

The rule may be given as an option rather than positionally:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
e = SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}], pairing];
ShiftIsomorphism[e, pairing, "Rule" -> "Position"] === ShiftIsomorphism[e, pairing, "Position"]
```

<!-- => True -->

## Scope

Over every product of at most four words of length at most $3$, the two rules agree on all the even numbers of factors and disagree on some of the odd ones:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
words = CyclicWords[3, pairing, "UpTo" -> True];
Table[k -> Tally[Table[
     SameQ[ShiftIsomorphism[SymmetricProduct @@ Append[tuple, pairing], pairing],
       ShiftIsomorphism[SymmetricProduct @@ Append[tuple, pairing], pairing, "Position"]],
     {tuple, Tuples[words, k]}]], {k, 4}]
```

<!-- => {1 -> {{True, 4}, {False, 4}}, 2 -> {{True, 64}}, 3 -> {{True, 304}, {False, 208}}, 4 -> {{True, 4096}}} -->

## Properties and Relations

The reversal rule intertwines the co-bracket of the two pictures:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
exterior = Append[pairing, "Convention" -> "Exterior"];
{ShiftIsomorphism[InvolutiveCobracket[CyclicWord[{x, y, y, y}], pairing], pairing], InvolutiveCobracket[CyclicWord[{x, y, y, y}], exterior]}
```

<!-- => {ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]], ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]]} -->

## Possible Issues

The direction is set by the `"Inverse"` option alone, never by the `"Convention"` key of the pairing object. The inverse of an [ExteriorProduct]() is taken against the same pairing object as the forward map.

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
exterior = Append[pairing, "Convention" -> "Exterior"];
ShiftIsomorphism[ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}], exterior], pairing, "Inverse" -> True]
```

<!-- => -SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{y, y}]] -->
