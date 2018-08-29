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

    /// Creates an empty `DictionaryProtocol`-conforming type with preallocated space for at least
    /// the specified number of elements.
    init(minimumCapacity: Int)

    // MARK: - Subscripts

    /// - Returns: `Value` for the given `key`, if present. Otherwise, `nil`.
    subscript (key: Key) -> Value? { get set }

    /// Reserves the required amount of memory to store the given `minimumCapacity` of key-value
    /// pairs.
    mutating func reserveCapacity(_ minimumCapacity: Int)
}

extension DictionaryProtocol {

    /// Create a `DictionaryProtocol` with two parallel arrays.
    ///
    /// - Note: Useful for creating a dataset from x- and y-value arrays.
    public init(_ xs: [Key], _ ys: [Value]) {
        self.init(minimumCapacity: xs.count)
        zip(xs,ys).forEach { key, value in self[key] = value }
    }

    /// Create a `DictionaryProtocol`-conforming type with a collection with dictionary-like
    /// elements.
    public init <C: Collection> (_ collection: C) where C.Element == (key: Key, value: Value) {
        self.init(minimumCapacity: collection.count)
        for (k, v) in collection { self[k] = v }
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

    /// Ensure that an `RangeReplaceableCollection`-conforming type value exists for the given
    /// `key`.
    public mutating func ensureValue(forKey key: Key) {
        if self[key] == nil { self[key] = Value() }
    }

    /// Safely append the given `value` to the `RangeReplaceableCollection`-conforming type `value`
    /// for the given `key`.
    public mutating func safelyAppend(_ value: Value.Element, forKey key: Key) {
        ensureValue(forKey: key)
        self[key]!.append(value)
    }

    /// Safely append the contents of an array to the Array-type `value` for the given `key`.
    public mutating func safelyAppend(contentsOf values: Value, forKey key: Key) {
        ensureValue(forKey: key)
        self[key]!.append(contentsOf: values)
    }
}

extension DictionaryProtocol where Value: RangeReplaceableCollection, Value.Element: Equatable {

    /// Safely append value to the array value for a given key.
    ///
    /// If this value already exists in desired array, the new value will not be added.
    public mutating func safelyAndUniquelyAppend(_ value: Value.Element, forKey key: Key) {
        ensureValue(forKey: key)
        if self[key]!.contains(value) { return }
        self[key]!.append(value)
    }
}

extension DictionaryProtocol where Value: SetAlgebra {

    /// Ensure that an `SetAlgebra`-conforming type value exists for the given `key`.
    public mutating func ensureValue(forKey key: Key) {
        if self[key] == nil { self[key] = Value() }
    }

    /// Safely append the given `value` to the `SetAlgebra`-conforming type `value` for the given
    /// `key`.
    public mutating func safelyInsert(_ value: Value.Element, forKey key: Key) {
        ensureValue(forKey: key)
        self[key]!.insert(value)
    }

    /// Safely append the contents of an array to the `SetAlgebra`-conforming type `value` for the
    /// given `key`.
    public mutating func safelyFormIntersection(_ other: Value, forKey key: Key) {
        ensureValue(forKey: key)
        self[key]!.formIntersection(other)
    }
}

extension DictionaryProtocol where Value: DictionaryProtocol {

    /// Ensure there is a value for a given `key`.
    public mutating func ensureValue(forKey key: Key) {
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
            ensureValue(forKey: key)
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
