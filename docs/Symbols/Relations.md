---
Template: Symbol
Name: Relations
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/Relations
Keywords: [relations, defining identities, axioms, arity, involutive bi-Lie algebra, A-infinity, cochain complex, Hodge decomposition]
SeeAlso: [Obstruction, RelationsQ, CanonicalLieBialgebra, AInfinityAlgebra, AInfinityMorphism, CochainComplexWithPairing, PreHodgeDecomposition]
RelatedGuides: [HomotopyAlgebras, CanonicalLieBialgebra, HodgeDecompositions]
---

## Usage

<code>[Relations]()[*structure*]</code> gives the Association from the name of each relation of *structure* to its arity, the number of arguments [Obstruction]() takes for it.

<!-- #| annotation: 26.09.30: Design review - one function names the relations of every structure, so that a single loop, Obstruction[s, name, t] over Tuples[basis, arity] for each entry of Relations[s], runs on every structure (R5e, 2026-09-30). The arity is the number of arguments Obstruction takes: All for the A-infinity relations, which have one relation of each arity, says that without claiming infinitely many arguments, and 0 for the own axioms of a decomposition, which are conditions on its parts in every degree rather than identities on arguments, keeps the loop running since Tuples[basis, 0] is {{}} (R5g, 2026-09-30). The relations of a complex are one per axiom the old recognizer CochainComplexWithPairingQ tested. It replaces the Association $DefiningIdentities, which carried each identity of the string algebra with its arity and its function. A Maurer-Cartan element is not a structure, and there is no Relations of an element. The function is declared with Obstruction and RelationsQ in the HomotopyAlgebras part, and the string-algebra and complex rules are put on it by the parts that define those structures. No alternative name was recorded. Prior art: the Wolfram Language has no symbol listing the defining relations of an algebraic structure. -->

## Details & Options

- [Relations]() gives the following relations and arities:

| Structure | Relation | Arity |
|---|---|---|
| [CanonicalLieBialgebra]()[*pairing*] | `"Jacobi"` | $3$ |
| [CanonicalLieBialgebra]()[*pairing*] | `"CoJacobi"` | $1$ |
| [CanonicalLieBialgebra]()[*pairing*] | `"Drinfeld"` | $2$ |
| [CanonicalLieBialgebra]()[*pairing*] | `"Involutivity"` | $1$ |
| [AInfinityAlgebra]() | `"AInfinity"` | `All` |
| [AInfinityMorphism]() | `"AInfinityMorphism"` | `All` |
| [CochainComplexWithPairing]() | `"DifferentialDegree"`, `"DifferentialSquare"` | $1$ |
| [CochainComplexWithPairing]() | `"PairingDegree"`, `"GradedSymmetry"`, `"Compatibility"` | $2$ |
| [CochainComplexWithPairing]() with a product | `"ProductDegree"`, `"GradedCommutativity"`, `"Leibniz"` | $2$ |
| [CochainComplexWithPairing]() with a product | `"Associativity"`, `"Invariance"` | $3$ |
| [CochainComplexWithPairing]() with a product and $1$ | `"Unit"` | $1$ |
| [PreHodgeDecomposition]() | those of its complex, and `"Harmonic"`, `"Coexact"`, `"Perpendicular"` | $0$ for its own |
| [HodgeDecomposition]() | those of a pre-Hodge decomposition, and `"Isotropic"` | $0$ for its own |
| [SpecialPropagator]() | `"Chain"`, `"Projector"`, `"Square"`, `"Symmetry"`, then those of its decomposition | $0$ for its own |

- The four relations of a canonical Lie bialgebra are the defining identities of an involutive bi-Lie algebra: the Jacobi identity of the bracket, the co-Jacobi identity of the co-bracket, their Drinfeld compatibility, and involutivity.
- The relations of a canonical Lie bialgebra do not depend on the convention of the pairing or on the empty word.
- The arity `All` says that the relation is defined on every positive number of arguments: an A-infinity algebra has one relation of each arity, and so has a morphism. [RelationsQ]() bounds the arity by the length of the tuples it tests.
- The relations of a cochain complex with a pairing of degree $n$ are its axioms, each an identity on elements:

| Relation | Identity |
|---|---|
| `"DifferentialDegree"` | $\mathrm{d}x$ has degree $\lvert x\rvert + 1$ |
| `"DifferentialSquare"` | $\mathrm{d}\mathrm{d}x = 0$ |
| `"PairingDegree"` | $\langle x, y\rangle = 0$ unless $\lvert x\rvert + \lvert y\rvert = n$ |
| `"GradedSymmetry"` | $\langle x, y\rangle = (-1)^{\lvert x\rvert\lvert y\rvert}\langle y, x\rangle$ |
| `"Compatibility"` | $\langle \mathrm{d}x, y\rangle = (-1)^{\lvert x\rvert+1}\langle x, \mathrm{d}y\rangle$ |
| `"ProductDegree"` | $xy$ has degree $\lvert x\rvert + \lvert y\rvert$ |
| `"GradedCommutativity"` | $xy = (-1)^{\lvert x\rvert\lvert y\rvert}yx$ |
| `"Associativity"` | $(xy)z = x(yz)$ |
| `"Unit"` | $1x = x$ |
| `"Leibniz"` | $\mathrm{d}(xy) = (\mathrm{d}x)y + (-1)^{\lvert x\rvert}x\,\mathrm{d}y$ |
| `"Invariance"` | $\langle xy, z\rangle = \langle x, yz\rangle$ |

- The last six relations are those of a complex with a product, and `"Unit"` requires $1$ to be a basis element.
- A decomposition $V = \mathcal{H}\oplus\mathrm{im}\,\mathrm{d}\oplus C$ has the relations of its complex and its own axioms, which are conditions on its parts in every degree rather than identities on arguments, so their arity is $0$:

