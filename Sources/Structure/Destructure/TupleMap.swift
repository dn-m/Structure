//
//  TupleMap.swift
//  Collections
//
//  Created by James Bean on 2/2/17.
//
//

import Foundation

/// Applies the given transform `f` to the given values `a` and `b`.
public func map <T, U> (_ a: T, _ b: T, _ f: (T) -> U) -> (U, U) {
    return (f(a), f(b))
}

/// Applies the given transform `f` to the given values `a` and `b`, `c`.
public func map <T, U> (_ a: T, _ b: T, _ c: T, _ f: (T) -> U) -> (U, U, U) {
    return (f(a), f(b), f(c))
}

/// Applies the given transform `f` to each value of the given tuple `values`.
public func map <T, U> (_ values: (T, T), _ f: (T) -> U) -> (U, U) {
    return (f(values.0), f(values.1))
}

/// Applies the given transform `f` to each value of the given tuple `values`.
public func map <T, U> (_ values: (T, T, T), _ f: (T) -> U) -> (U, U, U) {
    return (f(values.0), f(values.1), f(values.2))
}
