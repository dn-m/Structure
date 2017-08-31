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

    func randomInt(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }

    func testAccumulatingProductLinear() {
        assertPerformance(.linear) { testPoint in
            meanOutcome {
                let array = Array(count: testPoint) { randomInt(max: $0) }
                return time {
                    _ = array.accumulatingProduct
                }
            }
        }
    }
}
