//
//  IntegerWrapping.swift
//  Math
//
//  Created by James Bean on 1/2/17.
//  Copyright © 2017 James Bean. All rights reserved.
//

public protocol IntegerWrapping: ExpressibleByIntegerLiteral, Hashable, Comparable {

    var value: Int { get }

    init(integerLiteral: Int)
}

extension IntegerWrapping {

    // MARK: - Equatable

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}

extension IntegerWrapping {

    // MARK: - Comparable

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
    }
}

extension IntegerWrapping {

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

public func == <T: IntegerWrapping>(lhs: T, rhs: Int) -> Bool {
    return lhs.value == rhs
}

public func == <T: IntegerWrapping>(lhs: Int, rhs: T) -> Bool {
    return lhs == rhs.value
}

public func < <T: IntegerWrapping>(lhs: T, rhs: Int) -> Bool {
    return lhs.value < rhs
}

public func < <T: IntegerWrapping>(lhs: Int, rhs: T) -> Bool {
    return lhs < rhs.value
}

// MARK: - Math
public func + <T: IntegerWrapping>(augend: T, addend: T) -> T {
    return T(integerLiteral: augend.value + addend.value)
}

public func + <T: IntegerWrapping>(augend: T, addend: T) -> Int {
    return augend.value + addend.value
}

public func + <T: IntegerWrapping>(lhs: T, rhs: Int) -> Int {
    return lhs.value + rhs
}

public func + <T: IntegerWrapping>(lhs: Int, rhs: T) -> Int {
    return lhs + rhs.value
}

public func - <T: IntegerWrapping>(augend: T, addend: T) -> T {
    return T(integerLiteral: augend.value - addend.value)
}

public func - <T: IntegerWrapping>(minuend: T, subtrahend: T) -> Int {
    return minuend.value - subtrahend.value
}

public func - <T: IntegerWrapping>(lhs: T, rhs: Int) -> Int {
    return lhs.value - rhs
}

public func - <T: IntegerWrapping>(lhs: Int, rhs: T) -> Int {
    return lhs - rhs.value
}

public func * <T: IntegerWrapping>(augend: T, addend: T) -> T {
    return T(integerLiteral: augend.value * addend.value)
}

public func * <T: IntegerWrapping>(multiplicand: T, multiplier: T) -> Int {
    return multiplicand.value * multiplier.value
}

public func * <T: IntegerWrapping>(lhs: T, rhs: Int) -> Int {
    return lhs.value * rhs
}

public func * <T: IntegerWrapping>(lhs: Int, rhs: T) -> Int {
    return lhs * rhs.value
}

public func / <T: IntegerWrapping>(augend: T, addend: T) -> T {
    return T(integerLiteral: augend.value / addend.value)
}

public func / <T: IntegerWrapping>(dividend: T, divisor: T) -> Int {
    return dividend.value * divisor.value
}

public func / <T: IntegerWrapping>(lhs: T, rhs: Int) -> Int {
    return lhs.value / rhs
}

public func / <T: IntegerWrapping>(lhs: Int, rhs: T) -> Int {
    return lhs / rhs.value
}
