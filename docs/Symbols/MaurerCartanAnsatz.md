---
Template: Symbol
Name: MaurerCartanAnsatz
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/MaurerCartanAnsatz
Keywords: [Ansatz, unknowns, coefficients, Maurer-Cartan]
SeeAlso: [MaurerCartanQ, MaurerCartanBasis, MaurerCartanAnsatz, BeilinsonDrinfeldMasterEquation, PlanckDegree]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[MaurerCartanAnsatz]()[*coefficient*, *pairing*, *n*]</code> gives the general genus-zero BD action over <code>[MaurerCartanBasis]()[*pairing*, *n*]</code>, with *coefficient*[*k*] the unknown on the *k*-th basis monomial.

<code>[MaurerCartanAnsatz]()[*coefficient*, *degree*, *pairing*, *n*]</code> uses the given degree.

## Details & Options

Feeding the result to <code>[MaurerCartanEquation]()[…, "Equations"]</code> gives the equations the unknowns must satisfy — the round trip from an element to its equations and back.

The coefficients are indexed by **position** in the basis, not by the monomial. A coefficient carrying a [CyclicWord]() inside it is rewritten along with everything else when the expression is handed to the engine, and the engine then stops recognizing it as a scalar, so the operations cease to be linear in it and come back unevaluated. Any coefficient free of [CyclicWord]() and [HBar]() is safe.

## Basic Examples

The general element of the circle at truncation $4$:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
MaurerCartanAnsatz[c, pairing, 4]
```

---

Its equations, and their solution — at this truncation the only obstruction is that one coefficient vanishes:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
With[{equations = Values[MaurerCartanEquation[MaurerCartanAnsatz[c, pairing, 4], pairing, "Equations"]]},
 Solve[Thread[equations == 0], Variables[equations]]]
```

## Possible Issues

A coefficient built from a cyclic word is not a scalar to the engine, and the operations stop being linear in it:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
FreeQ[MaurerCartanAnsatz[c, pairing, 4], CyclicWord[_][_]]
```
