//
//  TupleMapTests.swift
//  Structure
//
//  Created by James Bean on 2/2/17.
//
//

import XCTest
import Restructure

class TupleMapTests: XCTestCase {

    func testMapAB() {
        XCTAssert(map(1,2) { $0 * 2 } == (2,4))
    }

    func testMapABC() {
        XCTAssert(map(1,2,3) { $0 * 3 } == (3,6,9))
    }

    func testMapTupleAB() {
        XCTAssert(map((1,2)) { $0 * 2 } == (2,4))
    }

    func testMapTupleABC() {
        XCTAssert(map((1,2,3)) { $0 * 3 } == (3,6,9))
    }
}
