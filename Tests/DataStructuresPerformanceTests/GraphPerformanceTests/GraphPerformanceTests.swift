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
            testPoints: Scale.small,
            setup: graph(size:),
            measuring: { $0.insert(Int.random(in: .min ..< .max)) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }

    func testInsertEdge_O_1() {
        let benchmark = Benchmark.mutating(
            testPoints: Scale.small,
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

    func testEdgesFromSourceInGraph_O_n() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: { _ = $0.edges(from: 0) }
        )
        XCTAssert(benchmark.performance(is: .linear))
    }

    func testEdgesFromSourceNotInGraph_O_1() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: { _ = $0.edges(from: -1) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }

    // FIXME: Assess why the testEdgeFromSourceInCompleteGraph benchmark test files
    func DISABLED_testEdgeFromSourceInCompleteGraph_O_n() {
        let benchmark = Benchmark.mutating(
            testPoints: Scale.small,
            setup: completeGraph(size:),
            measuring: { _ = $0.edges(from: 0) }
        )
        XCTAssert(benchmark.performance(is: .linear))
    }

    func testEdgesToDestinationInGraph_O_n() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: { _ = $0.edges(from: 0) }
        )
        XCTAssert(benchmark.performance(is: .linear))
    }

    func testEdgesToDestinationNotInGraph_O_1() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: { _ = $0.edges(from: -1) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }

    func testNeighborsOfNodeNotInGraph_O_1() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: { _ = $0.neighbors(of: -1) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }

    func testNeighborsOfNodeInGraph_O_n() {
        let benchmark = Benchmark.mutating(
            setup: graph(size:),
            measuring: { _ = $0.neighbors(of: 0) }
        )
        XCTAssert(benchmark.performance(is: .linear))
    }

    func testProfile() {
        let _ = graph(size: 1_000_000)
    }
}

private func completeGraph(size: Int) -> Graph<Int> {
    var graph = Graph<Int>(minimumNodesCapacity: size, minimumEdgesCapacity: size * (size - 1) / 2)
    (0..<size).forEach { size in graph.insert(size) }
    for a in 0..<size {
        for b in 0..<size where a != b {
            graph.insertEdge(from: a, to: b)
        }
    }
    return graph
}

/// Creates a `Graph` with nodes from `0..<size`, with roughly 1-in-10 connected to each other
private func graph(size: Int) -> Graph<Int> {
    var graph = Graph<Int>()
    (0..<size).forEach { size in graph.insert(size) }
    (0..<size/10).forEach { size in
        _ = graph.insertEdge(from: Int.random(in: 0 ... size), to: Int.random(in: 0 ... size))
    }
    return graph
}
