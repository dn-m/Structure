//
//  CombinationsTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Structure

class CombinationsTests: XCTestCase {

    func testCombinations() {
        let array1 = [1,2,3]
        let array2 = [4,5]
        XCTAssertEqual(combinations(array1, array2).count, 6)
    }
}
