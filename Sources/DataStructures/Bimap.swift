//
//  Bimap.swift
//  DataStructures
//
//  Created by James Bean on 8/31/18.
//

/// Dictionary-like structure which allows O(1) access from `Key` to `Value` as well as from `Value`
/// to `Key`.
public struct Bimap <Key: Hashable, Value: Hashable>: Hashable {

    // MARK: - Instance Properties

    @usableFromInline
    var valueByKey: [Key: Value]

    @usableFromInline
    var keyByValue: [Value: Key]
}

extension Bimap {

    // MARK: - Initializers

    /// Create an empty `Bimap`.
    @inlinable
    public init() {
        self.valueByKey = [:]
        self.keyByValue = [:]
    }

    /// Create an empty `Bimap` reserving the amount of memory needed to store the given
    /// `minimumCapacity` of key-value pairs.
    @inlinable
    public init(minimumCapacity: Int) {
        valueByKey = [Key: Value](minimumCapacity: minimumCapacity)
        keyByValue = [Value: Key](minimumCapacity: minimumCapacity)
    }

    /// Create a `Bimap` from a dictionary.
    @inlinable
    public init(_ elements: Dictionary<Key, Value>) {
        self.init(minimumCapacity: elements.count)
        for (k, value) in elements { self[key: k] = value }
    }

    /// Create a `Bimap` from the given `sequence` of key-value pairs.
    @inlinable
    public init <S: Sequence> (_ sequence: S) where S.Element == (Key, Value) {
        self.init()
        for (k, value) in sequence { self[key: k] = value }
    }

    /// Create a `Bimap` from the given `collection` of key-value pairs.
    @inlinable
    public init <C: Collection> (_ collection: C) where C.Element == (Key, Value) {
        self.init(minimumCapacity: collection.count)
        for (k, value) in collection { self[key: k] = value }
    }
}

extension Bimap {

    // MARK: - Computed Properties

    /// - Returns: The amount of key-value pairs contained herein.
    @inlinable
    public var count: Int {
        return valueByKey.count
    }

    /// - Returns: `true` if there are no key-value pairs contained herein. Otherwise, `false`.
    @inlinable
    public var isEmpty: Bool {
        return valueByKey.isEmpty
    }

    /// - Returns: A collection of `Key` values.
    @inlinable
    public var keys: AnyCollection<Key> {
        return AnyCollection(valueByKey.keys)
    }

    /// - Returns: A collection of `Value` values.
    @inlinable
    public var values: AnyCollection<Value> {
        return AnyCollection(keyByValue.keys)
    }
}

extension Bimap {

    // MARK: - Subscripts

    /// Get and set the `Key` for the given `value`.
    @inlinable
    public subscript(value value: Value) -> Key? {
        get { return keyByValue[value] }
        set(newKey) {
            let oldKey = keyByValue.removeValue(forKey: value)
            if let oldKey = oldKey { valueByKey.removeValue(forKey: oldKey) }
            keyByValue[value] = newKey
            if let newKey = newKey { valueByKey[newKey] = value }
        }
    }

    /// Get and set the `Value` for the given `key`.
    @inlinable
    public subscript(key key: Key) -> Value? {
        get { return valueByKey[key] }
        set {
            let oldValue = valueByKey.removeValue(forKey: key)
            if let oldValue = oldValue { keyByValue.removeValue(forKey: oldValue) }
            valueByKey[key] = newValue
            if let newValue = newValue { keyByValue[newValue] = key }
        }
    }
}

extension Bimap {

    // MARK: - Instance Methods

    /// Updates the current value to the given `value` for the given `key`.
    ///
    /// - Returns: The previous value for the given `key`, if it existed. Otherwise, `nil`.
    @inlinable
    @discardableResult
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let previous = self[key: key]
        self[key: key] = value
        return previous
    }

    /// Updates the current key to the given `key` for the given `value`.
    ///
    /// - Returns: The previous key for the given `value`, if it existed. Otherwise, `nil`.
    @inlinable
    @discardableResult
    public mutating func updateKey(_ key: Key, forValue value: Value) -> Key? {
        let previous = self[value: value]
        self[value: value] = key
        return previous
    }

    /// Removes the value for the given `key`.
    ///
    /// - Returns: The previous value for the given `key`, if it existed. Otherwise, `nil`.
    @inlinable
    @discardableResult
    public mutating func removeValue(forKey key: Key) -> Value? {
        let previous = self[key: key]
        self[key: key] = nil
        return previous
    }

    /// Removes the key for the given `value`.
    ///
    /// - Returns: The previous key for the given `value`, if it existed. Otherwise, `nil`.
    @inlinable
    @discardableResult
    public mutating func removeKey(forValue value: Value) -> Key? {
        let previous = self[value: value]
        self[value: value] = nil
        return previous
    }

    /// Removes all key-value pairs, without releasing memory.
    @inlinable
    public mutating func removeAll(keepCapacity capacity: Bool = true) {
        keyByValue.removeAll(keepingCapacity: capacity)
        valueByKey.removeAll(keepingCapacity: capacity)
    }

    /// - Returns: A `Bimap` with the keys and values filtered by the given `isIncluded`.
    @inlinable
    public func filter(_ isIncluded: ((key: Key, value: Value)) throws -> Bool) rethrows -> Bimap {
        return try Bimap(base.lazy.filter(isIncluded))
    }
}

extension Bimap: DictionaryProtocol {

    /// Gets and sets the value for the `key`.
    @inlinable
    public subscript(key: Key) -> Value? {
        get { return self[key: key] }
        set { self[key: key] = newValue }
    }

    /// Reserves the amount of memory needed to store the given `minimumCapacity` of key-value
    /// pairs.
    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        valueByKey.reserveCapacity(minimumCapacity)
        keyByValue.reserveCapacity(minimumCapacity)
    }
}

extension Bimap: CollectionWrapping {

    // MARK: - CollectionWrapping

    /// - Returns: The `[Key: Value]` base for `Collection` operations.
    @inlinable
    public var base: [Key: Value] {
        return valueByKey
    }
}

extension Bimap: ExpressibleByDictionaryLiteral {

    // MARK: ExpressibleByDictionaryLiteral Protocol Conformance
    /// Constructs a bimap using a dictionary literal.
    @inlinable
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(elements)
    }
}

extension Bimap {
    
    public func compose <Other: Hashable> (lhs: Bimap, rhs: Bimap<Value, Other>) -> Bimap<Key, Other> {
        return Bimap<Key, Other> (
            lhs.valueByKey.reduce(into: [Key: Other]()) { dict, pair in
                let (key, value) = pair
                dict[key] = rhs[value]
            }
        )
    }
}
