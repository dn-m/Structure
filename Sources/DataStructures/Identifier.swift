//
//  Identifier.swift
//  DataStructures
//
//  Created by James Bean on 9/1/18.
//

/// A type-safe identifier.
///
/// An `Identifier` is merely a wrapper around an `Int`, but with the added type-safety of the
/// generic type parameter `Subject`.
///
///     let truck: Identifier<Truck> = 0
///     let friend: Identifier<Friend> = 0
///
/// The `Subject` is not used within the type, but it exists to ensure that things like this don't
/// compile:
///
///     truck == friend
///     // Binary operator '==' cannot be applied to operands of type 'Identifier<Truck>' and
///     // 'Identifier<Friend>'
///
public struct Identifier <Subject> {

    let value: Int

    // MARK: - Initializers

    /// Creates an `Identifier` with the given `value`.
    public init(_ value: Int) {
        self.value = value
    }
}

extension Identifier: ExpressibleByIntegerLiteral {

    // MARK: - ExpressibleByIntgerLiteral

    /// Creates an `Identifier` with the given `value`.
    public init(integerLiteral value: Int) {
        self.value = value
    }
}

extension Identifier: Equatable { }
extension Identifier: Hashable { }
