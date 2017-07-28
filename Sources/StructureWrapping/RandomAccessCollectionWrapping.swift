//
//  RandomAccessCollectionWrapping.swift
//  Collections
//
//  Created by James Bean on 7/13/17.
//
//

/// Interface for wrapping any `RandomAccessCollection` type. The `RandomAccessCollection` interface
/// is exposed, regardless of the concrete implementation of the wrapped type.
///
/// The performance guarantees made by the `RandomAccessCollection` are sustained.
public protocol RandomAccessCollectionWrapping: RandomAccessCollection {

    // MARK: - Associated Types

    /// Wrapped `RandomAccessCollection`-conforming type.
    associatedtype Base: RandomAccessCollection

    // MARK: - Instance Properties

    /// Wrapped `RandomAccessCollection`-conforming type.
    var base: Base { get }
}

extension RandomAccessCollectionWrapping {

    // MARK: - RandomAccessCollection

    /// Start index.
    ///
    /// - Complexity: O(1)
    ///
    public var startIndex: Base.Index {
        return base.startIndex
    }

    /// End index.
    ///
    /// - Complexity: O(1)
    ///
    public var endIndex: Base.Index {
        return base.endIndex
    }

    /// First element, if there is at least one element. Otherwise, `nil`.
    ///
    /// - Complexity: O(1)
    ///
    public var first: Base.Iterator.Element? {
        return base.first
    }

    /// Last element, if there is at least one element. Otherwise, `nil`.
    ///
    /// - Complexity: O(1)
    ///
    public var last: Base.Iterator.Element? {
        return base.last
    }

    /// Amount of elements.
    ///
    /// - Complexity: O(1)
    ///
    public var count: Base.IndexDistance {
        return base.count
    }

    /// - Returns: `true` if there are no elements contained herein. Otherwise, `false`.
    ///
    /// - Complexity: O(1)
    ///
    public var isEmpty: Bool {
        return base.isEmpty
    }

    /// - Returns: The element at the given `index`.
    ///
    /// - Complexity: O(1)
    ///
    public subscript(position: Base.Index) -> Base.Iterator.Element {
        return base[position]
    }

    /// - Returns: Index after the given `index`.
    ///
    /// - Complexity: O(1)
    public func index(after index: Base.Index) -> Base.Index {
        return base.index(after: index)
    }

    /// - Returns: Index before the given `index`.
    ///
    /// - Complexity: O(1)
    ///
    public func index(before index: Base.Index) -> Base.Index {
        return base.index(before: index)
    }
}
