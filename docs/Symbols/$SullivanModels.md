---
Template: Symbol
Name: $SullivanModels
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/$SullivanModels
Keywords: [catalogue, Sullivan model, minimal model]
SeeAlso: [SullivanModel, HodgeTypeQ, NondegenerateQuotient]
RelatedGuides: [SullivanModels]
---

## Usage

<code>[$SullivanModels]()</code> is the list of the names of the catalogue models that [SullivanModel]() gives.

<!-- #| annotation: 26.09.30: Design review - the catalogue is a list of strings, and a name that takes a parameter is used with the parameter as its argument, as in "Sphere"[4], so the list itself holds names only and SullivanModel matches the parameter in the name. The names are the full English names of the spaces, as the naming rule of the paclet asks. The symbol is a global list and so carries the $ of a global parameter; no alternative name was recorded. Prior art: the Wolfram Language has no catalogue of spaces or of their rational models. The engine the verification suites load keeps the same nine names in its own list, and the suites compare the models of this catalogue with the engine's. -->

## Details & Options

- A name that takes a parameter is used as *name*[*k*]:

| Name | Model | Degree |
|---|---|---|
| `"Circle"` | $\Lambda(v)$, $\lvert v\rvert = 1$ | $1$ |
| `"Sphere"[m]` | $\Lambda(v)$ for odd $m$; $\Lambda(v,w)$ with $\mathrm{d}w = v^2$ for even $m$ | $m$ |
| `"ComplexProjectiveSpace"[m]` | $\Lambda(a,b)$, $\lvert a\rvert = 2$, $\mathrm{d}b = a^{m+1}$ | $2m$ |
| `"QuaternionicProjectiveSpace"[m]` | $\Lambda(a,b)$, $\lvert a\rvert = 4$, $\mathrm{d}b = a^{m+1}$ | $4m$ |
| `"Torus"[k]` | $\Lambda(v_1,\dots,v_k)$ in degree $1$, zero differential | $k$ |
| `"SpecialUnitaryGroup"[m]` | $\Lambda(h_3,h_5,\dots,h_{2m-1})$, zero differential | $m^2-1$ |
| `"HeisenbergNilmanifold"` | $\Lambda(x,y,z)$ in degree $1$, $\mathrm{d}z = xy$ | $3$ |
| `"KodairaThurston"` | $\Lambda(x,y,z,t)$ in degree $1$, $\mathrm{d}z = xy$ | $4$ |
| `"Degree4Obstruction"` | $\Lambda(a,c)$, $\lvert a\rvert = 2$, $\mathrm{d}a = c$, truncated above degree $4$ | $4$ |

- The parameter is at least $1$, and at least $2$ for `"SpecialUnitaryGroup"`.
- Each model carries its orientation: the product of the odd generators for an exterior algebra, and the power of $a$ or $v$ of top degree otherwise.
- `"Degree4Obstruction"` is Example 6.3 of [arXiv:2004.07362](https://arxiv.org/abs/2004.07362), a $1$-connected PDGA of degree $4$ that admits no Hodge decomposition. All the other models are of Hodge type.

## Basic Examples

The names of the catalogue:

```wl
$SullivanModels
```

<!-- => {"Circle", "Sphere", "ComplexProjectiveSpace", "QuaternionicProjectiveSpace", "Torus", "SpecialUnitaryGroup", "HeisenbergNilmanifold", "KodairaThurston", "Degree4Obstruction"} -->

---

The degree of each model, with the parameter taken to be $3$:

```wl
(name |-> name -> SullivanModel[name]["Degree"]) /@ {"Circle", "Sphere"[3], "ComplexProjectiveSpace"[3], "QuaternionicProjectiveSpace"[3], "Torus"[3], "SpecialUnitaryGroup"[3], "HeisenbergNilmanifold", "KodairaThurston", "Degree4Obstruction"}
```

<!-- => {"Circle" -> 1, "Sphere"[3] -> 3, "ComplexProjectiveSpace"[3] -> 6, "QuaternionicProjectiveSpace"[3] -> 12, "Torus"[3] -> 3, "SpecialUnitaryGroup"[3] -> 8, "HeisenbergNilmanifold" -> 3, "KodairaThurston" -> 4, "Degree4Obstruction" -> 4} -->

## Scope

The model of the three-torus is an exterior algebra on three generators of degree $1$:

```wl
SullivanModel["Torus"[3]]["Generators"]
```

<!-- => <|v1 -> 1, v2 -> 1, v3 -> 1|> -->

---

The model of $SU(3)$ has generators in degrees $3$ and $5$:

```wl
SullivanModel["SpecialUnitaryGroup"[3]]["Generators"]
```

<!-- => <|h3 -> 3, h5 -> 5|> -->

---

An even sphere needs a second generator, which kills the square of the first:

```wl
SullivanModel["Sphere"[2]]["Differential"]
```

<!-- => <|v -> 0, w -> v^2|> -->

## Properties and Relations

The models of the catalogue but the last are of Hodge type:

```wl
AllTrue[{"Circle", "Sphere"[4], "ComplexProjectiveSpace"[2], "Torus"[3], "HeisenbergNilmanifold", "KodairaThurston"}, name |-> HodgeTypeQ[SullivanModel[name]]]
```

<!-- => True -->

---

The last one is not:

```wl
HodgeTypeQ[SullivanModel["Degree4Obstruction"]]
```

<!-- => False -->

---

Every model of the catalogue satisfies Poincaré duality:

```wl
AllTrue[{"Circle", "Sphere"[4], "ComplexProjectiveSpace"[2], "Torus"[3], "HeisenbergNilmanifold", "KodairaThurston", "Degree4Obstruction"}, name |-> PoincareDualityQ[SullivanModel[name]]]
```

<!-- => True -->

## Possible Issues

A name that takes a parameter returns unevaluated without it:

```wl
SullivanModel["Sphere"]
```

<!-- => SullivanModel["Sphere"] -->
