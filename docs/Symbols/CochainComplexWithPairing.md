---
Template: Symbol
Name: CochainComplexWithPairing
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CochainComplexWithPairing
Keywords: [cochain complex, pairing, cyclic cochain complex, dPD algebra, differential graded algebra, structure constants, Hodge type]
SeeAlso: [Relations, RelationsQ, FindHodgeDecomposition, SullivanModel, PoincareDualityAlgebra, PoincareDualityQ, PerfectPairingQ, HodgeTypeQ, NondegenerateQuotient]
RelatedGuides: [HodgeDecompositions]
---

## Usage

<code>[CochainComplexWithPairing]()[*degrees*, *differential*, *pairing*]</code> is a finite-dimensional cochain complex with a graded symmetric pairing, given by the degrees of the basis elements, the differential on the basis and the values of the pairing.

<code>[CochainComplexWithPairing]()[*degrees*, *differential*, *product*, *orientation*]</code> is a differential graded algebra with the pairing $\langle x, y\rangle = \mathcal{O}(xy)$, given by the products of pairs of basis elements and an orientation $\mathcal{O}$.

<code>[CochainComplexWithPairing]()[*model*]</code> is the finite quotient of a [SullivanModel]() that agrees with it up to degree $n+1$ and has its Poincaré duality and Hodge type.

<code>[CochainComplexWithPairing]()[*algebra*]</code> is a [PoincareDualityAlgebra]() as a complex.

<!-- #| annotation: 26.09.30: Design review - the complex is a tagged object over an Association with the keys "Degrees", "Differential", "Pairing", "Degree" and, for an algebra, "Product", so that a finite complex can be written down and decomposed without a Sullivan model, as Example 6.1 of arXiv:2004.07362 over the rationals is. The three-argument form takes the pairing values and the four-argument form takes the product and an orientation and derives the pairing, since those determine a dPD algebra; both complete each pair given in one order by graded symmetry or commutativity, and both validate the data with RelationsQ and give a Failure instead of an object that breaks an axiom, the convention SullivanModel and GradedPairing follow for ill-formed data. The axioms are the relations of Relations since R5g, five for a complex and eleven with a product, with an Obstruction for each; they replace the recognizer CochainComplexWithPairingQ, which went with no alias. The form on a model is a quotient, not the subcomplex of degrees up to n+1 plus the image of the differential in degree n+2: that subcomplex has no monomial basis in degree n+2, while the quotient by everything above n+2 and by the non-pivot monomials of degree n+2 is isomorphic to it and is a CDGA. The form on a PoincareDualityAlgebra is the inverse of PoincareDualityAlgebra[complex], so no second data shape for an algebra enters the API. Prior art: the Wolfram Language 15.0 has no cochain complexes or graded pairings, and the engine of the verification suites has none either; T17 pins the complex of the catalogue models on their Poincare duality and Hodge type, and the quotient of the complex against the complex of the quotient. -->

## Details & Options

- The result is a tagged object, read with *complex*[*key*] and [Normal](). It has the following keys:

| Key | Value |
|---|---|
| `"Degrees"` | each basis element with its degree |
| `"Differential"` | the image of each basis element |
| `"Pairing"` | the nonzero values on pairs of basis elements, in both orders |
| `"Degree"` | the degree $n$ of the pairing |
| `"Product"` | the nonzero products of pairs of basis elements, for a differential graded algebra |

- The basis elements are monomials: $1$, symbols, and products of powers of symbols. An element is a linear combination of them.
- A product such as `a b` is the name of one basis element, and its product with other elements is whatever *product* says.
- The pairing has degree $n$: $\langle V^i, V^j\rangle = 0$ unless $i + j = n$.
- The pairing is graded symmetric, $\langle y, x\rangle = (-1)^{|x||y|}\langle x, y\rangle$, and compatible with the differential, $\langle \mathrm{d}x, y\rangle = (-1)^{|x|+1}\langle x, \mathrm{d}y\rangle$.
- *pairing* needs each pair in one order only; the other order follows from graded symmetry.
- *product* likewise needs each pair in one order, and the other follows from graded commutativity. When $1$ is a basis element it is the unit.
- *orientation* is a basis element of degree $n$, meaning the value $1$ on it, or an Association of values on the basis of degree $n$.
- The result is a [Failure]() when the data do not satisfy the axioms, and when the values do not define an orientation.
- The axioms are the relations of the complex: [Relations]() names them, [Obstruction]() gives each one on elements, and [RelationsQ]() tests them all.
- A Sullivan model is infinite-dimensional, but its Poincaré duality and its Hodge type are decided in degrees $0$ to $n+1$.
- <code>[CochainComplexWithPairing]()[*model*]</code> divides out everything above degree $n+2$ and the monomials of degree $n+2$ that the image of the differential does not need. The quotient is a differential graded algebra, agrees with the model up to degree $n+1$ and has no cohomology above.
- <code>[CochainComplexWithPairing]()[*algebra*]</code> keeps the basis of the algebra, reads the differential off its matrix and the product off its triple products.

