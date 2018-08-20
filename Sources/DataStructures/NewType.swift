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

extension NewType where Value: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Value.IntegerLiteralType) {
        self.init(value: Value(integerLiteral: value))
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
