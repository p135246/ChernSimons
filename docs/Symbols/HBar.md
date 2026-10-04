---
Template: Symbol
Name: HBar
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/HBar
Keywords: [HBar, Planck constant, formal variable, BD algebra, genus]
SeeAlso: [CanonicalBeilinsonDrinfeldOperator, CanonicalBeilinsonDrinfeldBracket, MaurerCartanElement, Obstruction, ElementDegree]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[HBar]()</code> is the formal variable $\hbar$ of the Beilinson-Drinfeld algebra.

<!-- #| annotation: 26.09.30: Design review - HBar is an ordinary symbol with no value, by design the one export of the paclet that carries none; it was the engine's hbar until T0b. Every operation treats it as a scalar through the scalar tests of its linearity rules, and it has even degree, so it never enters a Koszul sign. Its degree is given by ElementDegree in the symmetric grading only, 2(n - 3), the degree that makes the operator homogeneous of degree -1; in the other two gradings it returns unevaluated, a decision of R5f kept by Pavel. The verification suites load their engine after the paclet, so the engine's HBar is this symbol. Prior art: in the Wolfram Language the character \[HBar] is a letter that makes an ordinary symbol of the current context, with no built-in meaning. -->

## Details & Options

- [HBar]() is a symbol with no value.
- Every operation treats it as a scalar.
- Its symmetric degree is <code>[ElementDegree]()[HBar, *pairing*, "Symmetric"]</code>, which is $2(n-3)$. It has no bar or exterior degree.
- It is the weight of the bracket term in [CanonicalBeilinsonDrinfeldOperator](), $\Delta = \widehat{q}_{1,1,0} + \widehat{q}_{1,2,0} + \hbar\,\widehat{q}_{2,1,0}$.
- In a BD action it is the weight $\hbar^g$ of the genus-$g$ component.
- The BD formalism never inverts it. Negative powers appear only in the localized BV picture, where the BV action is $\hbar^{-1}$ times the BD one.
- It displays as $\hbar$.

## Basic Examples

The formal variable:

```wl
HBar
```

<!-- => HBar -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

It appears in the operator of the Beilinson-Drinfeld algebra:

```wl
CanonicalBeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], pairing]
```

<!-- => 2*HBar*CyclicWord[{x, y, y, y}] - SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

Setting it to zero gives the classical limit:

```wl
CanonicalBeilinsonDrinfeldOperator[SymmetricProduct[CyclicWord[{x, y, y, y}], CyclicWord[{x, y}], pairing], pairing] /. HBar -> 0
```

<!-- => -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}], CyclicWord[{x, y}]] -->

## Scope

Its degree on the circle is $2(1-3)$:

```wl
ElementDegree[HBar, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Symmetric"]
```

<!-- => -4 -->

---

A power $\hbar^g$ has $g$ times that degree:

```wl
ElementDegree[HBar^2, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Symmetric"]
```

<!-- => -8 -->

## Properties and Relations

Every operation treats it as a scalar:

```wl
CanonicalLieBracket[HBar CyclicWord[{x}], CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => -(HBar*CyclicWord[{x}]) -->

---

It is a symbol with no value:

```wl
OwnValues[HBar]
```

<!-- => {} -->

## Possible Issues

It has no bar degree, so the degree returns unevaluated:

```wl
ElementDegree[HBar, GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Bar"]
```

<!-- => the input with the pairing object in place, unevaluated -->
