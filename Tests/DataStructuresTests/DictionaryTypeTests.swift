//
//  DictionaryProtocolsTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import DataStructures

class DictionaryProtocolsTests: XCTestCase {

    func testSafelyAppendToExisting() {

        var dict = [0: [0,1,2]]
        dict.safelyAppend(3, toArrayWith: 0)

        XCTAssertEqual(dict[0]!, [0,1,2,3])
    }

    func testSafelyAppendToNotYetExisting() {

        var dict = [0: [0,1,2]]
        dict.safelyAppend(0, toArrayWith: 1)

        XCTAssertEqual(dict[1]!, [0])
    }

    func testSafelyAppendContentsToExisting() {

        var dict = [0: [0,1,2]]
        dict.safelyAppendContents(of: [3,4,5], toArrayWith: 0)

        XCTAssertEqual(dict[0]!, [0,1,2,3,4,5])
    }

    func testSafelyAppendContentsToNotYetExtant() {

        var dict = [0: [0,1,2]]
        dict.safelyAppendContents(of: [0,1,2], toArrayWith: 1)

        XCTAssertEqual(dict[1]!, [0,1,2])
    }

    func testSafelyAndUniquelyAppendValuePreexisting() {

        var dict = [0: [0,1,2]]
        dict.safelyAndUniquelyAppend(1, toArrayWith: 1)

        XCTAssertEqual(dict[0]!, [0,1,2])
    }

    func testSafelyAndUniquelyAppendValueNotExtant() {

        var dict = [0: [0,1,2]]
        dict.safelyAndUniquelyAppend(3, toArrayWith: 0)

        XCTAssertEqual(dict[0]!, [0,1,2,3])
    }

    func testEnsureArrayTypeValueForKeyPreexisting() {

        var dict = [0: [0], 1: [1], 2: [2]]
        dict.ensureValue(for: 0)

        XCTAssertEqual(dict[1]!, [1])
    }

    func testEnsureArrayTypeValueForKeyNotYetExtant() {

        var dict = [0: [0], 1: [1], 2: [2]]
        dict.ensureValue(for: 3)

        XCTAssertEqual(dict[3]!, [])
    }

    func testEnsureDictionaryTypeValuePreexisting() {

        var dict = [0: [0: 0]]
        dict.ensureValue(for: 0)

        XCTAssertNotNil(dict[0])
    }

    func testEnsureDictionaryTypeValueNotYetExtant() {

        var dict = [0: [0: 0]]
        dict.ensureValue(for: 1)

        XCTAssertNotNil(dict[1])
    }

//    func testUpdateValueForKeyPathThrowsAllIllFormed() {
//
//        var dict = ["parent": ["child": 0]]
//        XCTAssertThrowsError(try dict.update(1, keyPath: [1,2]))
//    }
//
//    func testEnsureValueForKeyPathIllFormedBadTypes() {
//
//        var dict: Dictionary<String, Dictionary<Int, Any>> = [:]
//        XCTAssertThrowsError(try dict.update("value", keyPath: [1, "root"]))
//    }
//
//    func testEnsureValueForKeyPathIllFormedBadKeyPathCount() {
//
//        var dict: Dictionary<String, Dictionary<Int, Any>> = [:]
//        XCTAssertThrowsError(try dict.update("value", keyPath: [1]))
//    }
//
//    func testUpdateValueForKeyPathThrowsRootIllFormed() {
//
//        var dict = ["parent": ["child": 0]]
//        XCTAssertThrowsError(try dict.update(1, keyPath: ["parent", 0]))
//    }
//
//    func testUpdateValueForKeyPathThrowsNestedIllFormed() {
//
//        var dict = ["parent": ["child": 0]]
//        XCTAssertThrowsError(try dict.update(1, keyPath: [1, "child"]))
//    }
//
//    func testUpdateValueForKeyPathStringKeys() {
//
//        var dict = ["parent": ["child": 0]]
//        try! dict.update(1, keyPath: "parent.child")
//
//        XCTAssertEqual(dict["parent"]!["child"], 1)
//    }
//
//    func testUpdateValueForKeyPathHeterogeneousKeys() {
//
//        var dict = ["0": [1: 2.0]]
//        try! dict.update(2.1, keyPath: ["0", 1])
//
//        XCTAssertEqual(dict["0"]![1], 2.1)
//    }

    func testMergeNewDictOvercomesOriginal() {

        var a = ["1": 1, "2": 2, "3": 3]
        let b = ["1": 0 ,"2": 1, "3": 2]
        a.merge(with: b)

        XCTAssertEqual(a,b)
    }

    func testMergedNewDictOvercomesOriginal() {

        let a = ["1": 1, "2": 2, "3": 3]
        let b = ["1": 0 ,"2": 1, "3": 2]
        let result = a.merged(with: b)
        let expected = b

        XCTAssertEqual(result, expected)
    }

    func testMergeNestedDict() {

        var a = ["1": ["a": 0], "2": ["b": 1], "3": ["c": 2]]
        let b =  ["1": ["a": 2], "2": ["b": 1], "3": ["c": 0]]
        a.merge(with: b)

        for (key, subDict) in a {
            XCTAssertEqual(subDict, b[key]!)
        }
    }

    func testMergedNestedDict() {

        let a = ["1": ["a": 0], "2": ["b": 1], "3": ["c": 2]]
        let b =  ["1": ["a": 2], "2": ["b": 1], "3": ["c": 0]]
        let result = a.merged(with: b)
        let expected = b

        for (key, subDict) in result {
            XCTAssertEqual(subDict, expected[key]!)
        }
    }

    func testDictionaryInitWithArrays() {

        let xs = [0,1,2,3,4]
        let ys = ["a","b","c","d","e"]

        let dict = Dictionary(xs,ys)

        XCTAssertEqual(dict[0], "a")
        XCTAssertEqual(dict[4], "e")
    }

    func testDictionaryInitWithArrayOfTuples() {

        let keysAndValues = [(1, "one"), (2, "two"), (3, "three")]
        _ = Dictionary(keysAndValues)
    }

// FIXME: Move to SortedDictionary
//    func testSortedDictionaryInitWithArraysSorted() {
//
//        let xs = [0,3,4,1,2]
//        let ys = ["a","d","e","b","c"]
//
//        let dict = SortedDictionary(xs,ys)
//
//        XCTAssertEqual(dict[0], "a")
//        XCTAssertEqual(dict[4], "e")
//    }

    func testEqualitySimple() {

        let stringByInt = [1: "one", 2: "two", 3: "three"]
        XCTAssert(stringByInt == [1: "one", 2: "two", 3: "three"])
    }
}