## Basic Examples

Example 6.1 of arXiv:2004.07362 with $k = 2$, a complex of degree $4$:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 1, 4: 1, of degree 4 -->

Its degree:

```wl
complex["Degree"]
```

<!-- => 4 -->

The pairing, in both orders:

```wl
complex["Pairing"]
```

<!-- => <|{1, v} -> 1, {db, a} -> -1, {b, b} -> 1, {b, da} -> 1, {v, 1} -> 1, {a, db} -> 1, {da, b} -> 1|> -->

The pairing is perfect on chain level:

```wl
PerfectPairingQ[complex]
```

<!-- => True -->

The paper shows the complex is not of Hodge type in characteristic $2$. Over $\mathbb{Q}$ it is:

```wl
HodgeTypeQ[complex]
```

<!-- => True -->

## Scope

The first algebra of Example 4.1 of arXiv:2609.14221, in degree $n = 3$, by structure constants: basis $1, a, b, \alpha, \beta, w$, products $a\alpha = b\beta = w$ and orientation $w$:

```wl
algebra = CochainComplexWithPairing[<|1 -> 0, a -> 1, b -> 1, alpha -> 2, beta -> 2, w -> 3|>, <||>,
   <|{a, alpha} -> w, {b, beta} -> w|>, w]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 2, 2: 2, 3: 1, of degree 3, with a product -->

The product in the other order, completed by graded commutativity:

```wl
algebra["Product"][{alpha, a}]
```

<!-- => w -->

The pairing it induces:

```wl
algebra["Pairing"][{alpha, a}]
```

<!-- => 1 -->

The pairing is perfect:

```wl
PerfectPairingQ[algebra]
```

<!-- => True -->

---

The second algebra of the same example has a differential, $\mathrm{d}c = ab$ and $\mathrm{d}\eta = \gamma$:

```wl
algebra = CochainComplexWithPairing[
   <|1 -> 0, a -> 1, b -> 1, c -> 1, a b -> 2, eta -> 2, alpha -> 3, beta -> 3, gamma -> 3, w -> 4|>,
   <|c -> a b, eta -> gamma|>,
   <|{a, b} -> a b, {a, alpha} -> w, {b, beta} -> w, {c, gamma} -> w, {a b, eta} -> w,
     {a, eta} -> -beta, {b, eta} -> alpha|>, w]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 3, 2: 2, 3: 3, 4: 1, of degree 4, with a product -->

It satisfies the axioms of a differential graded algebra with an invariant pairing:

```wl
RelationsQ[algebra]
```

<!-- => True -->

Its pairing is perfect on chain level:

```wl
PerfectPairingQ[algebra]
```

<!-- => True -->

It is perfect on cohomology as well:

```wl
PoincareDualityQ[algebra]
```

<!-- => True -->

---

The complex of the model of $\mathbb{CP}^2$ runs up to degree $6$:

```wl
complex = CochainComplexWithPairing[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 2: 1, 4: 1, 5: 1, 6: 1, of degree 4, with a product -->

Its basis, with the degrees:

```wl
complex["Degrees"]
```

<!-- => <|1 -> 0, a -> 2, a^2 -> 4, b -> 5, a^3 -> 6|> -->

In degree $6$ it keeps $a^3 = \mathrm{d}b$:

```wl
complex["Differential"][b]
```

<!-- => a^3 -->

It is of Hodge type, as the model is:

```wl
HodgeTypeQ[complex]
```

<!-- => True -->

---

The nondegenerate quotient of the Heisenberg nilmanifold as a complex:

```wl
complex = CochainComplexWithPairing[NondegenerateQuotient[SullivanModel["HeisenbergNilmanifold"]]]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 3, 2: 3, 3: 1, of degree 3, with a product -->

