//
//  OrderedDictionary.swift
//  Collections
//
//  Created by James Bean on 12/10/16.
//
//

/// Ordered Dictionary.
public struct OrderedDictionary <Key: Hashable, Value>: DictionaryProtocol {

    // MARK: - Instance Properties

    /// Ordered keys.
    public var keys: [Key] = []

    /// Values.
    public var unordered: [Key: Value] = [:]

    // MARK: - Initializers

    /// Create an empty `OrderedDictionary`
    public init() { }

    /// Creates an empty `OrderedDictionary` type with preallocated space for at least the specified
    /// number of elements.
    public init(minimumCapacity: Int) {
        self.keys = []
        self.keys.reserveCapacity(minimumCapacity)
        self.unordered = .init(minimumCapacity: minimumCapacity)
    }

    // MARK: - Subscripts

    /// - returns: Value for the given `key`, if available. Otherwise, `nil`.
    public subscript(key: Key) -> Value? {

        get {
            return unordered[key]
        }

        set {

            guard let newValue = newValue else {
                unordered.removeValue(forKey: key)
                keys = keys.filter { $0 != key }
                return
            }

            let oldValue = unordered.updateValue(newValue, forKey: key)
            if oldValue == nil {
                keys.append(key)
            }
        }
    }

    // MARK: - Instance Methods

    /// Append `value` for given `key`.
    public mutating func append(_ value: Value, key: Key) {
        keys.append(key)
        unordered[key] = value
    }

    /// Insert `value` for given `key` at `index`.
    public mutating func insert(_ value: Value, key: Key, index: Int) {
        keys.insert(key, at: index)
        unordered[key] = value
    }

    /// Append the contents of another `OrderedDictionary` structure.
    public mutating func appendContents(of orderedDictionary: OrderedDictionary<Key,Value>) {
        keys.append(contentsOf: orderedDictionary.keys)
        for key in orderedDictionary.keys {
            unordered.updateValue(orderedDictionary[key]!, forKey: key)
        }
    }

    /// Reserves the amount of memory required to store the given `minimumCapacity` of elements.
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        keys.reserveCapacity(minimumCapacity)
        unordered.reserveCapacity(minimumCapacity)
    }

    /// - Returns: The value at the given `index`.
    public func value(index: Int) -> Value? {
        guard index >= 0 && index < keys.count else { return nil }
        return unordered[keys[index]]
    }
}

extension OrderedDictionary: Collection {

    // MARK: - Collection

    /// - Index after given index `i`.
    public func index(after i: Int) -> Int {

        guard i != endIndex else {
            fatalError("Cannot increment endIndex")
        }

        return i + 1
    }

    /// Start index.
    public var startIndex: Int {
        return 0
    }

    /// End index.
    public var endIndex: Int {
        return keys.count
    }

    /// - returns: Element at the given `index`.
    public subscript (index: Int) -> (Key, Value) {
        let key = keys[index]
        let value = unordered[key]!
        return (key, value)
    }
}

extension OrderedDictionary: ExpressibleByDictionaryLiteral {

    // MARK: - ExpressibleByDictionaryLiteral

    /// Create an `OrderedDictionary` with a `DictionaryLiteral`.
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(minimumCapacity: elements.count)
        elements.forEach { (k, v) in append(v, key: k) }
    }
}

extension OrderedDictionary: Equatable where Value: Equatable { }
extension OrderedDictionary: Hashable where Value: Hashable { }
extension OrderedDictionary: Codable where Key: Codable, Value: Codable { }
