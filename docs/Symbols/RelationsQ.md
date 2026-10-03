---
Template: Symbol
Name: RelationsQ
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/RelationsQ
Keywords: [relations, test, predicate, axioms, Maurer-Cartan, A-infinity, involutive bi-Lie algebra, cochain complex, Hodge decomposition]
SeeAlso: [Obstruction, Relations, CanonicalLieBialgebra, MaurerCartanElement, AInfinityAlgebra, AInfinityMorphism, CochainComplexWithPairing, HodgeDecomposition]
RelatedGuides: [HomotopyAlgebras, CanonicalLieBialgebra, BeilinsonDrinfeldFormalism, HodgeDecompositions]
---

## Usage

<code>[RelationsQ]()[*structure*, *n*]</code> tests whether every relation of *structure* holds on every tuple of arguments in the range *n* sets.

<code>[RelationsQ]()[*structure*]</code> tests whether every relation of a [CochainComplexWithPairing](), a [PreHodgeDecomposition](), a [HodgeDecomposition]() or a [SpecialPropagator]() holds.

<code>[RelationsQ]()[*m*]</code> tests whether the [MaurerCartanElement]() *m* solves the Maurer-Cartan equation.

<!-- #| annotation: 26.09.30: Design review - one predicate tests the relations of every structure, Obstruction over the tuples Relations prescribes, and it replaces AInfinityQ, AInfinityMorphismQ, MaurerCartanQ and BeilinsonDrinfeldMasterQ (R5e, 2026-09-30) and the axiom tests of the old recognizers of the complex and the two decompositions, CochainComplexWithPairingQ among them (R5g, 2026-09-30). Alternative names considered: those tests. On a string algebra or an A-infinity structure the relations are infinitely many, so the test is finite and n bounds it: the word length for a string algebra and the tuple length for an A-infinity algebra or morphism, the ranges of the old AInfinityQ and of RelationFailures. A complex and a decomposition are finite and their relations multilinear, so testing every relation on every tuple of basis elements is complete, and that form takes no n. The old recognizers answered False on malformed data; RelationsQ returns unevaluated on input that is not one of the structures, the interface rule for such input. On a Maurer-Cartan element the test is Obstruction[m] === 0 and takes the empty word as an option, since the element carries a pairing and not a string algebra. Prior art: the Wolfram Language has no predicate for the relations of an algebraic structure; the verification suites run the test on the engine's twisted A-infinity structure of the circle, whose obstruction they pin against the engine's. -->

## Details & Options

- [RelationsQ]() is `True` when [Obstruction]() is $0$ on every tuple tested, and `False` otherwise.
- The tuples tested are:

| Structure | Tuples tested |
|---|---|
| [CanonicalLieBialgebra]()[*pairing*] | every tuple of cyclic words of length at most *n*, one tuple length per relation |
| [AInfinityAlgebra]() | every tuple of basis elements of length at most *n* |
| [AInfinityMorphism]() | every tuple of basis elements of the source of length at most *n* |
| [CochainComplexWithPairing]() | every tuple of basis elements, of the arity of each relation |
| [PreHodgeDecomposition](), [HodgeDecomposition]() | those of the complex, and each axiom of the decomposition once |
| [SpecialPropagator]() | those of the decomposition, and each of its four relations once |

- On a canonical Lie bialgebra with the empty word, the empty word is among the words tested.
- With *n*, the test is finite: it says the relations hold in that range, not that they hold. For an A-infinity algebra whose operations vanish above some arity, a large enough *n* is conclusive.
- On a complex, a decomposition and a propagator the structure is finite and the relations multilinear, so the test is complete and takes no *n*.
- Data without the keys and types of a complex return unevaluated, and so does anything that is not one of these structures, such as a [SullivanModel]().
- <code>[RelationsQ]()[*m*]</code> is <code>[Obstruction]()[*m*] === 0</code>.
- On an element whose pairing is in the exterior convention, [RelationsQ]() returns unevaluated.
- [RelationsQ]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the Maurer-Cartan equation of an element includes the empty word |

- The option applies to a Maurer-Cartan element and is the option of [Obstruction](). A canonical Lie bialgebra carries its own empty-word setting.

## Basic Examples

The canonical Lie bialgebra of the circle satisfies its four relations on all words of length at most $3$:

```wl
RelationsQ[CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], 3]
```

<!-- => True -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The canonical element of the circle is a Maurer-Cartan element:

```wl
RelationsQ[MaurerCartanElement[CyclicWord[{x, x, y}], pairing]]
```

<!-- => True -->

Another word is not:

