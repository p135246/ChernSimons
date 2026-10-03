---
Template: Symbol
Name: Obstruction
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/Obstruction
Keywords: [obstruction, relation, Jacobi identity, co-Jacobi identity, Drinfeld compatibility, involutivity, Maurer-Cartan equation, BD master equation, A-infinity relation, A-infinity morphism, cochain complex, Hodge decomposition]
SeeAlso: [Relations, RelationsQ, CanonicalLieBialgebra, MaurerCartanElement, AInfinityAlgebra, AInfinityMorphism, CochainComplexWithPairing, HodgeDecomposition]
RelatedGuides: [HomotopyAlgebras, CanonicalLieBialgebra, BeilinsonDrinfeldFormalism, HodgeDecompositions]
---

## Usage

<code>[Obstruction]()[*structure*, *relation*, {$a_1$, …, $a_k$}]</code> gives the obstruction of the named relation of *structure* on the arguments $a_1, \dots, a_k$, which is $0$ when the relation holds there.

<code>[Obstruction]()[*structure*, {$a_1$, …, $a_k$}]</code> gives the obstruction of the one relation of *structure* on the arguments $a_1, \dots, a_k$.

<code>[Obstruction]()[*m*]</code> gives the obstruction $\Delta s + \tfrac12\{s, s\}$ of the Maurer-Cartan equation for the [MaurerCartanElement]() *m* with BD action *s*.

<code>[Obstruction]()[*m*, "Equations"]</code> gives the Association of the scalar equations on the coefficients of *m*.

<!-- #| annotation: 26.09.30: Design review - one function per concept: the obstruction of a named relation of a structure on a tuple of arguments, the relation named by a string and its arity read from Relations, so that one loop over Relations[s] runs on every structure (R5e, 2026-09-30). With Relations and RelationsQ it replaced thirteen exports with no aliases; the obstructions among them were JacobiObstruction, CoJacobiObstruction, DrinfeldObstruction, InvolutivityObstruction, AInfinityObstruction, AInfinityMorphismObstruction, MaurerCartanEquation and BeilinsonDrinfeldMasterEquation. Alternative names considered: those names, one function per relation. A structure with one relation takes its name or omits it. The function is declared with its A-infinity rules in the HomotopyAlgebras part, and the string-algebra, element, complex and decomposition rules are put on it by the parts that define those objects, which keeps the dependencies between the parts one-way. The A-infinity obstructions are multilinear and read the signs on basis tuples; the sign before R3 (2026-09-29) was wrong on a scalar multiple of an odd element, and an argument outside the span of the basis now returns unevaluated instead of being read as 0. A string algebra carries its empty-word setting, so an option given with it returns unevaluated; a Maurer-Cartan element carries a pairing, not a string algebra, so there the empty word is an option. The BD algebra is the symmetric algebra, and an element with an exterior pairing returns unevaluated rather than being computed in the wrong picture. The own axioms of a decomposition are conditions on subspaces in every degree, so they take the empty tuple, and a list of the failing degrees says where they fail, as the Failure of FindPreHodgeDecomposition does (R5g, 2026-09-30). Prior art: the Wolfram Language has no symbol for the obstruction of a relation of an algebraic structure; the verification suites pin the A-infinity and morphism obstructions against the engine's ainftyRelation and ainftyMorphism on every tuple of length at most 4 of the circle's twisted A-infinity structure, and the element obstruction against the engine's BV master equation through the substitution of the BV action by s/HBar. -->

## Details & Options

- [Relations]()[*structure*] gives the relations of a structure and the number of arguments each takes.
- The relations and their obstructions are:

| Structure | Relation | Arguments | Obstruction |
|---|---|---|---|
| [CanonicalLieBialgebra]()[*pairing*] | `"Jacobi"` | three cyclic words $u, v, w$ | $\hat q_{2,1,0}\hat q_{2,1,0}(u\odot v\odot w)$ |
| [CanonicalLieBialgebra]()[*pairing*] | `"CoJacobi"` | one cyclic word $w$ | $\hat q_{1,2,0}\hat q_{1,2,0}(w)$ |
| [CanonicalLieBialgebra]()[*pairing*] | `"Drinfeld"` | two cyclic words $u, v$ | $(\hat q_{1,2,0}\hat q_{2,1,0} + \hat q_{2,1,0}\hat q_{1,2,0})(u\odot v)$ |
| [CanonicalLieBialgebra]()[*pairing*] | `"Involutivity"` | one cyclic word $w$ | $\hat q_{2,1,0}\hat q_{1,2,0}(w)$ |
| [AInfinityAlgebra]() | `"AInfinity"` | any number of elements | the A-infinity relation |
| [AInfinityMorphism]() | `"AInfinityMorphism"` | any number of elements of the source | the morphism relation |
| [CochainComplexWithPairing]() | `"DifferentialSquare"` | one element $x$ | $\mathrm{d}\mathrm{d}x$ |
| [CochainComplexWithPairing]() | `"GradedSymmetry"` | two elements $x, y$ | $\langle x, y\rangle - (-1)^{\lvert x\rvert\lvert y\rvert}\langle y, x\rangle$ |
| [CochainComplexWithPairing]() | `"Leibniz"` | two elements $x, y$ | $\mathrm{d}(xy) - (\mathrm{d}x)y - (-1)^{\lvert x\rvert}x\,\mathrm{d}y$ |
| [CochainComplexWithPairing]() | the other axioms | one to three elements | the difference of the two sides |
| [PreHodgeDecomposition](), [HodgeDecomposition]() | `"Harmonic"`, `"Coexact"`, `"Perpendicular"`, `"Isotropic"` | none | the degrees where the axiom fails |
| [SpecialPropagator]() | `"Chain"`, `"Projector"`, `"Square"`, `"Symmetry"` | none | the degrees where the relation fails |

