//
//  DirectedGraphPerformanceTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 9/27/18.
//

import XCTest
import PerformanceTesting
import DataStructures

class DirectedGraphPerformanceTests: XCTestCase {

    func testEdgesFromNode_O_1() {
        let benchmark = Benchmark.mutating(
            testPoints: Scale.small,
            setup: graph(size:),
            measuring: { _ = $0.edges(from: Int.random(in: .min ..< .max)) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }

    func testNeighborsOfNode_O_1() {
        let benchmark = Benchmark.mutating(
            testPoints: Scale.small,
            setup: graph(size:),
            measuring: { _ = $0.neighbors(of: Int.random(in: .min ..< .max)) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }
}

private func graph(size: Int) -> DirectedGraph<Int> {
    var graph = DirectedGraph<Int>()
    (0..<size).forEach { graph.insert($0) }
    (0..<size/10).forEach { _ in
        graph.insertEdge(from: Int.random(in: .min ..< .max), to: Int.random(in: .min ..< .max))
    }
    return graph
}
