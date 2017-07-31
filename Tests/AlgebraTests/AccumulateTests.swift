//
//  AccumulateTests.swift
//  AlgebraTests
//
//  Created by James Bean on 7/31/17.
//

import XCTest
import Algebra

class AccumulateTests: XCTestCase {
    
    func testIntArrayCumulativeRight() {
        let array = [1,2,3]
        XCTAssertEqual(array.accumulatingRight, [0,1,3])
    }

    func testFloatArrayCumulativeRight() {

        let array = [1.1, 2.2, 3.3]
        let expected = [0, 1.1, 3.3]

        zip(array.accumulatingRight, expected).forEach { actual, expected in
            XCTAssertEqual(actual, expected, accuracy: 0.000001)
        }
    }

    func testIntArrayCumulativeLeft() {
        let array = [1,2,3]
        XCTAssertEqual(array.accumulatingLeft, [0,3,5])
    }

    func testFloatArrayCumulativeLeft() {

        let array = [1.1, 2.2, 3.3]
        let expected = [0, 3.3, 5.5]

        zip(array.accumulatingLeft, expected).forEach { actual, expected in
            XCTAssertEqual(actual, expected, accuracy: 0.000001)
        }
    }
}
