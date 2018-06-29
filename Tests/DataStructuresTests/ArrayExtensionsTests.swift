//
//  ArrayExtensionsTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 6/29/18.
//

import XCTest
import DataStructures

class ArrayExtensionsTests: XCTestCase {

    func testSafeSubscriptNil() {
        let array: [Int] = []
        XCTAssertNil(array[safe: 0])
    }

    func testSafeSubscriptValid() {
        let array = [1,2,3]
        XCTAssertEqual(array[safe: 2]!, 3)
    }

    func testSecondNil() {
        let array = [1]
        XCTAssertNil(array.second)
    }

    func testSecondVaild() {
        let array = [1,2]
        XCTAssertEqual(array.second!, 2)
    }

    func testPenultimateNil() {
        let array = [1]
        XCTAssertNil(array.penultimate)
    }

    func testPenultimateValid() {
        let array = [1,2]
        XCTAssertEqual(array.penultimate!, 1)
    }

    func testLastAmountEmpty() {
        let array: [Int] = []
        let last5 = array.last(amount: 5)
        XCTAssert(last5.isEmpty)
    }

    func testLastAmountTooMany() {
        let array = [1,2,3,4]
        let last5 = array.last(amount: 5)
        XCTAssert(last5.isEmpty)
    }

    func testLastAmountEquiv() {
        let array = [1,2,3,4,5]
        let last5 = array.last(amount: 5)
        XCTAssertEqual(last5, array)
    }

    func testLastAmountValid() {
        let array = [1,2,3,4,5]
        let last4 = array.last(amount: 4)
        XCTAssertEqual(last4, [2,3,4,5])
    }

    func testReplaceFirst() {
        var array = [1,2,3]
        array.replaceFirst(with: 4)
        XCTAssertEqual(array, [4,2,3])
    }

    func testReplaceLast() {
        var array = [1,2,3]
        array.replaceLast(with: 0)
        XCTAssertEqual(array, [1,2,0])
    }

    func testReplaceElementAtIndex() {
        var array: [Int] = [1,2]
        array.replaceElement(at: 1, with: 0)
        XCTAssertEqual(array, [1,0])
    }

    func testInsertingAtIndexAtBeginning() {
        let array = [1,2,3]
        XCTAssertEqual(array.inserting(0, at: 0), [0,1,2,3])
    }

    func testInsertingAtIndexInMiddle() {
        let array = [0,1,3]
        XCTAssertEqual(array.inserting(2, at: 2), [0,1,2,3])
    }

    func testInsertingAtIndexAtEnd() {
        let array = [0,1,2]
        XCTAssertEqual(array.inserting(3, at: 3), [0,1,2,3])
    }

    func testSplitAndExtractEmpty() {
        let array: [Int] = []
        XCTAssertNil(array.splitAndExtractElement(at: 0))
    }

    func testSplitAndExtractSingle() {

        let array: [Int] = [0]

        let expected: ([Int], Int, [Int]) = ([], 0, [])
        let result = array.splitAndExtractElement(at: 0)!

        XCTAssertEqual(expected.0, result.0)
        XCTAssertEqual(expected.1, result.1)
        XCTAssertEqual(expected.2, result.2)
    }

    func testSplitAndExtractMutlple() {

        let array: [Int] = [1,2,3,4,5]

        let expected = ([1,2], 3, [4,5])
        let result = array.splitAndExtractElement(at: 2)!

        XCTAssertEqual(expected.0, result.0)
        XCTAssertEqual(expected.1, result.1)
        XCTAssertEqual(expected.2, result.2)
    }
}
