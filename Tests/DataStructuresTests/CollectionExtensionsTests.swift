//
//  CollectionExtensionsTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 6/29/18.
//

import XCTest
import DataStructures

class CollectionExtensionsTests: XCTestCase {
    
    func testIsHomogenousEmptyTrue() {
        XCTAssert(Array<Int>().isHomogeneous)
    }

    func testIsHomogenousSingleElementTrue() {
        XCTAssert([1].isHomogeneous)
    }

    func testIsHomoegeneous() {
        XCTAssert([1,1,1,1,1].isHomogeneous)
    }

    func testIsHomogeneousFail() {
        XCTAssertFalse([1,2,1,1].isHomogeneous)
    }

    func testIsHeterogeneousFalse() {
        XCTAssertFalse([1,1,1,1,1].isHeterogeneous)
    }

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
