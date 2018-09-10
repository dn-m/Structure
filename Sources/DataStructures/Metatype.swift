//
//  Metatype.swift
//  DataStructures
//
//  Created by James Bean on 9/10/18.
//

/// A wrapper around the metatype of any type.
///
/// This wrapper allows a metatype (`T.Type`, `String.self`, etc.) to conform to `Equatable` and
/// `Hashable`. Therefore, a metatype can be used as a key in a dictionary.
public struct Metatype {

    /// The metatype wrapped-up herein.
    @usableFromInline
    let base: Any.Type

    // MARK: - Initializers

    /// Creates a `Metatype` with the given `base` metatype to wrap.
    @inlinable
    public init(_ base: Any.Type) {
        self.base = base
    }
}

extension Metatype: Equatable {

    // MARK: - Equatable

    /// - Returns: `true` if the given metatypes wrapped up by the given `Metatype` values are
    /// equivalent. Otherwise, `false`.
    @inlinable
    public static func == (lhs: Metatype, rhs: Metatype) -> Bool {
        return lhs.base == rhs.base
    }
}

extension Metatype: Hashable {

    // MARK: - Hashable

    /// - Returns: A unique hash value for the metatype wrapped-up herein.
    @inlinable
    public var hashValue: Int {
        return ObjectIdentifier(base).hashValue
    }
}
