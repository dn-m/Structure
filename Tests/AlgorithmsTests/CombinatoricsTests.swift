//
//  CombinatoricsTests.swift
//  AlgorithmsTests
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
@testable import Algorithms

class CombinatoricsTests: XCTestCase {

    func testCartesianProductOfTwoArrays() {
        let a = [1,2,3]
        let b = [4,5]
        let result = cartesianProduct(a,b)
        let expected = [(1,4),(1,5),(2,4),(2,5),(3,4),(3,5)]
        XCTAssertEqual(result.count, expected.count)
        zip(result,expected).forEach { a,b in
            XCTAssertEqual(a.0,b.0)
            XCTAssertEqual(a.1,b.1)
        }
    }

    func testPermutationsEmpty() {
        let values: [Int] = []
        let permutations = values.permutations
        XCTAssert(values.permutations.isEmpty)
    }

    func testPermutations() {
        let array = [1,2,3]
        let expected = [[1, 2, 3], [2, 1, 3], [2, 3, 1], [1, 3, 2], [3, 1, 2], [3, 2, 1]]
        XCTAssertEqual(array.permutations, expected)
    }
}
