---
Template: Symbol
Name: CyclicHochschildDifferential
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CyclicHochschildDifferential
Keywords: [differential, cyclic cochain complex, non-formal, nilmanifold, involutive bi-Lie algebra]
SeeAlso: [CanonicalLieBracket, CanonicalLieCobracket, TwistedDifferential, CanonicalBeilinsonDrinfeldOperator, NondegenerateQuotient, GradedPairing, CanonicalMaurerCartan]
RelatedGuides: [CanonicalLieBialgebra]
---

## Usage

<code>[CyclicHochschildDifferential]()[*w*, *pairing*]</code> gives the differential of the cyclic word *w*, induced letter by letter by the differential of the Poincare duality algebra that *pairing* carries.

<code>[CyclicHochschildDifferential]()[*p*, *pairing*]</code> gives the extension of the differential as a derivation, applied to a product *p* of cyclic words.

<!-- #| annotation: 26.09.30: Design review - the differential is read from the "Algebra" key that GradedPairing[algebra] attaches, and from nothing else, so the alphabet is data: a pairing built by hand from degrees and values carries no algebra and every word is closed, with no message; no alternative was recorded. The sign is the running sign of the letters after the replaced one. It is the prefix rule of the literature read through the reversal sign $(-1)^{\sum_{r<s}\eta_r\eta_s}$ that relates the cyclic words to the functionals of the literature; both give the same operation in different coordinates, and the sign is pinned by the Leibniz rule, as the statement that the differential kills the canonical Maurer-Cartan element. The function takes no "EmptyWord" option. Alternative name considered: CyclicDifferential, the name until 2026-09-30. Prior art: the Wolfram Language has no cyclic Hochschild complex; the verification suites pin the function on the two nilmanifold alphabets against their differential pairings, and check that it squares to zero, lowers the degree, anticommutes with the bracket and the co-bracket, and vanishes on an alphabet of the catalogue exactly when its quotient carries the differential 0. -->

## Details & Options

- The differential is the operation $\mathfrak{q}_{1,1,0}$ of the dIBL structure of a cyclic cochain complex. It takes one cyclic word to a sum of cyclic words of the same length.
- Each letter in turn is replaced by its image under the differential dual to the one of the algebra, with the sign $(-1)^{d}$, $d$ being the bar degree of the letters after it.
- It lowers the degree by one, and it preserves the length of a word and the number of factors of a product.
- The differential is read from the `"Algebra"` key of *pairing*, which <code>[GradedPairing]()[*algebra*]</code> attaches, for instance to `GradedPairing[NondegenerateQuotient[model]]`.
- A pairing built from degrees and pairing values carries no algebra, and the differential of every word is then $0$.
- The differential is also $0$ when the Poincare duality algebra carries the differential $0$, as the nondegenerate quotient of a formal model does. The alphabets of the non-formal models `"HeisenbergNilmanifold"` and `"KodairaThurston"` of the catalogue carry a nonzero differential.
- On a cyclic word the operation carries no degree-shift sign, so it is the same in both pictures.
- In the second form the differential is applied to each factor of *p* in turn, with the Koszul sign of the shuffle that brings it to the front. The convention of *pairing* selects the picture of the product.
- Both forms are linear: they distribute over sums and pull out scalars.
- A word may be given as the list of its letters.
- A product whose head disagrees with the convention of *pairing* returns unevaluated.
- The differential is the first summand of [CanonicalBeilinsonDrinfeldOperator]() and of [TwistedDifferential]().

## Basic Examples

The alphabet of the Heisenberg nilmanifold carries $dz = xy$, so dually the letter $xy$ goes to the letter $z$:

```wl
CyclicHochschildDifferential[CyclicWord[{x*y}], GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]]
```

<!-- => CyclicWord[{z}] -->

---

Over the alphabet of the circle, which is formal, the differential is $0$:

```wl
CyclicHochschildDifferential[CyclicWord[{x, y, y, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => 0 -->

---

The alphabet of the Heisenberg nilmanifold:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => a GradedPairing object with eight letters, carrying the Poincare duality algebra of the Heisenberg nilmanifold -->

On a product the derivation extension preserves the number of factors:

```wl
CyclicHochschildDifferential[SymmetricProduct[CyclicWord[{x*y}], CyclicWord[{y}], pairing], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{z}]] -->

## Scope

The alphabet of the Heisenberg nilmanifold:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => a GradedPairing object with eight letters, carrying the Poincare duality algebra of the Heisenberg nilmanifold -->

All the words of length at most $2$ on which the differential is nonzero:

```wl
DeleteCases[(# -> CyclicHochschildDifferential[#, pairing] &) /@ GenerateCyclicWords[2, pairing, "UpTo" -> True], _ -> 0]
```

<!-- => {CyclicWord[{x*y}] -> CyclicWord[{z}], CyclicWord[{1, x*y}] -> CyclicWord[{1, z}], CyclicWord[{x*y, z}] -> CyclicWord[{z, z}], CyclicWord[{y, x*y}] -> CyclicWord[{y, z}], CyclicWord[{x, x*y}] -> CyclicWord[{x, z}], CyclicWord[{x*y, y*z}] -> -CyclicWord[{z, y*z}], CyclicWord[{x*y, x*z}] -> -CyclicWord[{z, x*z}], CyclicWord[{x*y, x*y*z}] -> CyclicWord[{z, x*y*z}]} -->

Both factors of a product contribute, each with the sign of the shuffle that brings it to the front:

