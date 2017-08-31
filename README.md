# Structure

[![Build Status](https://travis-ci.org/dn-m/Structure.svg?branch=master)](https://travis-ci.org/dn-m/Structure) 


## Destructure
>TODO

## Restructure
- Provide new representations of the same data
    - `stableSort`
    - `swap(ped)`
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

## DictionaryProtocol
- TODO (move into `DataStructures`)

## StructureWrapping
- `IntegerWrapping`
- `FloatWrapping`
- `DoubleWrapping`
- `SequenceWrapping`
- `CollectionWrapping`
- `SortedCollectionWrapping`
- `RandomAccessCollectionWrapping`

## Predicates
- `~=` for `Sequence where Element: Equatable`
- `any`, `all`, `none`
- `isHomogeneous`, `isHeterogeneous`
- `extrema`
