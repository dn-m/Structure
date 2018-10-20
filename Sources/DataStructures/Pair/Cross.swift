//
//  Cross.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// `Pair` of two values with potentially different types.
public struct Cross <T,U>: Pair {

    // MARK: - Instance Properties

    /// The first value contained herein.
    public let a: T

    /// The second value contained herein.
    public let b: U
}

extension Cross {

    // MARK: - Initializers

    /// Creates a `Cross` with the given values.
    @inlinable
    public init(_ a: T, _ b: U) {
        self.a = a
        self.b = b
    }
}

extension Cross: Comparable where T: Comparable & Equatable, U: Comparable {
    
    public static func < (lhs: Cross, rhs: Cross) -> Bool {
        return lhs.a < rhs.a || (lhs.a == rhs.a && lhs.b < rhs.b)
    }
}

extension Cross: Equatable where T: Equatable, U: Equatable { }
extension Cross: Hashable where T: Hashable, U: Hashable { }
