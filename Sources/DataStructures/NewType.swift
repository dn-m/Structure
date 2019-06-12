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

extension NewType where Value: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}

extension NewType where Value: Hashable {
    public var hashValue: Int {
        return value.hashValue
    }
}

extension NewType where Value: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
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