- On a canonical Lie bialgebra the operations are [CanonicalLieBracket]() and [CanonicalLieCobracket]() with their extensions to products, in the convention of the pairing, and with the empty word when the algebra has it.
- In the exterior convention the products in the string relations are exterior products.
- A cyclic word may be given as the list of its particles.
- On a canonical Lie bialgebra a nonzero value is a counterexample to the identity for that pairing.
- On an A-infinity algebra the convention is the shifted one: the term whose inner operation takes the arguments $r+1$ through $r+s$ carries the sign of the sum of the shifted degrees of the first $r$ arguments, and the relation on $e_1, \dots, e_n$ is $\sum_{r+s+t=n} (-1)^{|e_1|+\cdots+|e_r|}\, m_{r+1+t}(e_1,\dots,e_r, m_s(e_{r+1},\dots,e_{r+s}), \dots, e_n) = 0$.
- On an A-infinity morphism the left-hand side carries the same signs with the components $f_k$ outside, and the right-hand side sums over all compositions of the arguments into blocks, so a target with operations beyond $m_2$ is handled.
- The two A-infinity obstructions are multilinear in the elements, each a linear combination of basis elements, and an argument outside the span of the basis returns unevaluated.
- On a Maurer-Cartan element the equation is the BD master equation over $\mathbb{R}[[\hbar]]$, without inverting $\hbar$. The bracket is [CanonicalBeilinsonDrinfeldBracket](), so no negative power of $\hbar$ appears.
- The coefficient of the obstruction in $\mathrm{S}_\ell(C[1])\hbar^g$ is the $(\ell, g)$ Maurer-Cartan equation.
- In the `"Equations"` form the keys are the monomials, a power of $\hbar$ times a product of cyclic words, and the values the scalar coefficients, each of which must vanish. It is the form to give to <code>[Solve]()</code>.
- An element that solves the equation gives the empty Association in the `"Equations"` form.
- On an element whose pairing is in the exterior convention, [Obstruction]() returns unevaluated.
- On a cochain complex with a pairing each relation is an identity, and the obstruction is the difference of its two sides, multilinear in the elements, each a linear combination of basis elements.
- For `"DifferentialDegree"` and `"ProductDegree"` the obstruction is the part of $\mathrm{d}x$ or $xy$ outside the degree required.
- On a decomposition a relation of its complex has the obstruction it has on the complex.
- The own axioms of a decomposition are conditions on its parts in every degree, so they take the empty tuple of arguments, and the obstruction is $0$ when the axiom holds and otherwise the list of the degrees where it fails.
- A relation the structure does not have, or a tuple whose length is not the arity of the relation, returns unevaluated.
- [Obstruction]() has the following option:

| Option | Default | Description |
|---|---|---|
| <code>"EmptyWord"</code> | <code>False</code> | whether the operator and the bracket of the Maurer-Cartan equation of an element include the empty word |

- The option applies to a Maurer-Cartan element and is given to [CanonicalBeilinsonDrinfeldOperator]() and [CanonicalBeilinsonDrinfeldBracket]().
- A canonical Lie bialgebra carries its own empty-word setting, and the option given with a canonical Lie bialgebra returns unevaluated.

## Basic Examples

The Jacobi identity holds on a triple of words of the circle:

```wl
Obstruction[CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], "Jacobi", {CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{y, y}]}]
```

<!-- => 0 -->

---

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

All four identities over every tuple of these words:

```wl
KeyValueMap[{name, arity} |-> name -> Union[(t |-> Obstruction[algebra, name, t]) /@ Tuples[words, arity]], Relations[algebra]]
```

<!-- => {"Jacobi" -> {0}, "CoJacobi" -> {0}, "Drinfeld" -> {0}, "Involutivity" -> {0}} -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The canonical element of the circle solves the Maurer-Cartan equation:

