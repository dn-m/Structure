//
//  OrderedPair.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// `Pair` of two values of the same type for which the order of the values is meaningful.
public struct OrderedPair <T>: SwappablePair {

    // MARK: - Instance Properties

    /// The first value contained herein.
    public let a: T

    /// The second value contained herein.
    public let b: T
}

extension OrderedPair {

    // MARK: - Initializers

    /// Creates an `OrderedPair` with the given values.
    @inlinable
    public init(_ a: T, _ b: T) {
        self.a = a
        self.b = b
    }
}

extension OrderedPair: Equatable where T: Equatable { }
extension OrderedPair: Hashable where T: Hashable { }
