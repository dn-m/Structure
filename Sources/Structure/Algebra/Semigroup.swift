//
//  Semigroup.swift
//  Algebra
//
//  Created by James Bean on 7/9/17.
//
//

/// Composition operator.
infix operator <> : AdditionPrecedence

/// Interface defining objects with a single property:
///
/// - `Composition` operation.
///
public protocol Semigroup {

    /// - Returns: Composition of two of the same `Semigroup` type values.
    static func <> (_ lhs: Self, _ rhs: Self) -> Self
}
