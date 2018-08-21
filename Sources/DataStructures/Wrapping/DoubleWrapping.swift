//
//  DoubleWrapping.swift
//  Math
//
//  Created by James Bean on 7/24/17.
//  Copyright © 2017 James Bean. All rights reserved.
//

// TODO: Add doc comments.
// - Wrap global functions as static methods in extensions, where possible.
public protocol DoubleWrapping:
    ExpressibleByFloatLiteral,
    ExpressibleByIntegerLiteral,
    Hashable,
    Comparable
{
    init(floatLiteral: Double)
    init(integerLiteral: Int)
    var value: Double { get set }
    init(_ double: Double)
}

extension DoubleWrapping {

    public init(_ double: Double) {
        self.init(floatLiteral: double)
    }
}

extension DoubleWrapping {

    // MARK: - Hashable

    public var hashValue: Int { return value.hashValue }
}

// MARK: - Comparable
public func == <T: DoubleWrapping>(lhs: T, rhs: T) -> Bool {
    return lhs.value == rhs.value
}

public func == <T: DoubleWrapping>(lhs: T, rhs: Double) -> Bool {
    return lhs.value == rhs
}

public func == <T: DoubleWrapping>(lhs: Double, rhs: T) -> Bool {
    return lhs == rhs.value
}

public func < <T: DoubleWrapping>(lhs: T, rhs: T) -> Bool {
    return lhs.value < rhs.value
}

public func < <T: DoubleWrapping>(lhs: T, rhs: Double) -> Bool {
    return lhs.value < rhs
}

public func < <T: DoubleWrapping>(lhs: Double, rhs: T) -> Bool {
    return lhs < rhs.value
}

// MARK: - Math
public func + <T: DoubleWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value + addend.value)
}

public func + <T: DoubleWrapping>(augend: T, addend: T) -> Double {
    return augend.value + addend.value
}

public func + <T: DoubleWrapping>(lhs: T, rhs: Double) -> Double {
    return lhs.value + rhs
}

public func + <T: DoubleWrapping>(lhs: Double, rhs: T) -> Double {
    return lhs + rhs.value
}

public func - <T: DoubleWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value - addend.value)
}

public func - <T: DoubleWrapping>(minuend: T, subtrahend: T) -> Double {
    return minuend.value - subtrahend.value
}

public func - <T: DoubleWrapping>(lhs: T, rhs: Double) -> Double {
    return lhs.value - rhs
}

public func - <T: DoubleWrapping>(lhs: Double, rhs: T) -> Double {
    return lhs - rhs.value
}

public func * <T: DoubleWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value * addend.value)
}

public func * <T: DoubleWrapping>(multiplicand: T, multiplier: T) -> Double {
    return multiplicand.value * multiplier.value
}

public func * <T: DoubleWrapping>(lhs: T, rhs: Double) -> Double {
    return lhs.value * rhs
}

public func * <T: DoubleWrapping>(lhs: Double, rhs: T) -> Double {
    return lhs * rhs.value
}

public func / <T: DoubleWrapping>(dividend: T, divisor: T) -> T {
    return T(floatLiteral: dividend.value / divisor.value)
}

public func / <T: DoubleWrapping>(dividend: T, divisor: T) -> Double {
    return dividend.value * divisor.value
}

public func / <T: DoubleWrapping>(lhs: T, rhs: Double) -> Double {
    return lhs.value / rhs
}

public func / <T: DoubleWrapping>(lhs: Double, rhs: T) -> Double {
    return lhs / rhs.value
}
