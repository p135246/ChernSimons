# IBLInfinity

Involutive bi-Lie infinity structures on cyclic words: the exterior and symmetric conventions, the shift isomorphisms between them, the bracket and co-bracket, the pairings, and the defining identities.

The graded alphabet is **data, not global state**. `Pairing[degrees, spec]` returns a plain `Association`, and every operation takes it as its last argument — so nothing here is tied to the circle.

## Installation

The repository is private, so `PacletInstall` cannot fetch it by URL. Either install the built archive:

```wolfram
PacletInstall["/path/to/IBLInfinity/build/IBLInfinity-0.3.0.paclet"]
```

or load a clone in place, without installing:

```wolfram
PacletDirectoryLoad["/path/to"]   (* the directory *containing* IBLInfinity/ *)
```

Then:

```wolfram
Needs["IBLInfinity`"]
```

## Usage

Build the pairing object once and pass it to everything. The alphabet of the circle is a degree −1 particle `x`, a degree 0 particle `y`, and the single value ⟨x, y⟩ = 1; the rest is completed by graded antisymmetry.

```wolfram
Needs["IBLInfinity`"]

pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];

Normal[pairing]
(* {"Degrees" -> <|x -> -1, y -> 0|>,
    "Values" -> <|{x, x} -> 0, {x, y} -> 1, {y, x} -> -1, {y, y} -> 0|>,
    "Degree" -> -1, "Convention" -> "Symmetric"} *)
```

Words are cyclic. The two-argument `CyclicWord` normalizes to the canonical rotation with its Koszul sign, and gives `0` on a word that a rotation sends to minus itself; `CyclicWords` enumerates a basis.

```wolfram
CyclicWord[{y, x}, pairing]        (* CyclicWord[{x, y}] *)
CyclicWord[{x, x}, pairing]        (* 0 *)
CyclicWords[3, pairing]            (* the four cyclic words of length 3 *)
CyclicWords[3, pairing, "UpTo" -> True]

{WordDegree[{x, y}, pairing],
 WordDegree[{x, y}, pairing, "Exterior"],
 WordDegree[{x, y}, pairing, "Symmetric"]}     (* {-1, -2, -3} *)
```

The bracket and the co-bracket, and their extensions as a derivation and a co-derivation to products:

```wolfram
Bracket[CyclicWord[{x}], CyclicWord[{x, y}], pairing]
(* -CyclicWord[{x}] *)

Cobracket[CyclicWord[{x, y, y, y}], pairing]
(* -SymmetricProduct[CyclicWord[{y}], CyclicWord[{y}]] *)

Bracket[SymmetricProduct[CyclicWord[{x}], CyclicWord[{x, y}], pairing], pairing]
(* -SymmetricProduct[CyclicWord[{x}]] *)
```

Switch pictures by resetting one key. `"Symmetric"` grades by [−]₁ = [−] − 1 and multiplies with `SymmetricProduct`; `"Exterior"` grades by [−] and uses `ExteriorProduct`. `ShiftIsomorphism` carries one to the other — the default reversal rule is the convention that intertwines the bracket and the co-bracket in every arity.

```wolfram
exterior = Append[pairing, "Convention" -> "Exterior"];

Cobracket[CyclicWord[{x, y, y, y}], exterior]
(* ExteriorProduct[CyclicWord[{y}], CyclicWord[{y}]] *)

ShiftIsomorphism[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], pairing], pairing]
(* ExteriorProduct[CyclicWord[{x}], CyclicWord[{y}]] *)
```

The four defining identities, one obstruction function each — `0` means the identity holds there. `RelationFailures` sweeps one over every tuple of words up to a given length and returns the counterexamples.

```wolfram
Keys[$Relations]
(* {"Jacobi", "CoJacobi", "Drinfeld", "Involutivity"} *)

Map[# -> RelationFailures[#, pairing, 3] &, Keys[$Relations]]
(* all four empty — the identities hold on every tuple of words of length <= 3 *)
```

An empty list is a **truncated** statement: it says the identity holds out to that length and nothing beyond it.

A dual alphabet is attached with the four-argument `Pairing`, and unlocks `DualPairing` and `ProductPairing`:

```wolfram
dual = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>,
               <|a -> -1, b -> 0|>, <|{x, a} -> 1, {y, b} -> 1|>];

