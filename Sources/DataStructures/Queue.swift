//
//  Queue.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// First-in-first-out linear data structure.
///
/// - Remark: Consider using two linked lists instead of an `Array` as the internal storage.
/// `Array` gives `O(*n*)` performance for `remove(at:)`, which is used by `dequeue`.
public struct Queue <Element> {

    // MARK: - Instance Properties

    @usableFromInline
    var storage: [Element]
}

extension Queue {

    // MARK: - Initializers

    /// Creates an empty `Queue`.
    public init() {
        self.storage = []
    }
}

extension Queue {

    // MARK: - Computed Properties

    /// - Returns: `true` if there are no values contained herein. Otherwise, `false`.
    @inlinable
    public var isEmpty: Bool {
        return peek == nil
    }

    /// - Returns: The next value to be dequeued, if it exists. Otherwise, `nil`.
    @inlinable
    public var peek: Element? {
        return storage.first
    }
}

extension Queue {

    // MARK: - Instance Methods

    /// Adds the value to the `Queue`.
    ///
    /// - Complexity: O(*1*) amortized
    @inlinable
    public mutating func enqueue(_ value: Element) {
        storage.append(value)
    }

    /// Removes the next value in the `Queue` and returns it.
    ///
    /// - Returns: The next value in the `Queue`.
    ///
    /// - Warning: If `.isEmpty`, `dequeue()` will crash. If necessary, check that `peek` returns
    /// a non-`nil` value before dequeueing.
    ///
    /// - Complexity: O(*n*)
    @inlinable
    public mutating func dequeue() -> Element {
        return storage.removeFirst()
    }
}

extension Queue: Equatable where Element: Equatable { }
extension Queue: Hashable where Element: Hashable { }
extension Queue: Codable where Element: Codable { }
