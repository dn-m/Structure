//
//  MetatypeTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 9/10/18.
//

import XCTest
import DataStructures

class MetatypeTests: XCTestCase {

    func testInit() {
        let _ = Metatype(String.self)
        let _ = Metatype(Int.self)
        let _ = Metatype(type(of: 42.0))
    }

    func testEquatable() {
        let a = Metatype(Int.self)
        let b = Metatype(type(of: 1))
        XCTAssertEqual(a,b)
    }

    func testEquatableFalse() {
        let a = Metatype(String.self)
        let b = Metatype(type(of: 1))
        XCTAssertNotEqual(a,b)
    }

    func testHashableEqual() {
        let a = Metatype(String.self)
        let b = Metatype(type(of: "test"))
        XCTAssertEqual(a.hashValue, b.hashValue)
    }

    func testHashableNotEqual() {
        let a = Metatype(Int.self)
        let b = Metatype(type(of: "test"))
        XCTAssertNotEqual(a.hashValue, b.hashValue)
    }
}