```wl
Obstruction[MaurerCartanElement[CyclicWord[{x, x, y}], pairing]]
```

<!-- => 0 -->

Another word does not:

```wl
Obstruction[MaurerCartanElement[CyclicWord[{x, x, y, y}], pairing]]
```

<!-- => CyclicWord[{x, x, y, x, y, y}] - CyclicWord[{x, x, y, y, x, y}] -->

---

An algebra whose product is not associative:

```wl
bad = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, v, {u, v}, u, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

It fails the A-infinity relation:

```wl
Obstruction[bad, {u, u, v}]
```

<!-- => -v -->

## Scope

### Canonical Lie Bialgebras

The alphabet of the circle in the exterior convention:

```wl
exterior = Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1, in the exterior convention -->

Its canonical Lie bialgebra with the empty word:

```wl
algebra = CanonicalLieBialgebra[exterior, "EmptyWord" -> True]
```

<!-- => a CanonicalLieBialgebra object over the particles x and y, in the exterior convention, with the empty word -->

The co-Jacobi identity holds on every word of length at most $6$, the empty word among them:

```wl
Union[(w |-> Obstruction[algebra, "CoJacobi", {w}]) /@ GenerateCyclicWords[6, exterior, "UpTo" -> True, "EmptyWord" -> True]]
```

<!-- => {0} -->

---

A word may be given as the list of its particles:

```wl
Obstruction[CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]], "Drinfeld", {{x, y}, {x, y, y}}]
```

<!-- => 0 -->

### Maurer-Cartan Elements

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The `"Equations"` form turns an Ansatz into the equations on its unknowns:

```wl
Obstruction[MaurerCartanAnsatz[c, pairing, 4], "Equations"]
```

<!-- => <|CyclicWord[{x, x, y, x, y, y}] -> c[{x, x, y, y}]^2, CyclicWord[{x, x, y, y, x, y}] -> -c[{x, x, y, y}]^2|> -->

The scalar equations:

```wl
equations = Values[Obstruction[MaurerCartanAnsatz[c, pairing, 4], "Equations"]]
```

<!-- => {c[{x, x, y, y}]^2, -c[{x, x, y, y}]^2} -->

They are what <code>[Solve]()</code> takes:

```wl
Solve[Thread[equations == 0], Variables[equations]]
```

<!-- => {{c[{x, x, y, y}] -> 0}, {c[{x, x, y, y}] -> 0}} -->

A solution gives the empty Association:

```wl
Obstruction[MaurerCartanElement[CyclicWord[{x, x, y}], pairing], "Equations"]
```

<!-- => <||> -->

### A-infinity Algebras and Morphisms

An algebra whose product is not associative:

```wl
bad = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, v, {u, v}, u, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

A structure with one relation takes its name as well:

```wl
Obstruction[bad, "AInfinity", {u, u, v}]
```

<!-- => -v -->

The named and the unnamed forms agree:

```wl
Obstruction[bad, "AInfinity", {u, u, v}] === Obstruction[bad, {u, u, v}]
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
Obstruction[AInfinityMorphism[assoc, assoc, t |-> If[Length[t] === 1, First[t], 0]], {u, v, u}]
```

<!-- => 0 -->

A map that sends every element to $v$ fails the relation:

```wl
Obstruction[AInfinityMorphism[assoc, assoc, t |-> If[Length[t] === 1, v, 0]], {u, u}]
```

<!-- => v -->

### Complexes and Decompositions

A complex with a pairing:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>, <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with basis 1, a, da, b, db and v, of degree 4 -->

Its differential squares to $0$ on $a$:

```wl
Obstruction[complex, "DifferentialSquare", {a}]
```

<!-- => 0 -->

The differential changed so that $\mathrm{d}(\mathrm{d}a) = \mathrm{d}b$:

```wl
changed = Append[complex, "Differential" -> Append[complex["Differential"], da -> db]]
```

<!-- => a CochainComplexWithPairing object with the differential changed at da -->

The obstruction of $\mathrm{d}^2 = 0$ is the defect of the identity, and it is linear:

```wl
Obstruction[changed, "DifferentialSquare", {2 a + b}]
```

<!-- => 2 db -->

---

A complex with a pairing:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 3|>, <|a -> da, b -> db|>, <|{1, v} -> 1, {a, da} -> 1, {a, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with basis 1, a, da, b, db and v, of degree 3 -->

Its pre-Hodge decomposition, read as a Hodge decomposition, is not isotropic in degrees $1$ and $2$:

```wl
Obstruction[HodgeDecomposition[Normal[FindPreHodgeDecomposition[complex]]], "Isotropic", {}]
```

<!-- => {1, 2} -->

A Hodge decomposition of it is:

```wl
Obstruction[FindHodgeDecomposition[complex], "Isotropic", {}]
```

<!-- => 0 -->

A relation of the complex has on the decomposition the obstruction it has on the complex:

```wl
Obstruction[FindHodgeDecomposition[complex], "DifferentialSquare", {a}]
```

<!-- => 0 -->

## Options

### EmptyWord

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

Without the empty word the word $(x y)$ solves the Maurer-Cartan equation:

```wl
Obstruction[MaurerCartanElement[CyclicWord[{x, y}], pairing]]
```

<!-- => 0 -->

With the empty word its obstruction is a product of empty words:

```wl
Obstruction[MaurerCartanElement[CyclicWord[{x, y}], pairing], "EmptyWord" -> True]
```

<!-- => -SymmetricProduct[CyclicWord[{}], CyclicWord[{}]] -->

## Properties and Relations

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The Jacobi obstruction is the composite of the extensions of the bracket:

```wl
Obstruction[CanonicalLieBialgebra[pairing], "Jacobi", {CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{x, y, y}]}] === Expand[CanonicalLieBracket[CanonicalLieBracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], CyclicWord[{x, y, y}], pairing], pairing], pairing]]
```

<!-- => True -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

A BD action with a genus-one part:

```wl
s = CyclicWord[{x, x, y, y}] + lambda HBar CyclicWord[{x, x, y}]
```

<!-- => HBar lambda CyclicWord[{x, x, y}] + CyclicWord[{x, x, y, y}] -->

The Maurer-Cartan obstruction is $\Delta s + \tfrac12\{s, s\}$:

```wl
Obstruction[MaurerCartanElement[s, pairing]] === Expand[CanonicalBeilinsonDrinfeldOperator[s, pairing] + CanonicalBeilinsonDrinfeldBracket[s, s, pairing]/2]
```

<!-- => True -->

---

An algebra whose product is not associative:

```wl
bad = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, v, {u, v}, u, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

