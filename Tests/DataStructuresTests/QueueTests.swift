//
//  QueueTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 9/27/18.
//

import XCTest
import DataStructures

class QueueTests: XCTestCase {

    func testInitEmpty() {
        let q = Queue<Int>()
        XCTAssert(q.isEmpty)
    }

    func testInitPeekNil() {
        let q = Queue<Int>()
        XCTAssertNil(q.peek)
    }

    func testEnqueuedNotEmpty() {
        var q = Queue<Int>()
        q.enqueue(0)
        XCTAssertFalse(q.isEmpty)
    }

    func testEnqueuedPeekNotNil() {
        var q = Queue<Int>()
        q.enqueue(0)
        XCTAssertEqual(q.peek, 0)
    }

    func testEnqueuedDequeue() {
        var q = Queue<Int>()
        q.enqueue(0)
        XCTAssertEqual(q.dequeue(), 0)
    }
}
