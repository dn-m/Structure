# Algebra

The `Algebra` module defines fundamental algebraic structures which help to simplify the world when it seems too complicated.

### Unital Magmas
- Zero
- One

### Semigroup
- Semigroup
- AdditiveSemigroup
- MultiplicativeSemigroup

### Monoid
- Monoid
- Additive
- Multiplicative

### MonoidView
- Sum
- Product

### Group
- Group
- Invertible

## Swift Standard Library Conformances and Extensions

The `Algebra` module conforms Swift stdlib types to many of these basic algebraic structures.

For example, the numeric types, `Array` and `String` are each `Additive` monoids, while `Set` is an `Additive` monoid and a `MultiplicativeSemigroup`. The numeric types are also `Multiplicative` monoids.

`Sequence` and `Collection` types which contain various algebraic elements are extended with helpful properties, such as `.reduced` for sequences which hold any kind of monoid.

