//
//  SubsetsTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Structure

class SubsetsTests: XCTestCase {

    func testSubsetsEmptyEmpty() {
        let array: [Int] = []
        XCTAssert(array.subsets(cardinality: 2).isEmpty)
    }

    func testSubsetsCarinalityGreaterThanCountEmpty() {
        let array = [1,2]
        XCTAssert(array.subsets(cardinality: 3).isEmpty)
    }

    func testSubsetsDouble() {
        let array = [1,2]
        XCTAssert([[1],[2]] == array.subsets(cardinality: 1))
    }

    func testSubsetsTriple() {
        let array = [1,2,3]
        XCTAssert([[1,2],[1,3],[2,3]] == array.subsets(cardinality: 2))
    }

    func testSubsetsQuadruple() {
        let array = [1,2,3,4]
        XCTAssert(
            [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]] ==
                array.subsets(cardinality: 2)
        )
    }
}

private func == <T: Equatable> (lhs: [[T]], rhs: [[T]]) -> Bool {
    for pair in zip(lhs, rhs) {
        if pair.0 != pair.1 {
            return false
        }
    }
    return true
}
