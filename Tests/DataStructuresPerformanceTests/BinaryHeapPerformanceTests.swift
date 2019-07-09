//
//  BinaryHeapPerformanceTests.swift
//  DataStructuresPerformanceTests
//
//  Created by James Bean on 7/18/18.
//

import XCTest
import PerformanceTesting
import DataStructures

//class BinaryHeapPerformanceTests: XCTestCase {
//
//    /// Guarantee that insertion into `BinaryHeap` is O(*1*).
//    func testInsert_O_1() {
//        let benchmark = Benchmark.mutating(
//            testPoints: Scale.small,
//            setup: { BinaryHeap((0..<$0).map { _ in random }) },
//            measuring: {
//                let (element,value) = random
//                _ = $0.insert(element,value)
//            }
//        )
//        XCTAssert(benchmark.performance(is: .constant))
//    }
//
//    /// Guarantee that popping the minimum value from `BinaryHeap` is O(*1*).
//    func testPop_O_1() {
//        let benchmark = Benchmark.mutating(
//            testPoints: Scale.small,
//            setup: { BinaryHeap((0..<$0).map { _ in random }) },
//            measuring: { _ = $0.pop() }
//        )
//        XCTAssert(benchmark.performance(is: .constant))
//    }
//}

var random: (element: Int, value: String) {
    let value = Int.random(in: 1...100)
    return (value, "\(value)")
}
