//
//  SortedDictionaryTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Structure
import SortedDictionary

class SortedDictionaryTests: XCTestCase {

    func testInsert() {

        var dict = SortedDictionary<Int, String>()
        dict.insert("one", key: 1)
        XCTAssertEqual(dict.count, 1)
        dict.insert("two", key: 2)
        XCTAssertEqual(dict.count, 2)
    }

    func testRemoveViaSubscript() {

        var dict = SortedDictionary<Int, String>()
        dict.insert("one", key: 1)
        XCTAssert(dict.count == 1)
        dict.insert("two", key: 2)
        XCTAssert(dict.count == 2)
        dict[2] = nil
        XCTAssert(dict.count == 1)
    }

    func testSorted() {

        var dict = SortedDictionary<Int, String>()
        dict.insert("two", key: 2)
        dict.insert("four", key: 4)
        dict.insert("five", key: 5)
        dict.insert("one", key: 1)
        dict.insert("three", key: 3)

        XCTAssertEqual(dict.keys, [1,2,3,4,5])
    }

    func testIterationSorted() {

        var dict = SortedDictionary<Int, String>()
        dict.insert("two", key: 2)
        dict.insert("four", key: 4)
        dict.insert("five", key: 5)
        dict.insert("one", key: 1)
        dict.insert("three", key: 3)

        XCTAssertEqual(dict.map { $0.0 }, [1,2,3,4,5])
        XCTAssertEqual(dict.map { $0.1 }, ["one", "two", "three", "four", "five"])
    }

    func testInsertContentsOfSortedDictionary() {

        var dict1 = SortedDictionary<Int, String>()
        dict1.insert("one", key: 1)
        dict1.insert("three", key: 3)

        var dict2 = SortedDictionary<Int, String>()
        dict2.insert("two", key: 2)
        dict2.insert("four", key: 4)

        dict1.insertContents(of: dict2)

        XCTAssertEqual(dict1.map { $0.0 }, [1,2,3,4])
        XCTAssertEqual(dict1.map { $0.1 }, ["one", "two", "three", "four"])
    }

    func testAdditionOperator() {

        var dict1 = SortedDictionary<Int, String>()
        dict1.insert("one", key: 1)
        dict1.insert("three", key: 3)

        var dict2 = SortedDictionary<Int, String>()
        dict2.insert("two", key: 2)
        dict2.insert("four", key: 4)

        let dict3 = dict1 + dict2

        XCTAssertEqual(dict3.map { $0.0 }, [1,2,3,4])
        XCTAssertEqual(dict3.map { $0.1 }, ["one", "two", "three", "four"])
    }

    func testValueItIndex() {

        var dict = SortedDictionary<Int, String>()
        dict.insert("one", key: 1)
        dict.insert("two", key: 2)
        dict.insert("three", key: 3)
        dict.insert("four", key: 4)

        XCTAssertNil(dict.value(at: 4))
        XCTAssertEqual(dict.value(at: 0), "one")
        XCTAssertEqual(dict.value(at: 1), "two")
    }

    func testGetSubscript() {

        var dict = SortedDictionary<Int, String>()
        dict.insert("one", key: 1)
        dict.insert("two", key: 2)
        dict.insert("three", key: 3)
        dict.insert("four", key: 4)

        XCTAssertNil(dict[0])
        XCTAssertEqual(dict[1], "one")
        XCTAssertEqual(dict[2], "two")
    }

    func testSubscriptWithFloatKey() {

        var dict = SortedDictionary<Float, String>()
        dict.insert("one", key: 1)
        dict.insert("two", key: 2)
        dict.insert("three", key: 3)
        dict.insert("four", key: 4)

        XCTAssertNil(dict[0.0])
        XCTAssertEqual(dict[1.0], "one")
        XCTAssertEqual(dict[2.0], "two")
    }

    func testSetSubscript() {

        var dict = SortedDictionary<Float, String>()
        dict[1.0] = "one_point_oh"
        dict[2.5] = "two_point_five"
        dict[3.3] = "three_point_three"

        XCTAssertNil(dict[0.0])
        XCTAssertEqual(dict[1.0], "one_point_oh")
        XCTAssertEqual(dict[2.5], "two_point_five")
        XCTAssertEqual(dict[3.3], "three_point_three")
    }
}
