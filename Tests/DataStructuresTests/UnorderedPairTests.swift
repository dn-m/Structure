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

    func testHashValuesString() {
        let p1 = UnorderedPair("a","b")
        let p2 = UnorderedPair("b","a")
        XCTAssertEqual(p1.hashValue, p2.hashValue)
    }

    func testHashValuesInt() {
        let p1 = UnorderedPair(1,2)
        let p2 = UnorderedPair(2,1)
        XCTAssertEqual(p1.hashValue, p2.hashValue)
    }

    func testManyHashValuesString() {
        let p = UnorderedPair("a","b")
        for _ in 0 ..< 1_000_000 {
            _ = p.hashValue
        }
    }
}
