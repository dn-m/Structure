//
//  Swap.swift
//  Collections
//
//  Created by James Bean on 12/10/16.
//
//

// Immutable swap.
public func swapped <T, U> (_ a: T, _ b: U) -> (U, T) {
    return (b,a)
}

/// - returns: If the given `predicate` is `true`, a tuple of `(b, a, true)`
/// Otherwise, `(a, b, false)`
public func swapped <T> (_ a: T, _ b: T, if predicate: () -> Bool) -> (T, T, Bool) {
    return predicate() ? (b, a, true) : (a, b, false)
}

/// If the given predicate is `true`, the given `a` and `b` values are swapped in an `inout`
/// fasion, and `true` is returned. Otherwise, no `swap` takes place, and `false` is returned.
@discardableResult
public func swap <T> (_ a: inout T, _ b: inout T, if predicate: () -> Bool) -> Bool {

    if predicate() {
        swap(&a,&b)
        return true
    }

    return false
}
