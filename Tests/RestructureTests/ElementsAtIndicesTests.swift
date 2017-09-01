//
//  ElementsAtIndicesTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Restructure

class ElementsAtIndicesTests: XCTestCase {

    func testSafeSubscriptNil() {
        let array: [Int] = []
        XCTAssertNil(array[safe: 0])
    }

    func testSafeSubscriptValid() {
        let array = [1,2,3]
        XCTAssertEqual(array[safe: 2]!, 3)
    }

    func testSecondNil() {
        let array = [1]
        XCTAssertNil(array.second)
    }

    func testSecondVaild() {
        let array = [1,2]
        XCTAssertEqual(array.second!, 2)
    }

    func testPenultimateNil() {
        let array = [1]
        XCTAssertNil(array.penultimate)
    }

    func testPenultimateValid() {
        let array = [1,2]
        XCTAssertEqual(array.penultimate!, 1)
    }

    func testLastAmountEmpty() {
        let array: [Int] = []
        let last5 = array.last(amount: 5)
        XCTAssert(last5.isEmpty)
    }

    func testLastAmountTooMany() {
        let array = [1,2,3,4]
        let last5 = array.last(amount: 5)
        XCTAssert(last5.isEmpty)
    }

    func testLastAmountEquiv() {
        let array = [1,2,3,4,5]
        let last5 = array.last(amount: 5)
        XCTAssertEqual(last5, array)
    }

    func testLastAmountValid() {
        let array = [1,2,3,4,5]
        let last4 = array.last(amount: 4)
        XCTAssertEqual(last4, [2,3,4,5])
    }
}
