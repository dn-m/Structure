//
//  NewType.swift
//  DataStructures
//
//  Created by James Bean on 8/20/18.
//

public protocol NewType {
    associatedtype Value
    var value: Value { get }
    init(value: Value)
}

extension NewType {
    public init(_ value: Value) {
        self.init(value: value)
    }
}

extension NewType where Value: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Value.IntegerLiteralType) {
        self.init(value: Value(integerLiteral: value))
    }
}

extension NewType where Value: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Value.FloatLiteralType) {
        self.init(value: Value(floatLiteral: value))
    }
}

extension NewType where
    Value: ExpressibleByArrayLiteral,
    Value: RangeReplaceableCollection,
    Value.ArrayLiteralElement == Value.Element
{
    public init(arrayLiteral values: Value.ArrayLiteralElement...) {
        self.init(value: Value(values))
    }
}

extension NewType where Value: Numeric {

    public var magnitude: Value.Magnitude {
        return value.magnitude
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        return Self(value: lhs.value + rhs.value)
    }

    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        return Self(value: lhs.value - rhs.value)
    }

    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    public static func * (lhs: Self, rhs: Self) -> Self {
        return Self(value: lhs.value * rhs.value)
    }

    public static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let value = Value(exactly: source) else { return nil }
        self.init(value: value)
    }
}

extension NewType where Value: SignedNumeric { }

extension NewType where Value: Sequence {
    public func makeIterator() -> Value.Iterator {
        return value.makeIterator()
    }
}

extension NewType where Value: Collection {

    public typealias Iterator = Value.Iterator

    /// Start index.
    public var startIndex: Value.Index {
        return value.startIndex
    }

    /// End index.
    public var endIndex: Value.Index {
        return value.endIndex
    }

    /// Index after given index `i`.
    public func index(after i: Value.Index) -> Value.Index {
        return value.index(after: i)
    }

    public var indices: Value.Indices {
        return value.indices
    }

    /// - returns: Element at the given `index`.
    public subscript (index: Value.Index) -> Value.Element {
        return value[index]
    }
}
