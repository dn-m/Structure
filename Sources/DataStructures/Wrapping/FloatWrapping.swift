//
//  FloatWrapping.swift
//  Math
//
//  Created by James Bean on 5/10/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

// TODO: Add doc comments.
// - Wrap global functions as static methods in extensions, where possible.
public protocol FloatWrapping:
    ExpressibleByFloatLiteral,
    ExpressibleByIntegerLiteral,
    Hashable,
    Comparable
{
    init(floatLiteral: Float)
    init(integerLiteral: Int)
    var value: Float { get set }
    init(_ float: Float)
}

extension FloatWrapping {

    public init(_ float: Float) {
        self.init(floatLiteral: float)
    }
}


extension FloatWrapping {

    // MARK: - `Hashable`

    public var hashValue: Int { return value.hashValue }
}

// MARK: - Comparable
public func == <T: FloatWrapping>(lhs: T, rhs: T) -> Bool {
    return lhs.value == rhs.value
}

public func == <T: FloatWrapping>(lhs: T, rhs: Float) -> Bool {
    return lhs.value == rhs
}

public func == <T: FloatWrapping>(lhs: Float, rhs: T) -> Bool {
    return lhs == rhs.value
}

public func < <T: FloatWrapping>(lhs: T, rhs: T) -> Bool {
    return lhs.value < rhs.value
}

public func < <T: FloatWrapping>(lhs: T, rhs: Float) -> Bool {
    return lhs.value < rhs
}

public func < <T: FloatWrapping>(lhs: Float, rhs: T) -> Bool {
    return lhs < rhs.value
}

// MARK: - Math
public func + <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value + addend.value)
}

public func + <T: FloatWrapping>(augend: T, addend: T) -> Float {
    return augend.value + addend.value
}

public func + <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value + rhs
}

public func + <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs + rhs.value
}

public func - <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value - addend.value)
}

public func - <T: FloatWrapping>(minuend: T, subtrahend: T) -> Float {
    return minuend.value - subtrahend.value
}

public func - <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value - rhs
}

public func - <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs - rhs.value
}

public func * <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value * addend.value)
}

public func * <T: FloatWrapping>(multiplicand: T, multiplier: T) -> Float {
    return multiplicand.value * multiplier.value
}

public func * <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value * rhs
}

public func * <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs * rhs.value
}

public func / <T: FloatWrapping>(dividend: T, divisor: T) -> T {
    return T(floatLiteral: dividend.value / divisor.value)
}

public func / <T: FloatWrapping>(dividend: T, divisor: T) -> Float {
    return dividend.value * divisor.value
}

public func / <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value / rhs
}

public func / <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs / rhs.value
}
