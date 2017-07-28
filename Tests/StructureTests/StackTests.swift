//
//  StackTests.swift
//  Structure
//
//  Created by James Bean on 12/9/16.
//
//

import XCTest
import Structure

class StackTests: XCTestCase {

    func testTop() {
        let stack = Stack([1,2,3])
        XCTAssertEqual(stack.top, 3)
    }

    func testInitStackWithArray() {
        let array = [1]
        let stack = Stack(array)
        XCTAssert(stack == Stack([1]))
    }

    func testPush() {
        var stack = Stack<Int>()
        stack.push(1)
        XCTAssert(stack == Stack([1]))
    }

    func testPop() {
        var stack = Stack([1,2,3])
        let _ = stack.pop()
        XCTAssert(stack == Stack([1,2]))
    }

    func testPopAmountNotNil() {
        var stack = Stack([1,2,3,4,5,6,7,8,9])
        let popped = stack.pop(amount: 4)!
        XCTAssert(popped == Stack([9,8,7,6]))
        XCTAssert(stack == Stack([1,2,3,4,5]))
    }

    func testPopTooManyNil() {
        var stack = Stack([1,2,3,4])
        XCTAssertNil(stack.pop(amount: 5))
    }

    func testDestructured() {
        let stack: Stack = [1,2,3,4,5]
        let (top, rest) = stack.destructured!
        XCTAssertEqual(top, 5)
        XCTAssert(rest == Stack([1,2,3,4]))
    }
}
