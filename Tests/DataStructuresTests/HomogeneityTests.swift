//
//  HomogeneityTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 7/11/18.
//

import XCTest
import DataStructures

class HomogeneityTests: XCTestCase {
    
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
