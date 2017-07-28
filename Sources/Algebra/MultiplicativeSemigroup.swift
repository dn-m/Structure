//
//  MultiplicativeSemigroup.swift
//  Algebra
//
//  Created by James Bean on 7/19/17.
//
//

/// Interface for semigroups with an multiplicative binary operation.
public protocol MultiplicativeSemigroup {

    /// Multiplicative operation.
    static func * (lhs: Self, rhs: Self) -> Self
}
