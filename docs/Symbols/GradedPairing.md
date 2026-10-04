---
Template: Symbol
Name: GradedPairing
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/GradedPairing
Keywords: [pairing, graded alphabet, cyclic words, involutive bi-Lie algebra]
SeeAlso: [CyclicWord, GenerateCyclicWords, ElementDegree, DualPairing, NondegenerateQuotient, CanonicalMaurerCartan]
RelatedGuides: [CanonicalLieBialgebra, BeilinsonDrinfeldFormalism]
---

## Usage

<code>[GradedPairing]()[*degrees*, *spec*]</code> gives the pairing object of the graded alphabet with the degrees *degrees* and the pairing values *spec*.

<code>[GradedPairing]()[*degrees*, *spec*, *dual*, *evaluation*]</code> gives the pairing object that also carries the dual alphabet *dual* and the values *evaluation* of letters on dual letters.

<code>[GradedPairing]()[*algebra*]</code> gives the pairing object of the Poincaré duality algebra *algebra*, with its basis monomials as letters.

<code>[GradedPairing]()[*algebra*, *letters*]</code> gives the pairing object of *algebra*, with the list *letters* naming its basis.

<!-- #| annotation: 26.09.30: Design review - the graded alphabet is one object passed as the last argument of every operation, rather than degrees held in global variables as in the engine, so that two alphabets can be used side by side and every function computes from its arguments alone. The object is a tagged head around one Association, GradedPairing[assoc], since T0b; before it was a plain Association. The tag lets it be recognized by GradedPairingQ, dispatched on and shown as a summary box, and the upvalues Append, Normal, Keys, KeyExistsQ, Lookup, KeyDrop and KeyTake keep it usable like the Association it wraps. The convention is a key of the object and not an argument of each operation, so Append[pairing, "Convention" -> "Exterior"] switches every later operation at once; the engine instead passes the convention as an explicit argument (q210Odot, q210Wedge). An alphabet whose nonzero values have more than one degree is an attempt that failed, so it gives a Failure, while an algebra object with malformed parts returns unevaluated. GradedPairing[algebra] moved to ChernSimons beside the other forms in R5c, so that the part reads the PoincareDualityAlgebra of AlgebraicModels and no dependency runs the other way. Prior art: the Wolfram Language has no object for a graded alphabet with a pairing; the engine the verification suites load keeps the degrees of the circle in globals, and T12/paclet-pairing-object pins the degree, the completed values and the default convention of this object on the circle. -->

## Details & Options

- *degrees* is an association from letters to integer degrees. A letter is an arbitrary expression, usually a symbol; multi-character names are allowed.
- *spec* is either a function of two letters, or an association giving some of the values. In the association form the other values are completed by graded antisymmetry, $\langle q, p\rangle = -(-1)^{|p||q|}\langle p, q\rangle$, and every pair left out is $0$.
- The result is a tagged object <code>[GradedPairing]()[*assoc*]</code> around one association. <code>*pairing*["*key*"]</code> gives the value of a key, and <code>[Normal]()</code> gives the association.
- <code>[Append]()</code>, <code>[Keys]()</code>, <code>[KeyExistsQ]()</code>, <code>[Lookup]()</code>, <code>[KeyDrop]()</code> and <code>[KeyTake]()</code> act on the object as on its association, and <code>[Append]()</code>, <code>[KeyDrop]()</code> and <code>[KeyTake]()</code> give a pairing object again.
- The object has the following keys:

| Key | Value |
|---|---|
| `"Degrees"` | the *degrees* association, verbatim |
| `"Values"` | the completed pairing, an association from ordered pairs of letters to their value |
| `"Degree"` | the common degree $\lvert p\rvert+\lvert q\rvert$ over all pairs with $\langle p,q\rangle\neq 0$ |
| `"Convention"` | `"Symmetric"` by default, `"Exterior"` for the exterior picture |
| `"Dual"` | an association with its own `"Degrees"` and `"Values"`, present only in the four-argument form |
| `"Algebra"` | the Poincaré duality algebra, as an association, present only in the forms built from one |

