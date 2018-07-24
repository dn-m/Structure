//
//  DestructureTests.swift
//  DestructureTests
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Destructure

class DestructureTests: XCTestCase {

    func testArraySliceDestructured() {
        let values = [1,2,3]
        let (a,b) = values.destructured!
        XCTAssertEqual(1, a)
        XCTAssertEqual([2,3], b.map { $0 })
    }

    func testArraySliceDestructuredNil() {
        let arraySlice: ArraySlice<Int> = []
        XCTAssertNil(arraySlice.destructured)
    }

    func testArrayDestructured() {
        let values = [1,2,3]
        let (a,b) = values.destructured!
        XCTAssertEqual(1, a)
        XCTAssertEqual([2,3], b.map { $0 })
    }

    func testArrayDestructuredNil() {
        let array: Array<Int> = []
        XCTAssertNil(array.destructured)
    }
}
