//
//  DestructureTests.swift
//  DestructureTests
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Destructure
import Restructure

class DestructureTests: XCTestCase {

    func testArraySliceDestructured() {
        let arraySlice: ArraySlice<Int> = [1,2,3]
        let (a,b) = arraySlice.destructured!
        XCTAssertEqual(1, a)
        XCTAssertEqual([2,3], b)
    }

    func testArraySliceDestructuredNil() {
        let arraySlice: ArraySlice<Int> = []
        XCTAssertNil(arraySlice.destructured)
    }

    func testArrayDestructured() {
        let array: Array<Int> = [1,2,3]
        let (a,b) = array.destructured!
        XCTAssertEqual(1, a)
        XCTAssertEqual([2,3], b)
    }

    func testArrayDestructuredNil() {
        let array: Array<Int> = []
        XCTAssertNil(array.destructured)
    }
}
