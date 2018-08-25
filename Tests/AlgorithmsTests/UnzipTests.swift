//
//  UnzipTests.swift
//  AlgorithmsTests
//
//  Created by James Bean on 8/25/18.
//

import XCTest
import Algorithms

class UnzipTests: XCTestCase {

    func testEmpty() {

    }

    func testNonEmpty() {
        let array = [(1,2),(3,4),(5,6),(7,8),(9,10),(11,12),(13,14)]
        let (odds,evens) = array.unzipped()
        XCTAssertEqual(odds, [1,3,5,7,9,11,13])
        XCTAssertEqual(evens, [2,4,6,8,10,12,14])
    }

    func testPerformance() {
        let array = (0..<1_000_000).map { _ in
            (Int.random(in: .min ..< .max), Int.random(in: .min ..< .max))
        }
        measure {
            let (xs,ys) = array.unzipped()
        }
    }
}
