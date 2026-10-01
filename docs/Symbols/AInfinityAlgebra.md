---
Template: Symbol
Name: AInfinityAlgebra
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/AInfinityAlgebra
Keywords: [A-infinity algebra, structure constants, finite dimensional, graded]
SeeAlso: [AInfinityOperation, AInfinityMorphism, Obstruction, Relations, RelationsQ, AInfinityAlgebraQ]
RelatedGuides: [HomotopyAlgebras]
---

## Usage

<code>[AInfinityAlgebra]()[*degrees*, *products*]</code> is the A-infinity algebra with the basis elements and shifted degrees of *degrees* and the operations $m_k$ given by *products*.

<!-- #| annotation: 26.09.30: Design review - the algebra is finite-dimensional and given by its structure constants: an Association from the basis elements to their shifted degrees, and one function of a list of basis elements that gives every m_k, 0 on the arities it does not define, so an algebra with operations of any arity takes no further argument. The records give no alternative to the function, such as arrays of structure constants. The built algebra is AInfinityAlgebra around one Association with the keys "Degrees", "Basis" and "Products", with the Association upvalues of the other objects of the paclet, and an input with a degree that is not an integer or a basis element that is not a monomial returns unevaluated, so a construction that built nothing never looks like an algebra. The basis elements are monomials because the coordinates of an element are read with CoefficientRules in the variables of the basis, as in the Hodge decompositions; so 1 and products of symbols are basis elements too (R3, 2026-09-29). The degrees are the shifted ones, and the relation of Obstruction is in the shifted convention. No alternative name was recorded. Prior art: the Wolfram Language has no A-infinity algebras; the verification suites build the engine's twisted A-infinity structure of the circle as an AInfinityAlgebra and pin its relation and its morphism relation against the engine's on every tuple of length at most 4. -->

## Details & Options

- *degrees* is an Association from the basis elements to their shifted degrees, which are integers.
- A basis element is a monomial: a symbol, $1$, or a product of powers of symbols.
- *products* is a function of a list of basis elements that gives $m_k$ on it, as a linear combination of basis elements, and $0$ on the arities it does not define.
- The algebra is finite-dimensional: its operations are structure constants on the basis.
- An element is a linear combination of basis elements, and its coordinates are its coefficients on the basis monomials. With $1$ in the basis, the constant term of an element is its coordinate on $1$.
- The result is an [AInfinityAlgebra]() object with the keys `"Degrees"`, `"Basis"` and `"Products"`, and <code>*algebra*["*key*"]</code> gives the value of a key.
- <code>[Keys]()</code>, <code>[Normal]()</code>, <code>[Lookup]()</code>, <code>[KeyExistsQ]()</code>, <code>[Append]()</code>, <code>[KeyDrop]()</code> and <code>[KeyTake]()</code> act on the object as on its Association.
- The degrees are shifted. A strictly associative algebra concentrated in degree $0$ becomes, after the shift, one whose basis elements have degree $-1$, and at that degree the relation reads as associativity. At degree $0$ it demands anti-associativity.
- [AInfinityOperation](), [AInfinityMorphism](), [Obstruction](), [Relations]() and [RelationsQ]() take the object. Its one relation is `"AInfinity"`.
- An input with a degree that is not an integer, or with a basis element that is not a monomial, returns unevaluated.
- The algebra displays as a summary box: its basis and the shifted degrees, and the products under the opener.

## Basic Examples

A strictly associative algebra on two generators, as an A-infinity algebra:

```wl
assoc = AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis u and v, both of degree -1 -->

Its keys:

```wl
Keys[assoc]
```

<!-- => {"Degrees", "Basis", "Products"} -->

Its operation $m_2$:

```wl
AInfinityOperation[assoc, {u, v}]
```

<!-- => v -->

Its operation $m_3$ is $0$:

```wl
AInfinityOperation[assoc, {u, v, u}]
```

<!-- => 0 -->

## Scope

A basis may contain $1$, here the unit of a strictly associative algebra:

```wl
unital = AInfinityAlgebra[<|1 -> -1, e -> -1|>, t |-> If[Length[t] === 2, Switch[t, {1, 1}, 1, {1, e}, e, {e, 1}, e, _, 0], 0]]
```

<!-- => an AInfinityAlgebra object with basis 1 and e, both of degree -1 -->

The constant term of an element is its coordinate on $1$:

```wl
AInfinityOperation[unital, {3 + 2 e, e}]
```

<!-- => 3 e -->

The algebra satisfies the relation on all tuples of length at most $4$:

```wl
RelationsQ[unital, 4]
```

<!-- => True -->

---

The degrees read back from the algebra:

```wl
AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]]["Degrees"]
```

<!-- => <|u -> -1, v -> -1|> -->

## Properties and Relations

The associative algebra satisfies the relation in the shifted convention:

```wl
RelationsQ[AInfinityAlgebra[<|u -> -1, v -> -1|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]], 3]
```

<!-- => True -->

---

With unshifted degrees the same products fail it, since at degree $0$ the relation asks for anti-associativity:

```wl
RelationsQ[AInfinityAlgebra[<|u -> 0, v -> 0|>, t |-> If[Length[t] === 2, Switch[t, {u, u}, u, {u, v}, v, {v, u}, v, _, 0], 0]], 3]
```

<!-- => False -->

## Possible Issues

A degree that is not an integer returns unevaluated:

```wl
AInfinityAlgebra[<|u -> 1/2|>, 0 &]
```

<!-- => AInfinityAlgebra[<|u -> 1/2|>, 0 & ] -->

It is not an algebra:

```wl
AInfinityAlgebraQ[AInfinityAlgebra[<|u -> 1/2|>, 0 &]]
```

<!-- => False -->

---

A basis element that is not a monomial returns unevaluated:

```wl
AInfinityAlgebra[<|u + v -> -1|>, 0 &]
```

<!-- => AInfinityAlgebra[<|u + v -> -1|>, 0 & ] -->
