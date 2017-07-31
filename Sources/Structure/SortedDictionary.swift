//
//  SortedDictionary.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

/// Ordered dictionary which has sorted `keys`.
public struct SortedDictionary<Key, Value>: DictionaryProtocol where Key: Hashable & Comparable {

    /// Backing dictionary.
    ///
    // FIXME: Make `private` in Swift 4
    internal var unsorted: [Key: Value] = [:]

    // MARK: - Instance Properties

    /// Values contained herein, in order sorted by their associated keys.
    public var values: LazyMapRandomAccessCollection<SortedArray<Key>,Value> {
        return keys.lazy.map { self.unsorted[$0]! }
    }

    /// Sorted keys.
    public var keys: SortedArray<Key> = []

    // MARK: - Initializers

    /// Create an empty `SortedOrderedDictionary`.
    public init() { }

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
    public mutating func insertContents(of sortedDictionary: SortedDictionary<Key, Value>) {
        sortedDictionary.forEach { insert($0.1, key: $0.0) }
    }

    /// - returns: Value at the given `index`, if present. Otherwise, `nil`.
    public func value(at index: Int) -> Value? {
        if index >= keys.count { return nil }
        return unsorted[keys[index]]
    }
}

extension SortedDictionary: Collection {

    // MARK: - `Collection`

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

    // MARK: - `ExpressibleByDictionaryLiteral`

    /// Create a `SortedDictionary` with a `DictionaryLiteral`.
    public init(dictionaryLiteral elements: (Key, Value)...) {

        self.init()

        elements.forEach { (k, v) in
            insert(v, key: k)
        }
    }
}

/// - returns: `true` if all values contained in both `SortedDictionary` values are
/// equivalent. Otherwise, `false`.
public func == <K, V: Equatable> (lhs: SortedDictionary<K,V>, rhs: SortedDictionary<K,V>)
    -> Bool
{

    guard lhs.keys == rhs.keys else {
        return false
    }

    for key in lhs.keys {

        if rhs.unsorted[key] == nil || rhs.unsorted[key]! != lhs.unsorted[key]! {
            return false
        }
    }

    for key in rhs.keys {

        if lhs.unsorted[key] == nil || lhs.unsorted[key]! != rhs.unsorted[key]! {
            return false
        }
    }

    return true
}

/// - returns: `SortedOrderedDictionary` with values of two `SortedOrderedDictionary` values.
public func + <Value, Key> (
    lhs: SortedDictionary<Value, Key>,
    rhs: SortedDictionary<Value, Key>
) -> SortedDictionary<Value, Key> where Key: Hashable, Key: Comparable
{
    var result = lhs
    rhs.forEach { result.insert($0.1, key: $0.0) }
    return result
}
