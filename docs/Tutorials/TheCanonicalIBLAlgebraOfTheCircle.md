---
Template: TechNote
Name: TheCanonicalIBLAlgebraOfTheCircle
Title: The Canonical IBL Algebra of the Circle
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/tutorial/TheCanonicalIBLAlgebraOfTheCircle
Keywords: [circle, canonical Maurer-Cartan element, Hochschild differential, cyclic words, alphabet, x squared y]
RelatedGuides: [ChernSimons]
RelatedTutorials: [FromASullivanModelToAnIBLAlgebra, HodgeTypeAndTheNondegenerateQuotient]
---

The alphabet the rest of this paclet is written against — a particle $x$ of degree $-1$, a particle $y$ of degree $0$, and the single pairing value $\langle x,y\rangle = 1$ — is not an arbitrary choice of example. It is what the construction of the companion tutorial produces when it is fed the minimal model of $S^1$. This tutorial runs it, and then checks the three facts about the circle that the paper's Section 2 proves.

## The model of the circle

$H^*(S^1)$ is free on one generator of degree $1$, so the minimal model is $\Lambda(v)$ with $|v| = 1$ and zero differential. Since $|v|$ is odd, $v^2 = 0$, and the algebra is two-dimensional to begin with.

```wl
circle = SullivanModel["Circle"];
{Normal[circle["Generators"]], circle["Volume"], circle["Degree"]}
```

<!-- => {{v -> 1}, {v}, 1} -->

```wl
Table[SullivanModelBasis[circle, k], {k, 0, 3}]
```

<!-- => {{1}, {v}, {}, {}} -->

The volume form is $v$ itself, so the orientation is "the coefficient of $v$" — on the circle, integration. The pairing $\langle v_1,v_2\rangle = \mathcal{O}(v_1v_2)$ is already perfect: nothing is degenerate, and the model is its own nondegenerate quotient.

```wl
quotient = NondegenerateQuotient[circle];
{quotient["Basis"], quotient["Degrees"], quotient["Pairing"]}
```

<!-- => {{1, v}, {0, 1}, {{0, 1}, {1, 0}}} -->

```wl
HodgeTypeQ[circle]
```

<!-- => True -->

## The alphabet, named

Shifting down by one and naming the two basis vectors $x$ and $y$ gives the alphabet. The shift turns the graded symmetric pairing of degree $1$ into a graded antisymmetric pairing of degree $-1$, which is $n-2$.

```wl
pairing = GradedPairing[quotient, {x, y}];
{Normal[pairing["Degrees"]], pairing["Degree"]}
```

<!-- => {{x -> -1, y -> 0}, -1} -->

```wl
Normal[pairing["Values"]]
```

<!-- => {{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0} -->

This is the running example of every reference page in the paclet, on the nose:

```wl
KeyDrop[pairing, "Algebra"] === GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>]
```

<!-- => True -->

The one thing the derived object carries that the hand-written one does not is the algebra it came from, under the key `"Algebra"`; that is what lets [CanonicalMaurerCartan]() work from it.

## The element $x^2y$

The triple product of the two-dimensional algebra has one value up to symmetry, $\mathcal{O}(1\cdot 1\cdot v) = 1$, so the canonical Maurer-Cartan element is a single cyclic word of length three.

```wl
m = CanonicalMaurerCartan[pairing]
```

<!-- => CyclicWord[{x, x, y}] -->

That is $\mathfrak{m}^{\mathrm{can}}_{1,0} = x^2y$, coefficient and all — the element the paper's Section 2 starts from. The general formula sums over all $3^3$ index triples with the reversal sign and a factor $\tfrac13$; here three of them are nonzero, they agree after the cyclic rotations are normalised, and the $\tfrac13$ cancels.

```wl
MaurerCartanQ[m, pairing]
```

<!-- => True -->

## The three facts

**The Hochschild differential.** Twisting $\mathfrak{q}_{2,1,0}$ by $\mathfrak{m}^{\mathrm{can}}$ gives $\mathfrak{q}^{\mathfrak{m}}_{1,1,0} = \mathrm{H}d^*$, which inserts one letter $x$: on the words $x^ay^b$ it is $x^{a+1}y^b$ for $a$ odd and $0$ for $a$ even.

```wl
{TwistedDifferential[m, CyclicWord[{x, y, y}], pairing],
 TwistedDifferential[m, CyclicWord[{x, x, x, y}], pairing]}
```

<!-- => {CyclicWord[{x, x, y, y}], CyclicWord[{x, x, x, x, y}]} -->

```wl
{TwistedDifferential[m, CyclicWord[{x, x, y}], pairing],
 TwistedDifferential[m, CyclicWord[{x, x, x, x, y}], pairing]}
```

<!-- => {0, 0} -->

**The bracket.** $\mathfrak{q}_{2,1,0}(x^a\odot y^b) = -ab\,x^{a-1}y^{b-1}$, the deleted pair always being one $x$ and one $y$:

```wl
InvolutiveBracket[CyclicWord[{x, x, x}], CyclicWord[{y, y}], pairing]
```

<!-- => -6 CyclicWord[{x, x, y}] -->

**The co-bracket.** $\mathfrak{q}_{1,2,0}(xy^k) = -\sum_{i+j=k-1,\ i,j\ge 1} y^i\odot y^j$, so on $xy^4$ the two ordered pairs $(1,2)$ and $(2,1)$ give the same symmetric monomial twice:

```wl
InvolutiveCobracket[CyclicWord[{x, y, y, y, y}], pairing]
```

<!-- => -2 SymmetricProduct[CyclicWord[{y}], CyclicWord[{y, y}]] -->

Everything past this point — the Chern-Simons Maurer-Cartan element, the Bernoulli numbers, the gauge invariant $\rho_{1,1} = -1/24$ — happens inside this alphabet, and is what the rest of the paclet computes.
