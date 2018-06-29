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
}
