//
//  StableSortPerformanceTests.swift
//  Structure
//
//  Created by Brian Heim, 2017-08-27
//
//

import XCTest
import Structure
import PerformanceTesting

class StableSortPerformanceTests: PerformanceTestCase {

    func randomInt(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }

    func testStableSort() {
        assertPerformance(.linear, testPoints: Scale.small) { testPoint in
            meanOutcome {
                let array = Array(count: testPoint) { randomInt(max: $0) }
                return time {
                    _ = array.stableSort { $0 < $1 }
                }
            }
        }
    }
}
