---
Template: Symbol
Name: $DefiningIdentities
Context: ChernSimons`
Paclet: ChernSimons
URI: ChernSimons/ref/$DefiningIdentities
Keywords: [relations, defining identities, registry, involutive bi-Lie algebra]
SeeAlso: [JacobiObstruction, CoJacobiObstruction, DrinfeldObstruction, InvolutivityObstruction]
RelatedGuides: [ChernSimons]
---

## Usage

[$DefiningIdentities]() is the association of the defining identities of an involutive bi-Lie algebra, each carrying its arity and the function computing its obstruction.

## Details & Options

The keys are the names of the four identities; each value is an association with the keys `"Arity"` and `"Function"`.

| identity | arity | obstruction |
|---|---|---|
| `"JacobiObstruction"` | $3$ | [JacobiObstruction]() |
| `"CoJacobiObstruction"` | $1$ | [CoJacobiObstruction]() |
| `"DrinfeldObstruction"` | $2$ | [DrinfeldObstruction]() |
| `"InvolutivityObstruction"` | $1$ | [InvolutivityObstruction]() |

The arity is the number of cyclic words the obstruction takes before the pairing object, and it is what a sweep uses to build its tuples.

[$DefiningIdentities]() is a plain value, not a held registry: adding an entry to a copy of it is enough to sweep an identity of one's own, provided the function follows the same calling convention of *arity* words followed by the pairing object.

## Basic Examples

The four identities:

```wl
Keys[$DefiningIdentities]
```

<!-- => {"JacobiObstruction", "CoJacobiObstruction", "DrinfeldObstruction", "InvolutivityObstruction"} -->

---

Their arities:

```wl
Normal[Map[#["Arity"] &, $DefiningIdentities]]
```

<!-- => {"JacobiObstruction" -> 3, "CoJacobiObstruction" -> 1, "DrinfeldObstruction" -> 2, "InvolutivityObstruction" -> 1} -->

---

The obstruction function of one of them:

```wl
$DefiningIdentities["JacobiObstruction"]["Function"]
```

<!-- => JacobiObstruction -->

## Scope

Each entry can be applied directly, arity words then the pairing object:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
$DefiningIdentities["CoJacobiObstruction"]["Function"][CyclicWord[{x, y, y, y}], pairing]
```

<!-- => 0 -->

---

Sweeping all four at once over the same range:

```wl
pairing = GradedPairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Normal[Map[e |-> DeleteDuplicates[Map[t |-> Expand[e["Function"] @@ Append[t, pairing]],
   Tuples[CyclicWords[3, pairing, "UpTo" -> True], e["Arity"]]]], $DefiningIdentities]]
```

<!-- => {"JacobiObstruction" -> {0}, "CoJacobiObstruction" -> {0}, "DrinfeldObstruction" -> {0}, "InvolutivityObstruction" -> {0}} -->

## Properties and Relations

A sweep reads both fields of the entry it is given: the arity to build the tuples, the function to evaluate them:

```wl
Normal[Map[Keys, $DefiningIdentities]]
```

<!-- => {"JacobiObstruction" -> {"Arity", "Function"}, …} -->
