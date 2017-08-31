//
//  ReplaceElementsTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Restructure

class ReplaceElementsTests: XCTestCase {

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
}
