//
//  CombinatoricsPerformanceTests.swift
//  AlgorithmsPerformanceTests
//
//  Created by James Bean on 11/16/18.
//

import XCTest
import Algorithms
import PerformanceTesting

class CombinatoricsPerformanceTests: XCTestCase {

    func testCartesianProduct_O_n() {
        let benchmark = Benchmark.mutating(
            testPoints: Scale.small,
            setup: { size -> ([Int],[Int]) in (Array(0..<size),Array(0..<size)) },
            measuring: { pair in _ = cartesianProduct(pair.0,pair.1) }
        )
        XCTAssert(benchmark.performance(is: .linear))
    }
}
