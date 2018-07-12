# Structure

[![Build Status](https://travis-ci.org/dn-m/Structure.svg?branch=master)](https://travis-ci.org/dn-m/Structure) 

Algebraic and data structures in Swift 4.2. The `Structure` package consists of three modules.

## Destructure
Module which includes a single extension of `Collection`, which breaks it into a `head` and `tail` for functional-style recursive implementations of algorithms.

```Swift
extension Collection {
    /// 2-tuple containing the `head` `Element` and `tail` `[Element]` of `Self`
    public var destructured: (Element, SubSequence)? {
        guard let first = first else { return nil }
        return (first, dropFirst())
    }
}
	    
``` 

## Algebra
Protocols for representing Algebraic structures (`Semigroup`, `Monoid`, etc.), and their operations.

## DataStructures
Various data structures which are not included in the Standard Library.

## Algorithms
Various algorithms over the Standard Library built-in data structures.
