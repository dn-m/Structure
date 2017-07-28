//
//  AdditiveSemigroup.swift
//  Algebra
//
//  Created by James Bean on 7/19/17.
//
//

/// Interface for semigroups with an additive binary operation.
public protocol AdditiveSemigroup {

    /// Additive operation.
    static func + (lhs: Self, rhs: Self) -> Self
}
