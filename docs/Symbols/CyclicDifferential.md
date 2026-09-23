---
Template: Symbol
Name: CyclicDifferential
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CyclicDifferential
Keywords: [differential, cyclic cochain complex, non-formal, nilmanifold, involutive bi-Lie algebra]
SeeAlso: [InvolutiveBracket, InvolutiveCobracket, TwistedDifferential, BeilinsonDrinfeldOperator, NondegenerateQuotient, GradedPairing, CanonicalMaurerCartan]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[CyclicDifferential]()[*w*, *pairing*]</code> gives the differential of a cyclic word *w*, induced letterwise by the differential of the Poincare duality algebra carried by *pairing*.

<code>[CyclicDifferential]()[*p*, *pairing*]</code> applies the extension of the differential as a derivation to a product *p*.

## Details & Options

The differential is the operation $q_{1,1,0}$ of the involutive bi-Lie structure of a cyclic *cochain complex*: it takes one cyclic word and returns one cyclic word of the same length, replacing each letter in turn by its image under the differential dual to the one on the algebra, with the running sign of the letters strictly after that slot.

It lowers the degree by one and preserves length, so it is the only operation of the structure that changes neither the number of letters nor the number of factors.

The suffix running sign is the reference's prefix rule read through the alphabet's own convention: the engine's cyclic words correspond to the functionals of the literature via the reversal sign $(-1)^{\sum_{r<s}\eta_r\eta_s}$ of the letter degrees, and conjugating by that sign turns a prefix into a suffix. Both give the same operation; only the coordinates differ.

The differential is read from the `"Algebra"` key of *pairing*, which [GradedPairing]() attaches when the alphabet is built as `GradedPairing[NondegenerateQuotient[model]]`. An alphabet built by hand from degrees and pairing values carries no algebra, and the differential of every word is then $0$.

It is also $0$ whenever the model is formal — that is, whenever the nondegenerate quotient is already the cohomology. Nine of the catalogue's eleven models are of that kind; `"HeisenbergNilmanifold"` and `"KodairaThurston"` are the two that are not.

Unlike [InvolutiveBracket]() and [InvolutiveCobracket](), the operation itself carries no degree-shift sign, so on a cyclic word it is the same in both pictures. The convention key of *pairing* is still read, because the derivation extension to a product needs the Koszul signs of the picture it lives in.

The differential is the first summand of [BeilinsonDrinfeldOperator](), so it enters [MaurerCartanEquation]() and [MaurerCartanQ](); and it is the first summand of [TwistedDifferential](), whose second summand is the bracket with the twisting element.

## Basic Examples

The Heisenberg nilmanifold is not formal: its minimal model is its own nondegenerate quotient, and that quotient carries $dz = xy$. Dually, the letter $xy$ of the alphabet goes to the letter $z$:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
CyclicDifferential[CyclicWord[{x*y}], pairing]
```

<!-- => CyclicWord[{z}] -->

---

Over the alphabet of the circle, which is formal, every differential is $0$:

```wl
CyclicDifferential[CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

On a product the result is the derivation extension $\hat q_{1,1,0}$, which preserves the number of factors:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
CyclicDifferential[SymmetricProduct[CyclicWord[{x*y}], CyclicWord[{y}], pairing], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{z}]] -->

## Scope

