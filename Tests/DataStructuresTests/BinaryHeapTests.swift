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
        let first = heap.pop()!
        let second = heap.pop()!
        XCTAssertEqual(first.0, 2)
        XCTAssertEqual(first.1, 0.5)
        XCTAssertEqual(second.0, 1)
        XCTAssertEqual(second.1, 3.5)
        XCTAssertNil(heap.pop())
    }
    
    func testBalance() {
        var heap = BinaryHeap<Int, Double>()
        var input: [(Int, Double)] = []
        for i in 0..<100 {
            input.append( (i, Double.random(in: 0...1)) )
        }
        for (element, value) in input {
            heap.insert(element, value)
        }
        var output: [Double] = []
        for _ in 0..<100 {
            output.append(heap.pop()!.1)
        }
        input.sort(by: { $0.1 < $1.1 })
        XCTAssertEqual(input.compactMap { $0.1 }, output)
        XCTAssertNil(heap.pop())
    }
}
