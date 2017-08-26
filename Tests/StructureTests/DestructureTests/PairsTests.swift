//
//  PairsTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Structure

class PairsTests: XCTestCase {

    func testPairsNotWrapping() {
        let array = [1,9,2,8,3,7,4,6,5]
        let expected = [(1,9),(9,2),(2,8),(8,3),(3,7),(7,4),(4,6),(6,5)]
        zip(array.pairs, expected).forEach { a,b in
            XCTAssertEqual(a.0, b.0)
            XCTAssertEqual(a.1, b.1)
        }
    }

    func testPairsWrapping() {
        let array = [1,9,2,8,3,7,4,6,5]
        let expected = [(1,9),(9,2),(2,8),(8,3),(3,7),(7,4),(4,6),(6,5),(5,1)]
        let wrappedPairs = array.wrapped.pairs
        zip(wrappedPairs, expected).forEach { a,b in
            XCTAssertEqual(a.0, b.0)
            XCTAssertEqual(a.1, b.1)
        }
    }
}
