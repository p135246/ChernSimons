---
Template: Symbol
Name: GaugeFlow
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/GaugeFlow
Keywords: [gauge equivalence, BD homotopy, Picard iteration, flow]
SeeAlso: [BeilinsonDrinfeldOperator, BeilinsonDrinfeldBracket, MaurerCartanEquation]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[GaugeFlow]()[*a*, *b*, *pairing*, *n*, *t*, *order*]</code> solves the BD homotopy equation $\Delta b + \{a, b\} = -\dot a$ by Picard iteration, starting from the BD action *a* at $t = 0$ and flowing along the interval component *b*.

## Details & Options

Two BD actions are BD homotopic — equivalently, their Maurer-Cartan elements are gauge equivalent — when such a flow connects them.

The result is a polynomial in *t* of degree at most *order*, truncated to monomials of total word length at most *n*. Both truncations are genuine: the equation is satisfied to order $t^{order-1}$ and generally fails at $t^{order}$.

The equation is written in the BD algebra itself, from [BeilinsonDrinfeldOperator]() and [BeilinsonDrinfeldBracket](), so it needs no coefficient parametrization and is not tied to any alphabet. On the circle it reproduces the coefficient system of the paper's lemma on BD homotopies; note that the two truncate differently — by word length here, by array index there — so they agree only where both truncations are inactive.

The flow preserves the Maurer-Cartan property: if *a* solves the master equation, so does every $a(t)$.

## Basic Examples

A flow of the circle along a single homotopy generator:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ys[k_] := ConstantArray[y, k];
xyxy[i_, j_] := CyclicWord[Join[{x}, ys[i], {x}, ys[j]]];
yp[k_] := CyclicWord[ys[k]];
GaugeFlow[c01 xyxy[0, 1], w1 CyclicWord[{x, y}], pairing, 4, t, 3]
```

---

It starts where it was told to:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ys[k_] := ConstantArray[y, k];
xyxy[i_, j_] := CyclicWord[Join[{x}, ys[i], {x}, ys[j]]];
yp[k_] := CyclicWord[ys[k]];
Expand[(GaugeFlow[c01 xyxy[0, 1], w1 CyclicWord[{x, y}], pairing, 4, t, 3] /. t -> 0) - c01 xyxy[0, 1]]
```

## Properties and Relations

The flow solves the BD homotopy equation to the order asked for:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ys[k_] := ConstantArray[y, k];
xyxy[i_, j_] := CyclicWord[Join[{x}, ys[i], {x}, ys[j]]];
yp[k_] := CyclicWord[ys[k]];
With[{b = w1 CyclicWord[{x, y}]}, With[{a = GaugeFlow[c01 xyxy[0, 1], b, pairing, 4, t, 3]},
  Table[Expand[Coefficient[Expand[BeilinsonDrinfeldOperator[b, pairing] + BeilinsonDrinfeldBracket[a, b, pairing] + D[a, t]], t, k]], {k, 0, 2}]]]
```

---

And it carries Maurer-Cartan elements to Maurer-Cartan elements:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
ys[k_] := ConstantArray[y, k];
xyxy[i_, j_] := CyclicWord[Join[{x}, ys[i], {x}, ys[j]]];
yp[k_] := CyclicWord[ys[k]];
MaurerCartanEquation[GaugeFlow[c01 xyxy[0, 1], w1 CyclicWord[{x, y}], pairing, 4, t, 3], pairing]
```