The alphabet of the Heisenberg nilmanifold has eight letters, of which one carries a differential; these are all the words of length at most two on which it is nonzero:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
DeleteCases[Map[# -> CyclicDifferential[#, pairing] &, CyclicWords[2, pairing, "UpTo" -> True]], _ -> 0]
```

<!-- => {CyclicWord[{x*y}] -> CyclicWord[{z}], CyclicWord[{1, x*y}] -> CyclicWord[{1, z}], CyclicWord[{x*y, z}] -> CyclicWord[{z, z}], CyclicWord[{x*y, y}] -> CyclicWord[{y, z}], CyclicWord[{x, x*y}] -> CyclicWord[{x, z}], CyclicWord[{x*y, y*z}] -> -CyclicWord[{y*z, z}], CyclicWord[{x*y, x*z}] -> -CyclicWord[{x*z, z}], CyclicWord[{x*y, x*y*z}] -> CyclicWord[{x*y*z, z}]} -->

---

Both factors of a product contribute, each with the sign of the shuffle that brings it to the front:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
CyclicDifferential[SymmetricProduct[CyclicWord[{x*y}], CyclicWord[{x, x*y}], pairing], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{x*y}], CyclicWord[{x, z}]] + SymmetricProduct[CyclicWord[{z}], CyclicWord[{x, x*y}]] -->

---

Kodaira-Thurston is the Heisenberg nilmanifold crossed with a circle, and its quotient carries two differential entries rather than one — which is why it, and not the nilmanifold alone, is what fixes the sign of the operation:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["KodairaThurston"]]];
{CyclicDifferential[CyclicWord[{x*y}], pairing], CyclicDifferential[CyclicWord[{t*x*y}], pairing]}
```

<!-- => {CyclicWord[{z}], CyclicWord[{t*z}]} -->

## Properties and Relations

The differential squares to zero:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
Union[Map[CyclicDifferential[CyclicDifferential[#, pairing], pairing] &, CyclicWords[3, pairing, "UpTo" -> True]]]
```

<!-- => {0} -->

---

It anticommutes with [InvolutiveCobracket]() — the compatibility that makes the triple a dIBL structure:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
w = CyclicWord[{1, y, x*y*z, x*y}];
{CyclicDifferential[InvolutiveCobracket[w, pairing], pairing], InvolutiveCobracket[CyclicDifferential[w, pairing], pairing]}
```

<!-- => {SymmetricProduct[CyclicWord[{y}], CyclicWord[{z}]], -SymmetricProduct[CyclicWord[{y}], CyclicWord[{z}]]} -->

---

It kills the canonical Maurer-Cartan element. That is the Leibniz rule of the algebra, read on the element that carries its triple product, and it is a theorem rather than a convention — which is what lets it pin the sign of the operation:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
{CyclicDifferential[CanonicalMaurerCartan[pairing], pairing], MaurerCartanQ[CanonicalMaurerCartan[pairing], pairing]}
```

<!-- => {0, True} -->

---

[BeilinsonDrinfeldOperator]() carries it as its first summand, and $\Delta^2 = 0$ collects every identity the three operations satisfy together:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
{BeilinsonDrinfeldOperator[CyclicWord[{x*y}], pairing],
 Union[Map[BeilinsonDrinfeldOperator[BeilinsonDrinfeldOperator[#, pairing], pairing] &, CyclicWords[3, pairing, "UpTo" -> True]]]}
```

<!-- => {CyclicWord[{z}], {0}} -->

---

So does [TwistedDifferential](): twisting by the canonical element adds the bracket with it, the sum squares to zero, and its homology is Connes' cyclic cohomology:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
m = CanonicalMaurerCartan[pairing];
{TwistedDifferential[m, CyclicWord[{x*y}], pairing],
 TwistedDifferential[m, TwistedDifferential[m, CyclicWord[{x*y}], pairing], pairing]}
```

<!-- => {CyclicWord[{z}], 0} -->

---

On a cyclic word the two pictures agree, the operation having no degree-shift sign of its own:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]];
exterior = Append[pairing, "Convention" -> "Exterior"];
{CyclicDifferential[CyclicWord[{x*y}], pairing], CyclicDifferential[CyclicWord[{x*y}], exterior]}
```

<!-- => {CyclicWord[{z}], CyclicWord[{z}]} -->

## Possible Issues

**An alphabet with no algebra has no differential, and gives $0$ rather than an error.** The operation reads the `"Algebra"` key, which only `GradedPairing[NondegenerateQuotient[model]]` attaches; a pairing built by hand from degrees and values carries none, and every word is then closed. Check for the key before reading a zero as a computation.

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{KeyExistsQ[pairing, "Algebra"], CyclicDifferential[CyclicWord[{x, y}], pairing]}
```

<!-- => {False, 0} -->