| Relation | Axiom |
|---|---|
| `"Harmonic"` | $\mathcal{H}$ is a complement of $\mathrm{im}\,\mathrm{d}$ in $\ker\mathrm{d}$ |
| `"Coexact"` | $C$ is a complement of $\ker\mathrm{d}$ |
| `"Perpendicular"` | $C\perp\mathcal{H}$ |
| `"Isotropic"` | $C\perp C$, for a Hodge decomposition only |

- Anything that is not one of these structures, such as a [SullivanModel]() or a [MaurerCartanElement](), returns unevaluated.

## Basic Examples

The relations of the canonical Lie bialgebra of the circle:

```wl
Relations[CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]]
```

<!-- => <|"Jacobi" -> 3, "CoJacobi" -> 1, "Drinfeld" -> 2, "Involutivity" -> 1|> -->

---

A strictly associative algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

An A-infinity algebra has one relation, on any number of arguments:

```wl
Relations[assoc]
```

<!-- => <|"AInfinity" -> All|> -->

So has an A-infinity morphism:

```wl
Relations[AInfinityMorphism[assoc, assoc, t |-> If[Length[t] === 1, First[t], 0]]]
```

<!-- => <|"AInfinityMorphism" -> All|> -->

## Scope

A cochain complex with a product, and with $1$ in its basis, has eleven relations:

```wl
Relations[CochainComplexWithPairing[SullivanModel["Torus"[2]]]]
```

<!-- => <|"DifferentialDegree" -> 1, "DifferentialSquare" -> 1, "PairingDegree" -> 2, "GradedSymmetry" -> 2, "Compatibility" -> 2, "ProductDegree" -> 2, "GradedCommutativity" -> 2, "Associativity" -> 3, "Unit" -> 1, "Leibniz" -> 2, "Invariance" -> 3|> -->

---

A cochain complex without a product has five:

```wl
Relations[CochainComplexWithPairing[<|1 -> 0, x -> 1|>, <||>, <|{1, x} -> 1|>]]
```

<!-- => <|"DifferentialDegree" -> 1, "DifferentialSquare" -> 1, "PairingDegree" -> 2, "GradedSymmetry" -> 2, "Compatibility" -> 2|> -->

---

A Hodge decomposition has the relations of its complex and four axioms of its own:

```wl
Relations[FindHodgeDecomposition[SullivanModel["Torus"[2]]]]
```

<!-- => <|"DifferentialDegree" -> 1, "DifferentialSquare" -> 1, "PairingDegree" -> 2, "GradedSymmetry" -> 2, "Compatibility" -> 2, "ProductDegree" -> 2, "GradedCommutativity" -> 2, "Associativity" -> 3, "Unit" -> 1, "Leibniz" -> 2, "Invariance" -> 3, "Harmonic" -> 0, "Coexact" -> 0, "Perpendicular" -> 0, "Isotropic" -> 0|> -->

Its own axioms are those not of its complex:

```wl
KeyDrop[Relations[FindHodgeDecomposition[SullivanModel["Torus"[2]]]], Keys[Relations[CochainComplexWithPairing[SullivanModel["Torus"[2]]]]]]
```

<!-- => <|"Harmonic" -> 0, "Coexact" -> 0, "Perpendicular" -> 0, "Isotropic" -> 0|> -->

---

A pre-Hodge decomposition has three axioms of its own:

```wl
KeyDrop[Relations[FindPreHodgeDecomposition[SullivanModel["Torus"[2]]]], Keys[Relations[CochainComplexWithPairing[SullivanModel["Torus"[2]]]]]]
```

<!-- => <|"Harmonic" -> 0, "Coexact" -> 0, "Perpendicular" -> 0|> -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

Its canonical Lie bialgebra with the empty word:

```wl
algebra = CanonicalLieBialgebra[pairing, "EmptyWord" -> True]
```

<!-- => a CanonicalLieBialgebra object over the particles x and y, with the empty word -->

A test of every relation reads both halves of an entry, the name to give [Obstruction]() and the arity to build the tuples:

```wl
KeyValueMap[{name, arity} |-> name -> Union[(t |-> Obstruction[algebra, name, t]) /@ Tuples[GenerateCyclicWords[3, pairing, "UpTo" -> True, "EmptyWord" -> True], arity]], Relations[algebra]]
```

<!-- => {"Jacobi" -> {0}, "CoJacobi" -> {0}, "Drinfeld" -> {0}, "Involutivity" -> {0}} -->

## Properties and Relations

The relations do not depend on the convention or on the empty word:

```wl
Relations[CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]] === Relations[CanonicalLieBialgebra[Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"], "EmptyWord" -> True]]
```

<!-- => True -->

---

The canonical Lie bialgebra of the circle:

```wl
algebra = CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => a CanonicalLieBialgebra object over the particles x and y -->

The arity is the length of the tuple [Obstruction]() takes:

```wl
Obstruction[algebra, "Drinfeld", {CyclicWord[{x}], CyclicWord[{y}]}]
```

<!-- => 0 -->

A tuple of another length returns unevaluated:

```wl
Obstruction[algebra, "Drinfeld", {CyclicWord[{x}]}]
```

<!-- => the input, unevaluated -->

## Possible Issues

A Maurer-Cartan element is not a structure with relations, and the expression returns unevaluated:

```wl
Relations[MaurerCartanElement[CyclicWord[{x, x, y}], GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]]
```

<!-- => the input, unevaluated -->

---

A model is not one of the structures either; its complex is:

```wl
Relations[SullivanModel["Circle"]]
```

<!-- => the input, unevaluated -->
