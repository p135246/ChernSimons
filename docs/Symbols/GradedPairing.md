---
Template: Symbol
Name: GradedPairing
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/GradedPairing
Keywords: [pairing, graded alphabet, cyclic words, involutive bi-Lie algebra]
SeeAlso: [CyclicWord, CyclicWords, WordDegree, DualPairing, ProductPairing, NondegenerateQuotient, CanonicalMaurerCartan]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[GradedPairing]()[*degrees*, *spec*]</code> builds the pairing object of a graded alphabet, from an association *degrees* of particles to their degrees and a specification *spec* of the pairing values.

<code>[GradedPairing]()[*degrees*, *spec*, *dualDegrees*, *evaluation*]</code> attaches a dual alphabet, so that the resulting object also carries the evaluation of words on dual words.

<code>[GradedPairing]()[*algebra*]</code> builds the pairing object of a Poincaré duality algebra, as [NondegenerateQuotient]() returns one, taking its basis monomials as the particles.

<code>[GradedPairing]()[*algebra*, *particles*]</code> names the particles instead.

## Details & Options

The pairing object is the single piece of data every other operation in the paclet takes as its last argument. It is a plain <code>[Association]()</code>, not an opaque object, so it can be inspected, edited and stored like any other expression.

*degrees* is an association from particles to integer degrees. A particle is an arbitrary expression, usually a symbol; multi-character names are fine.

*spec* is either a function of two particles, or an association giving some of the values. In the association form the remaining values are completed by graded antisymmetry, $\langle q, p\rangle = -(-1)^{|p||q|}\langle p, q\rangle$, and every pair left unmentioned is $0$.

The result has the keys `"Degrees"`, `"Values"`, `"Degree"` and `"Convention"`, plus `"Dual"` in the four-argument form.

| key | value |
|---|---|
| `"Degrees"` | the *degrees* association, verbatim |
| `"Values"` | the completed pairing, an association from ordered pairs of particles to their value |
| `"Degree"` | the common degree $\lvert p\rvert+\lvert q\rvert$ over all pairs with $\langle p,q\rangle\neq 0$ |
| `"Convention"` | `"Symmetric"` by default, `"Exterior"` to work in the exterior picture |
| `"Dual"` | an association with its own `"Degrees"` and `"Values"`, present only in the four-argument form |
| `"Algebra"` | the Poincaré duality algebra, present only in the forms built from one |

In the forms built from an algebra the particles are a basis of $H[1]$: a particle for the basis vector $e_i$ has degree $\lvert e_i\rvert - 1$, and the values are $\langle se_i, se_j\rangle = (-1)^{\lvert e_i\rvert}\mathcal{O}(e_ie_j)$ — the sign that turns the graded symmetric pairing of degree $n$ into a graded antisymmetric one of degree $n-2$, which is the pairing degree the operations want. The `"Algebra"` key is what [CanonicalMaurerCartan]() reads the triple product from.

The convention is what selects the picture every later operation works in: `"Symmetric"` uses the [SymmetricProduct]() grading $[-]_1 = [-]-1$, `"Exterior"` the [ExteriorProduct]() grading $[-]$. Change it by resetting the key — <code>[Append]()[*pairing*, "Convention" -> "Exterior"]</code>.

The pairing must be homogeneous: if the nonzero values do not all have one degree $\lvert p\rvert+\lvert q\rvert$, [GradedPairing]() issues `GradedPairing::degree` and aborts.

*evaluation* in the four-argument form gives $\langle p, \alpha\rangle$ for a particle *p* and a dual particle $\alpha$; it is read by [DualPairing]() and [ProductPairing](), which abort without it.

The object displays as a summary box: the alphabet, the degree of the pairing and the convention, with the degrees, the matrix of values, the dual alphabet and the algebra under the opener. That is a display only — <code>[Normal]()</code> gives the association back, and the copied box is the object itself.

## Basic Examples

The alphabet of the circle: a degree $-1$ particle *x*, a degree $0$ particle *y*, and the single pairing value $\langle x, y\rangle = 1$.

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Normal[pairing]
```

<!-- => {"Degrees" -> <|x -> -1, y -> 0|>, "Values" -> <|{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0|>, "Degree" -> -1, "Convention" -> "Symmetric"} -->

---

Graded antisymmetry has supplied the value that was not given:

```wl
Normal[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]["Values"]]
```

<!-- => {{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0} -->

---

The degree of the pairing is read off the nonzero values:

```wl
GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]["Degree"]
```

<!-- => -1 -->

## Scope

*spec* may be a function of two particles instead of an association:

```wl
Normal[GradedPairing[<|x -> -1, y -> 0|>, Boole[#1 =!= #2] Signature[{#1, #2}] &]["Values"]]
```

<!-- => {{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0} -->

---

Particles are arbitrary expressions, so an alphabet of multi-character names works the same way:

```wl
GradedPairing[<|alpha -> -1, beta -> 0, gamma -> -1|>, <|{alpha, beta} -> 1, {gamma, beta} -> 1|>]["Degree"]
```

<!-- => -1 -->

---

The four-argument form attaches a dual alphabet:

```wl
Keys[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]]
```

<!-- => {"Degrees", "Values", "Degree", "Convention", "Dual"} -->

## Properties and Relations

The alphabet of the circle is what the construction produces from the minimal model of $S^1$, on the nose:

```wl
KeyDrop[GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}], "Algebra"] ===
  GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => True -->

---

The pairing degree of an algebra of degree $n$ is $n-2$:

```wl
algebra = NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]];
{GradedPairing[algebra]["Degree"], algebra["Degree"] - 2}
```

<!-- => {2, 2} -->

---

The convention is a key like any other, so the exterior picture is one <code>[Append]()</code> away:

```wl
Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]["Convention"]
```

<!-- => "Exterior" -->

---

[WordDegree]() reads the degrees out of the pairing object, in either grading:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{WordDegree[{x, y}, pairing], WordDegree[{x, y}, pairing, "Exterior"], WordDegree[{x, y}, pairing, "Symmetric"]}
```

<!-- => {-1, -2, -3} -->

## Possible Issues

Operations that need the dual alphabet abort when the pairing object was built with the two-argument form. Build it with four arguments to use [DualPairing]() and [ProductPairing]().

```wl
Keys[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {"Degrees", "Values", "Degree", "Convention"} -->
