# 🌀 Chern-Simons Theory

This Wolfram Language paclet makes parts of the Chern-Simons theory studied in the following papers computable.

- Cieliebak, Fukaya, Latschev, *Homological algebra related to surfaces with boundary*, [arXiv:1508.02741](https://arxiv.org/abs/1508.02741), 2015
- Hájek, *Twisted IBL-infinity-algebra and string topology: first look and examples*, [arXiv:1811.05281](https://arxiv.org/abs/1811.05281), 2018
- Hájek, *IBL-infinity model of string topology from perturbative Chern-Simons theory*, [arXiv:2003.07933](https://arxiv.org/abs/2003.07933), 2020
- Cieliebak, Hájek, Volkov, *Chain-level equivariant string topology: algebra versus analysis*, [arXiv:2202.06837](https://arxiv.org/abs/2202.06837), 2022
- Cieliebak, Volkov, *Chern-Simons theory and string topology*, [arXiv:2312.05922](https://arxiv.org/abs/2312.05922), 2023
- Cieliebak, Volkov, *String topology operations under Chen's iterated integrals and homotopy transfer*, [arXiv:2607.03782](https://arxiv.org/abs/2607.03782), 2026

It is based on the original implementation of the canonical IBL algebra in *Algebraic Model of String Operations*, [Wolfram Notebook Archive 2024](https://notebookarchive.org/2024-07-6ij9go2).

The theory is the large-n limit of U(n) Chern-Simons theory on a closed oriented manifold.
Its action is a Beilinson-Drinfeld action on cyclic words of the de Rham cohomology, equivalently a Maurer-Cartan element of an IBL∞-algebra.
It is related to string topology and to symplectic field theory.
One can imagine it as the open part of an open-closed string field theory of holomorphic curves in a cotangent bundle, the closed part being the symplectic field theory of the unit cotangent bundle.

## 🎯 Goals

- 🗺️ Map of the computational boundary of the theory.
- 🤖 Computational API for LLM agents to verify papers.
- 🧪 Finite set verification of axiomatic formalization.
- 🧵 String topology computations.

## ⚙️ Installation

Runs on the [Wolfram Engine](https://www.wolfram.com/engine/), which is freely available.
For a human interface, either buy [Mathematica](https://www.wolfram.com/mathematica/) or run it from the terminal via [wolframscript](https://www.wolfram.com/wolframscript/), from [Jupyter](https://github.com/WolframResearch/WolframLanguageForJupyter), or in chat in [VS Code](https://marketplace.visualstudio.com/items?itemName=WolframResearch.wolfram).

Install the development version of the paclet:

```wl
PacletInstall["https://www.wolframcloud.com/obj/hajek_pavel/s1paper/ChernSimons.paclet",
  ForceVersionInstall -> True]
Needs["ChernSimons`"]
```

List the symbols and follow the documentation:

```wl
?ChernSimons`*
```

Example for the circle:

```wl
circle = SullivanModel["Circle"];
HodgeTypeQ[circle]
pairing = GradedPairing[NondegenerateQuotient[circle], {x, y}];
CanonicalMaurerCartan[pairing]
InvolutiveBracket[CyclicWord[{x, x, x}], CyclicWord[{y, y}], pairing]
```

## 📜 Licence

[MIT](https://opensource.org/license/mit) for the code.
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) for the mathematics and the ideas.
