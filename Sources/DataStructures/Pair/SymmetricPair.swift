//
//  SymmetricPair.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// A `Pair` in which the two values are of the same type.
public protocol SymmetricPair: Pair where A == B { }

extension SymmetricPair where A: Equatable {

    /// - Returns: `true` if one of the values contained herein is equivalent to the given `value`.
    /// Otherwise, `false`.
    @inlinable
    public func contains(_ value: A) -> Bool {
        return a == value || b == value
    }
}

extension SymmetricPair {
    
    public func map <P,C> (_ f: (A) -> C) -> P where P: SymmetricPair, P.A == C {
        return P(f(self.a), f(self.b))
    }
}
