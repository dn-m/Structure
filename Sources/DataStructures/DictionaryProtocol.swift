//
//  DictionaryProtocol.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

/// Interface for Dictionary-like structures.
public protocol DictionaryProtocol: Collection {

    // MARK: - Associated Types

    /// Key type.
    associatedtype Key: Hashable

    /// Value type.
    associatedtype Value

    // MARK: - Initializers

    /// Create an empty `DictionaryProtocol` value.
    init()

    // MARK: - Subscripts

    /// - Returns: `Value` for the given `key`, if present. Otherwise, `nil`.
    subscript (key: Key) -> Value? { get set }
}

extension DictionaryProtocol {

    /// Create a `DictionaryProtocol` with two parallel arrays.
    ///
    /// - Note: Useful for creating a dataset from x- and y-value arrays.
    public init(_ xs: [Key], _ ys: [Value]) {
        self.init()
        zip(xs,ys).forEach { key, value in self[key] = value }
    }

    /// Create a `DictionaryProtocol` with an array of tuples.
    public init(_ keysAndValues: [(Key, Value)]) {
        self.init()
        for (key, value) in keysAndValues {
            self[key] = value
        }
    }
}

extension DictionaryProtocol where Element == (key: Key, value: Value) {

    // MARK: - Instance Methods

    /// Merge the contents of the given `dictionary` destructively into this one.
    public mutating func merge(with dictionary: Self) {
        for (k,v) in dictionary { self[k] = v }
    }

    /// - returns: A new `Dictionary` with the contents of the given `dictionary` merged `self`
    /// over those of `self`.
    public func merged(with dictionary: Self) -> Self {
        var copy = self
        copy.merge(with: dictionary)
        return copy
    }
}

extension DictionaryProtocol where Value: RangeReplaceableCollection {

    /// Ensure that an Array-type value exists for the given `key`.
    public mutating func ensureValue(for key: Key) {
        if self[key] == nil { self[key] = Value() }
    }

    /// Safely append the given `value` to the Array-type `value` for the given `key`.
    public mutating func safelyAppend(_ value: Value.Element, toArrayWith key: Key) {
        ensureValue(for: key)
        self[key]!.append(value)
    }

    /// Safely append the contents of an array to the Array-type `value` for the given `key`.
    public mutating func safelyAppendContents(of values: Value, toArrayWith key: Key) {
        ensureValue(for: key)
        self[key]!.append(contentsOf: values)
    }
}

extension DictionaryProtocol where Value: RangeReplaceableCollection, Value.Element: Equatable {

    /// Safely append value to the array value for a given key.
    ///
    /// If this value already exists in desired array, the new value will not be added.
    public mutating func safelyAndUniquelyAppend(_ value: Value.Element, toArrayWith key: Key) {
        ensureValue(for: key)
        if self[key]!.contains(value) { return }
        self[key]!.append(value)
    }
}

extension DictionaryProtocol where Value: DictionaryProtocol {

    /// Ensure there is a value for a given `key`.
    public mutating func ensureValue(for key: Key) {
        if self[key] == nil { self[key] = Value() }
    }
}

extension DictionaryProtocol where
    Value: DictionaryProtocol,
    Element == (Key, Value),
    Value.Element == (Value.Key, Value.Value)
{
    /// Merge the contents of the given `dictionary` destructively into this one.
    ///
    /// - warning: The value of a given key of the given `dictionary` will override that of
    /// this one.
    public mutating func merge(with dictionary: Self) {
        for (key, subDict) in dictionary {
            ensureValue(for: key)
            for (subKey, value) in subDict {
                self[key]![subKey] = value
            }
        }
    }

    /// - returns: A new `Dictionary` with the contents of the given `dictionary` merged `self`
    /// over those of `self`.
    public mutating func merged(with dictionary: Self) -> Self {
        var copy = self
        copy.merge(with: dictionary)
        return copy
    }
}

extension Dictionary: DictionaryProtocol { }
