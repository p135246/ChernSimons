---
Template: Symbol
Name: CanonicalMaurerCartan
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/CanonicalMaurerCartan
Keywords: [canonical Maurer-Cartan element, triple product, reversal sign, Hochschild differential]
SeeAlso: [MaurerCartanQ, MaurerCartanEquation, NondegenerateQuotient, GradedPairing, TwistedDifferential, PlanckDegree]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[CanonicalMaurerCartan]()[*pairing*]</code> is the canonical Maurer-Cartan element of the dIBL algebra of a Poincaré duality algebra.

## Details & Options

The triple product of a Poincaré duality algebra $(H,\mathcal{O})$ of degree $n$ is a cyclic three-cochain on $H[1]$, hence an element of the cyclic words of length three. In a basis $(e_i)$ it reads

$$\mathfrak{m}^{\mathrm{can}}_{1,0} = (-1)^{n-2}\frac{1}{3}\sum_{i,j,k} \pm\,(-1)^{\deg e_j}\,\mathcal{O}(e_i\cdot e_j\cdot e_k)\; e^ie^je^k,$$

with $\pm$ the reversal sign $(-1)^{\lvert e^k\rvert(\lvert e^i\rvert+\lvert e^j\rvert)+\lvert e^j\rvert\lvert e^i\rvert}$. The summand is invariant under cyclic rotation, so each cyclic word is produced three times and the $\tfrac13$ is exact.

*pairing* must carry an `"Algebra"` key, which <code>[GradedPairing]()[*algebra*]</code> supplies; without one the function issues `GradedPairing::algebra` and aborts.

This is the first recipe in the paclet that *produces* a Maurer-Cartan element rather than taking one as given. The geometric recipe — ribbon graphs, their combinatorial coefficients and the configuration-space integrals — is still not implemented; what is implemented is the algebraic element of a Poincaré duality algebra.

The element carries only the product. When the algebra has a nonzero differential the canonical dIBL structure of a cyclic cochain complex carries it in $\mathfrak{q}_{1,1,0}$, which the engine does not have; see [NondegenerateQuotient]().

## Basic Examples

The alphabet of the circle, and the element $x^2y$ the paper's Section 2 starts from:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}];
CanonicalMaurerCartan[pairing]
```

<!-- => CyclicWord[{x, x, y}] -->

---

It solves the Maurer-Cartan equation. On a word of length three the equation reduces to $\mathfrak{q}_{2,1,0}(\mathfrak{m}\odot\mathfrak{m}) = 0$, which is associativity in these coordinates.

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}];
MaurerCartanQ[CanonicalMaurerCartan[pairing], pairing]
```

<!-- => True -->

---

For $\mathbb{CP}^2$ there are two cyclic words, with the default particles being the basis monomials:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]];
CanonicalMaurerCartan[pairing]
```

<!-- => -CyclicWord[{1, 1, a^2}] - CyclicWord[{1, a, a}] -->

## Scope

The particles can be named anything; the element is the same up to the relabelling:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]], {e0, e1, e2}];
CanonicalMaurerCartan[pairing]
```

<!-- => -CyclicWord[{e0, e0, e2}] - CyclicWord[{e0, e1, e1}] -->

---

It solves the Maurer-Cartan equation for every model in the catalogue, including the two whose quotient carries a differential:

```wl
Map[name |-> name -> With[{pr = GradedPairing[NondegenerateQuotient[SullivanModel[name]]]},
    MaurerCartanQ[CanonicalMaurerCartan[pr], pr]],
  {"Sphere"[3], "ComplexProjectiveSpace"[3], "QuaternionicProjectiveSpace"[2],
   "Torus"[3], "SpecialUnitaryGroup"[3], "HeisenbergNilmanifold", "KodairaThurston"}]
```

## Properties and Relations

Its symmetric degree is $2(n-3)$, which is [PlanckDegree]() — the degree of $\HBar$, and so of a BD action:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["ComplexProjectiveSpace"[2]]]];
{WordDegree[CyclicWord[{1, 1, a^2}], pairing, "Symmetric"], PlanckDegree[pairing]}
```

<!-- => {2, 2} -->

---

Twisting $\mathfrak{q}_{2,1,0}$ by it gives the dual of the cyclic Hochschild differential. On the circle that operator inserts one letter $x$, and vanishes on a word with an even number of them:

```wl
pairing = GradedPairing[NondegenerateQuotient[SullivanModel["Circle"]], {x, y}];
m = CanonicalMaurerCartan[pairing];
{TwistedDifferential[m, CyclicWord[{x, y, y}], pairing],
 TwistedDifferential[m, CyclicWord[{x, x, y}], pairing]}
```

<!-- => {CyclicWord[{x, x, y, y}], 0} -->

## Possible Issues

A pairing object built from degrees and values carries no algebra, so there is no triple product to read, and [CanonicalMaurerCartan]() aborts on it with `GradedPairing::algebra`. Check for the key before evaluating.

```wl
KeyExistsQ[GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Algebra"]
```

<!-- => False -->
