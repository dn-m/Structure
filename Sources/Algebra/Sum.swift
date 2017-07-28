//
//  Sum.swift
//  Algebra
//
//  Created by James Bean on 7/9/17.
//
//

/// Multiplicative monoidal view of a `Additive`-conforming type.
public struct Sum <T: Additive>: MonoidView {

    // MARK: - Type Properties

    /// - Returns: The additive identity wrapped in a `AdditiveMonoid`.
    public static var identity: Sum {
        return Sum(T.zero)
    }

    // MARK: - Type Methods

    /// - Returns: The composition of the two given values.
    public static func <> (lhs: Sum, rhs: Sum) -> Sum {
        return Sum(lhs.value + rhs.value)
    }

    // MARK: - Instance Properties

    /// Value wrapped by `AdditiveMonoid`.
    public let value: T

    // MARK: - Initializers

    /// Creates a `AdditiveMonoid` with the given `value.`
    public init(_ value: T) {
        self.value = value
    }
}

extension Additive {

    /// - Returns: A `Sum` monoidal view of `self`.
    public var sum: Sum<Self> {
        return Sum(self)
    }
}