```wl
RelationsQ[MaurerCartanElement[CyclicWord[{x, x, y, y}], pairing]]
```

<!-- => False -->

---

A strictly associative algebra is an A-infinity algebra in the shifted convention:

```wl
RelationsQ[AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]], 4]
```

<!-- => True -->

## Scope

A model of the Heisenberg nilmanifold:

```wl
model = SullivanModel["HeisenbergNilmanifold"]
```

<!-- => a SullivanModel object, the model of the Heisenberg nilmanifold -->

Its complex satisfies its relations:

```wl
RelationsQ[CochainComplexWithPairing[model]]
```

<!-- => True -->

So does a Hodge decomposition of it:

```wl
RelationsQ[FindHodgeDecomposition[model]]
```

<!-- => True -->

---

A complex with a pairing:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>, <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with basis 1, a, da, b, db and v, of degree 3 -->

Its pre-Hodge decomposition:

```wl
pre = FindPreHodgeDecomposition[complex]
```

<!-- => a PreHodgeDecomposition object of the complex -->

It satisfies the relations of a pre-Hodge decomposition:

```wl
RelationsQ[pre]
```

<!-- => True -->

Read as a Hodge decomposition, it fails the axiom `"Isotropic"`:

```wl
RelationsQ[HodgeDecomposition[Normal[pre]]]
```

<!-- => False -->

---

With the empty word, in the exterior convention:

```wl
RelationsQ[CanonicalLieBialgebra[Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"], "EmptyWord" -> True], 3]
```

<!-- => True -->

---

Every multiple of the canonical element is a Maurer-Cartan element:

```wl
RelationsQ[MaurerCartanElement[lambda CyclicWord[{x, x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]]
```

<!-- => True -->

---

A strictly associative algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

Its identity is an A-infinity morphism:

```wl
RelationsQ[AInfinityMorphism[assoc, assoc, t |-> If[Length[t] === 1, First[t], 0]], 4]
```

<!-- => True -->

A map that sends every element to $v$ is not:

```wl
RelationsQ[AInfinityMorphism[assoc, assoc, t |-> If[Length[t] === 1, v, 0]], 3]
```

<!-- => False -->

## Options

### EmptyWord

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

Without the empty word the word $(x y)$ solves the Maurer-Cartan equation:

```wl
RelationsQ[MaurerCartanElement[CyclicWord[{x, y}], pairing]]
```

<!-- => True -->

With the empty word it does not:

```wl
RelationsQ[MaurerCartanElement[CyclicWord[{x, y}], pairing], "EmptyWord" -> True]
```

<!-- => False -->

## Properties and Relations

The canonical Lie bialgebra of the circle:

```wl
algebra = CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => a CanonicalLieBialgebra object over the particles x and y -->

Its words of length at most $3$:

```wl
words = GenerateCyclicWords[3, algebra["Pairing"], "UpTo" -> True]
```

<!-- => {CyclicWord[{x}], CyclicWord[{y}], CyclicWord[{x, y}], CyclicWord[{y, y}], CyclicWord[{x, x, x}], CyclicWord[{x, x, y}], CyclicWord[{x, y, y}], CyclicWord[{y, y, y}]} -->

The test is [Obstruction]() over the tuples [Relations]() prescribes:

```wl
RelationsQ[algebra, 3] === AllTrue[Normal[Relations[algebra]], relation |-> AllTrue[Tuples[words, Last[relation]], t |-> Obstruction[algebra, First[relation], t] === 0]]
```

<!-- => True -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

On an element the test is whether the obstruction is $0$:

```wl
RelationsQ[MaurerCartanElement[CyclicWord[{x, x, y, y}], pairing]] === (Obstruction[MaurerCartanElement[CyclicWord[{x, x, y, y}], pairing]] === 0)
```

<!-- => True -->

## Possible Issues

The same associative algebra with unshifted degrees fails, since at degree $0$ the relation asks for anti-associativity:

```wl
RelationsQ[AInfinityAlgebra[<|u -> 0, v -> 0|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]], 3]
```

<!-- => False -->

---

A model is not one of the structures, and the expression returns unevaluated:

```wl
RelationsQ[SullivanModel["Circle"]]
```

<!-- => the input, unevaluated -->

Its complex is one:

```wl
RelationsQ[CochainComplexWithPairing[SullivanModel["Circle"]]]
```

<!-- => True -->

---

An element whose pairing is in the exterior convention returns unevaluated:

```wl
RelationsQ[MaurerCartanElement[CyclicWord[{x, x, y}], Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]]]
```

<!-- => the input, unevaluated -->
