//
//  Sum.swift
//  Algebra
//
//  Created by James Bean on 7/9/17.
//
//

/// Additive monoidal view of a `Additive`-conforming type.
public struct Sum <Value: Additive>: MonoidView {

    // MARK: - Type Properties

    /// - Returns: The additive identity wrapped in a `AdditiveMonoid`.
    public static var identity: Sum {
        return Sum(Value.zero)
    }

    // MARK: - Type Methods

    /// - Returns: The composition of the two given values.
    public static func <> (lhs: Sum, rhs: Sum) -> Sum {
        return Sum(lhs.value + rhs.value)
    }

    // MARK: - Instance Properties

    /// Value wrapped by `AdditiveMonoid`.
    public let value: Value

    // MARK: - Initializers

    /// Creates a `AdditiveMonoid` with the given `value.`
    public init(_ value: Value) {
        self.value = value
    }
}

extension Sum: Additive {

    // MARK: - Additive

    /// - Returns: The wrapped-up `zero` type property of the wrapped type.
    public static var zero: Sum<Value> {
        return Sum(Value.zero)
    }

    /// - Returns: The wrapped-up sum of the two given values.
    public static func + (lhs: Sum<Value>, rhs: Sum<Value>) -> Sum<Value> {
        return Sum(lhs.value + rhs.value)
    }
}

extension Additive {

    /// - Returns: A `Sum` monoidal view of `self`.
    public var sum: Sum<Self> {
        return Sum(self)
    }
}
