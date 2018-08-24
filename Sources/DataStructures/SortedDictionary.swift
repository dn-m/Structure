//
//  SortedDictionary.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

import Algebra

/// Ordered dictionary which has sorted `keys`.
public struct SortedDictionary<Key, Value>: DictionaryProtocol where Key: Hashable & Comparable {

    // MARK: - Instance Properties

    /// Sorted keys.
    public var keys: SortedArray<Key> = []

    /// Values contained herein, in order sorted by their associated keys.
    public var values: [Value] {
        return keys.map { unsorted[$0]! }
    }

    /// Backing dictionary.
    private var unsorted: [Key: Value] = [:]

    // MARK: - Initializers

    /// Create an empty `SortedOrderedDictionary`.
    public init() { }

    /// Creates an empty `SortedDictionary` type with preallocated space for at least the specified
    /// number of elements.
    public init(minimumCapacity: Int) {
        self.keys = []
        self.keys = .init(minimumCapacity: minimumCapacity)
    }

    /// Create a `SortedDictionary` with the elements of a presorted `OrderedDictionary`.
    ///
    /// - Warning: You must be certain that `presorted` is sorted, otherwise undefined behavior is
    /// certain.
    public init(presorted: OrderedDictionary<Key,Value>) {
        self.keys = SortedArray(presorted: presorted.keys)
        self.unsorted = presorted.unordered
    }

    /// Creats a `SortedDictionary` with the contents of another `SortedDictionary`.
    public init(_ sorted: SortedDictionary) {
        self.keys = sorted.keys
        self.unsorted = sorted.unsorted
    }

    // MARK: - Subscripts

    /// - returns: Value for the given `key`, if available. Otherwise, `nil`.
    public subscript(key: Key) -> Value? {

        get {
            return unsorted[key]
        }

        set {

            guard let newValue = newValue else {
                unsorted.removeValue(forKey: key)
                keys.remove(key)
                return
            }

            let oldValue = unsorted.updateValue(newValue, forKey: key)

            if oldValue == nil {
                keys.insert(key)
            }
        }
    }

    // MARK: - Instance Methods

    /// Insert the given `value` for the given `key`. Order will be maintained.
    public mutating func insert(_ value: Value, key: Key) {
        keys.insert(key)
        unsorted[key] = value
    }

    /// Insert the contents of another `SortedDictionary` value.
    public mutating func insert(contentsOf sortedDictionary: SortedDictionary<Key, Value>) {
        sortedDictionary.forEach { insert($0.1, key: $0.0) }
    }

    /// Reserves the amount of memory required to store the given `minimumCapacity` of elements.
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        keys.reserveCapacity(minimumCapacity)
        unsorted.reserveCapacity(minimumCapacity)
    }

    /// - returns: Value at the given `index`, if present. Otherwise, `nil`.
    public func value(at index: Int) -> Value? {
        if index >= keys.count { return nil }
        return unsorted[keys[index]]
    }
}

extension SortedDictionary: Equatable where Value: Equatable { }

extension SortedDictionary: Collection {

    // MARK: - Collection

    /// Index after the given `index`.
    public func index(after index: Int) -> Int {
        assert(index < endIndex, "Cannot decrement index to \(index - 1)")
        return index + 1
    }

    /// Start index.
    public var startIndex: Int {
        return 0
    }

    /// End index.
    public var endIndex: Int {
        return keys.count
    }

    /// Count.
    public var count: Int {
        return keys.count
    }
}

extension SortedDictionary: BidirectionalCollection {

    /// Index before the given `index`.
    public func index(before index: Int) -> Int {
        assert(index > 0, "Cannot decrement index to \(index - 1)")
        return index - 1
    }
}

extension SortedDictionary: RandomAccessCollection {

    /// - Returns: Element at the given `index`.
    public subscript (index: Int) -> (Key, Value) {
        let key = keys[index]
        let value = unsorted[key]!
        return (key, value)
    }
}

extension SortedDictionary {

    public func min() -> (Key,Value)? {
        guard let firstKey = keys.first else { return nil }
        return (firstKey, unsorted[firstKey]!)
    }

    public func max() -> (Key,Value)? {
        guard let lastKey = keys.last else { return nil }
        return (lastKey, unsorted[lastKey]!)
    }

    public func sorted() -> [(Key,Value)] {
        return Array(self)
    }
}

extension SortedDictionary: ExpressibleByDictionaryLiteral {

    // MARK: - ExpressibleByDictionaryLiteral

    /// Create a `SortedDictionary` with a `DictionaryLiteral`.
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(minimumCapacity: elements.count)
        elements.forEach { (k, v) in insert(v, key: k) }
    }
}

extension SortedDictionary: Zero {

    /// - Returns: A `SortedDictionary` with no elements.
    public static var zero: SortedDictionary {
        return .init()
    }
}
