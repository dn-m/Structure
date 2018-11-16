//
//  OrderedPairTests.swift
//  Structure
//
//  Created by Benjamin Wetherfield on 15/11/2018.
//

import XCTest
import DataStructures

class OrderedPairTests: XCTestCase {
    
    func testMap() {
        let start = OrderedPair("a","ab")
        let expected = OrderedPair(1,2)
        XCTAssertEqual(start.map { $0.count }, expected)
    }
}
