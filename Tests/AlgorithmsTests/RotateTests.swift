//
//  RotateTests.swift
//  AlgorithmsTests
//
//  Created by James Bean on 7/11/18.
//

import XCTest
import Algorithms

class RotateTests: XCTestCase {

    func testRotateBy0() {
        let array = [1,2,3,4]
        XCTAssertEqual(array.rotated(by: 0), array)
    }

    func testRotateBy1() {
        let array = [1,2,3,4]
        XCTAssertEqual(array.rotated(by: 1), [2,3,4,1])
    }

    func testRotateByGreaterThanCount() {
        let array = [1,2,3,4]
        XCTAssertEqual(array.rotated(by: 5), [2,3,4,1])
    }

    func testRotateByNegative1() {
        let array = [1,2,3,4]
        XCTAssertEqual(array.rotated(by: -1), [4,1,2,3])
    }
}
