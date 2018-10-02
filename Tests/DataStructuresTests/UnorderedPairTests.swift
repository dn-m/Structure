//
//  UnorderedPairTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 10/1/18.
//

import XCTest
import DataStructures

class UnorderedPairTests: XCTestCase {

    func testEquatable() {
        let p1 = UnorderedPair("a","b")
        let p2 = UnorderedPair("b","a")
        XCTAssertEqual(p1, p2)
    }

    func testHashValue() {
        let p1 = UnorderedPair("a","b")
        let p2 = UnorderedPair("b","a")
        XCTAssertEqual(p1.hashValue, p2.hashValue)
    }
}
