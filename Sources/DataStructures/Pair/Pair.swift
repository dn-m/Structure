//
//  Pair.swift
//  Algebra
//
//  Created by James Bean on 9/27/18.
//

/// Pair of two values.
///
/// `Pair` makes no assumptions about the equivalence of types, or order of the values contained
/// herein.
public protocol Pair {

    // MARK: - Associated Types

    /// The type of the first value contained herein.
    associatedtype A

    /// The type of the second value contained herein.
    associatedtype B

    // MARK: - Instance Properties

    /// The first value contained herein.
    var a: A { get }

    /// The second value contained herein.
    var b: B { get }

    // MARK: - Initializers

    /// Creates a `Pair` with the given values.
    init(_ a: A, _ b: B)
}

extension Pair {
    
    func map <P,C,D> (_ f: (A,B) -> (C,D)) -> P where P: Pair, P.A == C, P.B == D {
        let (c,d) = f(self.a, self.b)
        return P(c,d)
    }
}
