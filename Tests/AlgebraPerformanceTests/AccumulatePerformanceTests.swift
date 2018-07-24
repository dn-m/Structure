//
//  AlgebraPerformanceTests.swift
//  AlgebraPerformanceTests
//
//  Created by James Bean on 08/30/17.
//
//

import XCTest
import PerformanceTesting
import Algebra

class AccumulatePerformanceTests: XCTestCase {

    func randomInt(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }

    func testAccumulatingProductLinear() {
        let benchmark = Benchmark.nonMutating(
            setup: { Array((0..<$0).map { Int.random(in: 0...$0) } ) },
            measuring: { _ = $0.accumulatingProduct }
        )
        XCTAssert(benchmark.performance(is: .linear))
    }
}
