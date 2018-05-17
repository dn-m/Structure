//
//  OrderedDictionaryTests.swift
//  Structure
//
//  Created by James Bean on 12/10/16.
//
//

import XCTest
import DataStructures

class OrderedDictionaryTests: XCTestCase {

    func emptyDict() -> OrderedDictionary<String, String> {
        return OrderedDictionary<String, String>()
    }

    func testInit() {
        let dict = OrderedDictionary<String, String>()
        XCTAssertEqual(dict.count, 0)
    }

    func testSubscriptKeyNil() {
        let dict = emptyDict()
        XCTAssertNil(dict["zero"])
    }

    func testSubscriptIntValid() {

        var dict = emptyDict()
        dict.insert("val", key: "key", index: 0)

        XCTAssertEqual(dict.value(index: 0), "val")
    }

    func testSubscriptKeyValid() {

        var dict = emptyDict()
        dict.insert("val", key: "key", index: 0)

        XCTAssertEqual(dict["key"]!, "val")
    }

    func testInsert() {

        var dict = OrderedDictionary<String, String>()
        dict.insert("val", key: "key", index: 0)
        dict.insert("insertedVal", key: "insertedKey", index: 0)

        XCTAssertEqual(dict.value(index: 0), "insertedVal")
        XCTAssertEqual(dict.value(index: 1), "val")
    }

    func testAppend() {

        var dict = OrderedDictionary<String, String>()
        dict.append("val", key: "key")
        dict.append("anotherVal", key: "anotherKey")

        XCTAssertEqual(dict.value(index: 0), "val")
        XCTAssertEqual(dict.value(index: 1), "anotherVal")
    }

    func testAppendContentsOfEmptyDict() {

        var dict1 = emptyDict()
        let dict2 = emptyDict()
        dict1.appendContents(of: dict2)

        XCTAssertEqual(dict1.count, 0)
        XCTAssertEqual(dict2.count, 0)
    }

    func testAppendContentsOfNonEmptyToEmptyDict() {

        var dict1 = emptyDict()
        var dict2 = emptyDict()
        dict2.insert("val", key: "key", index: 0)
        dict1.appendContents(of: dict2)

        XCTAssertEqual(dict1.count, 1)
    }

    func testAppendContentsOfEmptyToNonEmptyDict() {

        var dict1 = emptyDict()
        dict1.insert("val", key: "key", index: 0)

        let dict2 = emptyDict()
        dict1.appendContents(of: dict2)

        XCTAssertEqual(dict1.count, 1)
    }

    func testIterationOrdered() {

        var dict = OrderedDictionary<Int, String>()
        dict[1] = "one"
        dict[2] = "two"
        dict[3] = "three"
        dict[4] = "four"
        dict[5] = "five"

        XCTAssertEqual(dict.map { $0.0 }, [1, 2, 3, 4, 5])
        XCTAssertEqual(dict.map { $0.1 }, ["one", "two", "three", "four", "five"])
    }

    func testEquatable() {
        let a: OrderedDictionary = [1: "one", 2: "two", 3: "three"]
        let b: OrderedDictionary = [1: "one", 2: "two", 3: "three"]
        XCTAssertEqual(a,b)
    }
}
