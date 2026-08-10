---
Template: Symbol
Name: $Relations
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/$Relations
Keywords: [relations, defining identities, registry, involutive bi-Lie algebra]
SeeAlso: [RelationFailures, Jacobi, CoJacobi, Drinfeld, Involutivity]
---

## Usage

[$Relations]() is the association of the defining identities of an involutive bi-Lie algebra, each carrying its arity and the function computing its obstruction.

## Details & Options

The keys are the names of the four identities; each value is an association with the keys `"Arity"` and `"Function"`.

| identity | arity | obstruction |
|---|---|---|
| `"Jacobi"` | $3$ | [Jacobi]() |
| `"CoJacobi"` | $1$ | [CoJacobi]() |
| `"Drinfeld"` | $2$ | [Drinfeld]() |
| `"Involutivity"` | $1$ | [Involutivity]() |

The arity is the number of cyclic words the obstruction takes before the pairing object, and it is what [RelationFailures]() uses to build the tuples it sweeps.

[$Relations]() is a plain value, not a held registry: adding an entry to a copy of it is enough to sweep an identity of one's own with [RelationFailures](), provided the function follows the same calling convention of *arity* words followed by the pairing object.

## Basic Examples

The four identities:

```wl
Keys[$Relations]
```

<!-- => {"Jacobi", "CoJacobi", "Drinfeld", "Involutivity"} -->

---

Their arities:

```wl
Normal[Map[#["Arity"] &, $Relations]]
```

<!-- => {"Jacobi" -> 3, "CoJacobi" -> 1, "Drinfeld" -> 2, "Involutivity" -> 1} -->

---

The obstruction function of one of them:

```wl
$Relations["Jacobi"]["Function"]
```

<!-- => Jacobi -->

## Scope

Each entry can be applied directly, arity words then the pairing object:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
$Relations["CoJacobi"]["Function"][CyclicWord[{x, y, y, y}], pairing]
```

<!-- => 0 -->

---

Sweeping all four at once over the same range:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[# -> RelationFailures[#, pairing, 3] &, Keys[$Relations]]
```

<!-- => {"Jacobi" -> {}, "CoJacobi" -> {}, "Drinfeld" -> {}, "Involutivity" -> {}} -->

## Properties and Relations

[RelationFailures]() reads both fields of the entry it is given — the arity to build the tuples, the function to evaluate them:

```wl
Normal[Map[Keys, $Relations]]
```

<!-- => {"Jacobi" -> {"Arity", "Function"}, …} -->
