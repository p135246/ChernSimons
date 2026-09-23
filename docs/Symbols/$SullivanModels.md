---
Template: Symbol
Name: $SullivanModels
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/$SullivanModels
Keywords: [catalogue, Sullivan model, minimal model]
SeeAlso: [SullivanModel, HodgeTypeQ, NondegenerateQuotient]
RelatedGuides: [ChernSimons]
---

## Usage

<code>[$SullivanModels]()</code> is the list of catalogue names [SullivanModel]() accepts.

## Details & Options

A name taking a parameter is used as *name*[*k*]:

| name | model | degree |
|---|---|---|
| `"Circle"` | $\Lambda(v)$, $\lvert v\rvert = 1$ | $1$ |
| `"Sphere"[m]` | $\Lambda(v)$ for odd $m$; $\Lambda(v,w)$ with $\mathrm{d}w = v^2$ for even $m$ | $m$ |
| `"ComplexProjectiveSpace"[m]` | $\Lambda(a,b)$, $\lvert a\rvert = 2$, $\mathrm{d}b = a^{m+1}$ | $2m$ |
| `"QuaternionicProjectiveSpace"[m]` | $\Lambda(a,b)$, $\lvert a\rvert = 4$, $\mathrm{d}b = a^{m+1}$ | $4m$ |
| `"Torus"[k]` | $\Lambda(v_1,\dots,v_k)$ in degree $1$, zero differential | $k$ |
| `"SpecialUnitaryGroup"[m]` | $\Lambda(h_3,h_5,\dots,h_{2m-1})$, zero differential | $m^2-1$ |
| `"HeisenbergNilmanifold"` | $\Lambda(x,y,z)$ in degree $1$, $\mathrm{d}z = xy$ | $3$ |
| `"KodairaThurston"` | $\Lambda(x,y,z,t)$ in degree $1$, $\mathrm{d}z = xy$ | $4$ |
| `"Degree4Obstruction"` | $\Lambda(a,c)$, $\mathrm{d}a = c$, truncated above degree $4$ | $4$ |

All of them are of Hodge type except the last, which is Example 6.3 of [arXiv:2004.07362](https://arxiv.org/abs/2004.07362) — a $1$-connected PDGA of degree $4$ that admits no Hodge decomposition.

## Basic Examples

```wl
$SullivanModels
```

<!-- => {Circle, Sphere, ComplexProjectiveSpace, QuaternionicProjectiveSpace, Torus, SpecialUnitaryGroup, HeisenbergNilmanifold, KodairaThurston, Degree4Obstruction} -->

---

The degree of each, with the parametrised ones taken at $m = 3$:

```wl
Map[name |-> name -> SullivanModel[name]["Degree"],
  {"Circle", "Sphere"[3], "ComplexProjectiveSpace"[3], "QuaternionicProjectiveSpace"[3],
   "Torus"[3], "SpecialUnitaryGroup"[3], "HeisenbergNilmanifold", "KodairaThurston",
   "Degree4Obstruction"}]
```

## Properties and Relations

Every name but the last gives a model of Hodge type:

```wl
Map[name |-> name -> HodgeTypeQ[SullivanModel[name]],
  {"Circle", "Sphere"[4], "ComplexProjectiveSpace"[2], "KodairaThurston", "Degree4Obstruction"}]
```