```wl
CyclicHochschildDifferential[SymmetricProduct[CyclicWord[{x*y}], CyclicWord[{x, x*y}], pairing], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{x*y}], CyclicWord[{x, z}]] + SymmetricProduct[CyclicWord[{z}], CyclicWord[{x, x*y}]] -->

A word may be given as the list of its letters:

```wl
CyclicHochschildDifferential[{x, x*y}, pairing]
```

<!-- => CyclicWord[{x, z}] -->

---

The alphabet of the Kodaira-Thurston manifold, the Heisenberg nilmanifold times a circle:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["KodairaThurston"]]]
```

<!-- => a GradedPairing object carrying the Poincare duality algebra of the Kodaira-Thurston manifold -->

Its quotient carries two differential entries, and the letter $xy$ goes to $z$:

```wl
CyclicHochschildDifferential[CyclicWord[{x*y}], pairing]
```

<!-- => CyclicWord[{z}] -->

The letter $txy$ goes to $tz$:

```wl
CyclicHochschildDifferential[CyclicWord[{t*x*y}], pairing]
```

<!-- => CyclicWord[{t*z}] -->

## Properties and Relations

The differential squares to zero on every word of length at most $3$ of the Heisenberg nilmanifold:

```wl
Union[(CyclicHochschildDifferential[CyclicHochschildDifferential[#, GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]], GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]] &) /@ GenerateCyclicWords[3, GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]], "UpTo" -> True]]
```

<!-- => {0} -->

---

The alphabet of the Heisenberg nilmanifold:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => a GradedPairing object with eight letters, carrying the Poincare duality algebra of the Heisenberg nilmanifold -->

The differential after the co-bracket:

```wl
CyclicHochschildDifferential[CanonicalLieCobracket[CyclicWord[{1, y, x*y*z, x*y}], pairing], pairing]
```

<!-- => SymmetricProduct[CyclicWord[{y}], CyclicWord[{z}]] -->

The co-bracket after the differential is its negative, so the two anticommute:

```wl
CanonicalLieCobracket[CyclicHochschildDifferential[CyclicWord[{1, y, x*y*z, x*y}], pairing], pairing]
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{z}]] -->

---

The alphabet of the Heisenberg nilmanifold:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => a GradedPairing object with eight letters, carrying the Poincare duality algebra of the Heisenberg nilmanifold -->

The differential kills the one-word part of the canonical Maurer-Cartan element, which is the Leibniz rule of the algebra read on the element that carries its triple product:

```wl
CyclicHochschildDifferential[CanonicalMaurerCartan[pairing][{1, 0}], pairing]
```

<!-- => 0 -->

The canonical element solves the Maurer-Cartan equation:

```wl
RelationsQ[CanonicalMaurerCartan[pairing]]
```

<!-- => True -->

---

The alphabet of the Heisenberg nilmanifold:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => a GradedPairing object with eight letters, carrying the Poincare duality algebra of the Heisenberg nilmanifold -->

[CanonicalBeilinsonDrinfeldOperator]() carries the differential as its first summand:

```wl
CanonicalBeilinsonDrinfeldOperator[CyclicWord[{x*y}], pairing]
```

<!-- => CyclicWord[{z}] -->

Its square $\Delta^2$ is $0$ on every word of length at most $3$:

```wl
Union[(CanonicalBeilinsonDrinfeldOperator[CanonicalBeilinsonDrinfeldOperator[#, pairing], pairing] &) /@ GenerateCyclicWords[3, pairing, "UpTo" -> True]]
```

<!-- => {0} -->

---

The canonical Maurer-Cartan element of the Heisenberg nilmanifold:

```wl
m = CanonicalMaurerCartan[GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]]
```

<!-- => a MaurerCartanElement object on the alphabet of the Heisenberg nilmanifold -->

[TwistedDifferential]() adds to the differential the bracket with the element:

```wl
TwistedDifferential[m, CyclicWord[{x*y}]]
```

<!-- => CyclicWord[{z}] -->

The twisted differential squares to zero:

```wl
TwistedDifferential[m, TwistedDifferential[m, CyclicWord[{x*y}]]]
```

<!-- => 0 -->

---

The alphabet of the Heisenberg nilmanifold:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => a GradedPairing object with eight letters, carrying the Poincare duality algebra of the Heisenberg nilmanifold -->

On a cyclic word the exterior picture gives the same differential:

```wl
CyclicHochschildDifferential[CyclicWord[{x*y}], Append[pairing, "Convention" -> "Exterior"]]
```

<!-- => CyclicWord[{z}] -->

## Possible Issues

The alphabet of the circle built from degrees and values:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

It carries no algebra:

```wl
KeyExistsQ[pairing, "Algebra"]
```

<!-- => False -->

So the differential is $0$ on every word, with no message:

```wl
CyclicHochschildDifferential[CyclicWord[{x, y}], pairing]
```

<!-- => 0 -->

---

The alphabet of the Heisenberg nilmanifold:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => a GradedPairing object with eight letters, carrying the Poincare duality algebra of the Heisenberg nilmanifold -->

A symmetric product under an exterior pairing returns unevaluated:

```wl
CyclicHochschildDifferential[SymmetricProduct[CyclicWord[{x*y}], CyclicWord[{y}], pairing], Append[pairing, "Convention" -> "Exterior"]]
```

<!-- => the input with the exterior pairing in place, unevaluated -->
