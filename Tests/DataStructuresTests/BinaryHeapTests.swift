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
        let input = (0..<100).map { _ in Double.random(in: 0...1) }
        for (element, value) in input.enumerated() {
            heap.insert(element, value)
        }
        let output = (0..<100).map { _ in heap.pop()!.1 }
        let testAgainst = input.sorted()
        XCTAssertEqual(testAgainst, output)
        XCTAssertNil(heap.pop())
    }
    
    func testUpdate() {
        var heap = BinaryHeap<Int, Double>()
        let input = (0..<100).map { _ in Double.random(in: 0...1) }
        let throughput = (0..<100).map { _ in Double.random(in: 0...1) }
        let testAgainst = (0..<100).map { i in min(input[i], throughput[i]) }.sorted()
        input.enumerated().forEach { pair in heap.insert(pair.0, pair.1) }
        throughput.enumerated().forEach { pair in heap.suggestDecrease(of: pair.0, to: pair.1) }
        let output = (0..<100).map { _ in heap.pop()!.1 }
        XCTAssertEqual(testAgainst, output)
        XCTAssertNil(heap.pop())
    }
}
