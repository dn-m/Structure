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
    public var values: [Key: Value] = [:]

    // MARK: - Initializers

    /// Create an empty `OrderedDictionary`
    public init() { }

    // MARK: - Subscripts

    /// - returns: Value for the given `key`, if available. Otherwise, `nil`.
    public subscript(key: Key) -> Value? {

        get {
            return values[key]
        }

        set {

            guard let newValue = newValue else {
                values.removeValue(forKey: key)
                keys = keys.filter { $0 != key }
                return
            }

            let oldValue = values.updateValue(newValue, forKey: key)
            if oldValue == nil {
                keys.append(key)
            }
        }
    }

    // MARK: - Instance Methods

    /// Append `value` for given `key`.
    public mutating func append(_ value: Value, key: Key) {
        keys.append(key)
        values[key] = value
    }

    /// Insert `value` for given `key` at `index`.
    public mutating func insert(_ value: Value, key: Key, index: Int) {
        keys.insert(key, at: index)
        values[key] = value
    }

    /// Append the contents of another `OrderedDictionary` structure.
    public mutating func appendContents(of orderedDictionary: OrderedDictionary<Key,Value>) {
        keys.append(contentsOf: orderedDictionary.keys)
        for key in orderedDictionary.keys {
            values.updateValue(orderedDictionary[key]!, forKey: key)
        }
    }

    /// - returns: The value at the given `index`.
    public func value(index: Int) -> Value? {

        guard index >= 0 && index < keys.count else {
            return nil
        }

        return values[keys[index]]
    }
}

extension OrderedDictionary: Collection {

    // MARK: - `Collection`

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
        let value = values[key]!
        return (key, value)
    }
}

extension OrderedDictionary: ExpressibleByDictionaryLiteral {

    // MARK: - `ExpressibleByDictionaryLiteral`

    /// Create an `OrderedDictionary` with a `DictionaryLiteral`.
    public init(dictionaryLiteral elements: (Key, Value)...) {

        self.init()

        elements.forEach { (k, v) in
            append(v, key: k)
        }
    }
}

/// - returns: `true` if all values contained in both `OrderedDictionary` values are
/// equivalent. Otherwise, `false`.
public func == <K, V: Equatable> (lhs: OrderedDictionary<K,V>, rhs: OrderedDictionary<K,V>)
    -> Bool
{

    guard lhs.keys == rhs.keys else {
        return false
    }

    for key in lhs.keys {

        if rhs.values[key] == nil || rhs.values[key]! != lhs.values[key]! {
            return false
        }
    }

    for key in rhs.keys {

        if lhs.values[key] == nil || lhs.values[key]! != rhs.values[key]! {
            return false
        }
    }

    return true
}
