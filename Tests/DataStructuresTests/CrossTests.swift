//
//  CrossTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 10/20/18.
//

import XCTest
import DataStructures

class CrossTests: XCTestCase {

    func testComparableFalseEqual() {
        let a = Cross(1,1)
        let b = Cross(1,1)
        XCTAssertEqual(a,b)
        XCTAssertFalse(a < b)
    }

    func testComparableLexicographic() {
        let a = Cross(1,1)
        let b = Cross(1,2)
        XCTAssert(a < b)
        XCTAssert(b > a)
    }

    func testComparableLexicographicFalse() {
        let a = Cross(1,2)
        let b = Cross(1,1)
        XCTAssertFalse(a < b)
        XCTAssertFalse(b > a)
    }
}
