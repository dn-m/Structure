//
//  AlgebraPerformanceTests.swift
//  AlgebraPerformanceTests
//
//  Created by James Bean on 08/30/17.
//
//

import XCTest
import Algebra
import PerformanceTesting

class AccumulatePerformanceTests: PerformanceTestCase {

    func testAccumulatingProductLinear() {
        assertPerformance(.linear) { testPoint in
            meanOutcome {
                let array = Array(count: testPoint) { Int.random(in: 0..<$0) }
                return time {
                    _ = array.accumulatingProduct
                }
            }
        }
    }
}
