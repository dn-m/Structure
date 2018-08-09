//
//  Product.swift
//  Algebra
//
//  Created by James Bean on 7/9/17.
//
//

/// Multiplicative monoidal view of a `Multiplicative`-conforming type.
public struct Product <Value: Multiplicative>: MonoidView {

    // MARK: - Type Properties

    /// - Returns: The multiplicative identity wrapped in a `MultiplicativeMonoid`.
    public static var identity: Product {
        return Product(Value.one)
    }

    // MARK: - Type Methods

    /// - Returns: The composition of the two given values.
    public static func <> (lhs: Product, rhs: Product) -> Product {
        return Product(lhs.value * rhs.value)
    }

    // MARK: - Instance Properties

    /// Value wrapped by `MultiplicativeMonoid`.
    public let value: Value

    // MARK: - Initializers

    /// Creates a `MultiplicativeMonoid` with the given `value.`
    public init(_ value: Value) {
        self.value = value
    }
}

extension Product: Multiplicative {

    // MARK: - Multiplicative

    /// - Returns: The wrapped-up `one` type property of the wrapped type.
    public static var one: Product<Value> {
        return Product(Value.one)
    }

    /// - Returns: The wrapped-up product of the two given values.
    public static func * (lhs: Product<Value>, rhs: Product<Value>) -> Product<Value> {
        return Product(lhs.value * rhs.value)
    }
}

extension Multiplicative {

    /// - Returns: A `Product` monoidal view of `self`.
    public var product: Product<Self> {
        return Product(self)
    }
}
