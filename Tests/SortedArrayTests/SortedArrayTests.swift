//
//  SortedArrayTests.swift
//  Structure
//
//  Created by James Bean on 12/10/16.
//
//

import XCTest
import Algebra
import StructureWrapping
import SortedArray

class SortedArrayTests: XCTestCase {

    func testInitEmpty() {
        let sortedArray: SortedArray<Int> = SortedArray()
        XCTAssertEqual(sortedArray, [])
    }

    func testInitWithArraySorted() {
        let array = [1,5,4,3,2]
        let sortedArray = SortedArray(array)
        XCTAssertEqual(sortedArray, [1,2,3,4,5])
    }

    func testInsertAtBeginning() {
        var sortedArray: SortedArray = [2,3,4,5]
        sortedArray.insert(1)
        XCTAssertEqual(sortedArray, [1,2,3,4,5])
    }

    func testInsertAtEnd() {
        var sortedArray: SortedArray = [1,2,3,4]
        sortedArray.insert(5)
        XCTAssertEqual(sortedArray, [1,2,3,4,5])
    }

    func testInsertInMiddle() {
        var sortedArray: SortedArray = [1,2,4,5]
        sortedArray.insert(3)
        XCTAssertEqual(sortedArray, [1,2,3,4,5])
    }

    func testRemove() {
        var sortedArray: SortedArray = [1,2,3,4,5]
        sortedArray.remove(3)
        XCTAssertEqual(sortedArray, [1,2,4,5])
    }

    func testInsertElements() {
        var a: SortedArray = [1,3,5]
        let b: SortedArray = [2,4,6]
        a.insert(contentsOf: b)
        XCTAssertEqual(a, [1,2,3,4,5,6])
    }

    func testAdd() {
        let a: SortedArray = [1,2,5,6]
        let b: SortedArray = [3,4]
        XCTAssertEqual(a + b, [1,2,3,4,5,6])
    }

    func testStartIndex() {
        let sortedArray: SortedArray = [1]
        XCTAssertEqual(sortedArray.startIndex, 0)
    }

    func testEndIndex() {
        let sortedArray: SortedArray = [1,2]
        XCTAssertEqual(sortedArray.endIndex, sortedArray.count)
    }

    func testSubscript() {
        let sortedArray: SortedArray = [1]
        XCTAssertEqual(sortedArray[0], 1)
    }

    func testIndex() {
        let sortedArray: SortedArray = [1,2,3]
        XCTAssertEqual(sortedArray.index(after: 2), 3)
    }
}
