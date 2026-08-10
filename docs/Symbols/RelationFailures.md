---
Template: Symbol
Name: RelationFailures
Context: IBLInfinity`
Paclet: IBLInfinity
URI: IBLInfinity/ref/RelationFailures
Keywords: [relation failures, verification, truncation, defining identities, counterexample]
SeeAlso: [$Relations, Jacobi, CoJacobi, Drinfeld, Involutivity, CyclicWords, Pairing]
---

## Usage

<code>[RelationFailures]()[*name*, *pairing*, *n*]</code> returns the tuples of cyclic words of length at most *n* on which the named identity fails. An empty list means it holds throughout the range.

## Details & Options

*name* is one of the keys of [$Relations]() — `"Jacobi"`, `"CoJacobi"`, `"Drinfeld"` or `"Involutivity"`.

The sweep runs over <code>[CyclicWords]()[*n*, *pairing*, "UpTo" -> True]</code>, taking tuples of the arity the entry records, and keeps those whose obstruction does not expand to $0$.

The convention key of *pairing* selects the picture, so an identity can be checked in the symmetric and the exterior picture separately.

**The empty list is a truncated statement, not a proof.** It says the identity holds on every tuple of words of length at most *n*, and says nothing beyond that range. Any claim resting on it must state the *n* it was checked at.

The cost grows quickly: the number of tuples is the number of words up to length *n* raised to the arity, so `"Jacobi"` at arity $3$ is the expensive one.

## Basic Examples

The Jacobi identity holds on every triple of words of length at most $3$:

```wl
RelationFailures["Jacobi", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 3]
```

<!-- => {} -->

---

So does involutivity, out to length $5$:

```wl
RelationFailures["Involutivity", Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], 5]
```

<!-- => {} -->

---

All four identities over the same range:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[# -> RelationFailures[#, pairing, 3] &, Keys[$Relations]]
```

<!-- => {"Jacobi" -> {}, "CoJacobi" -> {}, "Drinfeld" -> {}, "Involutivity" -> {}} -->

## Scope

The same sweep in the exterior picture:

```wl
exterior = Append[Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>], "Convention" -> "Exterior"];
Map[# -> RelationFailures[#, exterior, 3] &, Keys[$Relations]]
```

<!-- => {"Jacobi" -> {}, "CoJacobi" -> {}, "Drinfeld" -> {}, "Involutivity" -> {}} -->

---

The range that is actually swept is the enumeration, so its size is what the truncation means:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Length[CyclicWords[5, pairing, "UpTo" -> True]]
```

<!-- => 20 -->

---

A three-particle alphabet is swept the same way:

```wl
RelationFailures["Involutivity", Pairing[<|alpha -> -1, beta -> 0, gamma -> -1|>, <|{alpha, beta} -> 1, {gamma, beta} -> 1|>], 3]
```

<!-- => {} -->

## Properties and Relations

The arity of the tuples comes from [$Relations](), which is why a one-word identity and a three-word one are swept by the same call:

```wl
Normal[Map[#["Arity"] &, $Relations]]
```

<!-- => {"Jacobi" -> 3, "CoJacobi" -> 1, "Drinfeld" -> 2, "Involutivity" -> 1} -->

---

A failure would be reported as the tuple itself, so a nonempty result is directly re-runnable through the obstruction function:

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Map[$Relations["Involutivity"]["Function"][#, pairing] &, CyclicWords[4, pairing, "UpTo" -> True]] // Union
```

<!-- => {0} -->

## Possible Issues

The result is a list of **tuples**, so a one-word identity returns a list of one-element lists rather than a list of words. Flatten before feeding them back if that matters.

```wl
pairing = Pairing[<|x -> -1, y -> 0|>, <|{x, y} -> 1|>];
Head[RelationFailures["CoJacobi", pairing, 4]]
```

<!-- => List -->
