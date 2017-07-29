//
//  Bitwise.swift
//  Bitwise
//
//  Created by James Bean on 1/8/17.
//  Copyright © 2017 James Bean. All rights reserved.
//

private let intBitCount = MemoryLayout<Int>.size * 8

/// Count Trailing Zeros (ctz) counts the number of zero bits succeeding the least
/// significant one bit. For example, the ctz of 0x00000F00 is 8, and the ctz of
/// 0x80000000 is 31. This also counts the exponent of the `2` factor in the prime
/// factorization of a positive number.
public func countTrailingZeros(_ n: Int) -> Int {

    var mask = 1

    for index in 0...intBitCount {

        if mask & n != 0 {
            return index
        }

        mask <<= 1
    }

    return intBitCount
}

/// Count Leading Zeros (clz) counts the number of zero bits preceding the most
/// significant one bit. For example, the clz of 0x00F00000 is 8, and the clz of
/// 0x00000001 is 31.
public func countLeadingZeros(_ n: Int) -> Int {

    var mask = 1 << (intBitCount - 1)

    for index in 0...intBitCount {

        if mask & n != 0 {
            return index
        }

        mask >>>= 1
    }

    return intBitCount
}

infix operator >>> : BitwiseShiftPrecedence

/// Logical right shift.
public func >>> (lhs: Int, rhs: Int) -> Int {
    return Int(bitPattern: UInt(bitPattern: lhs) >> UInt(rhs))
}

infix operator >>>= : BitwiseShiftPrecedence

/// Logical right shift assignment.
public func >>>= (lhs: inout Int, rhs: Int) {
    lhs = lhs >>> rhs
}
