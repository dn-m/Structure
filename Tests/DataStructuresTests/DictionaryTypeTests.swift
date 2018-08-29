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
        dict.safelyAppend(3, forKey: 0)
        XCTAssertEqual(dict[0]!, [0,1,2,3])
    }

    func testSafelyAppendToNotYetExisting() {
        var dict = [0: [0,1,2]]
        dict.safelyAppend(0, forKey: 1)
        XCTAssertEqual(dict[1]!, [0])
    }

    func testSafelyAppendContentsToExisting() {
        var dict = [0: [0,1,2]]
        dict.safelyAppend(contentsOf: [3,4,5], forKey: 0)
        XCTAssertEqual(dict[0]!, [0,1,2,3,4,5])
    }

    func testSafelyAppendContentsToNotYetExtant() {
        var dict = [0: [0,1,2]]
        dict.safelyAppend(contentsOf: [0,1,2], forKey: 1)
        XCTAssertEqual(dict[1]!, [0,1,2])
    }

    func testSafelyAndUniquelyAppendValuePreexisting() {
        var dict = [0: [0,1,2]]
        dict.safelyAndUniquelyAppend(1, forKey: 1)
        XCTAssertEqual(dict[0]!, [0,1,2])
    }

    func testSafelyAndUniquelyAppendValueNotExtant() {
        var dict = [0: [0,1,2]]
        dict.safelyAndUniquelyAppend(3, forKey: 0)
        XCTAssertEqual(dict[0]!, [0,1,2,3])
    }

    func testEnsureRangeReplaceableCollectionValueForKeyPreexisting() {
        var dict = [0: [0], 1: [1], 2: [2]]
        dict.ensureValue(forKey: 0)
        XCTAssertEqual(dict[1]!, [1])
    }

    func testEnsureRangeReplaceableCollectionValueForKeyNotYetExtant() {
        var dict = [0: [0], 1: [1], 2: [2]]
        dict.ensureValue(forKey: 3)
        XCTAssertEqual(dict[3]!, [])
    }

    func testEnsureDictionaryTypeValuePreexisting() {
        var dict = [0: [0: 0]]
        dict.ensureValue(forKey: 0)
        XCTAssertNotNil(dict[0])
    }

    func testEnsureDictionaryTypeValueNotYetExtant() {
        var dict = [0: [0: 0]]
        dict.ensureValue(forKey: 1)
        XCTAssertNotNil(dict[1])
    }

    func testSafelyInsertToExisting() {
        var dict: [Int: Set<Int>] = [0: [0,1,2]]
        dict.safelyInsert(3, forKey: 0)
        XCTAssertEqual(dict[0]!, [0,1,2,3])
    }

    func testSafelyInsertToNotYetExisting() {
        var dict: [Int: Set<Int>] = [0: [0,1,2]]
        dict.safelyInsert(0, forKey: 1)
        XCTAssertEqual(dict[1]!, [0])
    }

    func testSafelyInsertContentsToExisting() {
        var dict: [Int: Set<Int>] = [0: [0,1,2]]
        dict.safelyFormIntersection([3,4,5], forKey: 0)
        XCTAssertEqual(dict[0]!, [0,1,2,3,4,5])
    }

    func testSafelyInsertContentsToNotYetExtant() {
        var dict: [Int: Set<Int>] = [0: [0,1,2]]
        dict.safelyFormIntersection([0,1,2], forKey: 1)
        XCTAssertEqual(dict[1]!, [0,1,2])
    }

    func testEnsureSetAlgebraValueForKeyPreexisting() {
        var dict: [Int: Set<Int>] = [0: [0], 1: [1], 2: [2]]
        dict.ensureValue(forKey: 0)
        XCTAssertEqual(dict[1]!, [1])
    }

    func testEnsureSetAlgebraValueForKeyNotYetExtant() {
        var dict: [Int: Set<Int>] = [0: [0], 1: [1], 2: [2]]
        dict.ensureValue(forKey: 3)
        XCTAssertEqual(dict[3]!, [])
    }

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

    func testEqualitySimple() {
        let stringByInt = [1: "one", 2: "two", 3: "three"]
        XCTAssert(stringByInt == [1: "one", 2: "two", 3: "three"])
    }
}