DualPairing[CyclicWord[{x, y}], CyclicWord[{a, b}], dual]   (* 1 *)
DualPairing[CyclicWord[{y, y}], CyclicWord[{b, b}], dual]   (* 2 *)

ProductPairing[SymmetricProduct[CyclicWord[{x}], CyclicWord[{y}], dual],
               SymmetricProduct[CyclicWord[{a}], CyclicWord[{b}], dual], dual]   (* 1/2 *)
```

Nothing is specific to the circle — particles are arbitrary expressions, and multi-character names work:

```wolfram
p2 = Pairing[<|alpha -> -1, beta -> 0, gamma -> -1|>,
             <|{alpha, beta} -> 1, {gamma, beta} -> 1|>];

Bracket[CyclicWord[{alpha}], CyclicWord[{alpha, beta}], p2]   (* -CyclicWord[{alpha}] *)
```

### Known issue

The derivation and co-derivation extensions are **not linear in their first argument**. `Bracket[p, pairing]` and `Cobracket[p, pairing]` match a bare product, not `c p` for a scalar `c` — and the products themselves return a sign whenever their factors need reordering. So `Cobracket[c p, pairing]` falls through to the one-word rule and returns an unreduced internal symbol *with no message*, and `Bracket[c p, pairing]` comes back unevaluated. Divide the coefficient out, map over the terms of a sum, and multiply back:

```wolfram
p = SymmetricProduct[CyclicWord[{y}], CyclicWord[{x, y, y, y}], pairing];

Cobracket[-p, pairing] === -Cobracket[p, pairing]   (* False *)
-Cobracket[p, pairing]                              (* the right answer *)
```

## Two contexts

- `` Needs["IBLInfinity`"] `` — the eighteen curated exports used above.
- `` Needs["IBLInfinity`Engine`"] `` — the raw engine underneath (`cyc`, `q210Odot`, `bvDelta`, `ainftyM`, `gaugeFlow`, `$letterDegrees`, …), which also carries the BV, A∞ and gauge layers that the curated API does not cover.

## Documentation

Every export has a real reference page, so `?Pairing`, F1 and Documentation Center search work once the paclet is installed:

```wolfram
Documentation`ResolveLink["paclet:IBLInfinity/ref/Pairing"]
```

The pages are generated one-way from `docs/Symbols/*.md` — **edit the Markdown, never the `.nb`**:

```bash
wolframscript -file BuildDocs.wls            # pages whose source is newer
wolframscript -file BuildDocs.wls Pairing    # named pages
wolframscript -file BuildDocs.wls --all      # everything
```

The build needs a clone of [WolframInstitute/MarkdownToNotebook](https://github.com/WolframInstitute/MarkdownToNotebook) at the parent of this directory. Every example cell is evaluated at build time and its real output spliced into the page, so a page is not finished until the built `.nb` has been read back.

## Building the archive

```wolfram
CreatePacletArchive["/path/to/IBLInfinity"]
```

`build/IBLInfinity-0.3.0.paclet` is the current build (192 kB, 57 files, documentation bundled).

## Provenance

This repository is a **snapshot**. The source of truth is `FromLLM/IBLInfinity/` in the private `s1paper` repository (Cieliebak–Hájek, the Chern–Simons IBL∞ algebra of S¹), where the paclet is pinned by a test suite of 325 `VerificationTest`s — `T12` for the API, `T16` for the documentation tree. `Engine/` there is a synced copy of `FromLLM/Kernel/*.wl`, refreshed by `SyncEngine.wls`.

Two scripts here only work inside that repository and are kept for fidelity: `SyncEngine.wls` (reads `../Kernel/`) and `Publish.wls` (uploads to a Wolfram Cloud path under `hajek_pavel`, and does **not** stage `Documentation/`).

## License

MIT — see [LICENSE](LICENSE).
