//
//  QueuePerformanceTests.swift
//  DataStructuresPerformanceTests
//
//  Created by James Bean on 9/27/18.
//

import XCTest
import PerformanceTesting
import DataStructures

class QueuePerformanceTests: XCTestCase {

    func testEnqueue_O_1() {
        let benchmark = Benchmark.mutating(
            setup: { _ in Queue<Int>() },
            measuring: { $0.enqueue(0) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }

    func testDequeue_O_n() {
        let benchmark = Benchmark.mutating(
            setup: { size -> Queue<Int> in
                var q = Queue<Int>()
                (0..<size).forEach { q.enqueue($0) }
                return q
            },
            measuring: { _ = $0.dequeue() }
        )
        print(benchmark)
        XCTAssert(benchmark.performance(is: .linear))
    }
}
