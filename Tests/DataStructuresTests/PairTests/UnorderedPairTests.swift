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

    func testManyHashValuesIntForCollisions() {
        for _ in 0 ..< 1_000_000 {
            let a = UnorderedPair(Int.random(in: .min ... .max), Int.random(in: .min ... .max))
            let b = UnorderedPair(Int.random(in: .min ... .max), Int.random(in: .min ... .max))
            if a == b {
                XCTAssertEqual(a.hashValue, b.hashValue)
            } else {
                XCTAssertNotEqual(a.hashValue, b.hashValue)
            }
        }
    }

    func testManyHashValuesStringForCollisions() {
        for _ in 0 ..< 1_000_000 {
            let a = UnorderedPair(randomString(), randomString())
            let b = UnorderedPair(randomString(), randomString())
            if a == b {
                XCTAssertEqual(a.hashValue, b.hashValue)
            } else {
                XCTAssertNotEqual(a.hashValue, b.hashValue)
            }
        }
    }
    
    func testMap() {
        let start = UnorderedPair("a","ab")
        let expected = UnorderedPair(1,2)
        XCTAssertEqual(start.map { $0.count }, expected)
    }

    func testDescription() {
        XCTAssertEqual(UnorderedPair("a","z").description, "{a,z}")
    }
}

func randomString(maxLength: Int = 10) -> String {
    let alphaNumeric = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let count = Int.random(in: 1 ..< maxLength)
    return String((0..<count).map { _ in alphaNumeric.randomElement()! })
}
