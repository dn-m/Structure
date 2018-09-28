//
//  GraphPerformanceTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 9/27/18.
//

import XCTest
import PerformanceTesting
import DataStructures

class GraphPerformanceTests: XCTestCase {

    func testInsertNode_O_1() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: { $0.insert(Int.random(in: .min ..< .max)) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }

    func testInsertEdge_O_1() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: {
                $0.insertEdge(
                    from: Int.random(in: .min ..< .max),
                    to: Int.random(in: .min ..< .max)
                )
            }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }

    func testNeighborsOfNode_O_n() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: { _ = $0.neighbors(of: Int.random(in: .min ..< .max)) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }
}

func graph (size: Int) -> Graph<Int> {
    var result = Graph<Int>()
    (0..<size).forEach { size in result.insert(size) }
    return result
}
