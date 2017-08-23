//
//  RotateTests.swift
//  StructureTests
//
//  Created by James Bean on 8/23/17.
//

import XCTest
import Structure

class RotateTests: XCTestCase {

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
