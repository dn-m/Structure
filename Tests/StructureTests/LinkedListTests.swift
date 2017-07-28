//
//  LinkedListTests.swift
//  Structure
//
//  Created by Jeremy Corren on 12/22/16.
//  Copyright © 2016 Jeremy Corren. All rights reserved.
//

import XCTest
import Structure

class LinkedListTests: XCTestCase {

    func testInitEmpty() {
        let _ = LinkedList<Int>.end
    }

    func testInitArray() {
        let array = [3,2,1]
        let _ = LinkedList(arrayLiteral: array)
    }

    func testPush() {
        var list: LinkedList<Int> = [3,2,1]
        list.push(x: 4)
        XCTAssertEqual(list[0], 4)
    }

    func testPop() {
        var list: LinkedList<Int> = [3,2,1]
        let _ = list.pop()
        XCTAssertEqual(list[0], 2)
    }

    func testPopTail() {
        var list: LinkedList<Int> = []
        XCTAssertNil(list.pop())
    }

    func testCollection() {
        let list: LinkedList<Int> = [3,2,1]
        XCTAssertEqual((list.map { $0 * $0 }), [9, 4, 1])
    }
}
