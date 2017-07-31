//
//  SequenceAlgebraTests.swift
//  Structure
//
//  Created by James Bean on 7/19/17.
//
//

import XCTest
import Structure

class SequenceAlgebraTests: XCTestCase {

    func testSumOfAdditiveSemigroup() {
        let array: [Int] = [1,2,3,4]
        XCTAssertEqual(array.nonEmptySum, 10)
    }

    func testSetIntersections() {
        let sets: [Set<Int>] = [[1,2,3,4,5,6],[2,3,4,5],[3,4,5,6,7],[1,4,5]]
        XCTAssertEqual(sets.nonEmptyProduct, [4,5])
    }
}
