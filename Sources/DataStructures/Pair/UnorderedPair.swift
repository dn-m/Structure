//
//  UnorderedPair.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// `Pair` of two values of the same type for which the order of the values is not meaningful.
public struct UnorderedPair <T>: SymmetricPair {

    // MARK: - Instance Properties

    /// The first value contained herein.
    public let a: T

    /// The second value contained herein.
    public let b: T
}

extension UnorderedPair {

    // MARK: - Initializers

    /// Creates an `UnrderedPair` with the given values.
    @inlinable
    public init(_ a: T, _ b: T) {
        self.a = a
        self.b = b
    }

}

extension UnorderedPair where T: Equatable {

    /// - Returns: The value in this `UnorderedPair` other than the given `value`, if the given
    /// `value` is contained herein. Otherwise, `nil`.
    public func other(_ value: T) -> T? {
        return a == value ? b : b == value ? a : nil
    }
}

extension UnorderedPair: Equatable where T: Equatable {

    // MARK: - Equatable

    /// - Returns: `true` if both values contained by the given `UnorderedPair` values are
    /// equivalent, regardless of order. Otherwise, `false`.
    public static func == (_ lhs: UnorderedPair, _ rhs: UnorderedPair) -> Bool {
        return (lhs.a == rhs.a && lhs.b == rhs.b) || (lhs.a == rhs.b && lhs.b == rhs.a)
    }
}

extension UnorderedPair: Hashable where T: Hashable {

    // MARK: - Hashable

    /// Implements hashable requirement.
    public var hashValue: Int {
        return Set([a,b]).hashValue
    }
}
