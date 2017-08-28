//
//  CombinatoricsTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
@testable import Combinatorics

class CombinatoricsTests: XCTestCase {

    func testCombinationsOfTwoArrays() {
        let result = [1,2,3] * [4,5]
        let expected = [(1,4),(1,5),(2,4),(2,5),(3,4),(3,5)]
        XCTAssertEqual(result.count, 6)
        zip(result,expected).forEach { a,b in
            XCTAssertEqual(a.0,b.0)
            XCTAssertEqual(a.1,b.1)
        }
    }

    func testInjecting() {
        let values = [1,2,3]
        let result = injecting(0, into: values)
        let expected = [[0, 1, 2, 3], [1, 0, 2, 3], [1, 2, 0, 3], [1, 2, 3, 0]]
        XCTAssertEqual(result.count, expected.count)
        zip(result,expected).forEach { (a,b) in XCTAssertEqual(a,b) }
    }

    func testPermutations() {
        let array = [1,2,3]
        let expected = [[1, 2, 3], [2, 1, 3], [2, 3, 1], [1, 3, 2], [3, 1, 2], [3, 2, 1]]
        XCTAssertEqual(expected.count, array.permutations.count)
        zip(array.permutations, expected).forEach { a,b in XCTAssertEqual(a,b) }
    }
}