The A-infinity obstruction is multilinear, so a multiple of an element of odd degree carries the sign of that element:

```wl
Obstruction[bad, {2 u, u, v}]
```

<!-- => -2 v -->

It is twice the obstruction on $(u, u, v)$:

```wl
2 Obstruction[bad, {u, u, v}]
```

<!-- => -2 v -->

---

A three-letter alphabet:

```wl
three = GradedPairing[<|p -> -1, q -> 0, r -> -1|>, <|{p, q} -> 1, {r, q} -> 1|>]
```

<!-- => a GradedPairing object with particles p, q and r, of pairing degree -1 -->

Nothing here is particular to the circle. The word $(p p q)$ is a Maurer-Cartan element:

```wl
Obstruction[MaurerCartanElement[CyclicWord[{p, p, q}], three]]
```

<!-- => 0 -->

So is the word $(p q q)$:

```wl
Obstruction[MaurerCartanElement[CyclicWord[{p, q, q}], three]]
```

<!-- => 0 -->

## Possible Issues

The canonical Lie bialgebra of the circle:

```wl
algebra = CanonicalLieBialgebra[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]]
```

<!-- => a CanonicalLieBialgebra object over the particles x and y -->

A canonical Lie bialgebra has four relations, so its relation cannot be omitted, and the expression returns unevaluated:

```wl
Obstruction[algebra, {CyclicWord[{x, y}]}]
```

<!-- => the input, unevaluated -->

A tuple whose length is not the arity of the relation returns unevaluated:

```wl
Obstruction[algebra, "Jacobi", {CyclicWord[{x}], CyclicWord[{y}]}]
```

<!-- => the input, unevaluated -->

A relation the algebra does not have returns unevaluated:

```wl
Obstruction[algebra, "Leibniz", {CyclicWord[{x}]}]
```

<!-- => the input, unevaluated -->

---

The alphabet of the circle:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => a GradedPairing object with particles x and y, of pairing degree -1 -->

The empty word belongs to the algebra, so the option given with a canonical Lie bialgebra returns unevaluated:

```wl
Obstruction[CanonicalLieBialgebra[pairing], "Involutivity", {{x, x, y, y}}, "EmptyWord" -> True]
```

<!-- => the input, unevaluated -->

The empty word is set on the algebra instead:

```wl
Obstruction[CanonicalLieBialgebra[pairing, "EmptyWord" -> True], "Involutivity", {{x, x, y, y}}]
```

<!-- => 0 -->

---

An element whose pairing is in the exterior convention returns unevaluated:

```wl
Obstruction[MaurerCartanElement[CyclicWord[{x, x, y}], Append[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"]]]
```

<!-- => the input, unevaluated -->

---

An argument outside the span of the basis returns unevaluated:

```wl
Obstruction[AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, v, {u, v}, u, _, 0], 0]], {u, Sin[v], u}]
```

<!-- => the input, unevaluated -->
