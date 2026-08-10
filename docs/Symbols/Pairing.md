---
Template: Symbol
Name: Pairing
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/Pairing
Keywords: [pairing, graded alphabet, cyclic words, involutive bi-Lie algebra]
SeeAlso: [CyclicWord, CyclicWords, WordDegree, DualPairing, ProductPairing]
---

## Usage

<code>[Pairing]()[*degrees*, *spec*]</code> builds the pairing object of a graded alphabet, from an association *degrees* of particles to their degrees and a specification *spec* of the pairing values.

<code>[Pairing]()[*degrees*, *spec*, *dualDegrees*, *evaluation*]</code> attaches a dual alphabet, so that the resulting object also carries the evaluation of words on dual words.

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

The convention is what selects the picture every later operation works in: `"Symmetric"` uses the [SymmetricProduct]() grading $[-]_1 = [-]-1$, `"Exterior"` the [ExteriorProduct]() grading $[-]$. Change it by resetting the key — <code>[Append]()[*pairing*, "Convention" -> "Exterior"]</code>.

The pairing must be homogeneous: if the nonzero values do not all have one degree $\lvert p\rvert+\lvert q\rvert$, [Pairing]() issues `Pairing::degree` and aborts.

*evaluation* in the four-argument form gives $\langle p, \alpha\rangle$ for a particle *p* and a dual particle $\alpha$; it is read by [DualPairing]() and [ProductPairing](), which abort without it.

## Basic Examples

The alphabet of the circle: a degree $-1$ particle *x*, a degree $0$ particle *y*, and the single pairing value $\langle x, y\rangle = 1$.

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Normal[pairing]
```

<!-- => {"Degrees" -> <|x -> -1, y -> 0|>, "Values" -> <|{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0|>, "Degree" -> -1, "Convention" -> "Symmetric"} -->

---

Graded antisymmetry has supplied the value that was not given:

```wl
Normal[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]["Values"]]
```

<!-- => {{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0} -->

---

The degree of the pairing is read off the nonzero values:

```wl
Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]["Degree"]
```

<!-- => -1 -->

## Scope

*spec* may be a function of two particles instead of an association:

```wl
Normal[Pairing[<|x -> -1, y -> 0|>, Boole[#1 =!= #2] Signature[{#1, #2}] &]["Values"]]
```

<!-- => {{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0} -->

---

Particles are arbitrary expressions, so an alphabet of multi-character names works the same way:

```wl
Pairing[<|alpha -> -1, beta -> 0, gamma -> -1|>, <|{alpha, beta} -> 1, {gamma, beta} -> 1|>]["Degree"]
```

<!-- => -1 -->

---

The four-argument form attaches a dual alphabet:

```wl
Keys[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>, <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>]]
```

<!-- => {"Degrees", "Values", "Degree", "Convention", "Dual"} -->

## Properties and Relations

The convention is a key like any other, so the exterior picture is one <code>[Append]()</code> away:

```wl
Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]["Convention"]
```

<!-- => "Exterior" -->

---

[WordDegree]() reads the degrees out of the pairing object, in either grading:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
{WordDegree[{x, y}, pairing], WordDegree[{x, y}, pairing, "Exterior"], WordDegree[{x, y}, pairing, "Symmetric"]}
```

<!-- => {-1, -2, -3} -->

## Possible Issues

Operations that need the dual alphabet abort when the pairing object was built with the two-argument form. Build it with four arguments to use [DualPairing]() and [ProductPairing]().

```wl
Keys[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => {"Degrees", "Values", "Degree", "Convention"} -->
