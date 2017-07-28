//
//  ComparisonTests.swift
//  Structure
//
//  Created by James Bean on 7/11/17.
//
//

import XCTest
import Structure

class ComparisonTests: XCTestCase {

    func testCompareIntsEqual() {
        XCTAssertEqual(compare(5,5), Comparison.equal)
    }

    func testCompareIntsLessThan() {
        XCTAssertEqual(compare(3,6), Comparison.lessThan)
    }

    func testCompareIntsGreaterThan() {
        XCTAssertEqual(compare(6,3), Comparison.greaterThan)
    }
}