It keeps the differential of the algebra:

```wl
DeleteCases[complex["Differential"], 0]
```

<!-- => <|z -> x y|> -->

## Properties and Relations

Example 6.1 of arXiv:2004.07362:

```wl
complex = CochainComplexWithPairing[<|1 -> 0, a -> 1, da -> 2, b -> 2, db -> 3, v -> 4|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> 1|>]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 1: 1, 2: 2, 3: 1, 4: 1, of degree 4 -->

The axioms of a complex without a product, with their arities:

```wl
Relations[complex]
```

<!-- => <|"DifferentialDegree" -> 1, "DifferentialSquare" -> 1, "PairingDegree" -> 2, "GradedSymmetry" -> 2, "Compatibility" -> 2|> -->

They hold:

```wl
RelationsQ[complex]
```

<!-- => True -->

A changed differential with $\mathrm{d}(\mathrm{d}a) = \mathrm{d}b$:

```wl
changed = Append[complex, "Differential" -> Append[complex["Differential"], da -> db]]
```

<!-- => a CochainComplexWithPairing object like complex, with d da = db -->

It breaks the axioms:

```wl
RelationsQ[changed]
```

<!-- => False -->

The obstruction of $\mathrm{d}^2 = 0$ on $a$ is $\mathrm{d}b$:

```wl
Obstruction[changed, "DifferentialSquare", {a}]
```

<!-- => db -->

---

The complex of every catalogue model is a differential graded algebra with an invariant pairing:

```wl
AllTrue[{"Circle", "Sphere"[2], "ComplexProjectiveSpace"[3], "Torus"[3], "HeisenbergNilmanifold",
   "KodairaThurston", "Degree4Obstruction"},
  name |-> RelationsQ[CochainComplexWithPairing[SullivanModel[name]]]]
```

<!-- => True -->

---

The model of the Kodaira-Thurston nilmanifold:

```wl
model = SullivanModel["KodairaThurston"]
```

<!-- => a SullivanModel object with generators x, y, z, t of degree 1 and dz = x y, of degree 4 -->

The nondegenerate quotient of its complex is the complex of its quotient:

```wl
NondegenerateQuotient[CochainComplexWithPairing[model]] === CochainComplexWithPairing[NondegenerateQuotient[model]]
```

<!-- => True -->

---

The complex of a model has the model's Hodge type:

```wl
AllTrue[{"Sphere"[2], "ComplexProjectiveSpace"[3], "HeisenbergNilmanifold", "Degree4Obstruction"},
  name |-> HodgeTypeQ[SullivanModel[name]] === HodgeTypeQ[CochainComplexWithPairing[SullivanModel[name]]]]
```

<!-- => True -->

---

That includes the one catalogue model not of Hodge type:

```wl
HodgeTypeQ[CochainComplexWithPairing[SullivanModel["Degree4Obstruction"]]]
```

<!-- => False -->

## Possible Issues

The graded symmetry is part of the axioms. With $k = 3$ in Example 6.1, $b$ has odd degree and $\langle b, b\rangle = 1$ is impossible, so the result is a [Failure](), whose message says so:

```wl
CochainComplexWithPairing[<|1 -> 0, a -> 2, da -> 3, b -> 3, db -> 4, v -> 6|>,
   <|a -> da, b -> db|>, <|{v, 1} -> 1, {a, db} -> 1, {b, b} -> 1, {da, b} -> -1|>]["Message"]
```

<!-- => "The data do not satisfy the axioms of a cochain complex with a pairing." -->

---

The complex of the model of $\mathbb{CP}^2$:

```wl
complex = CochainComplexWithPairing[SullivanModel["ComplexProjectiveSpace"[2]]]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 2: 1, 4: 1, 5: 1, 6: 1, of degree 4, with a product -->

Truncating the model above degree $n+1$ instead makes $b$ closed:

```wl
truncated = CochainComplexWithPairing[KeyDrop[complex["Degrees"], a^3], <|b -> 0|>, complex["Pairing"]]
```

<!-- => a CochainComplexWithPairing object with dimensions 0: 1, 2: 1, 4: 1, 5: 1, of degree 4 -->

The complex of the model has Poincaré duality:

```wl
PoincareDualityQ[complex]
```

<!-- => True -->

The truncation does not, since the class of $b$ pairs with nothing:

```wl
PoincareDualityQ[truncated]
```

<!-- => False -->
