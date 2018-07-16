//
//  BinaryHeapTests.swift
//  PitchSpellerTests
//
//  Created by Benjamin Wetherfield on 7/16/18.
//

import XCTest
@testable import DataStructures

class BinaryHeapTests: XCTestCase {
    
    func testPopNil() {
        var heap = BinaryHeap<Int, Double>()
        XCTAssertNil(heap.pop())
    }
    
    func testBasicInsertPop() {
        var heap = BinaryHeap<Int, Double>()
        heap.insert(4, 3.5)
        let (minimum, value) = heap.pop()!
        XCTAssertEqual(minimum, 4)
        XCTAssertEqual(value, 3.5)
    }
    
    func testSimpleBalance() {
        var heap = BinaryHeap<Int, Double>()
        heap.insert(1, 3.5)
        heap.insert(2, 0.5)
        let (minimum, value) = heap.pop()!
        XCTAssertEqual(minimum, 2)
        XCTAssertEqual(value, 0.5)
    }
}
