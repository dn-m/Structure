//
//  DestructurePerformanceTests.swift
//  DestructurePerformanceTests
//
//  Created by James Bean on 08/27/17.
//
//

import XCTest
import Destructure
import PerformanceTesting

class DestructurePerformanceTests: PerformanceTestCase {

    func randomInt(_ max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }

    func testDestructure() {
        assertPerformance(.constant) { testPoint in
            meanOutcome {
                var array: [Int] = []
                for _ in 0..<testPoint { array.append(randomInt(testPoint)) }
                return time {
                    let _ = array.destructured
                }
            }
        }
    }
}
