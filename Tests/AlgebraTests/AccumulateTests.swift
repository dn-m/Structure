//
//  AccumulateTests.swift
//  Algebra
//
//  Created by James Bean on 7/19/17.
//
//

import XCTest
import Algebra

class AccumulateTests: XCTestCase {

    func testIntArrayAccumulatingSum() {
        let array = [1,2,3]
        XCTAssertEqual(array.accumulatingSum, [0,1,3])
    }

    func testFloatArrayAccumulatingSum() {

        let array = [1.1, 2.2, 3.3]
        let expected = [0, 1.1, 3.3]

        zip(array.accumulatingSum, expected).forEach { actual, expected in
            XCTAssertEqual(actual, expected, accuracy: 0.000001)
        }
    }

    func testAccumulatingProduct() {
        let numbers = [2,1,2]
        let accumulated = numbers.accumulatingProduct
        XCTAssertEqual(accumulated, [1,2,2])
    }
}
