//
//  ReplaceElementsTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Structure

class ReplaceElementsTests: XCTestCase {

    func testReplaceFirstThrows() {
        var array: [Int] = []
        do {
            try array.replaceFirst(with: 0)
            XCTFail()
        } catch { }
    }

    func testReplaceFirst() {
        var array = [1,2,3]
        do {
            try array.replaceFirst(with: 4)
            XCTAssertEqual(array, [4,2,3])
        } catch {
            XCTFail()
        }
    }

    func testReplaceLastThrows() {
        var array: [Int] = []
        do {
            try array.replaceLast(with: 0)
            XCTFail()
        } catch { }
    }

    func testReplaceLast() {
        var array = [1,2,3]
        do {
            try array.replaceLast(with: 0)
            XCTAssertEqual(array, [1,2,0])
        } catch {
            XCTFail()
        }
    }

    func testReplaceElementAtIndexThrows() {
        var array: [Int] = []
        do {
            try array.replaceElement(at: 0, with: 0)
            XCTFail()
        } catch { }
    }

    func testReplaceElementAtIndex() {
        var array: [Int] = [1,2]
        do {
            try array.replaceElement(at: 1, with: 0)
            XCTAssertEqual(array, [1,0])
        } catch {
            XCTFail()
        }
    }

    func testInsertingAtIndexAtBeginning() {
        let array = [1,2,3]
        XCTAssertEqual(try array.inserting(0, at: 0), [0,1,2,3])
    }

    func testInsertingAtIndexInMiddle() {
        let array = [0,1,3]
        XCTAssertEqual(try array.inserting(2, at: 2), [0,1,2,3])
    }

    func testInsertingAtIndexAtEnd() {
        let array = [0,1,2]
        XCTAssertEqual(try array.inserting(3, at: 3), [0,1,2,3])
    }
}
