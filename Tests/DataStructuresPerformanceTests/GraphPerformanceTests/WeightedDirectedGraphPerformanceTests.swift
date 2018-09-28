//
//  WeightedDirectedGraphPerformanceTests.swift
//  DataStructuresPerformanceTests
//
//  Created by James Bean on 9/28/18.
//

import XCTest
import PerformanceTesting
import DataStructures

class WeightedDirectedGraphPerformanceTests: XCTestCase {

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

private func graph(size: Int) -> WeightedDirectedGraph<Int,Double> {
    var graph = WeightedDirectedGraph<Int,Double>()
    (0..<size).forEach { graph.insert($0) }
    (0..<size/10).forEach { _ in
        graph.insertEdge(
            from: Int.random(in: .min ..< .max),
            to: Int.random(in: .min ..< .max),
            weight: Double.random(in: 0..<1)
        )
    }
    return graph
}
