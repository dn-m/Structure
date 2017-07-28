//
//  DictionaryProtocol.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

// FIXME: Make Contains protocol

public protocol ArrayProtocol: Collection {
    init()
    mutating func append(_ element: Element)
    mutating func append<S> (contentsOf newElements: S) where S: Sequence, S.Element == Element
}

extension Array: ArrayProtocol { }

public enum DictionaryProtocolError: Error {
    case illFormedKeyPath
}

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

    /// - returns: `Value` for the given `key`, if present. Otherwise, `nil`.
    subscript (key: Key) -> Value? { get set }
}

extension DictionaryProtocol {

    /// Create a `DictionaryProtocol` with two parallel arrays.
    ///
    /// - Note: Usefule for creating a dataset from x- and y-value arrays.
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

// FIXME: Consider making this `where Value: AdditiveMonoid`
extension DictionaryProtocol where Value: ArrayProtocol {

    /// Ensure that an Array-type value exists for the given `key`.
    public mutating func ensureValue(for key: Key) {
        if self[key] == nil {
            self[key] = Value()
        }
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

extension DictionaryProtocol where Value: ArrayProtocol, Value.Element: Equatable {

    /**
     Safely append value to the array value for a given key.

     If this value already exists in desired array, the new value will not be added.
     */
    public mutating func safelyAndUniquelyAppend(_ value: Value.Element, toArrayWith key: Key) {

        ensureValue(for: key)

        // FIXME: Find a way to not cast to Array!
        if (self[key] as! Array).contains(value) {
            return
        }

        self[key]!.append(value)
    }
}

extension DictionaryProtocol where Value: DictionaryProtocol {

    /// Ensure there is a value for a given `key`.
    public mutating func ensureValue(for key: Key) {

        if self[key] == nil {
            self[key] = Value()
        }
    }

    // FIXME: Implement with Swift 4 KeyPath
//    /**
//     Update the `value` for the given `keyPath`.
//
//     - TODO: Use subscript (keyPath: KeyPath) { get set }
//     */
//    public mutating func update(_ value: Value.Value, keyPath: KeyPath) throws {
//
//        guard
//            keyPath.count >= 2,
//            let key = keyPath[0] as? Key,
//            let subKey = keyPath[1] as? Value.Key
//        else {
//            throw DictionaryProtocolError.illFormedKeyPath
//        }
//
//        ensureValue(for: key)
//        self[key]![subKey] = value
//    }
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

extension DictionaryProtocol where
    Value: DictionaryProtocol,
    Element == (Key, Value),
    Value.Element == (Value.Key, Value.Value),
    Value.Value: ArrayProtocol
{

    // FIXME: Implement with Swift 4 KeyPath
//    /// Ensure that there is an Array-type value for the given `keyPath`.
//    public mutating func ensureValue(for keyPath: KeyPath) throws {
//
//        guard
//            let key = keyPath[0] as? Key,
//            let subKey = keyPath[1] as? Value.Key
//        else {
//            throw DictionaryProtocolError.illFormedKeyPath
//        }
//
//        ensureValue(for: key)
//        self[key]!.ensureValue(for: subKey)
//    }

//    /// Append the given `value` to the array at the given `keyPath`.
//    ///
//    /// > If no such subdictionary or array exists, these structures will be created.
//    public mutating func safelyAppend(
//        _ value: Value.Value.Element,
//        toArrayWith keyPath: KeyPath
//    ) throws
//    {
//        guard
//            let key = keyPath[0] as? Key,
//            let subKey = keyPath[1] as? Value.Key
//        else {
//            throw DictionaryProtocolError.illFormedKeyPath
//        }
//
//        try ensureValue(for: keyPath)
//        self[key]!.safelyAppend(value, toArrayWith: subKey)
//    }

//    /// Append the given `values` to the array at the given `keyPath`.
//    ///
//    /// > If no such subdictionary or array exists, these structures will be created.
//    public mutating func safelyAppendContents(
//        of values: Value.Value,
//        toArrayWith keyPath: KeyPath
//    ) throws
//    {
//        guard
//            let key = keyPath[0] as? Key,
//            let subKey = keyPath[1] as? Value.Key
//        else {
//            throw DictionaryProtocolError.illFormedKeyPath
//        }
//
//        try ensureValue(for: keyPath)
//        self[key]!.safelyAppendContents(of: values, toArrayWith: subKey)
//    }
}

extension DictionaryProtocol where
    Value: DictionaryProtocol,
    Element == (Key, Value),
    Value.Element == (Value.Key, Value.Value),
    Value.Value: ArrayProtocol,
    Value.Value.Element: Equatable
{

    // FIXME: Implement with Swift 4 KeyPath
//    /// Append given `value` to the array at the given `keyPath`, ensuring that there are no
//    /// duplicates.
//    ///
//    /// > If no such subdictionary or array exists, these structures will be created.
//    public mutating func safelyAndUniquelyAppend(
//        _ value: Value.Value.Element,
//        toArrayWith keyPath: KeyPath
//    ) throws
//    {
//        guard
//            let key = keyPath[0] as? Key,
//            let subKey = keyPath[1] as? Value.Key
//        else {
//            throw DictionaryProtocolError.illFormedKeyPath
//        }
//
//        try ensureValue(for: keyPath)
//        self[key]!.safelyAndUniquelyAppend(value, toArrayWith: subKey)
//    }
}

// MARK: - Evaluating the equality of `DictionaryProtocol` values

/// - returns: `true` if all values in `[H: T]` types are equivalent. Otherwise, `false`.
public func == <D: DictionaryProtocol> (lhs: D, rhs: D) -> Bool where
    D.Element == (D.Key, D.Value),
    D.Value: Equatable
{
    for (key, _) in lhs {
        guard let rhsValue = rhs[key], lhs[key]! == rhsValue else {
            return false
        }
    }
    return true
}


/// - returns: `true` if any values in `[H: T]` types are not equivalent. Otherwise, `false`.
public func != <D: DictionaryProtocol> (lhs: D, rhs: D) -> Bool where
    D.Element == (D.Key, D.Value),
    D.Value: Equatable
{
    return !(lhs == rhs)
}

/// - returns: `true` if all values in `[H: [T]]` types are equivalent. Otherwise, `false`.
public func == <D: DictionaryProtocol> (lhs: D, rhs: D) -> Bool where
    D.Element == (D.Key, D.Value),
    D.Value: Collection,
    D.Value.Element: Equatable,
    D.Value.Index == Int // FIXME: Find a way to do without this constraint
{
    for (key, lhsArray) in lhs {
        guard let rhsArray = rhs[key] else { return false }
        if lhsArray.count != rhsArray.count { return false }
        for i in 0 ..< lhsArray.endIndex {
            if lhsArray[i] != rhsArray[i] { return false }
        }
    }
    return true
}

/// - returns: `true` if any values in `[H: [T]]` types are not equivalent. Otherwise, `false`.
public func != <D: DictionaryProtocol> (lhs: D, rhs: D) -> Bool where
    D.Element == (D.Key, D.Value),
    D.Value: Collection,
    D.Value.Element: Equatable,
    D.Value.Index == Int // FIXME: Find a way to do without this constraint
{
    return !(lhs == rhs)
}


/// - returns: `true` if all values in `[H: [HH: T]]` types are equivalent. Otherwise, `false`.
public func == <D: DictionaryProtocol> (lhs: D, rhs: D) -> Bool where
    D.Element == (D.Key, D.Value),
    D.Value: DictionaryProtocol,
    D.Value.Element == (D.Value.Key, D.Value.Value),
    D.Value.Value: Equatable
{
    for (key, lhsDict) in lhs {
        guard let rhsDict = rhs[key], lhsDict != rhsDict else {
            return false
        }
    }
    return true
}


/// - returns: `true` if any values in `[H: [HH: T]]` types are not equivalent. Otherwise,
/// `false`.
public func != <D: DictionaryProtocol> (lhs: D, rhs: D) -> Bool where
    D.Element == (D.Key, D.Value),
    D.Value: DictionaryProtocol,
    D.Value.Element == (D.Value.Key, D.Value.Value),
    D.Value.Value: Equatable
{
    return !(lhs == rhs)
}

/// - returns: `true` if all values in `[H: [HH: [T]]]` types are equivalent. Otherwise,
/// `false`.
public func == <D: DictionaryProtocol> (lhs: D, rhs: D) -> Bool where
    D.Element == (D.Key, D.Value),
    D.Value: DictionaryProtocol,
    D.Value.Element == (D.Value.Key, D.Value.Value),
    D.Value.Value: Collection,
    D.Value.Value.Element: Equatable,
    D.Value.Value.Index == Int // FIXME: Find a way to do without this constraint
{
    for (key, lhsDict) in lhs {

        guard let rhsDict = rhs[key] else {
            return false
        }

        if lhsDict != rhsDict {
            return false
        }
    }
    return true
}


/// - returns: `true` if any values in `[H: [HH: [T]]]` types are not equivalent.
// Otherwise, `false`.
public func != <D: DictionaryProtocol> (lhs: D, rhs: D) -> Bool where
    D.Element == (D.Key, D.Value),
    D.Value: DictionaryProtocol,
    D.Value.Element == (D.Value.Key, D.Value.Value),
    D.Value.Value: Collection,
    D.Value.Value.Element: Equatable,
    D.Value.Value.Index == Int // FIXME: Find a way to do without this constraint
{
    return !(lhs == rhs)
}

extension Dictionary: DictionaryProtocol {

    // MARK: - `DictionaryProtocol`
}
