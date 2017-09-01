# Structure

[![Build Status](https://travis-ci.org/dn-m/Structure.svg?branch=master)](https://travis-ci.org/dn-m/Structure) 


## Destructure
Break a `Collection` into a head and tail for functional-style recursive implementations of algorithms.

## Restructure
- Provide new representations of the same data
    - `stableSort(_:)`
    - `swap<T,U>(_:_:)`
    - `split(at:)`
- Modify data:
    - `replaceElement(at:with:)`

## Algebra
Protocols for representing Algabraic structures (`Semigroup`, `Monoid`), and their operations.

## DataStructures
- Stack
- Matrix
- CircularArray
- SortedArray
- OrderedDictionary
- SortedDictionary
- LinkedList
- Tree
- ReferenceTree
- ReferenceGraph
- Zip3Sequence

## SumType
- `InvertibleOptionSet`
- Enum extensions

## Combinatorics
- `pairs`
- `permutations`
- `*`: Cartesian product
- `subsets(cardinality:)`

## Bitwise
- `countLeadingZeros`
- `countTrailingZeros`

## StructureWrapping

Create domain specific wrappers of basic types, which expose the API of the wrapped type.

- `IntegerWrapping`
- `FloatWrapping`
- `DoubleWrapping`
- `SequenceWrapping`
- `CollectionWrapping`
- `SortedCollectionWrapping`
- `RandomAccessCollectionWrapping`

## Predicates
- `~=` for `Sequence where Element: Equatable`
- `any(satisfy:)`, `all(satisfy:)`, `none(satisfy:)`
- `isHomogeneous`, `isHeterogeneous`
- `extrema(property:areInIncreasingOrder:)`
