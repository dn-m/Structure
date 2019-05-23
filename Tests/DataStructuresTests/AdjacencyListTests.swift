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
    
    func testSimpleCycleTwoNodes() {
        let adjacencyList = AdjacencyList<Int>([1:[2], 2:[1]])
        XCTAssertTrue(adjacencyList.containsCycle())
    }
    
    func testSimpleCycleThreeNodesMixed() {
        let adjacencyList = AdjacencyList<Int>([1:[2], 2:[1], 3: [1,2]])
        XCTAssertTrue(adjacencyList.containsCycle())
    }
    
    func testSimpleCycleDisjoint() {
        let adjacencyList = AdjacencyList<Int>([1:[], 2:[3], 3:[4], 4:[2]])
        XCTAssertTrue(adjacencyList.containsCycle())
    }
}
