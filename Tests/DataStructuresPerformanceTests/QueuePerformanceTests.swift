//
//  QueuePerformanceTests.swift
//  DataStructuresPerformanceTests
//
//  Created by James Bean on 9/27/18.
//

import XCTest
import PerformanceTesting
import DataStructures
//
//class QueuePerformanceTests: XCTestCase {
//
//    func testEnqueue_O_1() {
//        let benchmark = Benchmark.mutating(
//            setup: { size -> Queue<Int> in
//                var q = Queue<Int>()
//                (0..<size).forEach { q.enqueue($0) }
//                return q
//            },
//            measuring: { $0.enqueue(0) }
//        )
//        XCTAssert(benchmark.performance(is: .constant))
//    }
//
//    // If this is tested against `.constant`, this test also passes. The tolerance for `.constant`
//    // performance should probably be tightened.
//    func testDequeue_O_n() {
//        let benchmark = Benchmark.mutating(
//            setup: { size -> Queue<Int> in
//                var q = Queue<Int>()
//                (0..<size).forEach { q.enqueue($0) }
//                return q
//            },
//            measuring: { _ = $0.dequeue() }
//        )
//        XCTAssert(benchmark.performance(is: .linear))
//    }
//
//    func testPeek_O_1() {
//        let benchmark = Benchmark.mutating(
//            setup: { size -> Queue<Int> in
//                var q = Queue<Int>()
//                (0..<size).forEach { q.enqueue($0) }
//                return q
//            },
//            measuring: { _ = $0.peek }
//        )
//        XCTAssert(benchmark.performance(is: .constant))
//    }
//
//    func testIsEmpty_O_1() {
//        let benchmark = Benchmark.mutating(
//            setup: { size -> Queue<Int> in
//                var q = Queue<Int>()
//                (0..<size).forEach { q.enqueue($0) }
//                return q
//        },
//            measuring: { _ = $0.isEmpty }
//        )
//        XCTAssert(benchmark.performance(is: .constant))
//    }
//}
