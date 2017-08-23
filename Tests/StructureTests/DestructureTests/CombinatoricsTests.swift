//
//  CombinatoricsTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
@testable import Structure

class CombinatoricsTests: XCTestCase {

    func testCombinationsOfTwoArrays() {
        let array1 = [1,2,3]
        let array2 = [4,5]
        XCTAssertEqual(combinations(array1, array2).count, 6)
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
