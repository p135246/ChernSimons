---
Template: Symbol
Name: CanonicalBeilinsonDrinfeldHomotopy
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CanonicalBeilinsonDrinfeldHomotopy
Keywords: [gauge equivalence, BD homotopy, Picard iteration, flow]
SeeAlso: [CanonicalBeilinsonDrinfeldOperator, CanonicalBeilinsonDrinfeldBracket, MaurerCartanElement, Obstruction]
RelatedGuides: [BeilinsonDrinfeldFormalism]
---

## Usage

<code>[CanonicalBeilinsonDrinfeldHomotopy]()[*a*, *b*, *pairing*, *n*, *t*, *order*]</code> gives the solution $a(t)$ of the BD homotopy equation $\Delta b + \{a(t), b\} = -\dot a(t)$ with $a(0) = a$, as a polynomial in *t* of degree at most *order*, truncated to total word length at most *n*.

<!-- #| annotation: 26.09.30: Design review - the name says what the function computes, a homotopy in the Beilinson-Drinfeld algebra of the string operations, beside CanonicalBeilinsonDrinfeldOperator and CanonicalBeilinsonDrinfeldBracket; it was GaugeFlow until R5f (the name the names doc recommended, approved by Pavel, 2026-09-30), with the same signature and option. Alternative name considered: GaugeFlow. It takes BD actions and a pairing, not MaurerCartanElement objects; R5d and R5f kept that signature, and no alternative was recorded. The equation is written in the BD algebra itself, from CanonicalBeilinsonDrinfeldOperator and CanonicalBeilinsonDrinfeldBracket, so it needs no parametrization by coefficients and is not tied to any alphabet; the two truncations, by word length and by the power of t, are explicit arguments. A pairing in the exterior convention returns unevaluated, since the BD algebra is the symmetric algebra (R2). Prior art: the Wolfram Language has no BD algebras; the engine the verification suites load solves the coefficient equations of the circle on arrays truncated by index, which truncates differently, so T12/paclet-gauge-flow-solves-the-bd-homotopy-equation tests the equation itself rather than a comparison, and T12/paclet-empty-word-gauge-flow-is-the-extended-transport pins the velocity at t = 0 against the transport of the empty-word extension, with and without the option. -->

## Details & Options

- *a* is a BD action, a sum of scalars times powers of [HBar]() times cyclic words and symmetric products, and *b* is the interval component of the homotopy, constant in *t*.
- $\Delta$ is [CanonicalBeilinsonDrinfeldOperator]() and $\{\cdot, \cdot\}$ is [CanonicalBeilinsonDrinfeldBracket]().
- The solution is computed by Picard iteration: *order* steps of $a(t) \mapsto a - \int_0^t \bigl(\Delta b + \{a(s), b\}\bigr)\,ds$, each truncated to degree at most *order* in *t*.
- After each step the words and products of total word length greater than *n* are dropped, those of *a* included.
- The equation holds to order $t^{\text{order}-1}$ and in general fails at $t^{\text{order}}$.
- Two BD actions are BD homotopic, equivalently their Maurer-Cartan elements are gauge equivalent, when such a flow connects them.
- If *a* solves the Maurer-Cartan equation, so does $a(t)$, up to the two truncations.
- The result is a BD action, which [MaurerCartanElement]() splits into its parts.
- On the circle the equation is the coefficient system of the paper's lemma on BD homotopies. That system is truncated by the indices of the coefficients rather than by word length, so the two agree only where neither truncation is active.
- A pairing in the exterior convention returns unevaluated.
- [CanonicalBeilinsonDrinfeldHomotopy]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether [CanonicalBeilinsonDrinfeldOperator]() and [CanonicalBeilinsonDrinfeldBracket]() count the empty word, so that the modes on the empty word flow too |

## Basic Examples

A flow of the circle along a single homotopy generator $w_1\,xy$:

```wl
flow = CanonicalBeilinsonDrinfeldHomotopy[c01 CyclicWord[{x, x, y}], w1 CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 4, t, 3]
```

<!-- => c01 CyclicWord[{x, x, y}] - c01 t w1 CyclicWord[{x, x, y}] + (c01 t^2 w1^2 CyclicWord[{x, x, y}])/2 - (c01 t^3 w1^3 CyclicWord[{x, x, y}])/6 -->

It starts at the given action:

```wl
flow /. t -> 0
```

<!-- => c01 CyclicWord[{x, x, y}] -->

## Scope

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

A flow of an action with a two-word part, to order $2$:

```wl
CanonicalBeilinsonDrinfeldHomotopy[c01 CyclicWord[{x, x, y}] + d SymmetricProduct[{y}, {y}, pairing], w1 CyclicWord[{x, y}], pairing, 4, t, 2]
```

<!-- => c01 CyclicWord[{x, x, y}] - c01 t w1 CyclicWord[{x, x, y}] + (c01 t^2 w1^2 CyclicWord[{x, x, y}])/2 + d SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] + 2 d t w1 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] + 2 d t^2 w1^2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] -->

## Options

### EmptyWord

With `"EmptyWord" -> True` the flow also creates a term on the product of two empty words:

```wl
CanonicalBeilinsonDrinfeldHomotopy[c01 CyclicWord[{x, x, y}], w1 CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 4, t, 3, "EmptyWord" -> True]
```

<!-- => c01 CyclicWord[{x, x, y}] - c01 t w1 CyclicWord[{x, x, y}] + (c01 t^2 w1^2 CyclicWord[{x, x, y}])/2 - (c01 t^3 w1^3 CyclicWord[{x, x, y}])/6 + t w1 SymmetricProduct[CyclicWord[{}], CyclicWord[{}]] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The flow along $w_1\,xy$:

```wl
flow = CanonicalBeilinsonDrinfeldHomotopy[c01 CyclicWord[{x, x, y}], w1 CyclicWord[{x, y}], pairing, 4, t, 3]
```

<!-- => c01 CyclicWord[{x, x, y}] - c01 t w1 CyclicWord[{x, x, y}] + (c01 t^2 w1^2 CyclicWord[{x, x, y}])/2 - (c01 t^3 w1^3 CyclicWord[{x, x, y}])/6 -->

The coefficients of $t^0$ to $t^3$ of $\Delta b + \{a(t), b\} + \dot a(t)$: the equation holds to order $t^2$ and fails at $t^3$:

```wl
Table[Coefficient[Expand[CanonicalBeilinsonDrinfeldOperator[w1 CyclicWord[{x, y}], pairing] + CanonicalBeilinsonDrinfeldBracket[flow, w1 CyclicWord[{x, y}], pairing] + D[flow, t]], t, k], {k, 0, 3}]
```

<!-- => {0, 0, 0, -1/6 (c01 w1^4 CyclicWord[{x, x, y}])} -->

The flow carries the Maurer-Cartan element $c_{01}\,x^2y$ to Maurer-Cartan elements:

```wl
Obstruction[MaurerCartanElement[flow, pairing]]
```

<!-- => 0 -->

## Possible Issues

The truncation applies to the starting action too, so a truncation below the length of its words gives $0$:

```wl
CanonicalBeilinsonDrinfeldHomotopy[c01 CyclicWord[{x, x, y}], w1 CyclicWord[{x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 2, t, 3]
```

<!-- => 0 -->

---

The BD algebra is the symmetric algebra, so a pairing in the exterior convention returns unevaluated:

```wl
CanonicalBeilinsonDrinfeldHomotopy[c01 CyclicWord[{x, x, y}], w1 CyclicWord[{x, y}], Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"], 4, t, 3]
```

<!-- => the input with the exterior pairing in place, unevaluated -->
