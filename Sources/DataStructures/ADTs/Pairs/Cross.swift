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

extension Cross: Comparable where T: Comparable, U: Comparable {
    
    /// - Returns: true if and only if the first element of `lhs` is less than the first element
    /// of `rhs` OR if those elements are equal and the second element of `lhs` is less than the
    /// second element of `rhs` (lexicographic ordering).
    public static func < (lhs: Cross, rhs: Cross) -> Bool {
        return lhs.a < rhs.a || (lhs.a == rhs.a && lhs.b < rhs.b)
    }
}

extension Cross: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printable description of `Cross`.
    public var description: String {
        return "<\(a),\(b)>"
    }
}

extension Cross: Equatable where T: Equatable, U: Equatable { }
extension Cross: Hashable where T: Hashable, U: Hashable { }
extension Cross: Codable where T: Codable, U: Codable { }
