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

class StableSortPerformanceTests: PerformanceTestCase {

    func testStableSort() {
        assertPerformance(.linear, testPoints: Scale.small) { testPoint in
            meanOutcome {
                let array = Array(count: testPoint) { Int.random(in: 0...$0) }
                return time {
                    _ = array.stableSort { $0 < $1 }
                }
            }
        }
    }
}
