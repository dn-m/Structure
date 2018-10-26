//
//  OrderedTests.swift
//  AlgorithmsTests
//
//  Created by James Bean on 8/8/18.
//

import XCTest
import Algorithms

class OrderedTests: XCTestCase {

    func testOrderedEqual() {
        let a = 4
        let b = 4
        let (newA, newB) = ordered(a, b)
        XCTAssertEqual(newA, a)
        XCTAssertEqual(newB, b)
    }

    func testOrderInOrder() {
        let a = 4
        let b = 5
        let (newA, newB) = ordered(a, b)
        XCTAssertEqual(newA, a)
        XCTAssertEqual(newB, b)
    }

    func testOrderNeedsOrdering() {
        let a = 5
        let b = 4
        let (newB, newA) = ordered(a, b)
        XCTAssertEqual(newA, a)
        XCTAssertEqual(newB, b)
    }
}
