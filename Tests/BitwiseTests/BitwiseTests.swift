//
//  BitwiseOperationsTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 1/8/17.
//  Copyright © 2017 James Bean. All rights reserved.
//

import XCTest
import Bitwise

class BitwiseOperationsTests: XCTestCase {

    let intBitCount = MemoryLayout<Int>.size * 8

    func testCountLeadingZeros() {
        XCTAssertEqual(countLeadingZeros(-1), 0)
        XCTAssertEqual(countLeadingZeros(-112348123), 0)
        XCTAssertEqual(countLeadingZeros(-2), 0)
        XCTAssertEqual(countLeadingZeros(0), intBitCount)
        XCTAssertEqual(countLeadingZeros(1), intBitCount-1)
        XCTAssertEqual(countLeadingZeros(3), intBitCount-2)
    }

    func testCoundLeadingZeros64Bit() {
        #if (arch(x86_64) || arch(arm64))
            XCTAssertEqual(countLeadingZeros(-0x8000000000000000), 0)
            XCTAssertEqual(countLeadingZeros(0x7FFFFFFFFFFFFFFF), 1)
            XCTAssertEqual(countLeadingZeros(0x3FFFFFFFFFFFFFFF), 2)
            XCTAssertEqual(countLeadingZeros(0x0FFFFFFFFFFFFFFF), 4)
        #endif
    }

    func testCountTrailingZeros() {
        XCTAssertEqual(countTrailingZeros(-1), 0)
        XCTAssertEqual(countTrailingZeros(-112348124), 2)
        XCTAssertEqual(countTrailingZeros(-2), 1)
    }

    func testCountTrailingZeros64Bit() {
        #if (arch(x86_64) || arch(arm64))
            XCTAssertEqual(countTrailingZeros(0), intBitCount)
            XCTAssertEqual(countTrailingZeros(1), 0)
            XCTAssertEqual(countTrailingZeros(2), 1)
            XCTAssertEqual(countTrailingZeros(-0x8000000000000000), intBitCount-1)
            XCTAssertEqual(countTrailingZeros(0x1000000000000000), 60)
            XCTAssertEqual(countTrailingZeros(0x2000000000000000), 61)
            XCTAssertEqual(countTrailingZeros(0x1ABCDEF400000000), 4 * 8 + 2)
        #endif
    }
}
