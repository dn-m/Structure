//
//  WeightedGraphPerformanceTests.swift
//  DataStructuresPerformanceTests
//
//  Created by James Bean on 9/28/18.
//

import XCTest
import PerformanceTesting
import DataStructures

//class WeightedGraphPerformanceTests: XCTestCase {
//
//    func testNeighborsOfNode_O_1() {
//        let benchmark = Benchmark.mutating(
//            testPoints: Scale.small,
//            setup: graph(size:),
//            measuring: { _ = $0.neighbors(of: Int.random(in: .min ..< .max)) }
//        )
//        XCTAssert(benchmark.performance(is: .constant))
//    }
//}
//
//private func graph(size: Int) -> WeightedGraph<Int,Double> {
//    var graph = WeightedGraph<Int,Double>()
//    (0..<size).forEach { graph.insert($0) }
//    (0..<size/10).forEach { _ in
//        graph.insertEdge(
//            from: Int.random(in: .min ..< .max),
//            to: Int.random(in: .min ..< .max),
//            weight: Double.random(in: 0 ..< 1)
//        )
//    }
//    return graph
//}
