//
//  AdjacencyListTests.swift
//  DataStructuresTests
//
//  Created by Benjamin Wetherfield on 5/23/19.
//

import XCTest
import DataStructures

class AdjacencyListTests: XCTestCase {
    
    func testSimpleCycle() {
        let adjacencyList = AdjacencyList<Int>([1:[1]])
        XCTAssertTrue(adjacencyList.containsCycle())
    }
}
