//
//  StableSortPerformanceTests.swift
//  DataStructuresPerformanceTests
//
//  Created by Brian Heim, 2017-08-27
//
//

import XCTest
import Algorithms
import PerformanceTesting

class StableSortPerformanceTests: XCTestCase {

    // FIXME: There is currently no linearithmic option for `Complexity`.
    func testStableSort_O_nlogn() {
        let benchmark = Benchmark.mutating(
            testPoints: Scale.small,
            setup: { Array((0..<$0).map { Int.random(in: 0...$0) }) },
            measuring: { _ = $0.stableSort(<) }
        )
        XCTAssert(benchmark.performance(is: .constant))
    }
}
