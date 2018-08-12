# Structure

![Swift](https://img.shields.io/badge/Swift-4.2-brightgreen.svg)
[![Build Status](https://travis-ci.org/dn-m/Structure.svg?branch=master)](https://travis-ci.org/dn-m/Structure)

Algebraic and data structures in Swift 4.2. The `Structure` package consists of four modules:

## Destructure
Module which includes a single extension of `Sequence`, which breaks it into a `head` and `tail` for functional-style recursive implementations of algorithms.

```
extension Sequence {
    /// 2-tuple containing the `head` and `tail` of a given `Sequence`.
    public var destructured: (Element, AnySequence<Element>)?
}  
``` 

## Algebra
Protocols for representing Algebraic structures (`Semigroup`, `Monoid`, etc.), and their operations.

## DataStructures
Data structures which are not included in the Standard Library.

## Algorithms
Algorithms over the Standard Library built-in data structures.
