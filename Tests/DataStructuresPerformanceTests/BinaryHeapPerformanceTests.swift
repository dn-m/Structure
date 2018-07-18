//
//  BinaryHeapPerformanceTests.swift
//  DataStructuresPerformanceTests
//
//  Created by James Bean on 7/18/18.
//

import XCTest
import PerformanceTesting
import DataStructures

class BinaryHeapPerformanceTests: PerformanceTestCase {

    /// Guarantee that insertion into `BinaryHeap` is O(1)
    func testInsert_O_1() {

        var random: (element: Int, value: String) {
            let value = Int.random(in: 1...100)
            return (value, "\(value)")
        }

        assertPerformance(.constant) { testPoint in
            meanOutcome {
                let count = Int.random(in: 1...100)
                var heap = BinaryHeap<Int,String>((0...count).map { _ in random })
                return time {
                    let (element,value) = random
                    _ = heap.insert(element,value)
                }
            }
        }
    }
}