- The nonzero values must all have one degree $\lvert p\rvert+\lvert q\rvert$. Otherwise the result is a <code>[Failure]()</code> whose message says that the pairing has no well-defined degree, and whose `"Degrees"` lists the degrees found.
- The convention selects the picture every later operation works in: `"Symmetric"` uses the [SymmetricProduct]() grading $[-]_1 = [-]-1$, `"Exterior"` the [ExteriorProduct]() grading $[-]$. <code>[Append]()[*pairing*, "Convention" -> "Exterior"]</code> switches it.
- In the four-argument form *dual* is an association from dual letters to their degrees, and *evaluation* gives $\langle p, \alpha\rangle$ for a letter $p$ and a dual letter $\alpha$. It is read by [DualPairing](), which issues a message and returns unevaluated on a pairing object without it. [ElementDegree]() reads the degrees of the dual letters as well.
- In the forms built from an algebra the letters are a basis of $H[1]$: the letter of the basis vector $e_i$ has degree $\lvert e_i\rvert - 1$, and the values are $\langle se_i, se_j\rangle = (-1)^{\lvert e_i\rvert}\mathcal{O}(e_ie_j)$. This sign turns the graded symmetric pairing of degree $n$ into a graded antisymmetric one of degree $n-2$.
- The `"Algebra"` key is where [CanonicalMaurerCartan]() reads the triple product from.
- An algebra object without a list of basis monomials, integer degrees and a Gram matrix of the matching size returns unevaluated.
- The object displays as a summary box: the alphabet, the degree of the pairing and the convention, with the degrees, the matrix of values, the dual alphabet and the algebra under the opener.

## Basic Examples

The alphabet of the circle, a letter *x* of degree $-1$, a letter *y* of degree $0$ and the pairing value $\langle x, y\rangle = 1$:

```wl
GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

---

The association inside the object:

```wl
Normal[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => <|"Degrees" -> <|x -> -1, y -> 0|>, "Values" -> <|{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0|>, "Degree" -> -1, "Convention" -> "Symmetric"|> -->

---

Graded antisymmetry has supplied the value that was not given:

```wl
GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]["Values"]
```

<!-- => <|{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0|> -->

---

The degree of the pairing is read off the nonzero values:

```wl
GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]["Degree"]
```

<!-- => -1 -->

## Scope

*spec* may be a function of two letters instead of an association:

```wl
GradedPairing[<|x -> -1, y -> 0|>, {p, q} |-> Boole[p =!= q] Signature[{p, q}]]["Values"]
```

<!-- => <|{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0|> -->

---

Letters are arbitrary expressions, so an alphabet of multi-character names works the same way:

```wl
GradedPairing[<|alpha -> -1, beta -> 0, gamma -> -1|>, <|{alpha, beta} -> 1, {gamma, beta} -> 1|>]["Degree"]
```

<!-- => -1 -->

---

The four-argument form attaches a dual alphabet:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1, with the dual alphabet a and b -->

It is carried under the key `"Dual"`:

```wl
pairing["Dual"]
```

<!-- => <|"Degrees" -> <|a -> -1, b -> 0|>, "Values" -> <|{x, a} -> 1, {y, b} -> 1|>|> -->

---

The pairing object of the minimal model of the circle, with the basis monomials as letters:

```wl
GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]]]["Degrees"]
```

<!-- => <|1 -> -1, v -> 0|> -->

---

The same algebra with the letters named *x* and *y*:

```wl
GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}]["Degrees"]
```

<!-- => <|x -> -1, y -> 0|> -->

## Properties and Relations

The alphabet of the circle is what the construction produces from the minimal model of $S^1$, up to the `"Algebra"` key:

```wl
KeyDrop[GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}], "Algebra"] === GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => True -->

---

The Poincaré duality algebra of $\mathbb{CP}^2$, of degree $4$:

```wl
algebra = NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a PoincareDualityAlgebra object of degree 4 -->

Its degree:

```wl
algebra["Degree"]
```

<!-- => 4 -->

The pairing degree of its alphabet is $n-2$:

```wl
GradedPairing[algebra]["Degree"]
```

<!-- => 2 -->

---

The convention is a key like any other, so the exterior picture is one <code>[Append]()</code> away:

```wl
Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]["Convention"]
```

<!-- => "Exterior" -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with letters x and y, of pairing degree -1 -->

[ElementDegree]() reads the degrees out of the pairing object, in each of the three gradings:

```wl
ElementDegree[{x, y}, pairing, #] & /@ {"Bar", "Exterior", "Symmetric"}
```

<!-- => {-1, -2, -3} -->

---

The object is recognized by [GradedPairingQ]():

```wl
GradedPairingQ[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => True -->

## Possible Issues

When the nonzero values have two degrees the result is a <code>[Failure]()</code>, whose message says so:

```wl
GradedPairing[<|x -> -1, y -> 0, z -> 0|>, <|{x, y} -> 1, {y, z} -> 1|>]["Message"]
```

<!-- => "The pairing has no well-defined degree." -->

The degrees it found:

```wl
GradedPairing[<|x -> -1, y -> 0, z -> 0|>, <|{x, y} -> 1, {y, z} -> 1|>]["Degrees"]
```

<!-- => {-1, 0} -->

---

[DualPairing]() needs the dual alphabet, so on a pairing object built with two arguments it issues a message:

```wl
DualPairing[CyclicWord[{x}], CyclicWord[{x}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => the message GradedPairing::dual is issued and the expression returns unevaluated -->
