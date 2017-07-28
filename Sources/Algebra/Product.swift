//
//  Product.swift
//  Algebra
//
//  Created by James Bean on 7/9/17.
//
//

/// Multiplicative monoidal view of a `Multiplicative`-conforming type.
public struct Product <T: Multiplicative>: MonoidView {

    // MARK: - Type Properties

    /// - Returns: The multiplicative identity wrapped in a `MultiplicativeMonoid`.
    public static var identity: Product {
        return Product(T.one)
    }

    // MARK: - Type Methods

    /// - Returns: The composition of the two given values.
    public static func <> (lhs: Product, rhs: Product) -> Product {
        return Product(lhs.value * rhs.value)
    }

    // MARK: - Instance Properties

    /// Value wrapped by `MultiplativeMonoid`.
    public let value: T

    // MARK: - Initializers

    /// Creates a `MultiplicativeMonoid` with the given `value.`
    public init(_ value: T) {
        self.value = value
    }
}

extension Multiplicative {

    /// - Returns: A `Product` monoidal view of `self`.
    public var product: Product<Self> {
        return Product(self)
    }
}
