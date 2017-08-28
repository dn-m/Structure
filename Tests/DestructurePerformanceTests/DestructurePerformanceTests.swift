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
                let array = Array(count: testPoint) { randomInt($0) }
                return time {
                    let _ = array.destructured
                }
            }
        }
    }
}
