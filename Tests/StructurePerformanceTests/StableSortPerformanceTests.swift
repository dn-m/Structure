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

    func randomInt(_ max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }

    func testStableSort() {
        assertPerformance(.linear, testPoints: Scale.small) { testPoint in
            meanOutcome {
                // fill an array with random pairs of numbers
                var array = Array<Int>()
                array.reserveCapacity(testPoint)
                for _ in 0..<testPoint { array.append(randomInt(testPoint)) }
                return time {
                    _ = array.stableSort { $0 < $1 }
                }
            }
        }
    }
}
