//
//  EnumComparableTests.swift
//  Structure
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import SumType

class EnumComparableTests: XCTestCase {

    enum E: Int {
        case a, b, c
    }

    func testLessThan() {
        XCTAssert(E.a < E.b)
    }

    func testNotLessThan() {
        XCTAssertFalse(E.c < E.a)
    }
}
