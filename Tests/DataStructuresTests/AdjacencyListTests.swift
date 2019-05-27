//
//  AdjacencyListTests.swift
//  DataStructuresTests
//
//  Created by Benjamin Wetherfield on 5/23/19.
//

import XCTest
import DataStructures

class AdjacencyListTests: XCTestCase {
    
    func testSafeInitializer() {
        let adjacencyList = AdjacencyList<Int>(safe: [1:[2,3,4]])
        XCTAssertEqual(adjacencyList.adjacencies[1],[2,3,4])
        XCTAssertEqual(adjacencyList.adjacencies[2],[])
        XCTAssertEqual(adjacencyList.adjacencies[3],[])
        XCTAssertEqual(adjacencyList.adjacencies[4],[])
    }
    
    func testSimpleCycle() {
        let adjacencyList = AdjacencyList<Int>([1:[1]])
        XCTAssertTrue(adjacencyList.containsCycle())
    }
    
    func testSimpleNonCycle() {
        let adjacencyList = AdjacencyList<Int>([1:[]])
        XCTAssertFalse(adjacencyList.containsCycle())
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
    
    func testSimpleNoCycleDisjoint() {
        let adjacencyList = AdjacencyList<Int>([1:[2], 2:[], 3:[4], 4:[5], 5:[]])
        XCTAssertFalse(adjacencyList.containsCycle())
    }
    
    func testDAGifySimpleCycle() {
        let adjacencyList = AdjacencyList<Int>([1:[1]])
        XCTAssertFalse(adjacencyList.DAGify().containsCycle())
    }
    
    func testDAGifySimpleNonCycle() {
        let adjacencyList = AdjacencyList<Int>([1:[]])
        XCTAssertFalse(adjacencyList.DAGify().containsCycle())
    }
    
    func testDAGifySimpleCycleTwoNodes() {
        let adjacencyList = AdjacencyList<Int>([1:[2], 2:[1]])
        XCTAssertFalse(adjacencyList.DAGify().containsCycle())
    }
    
    func testDAGifySimpleCycleThreeNodesMixed() {
        let adjacencyList = AdjacencyList<Int>([1:[2], 2:[1], 3: [1,2]])
        XCTAssertFalse(adjacencyList.DAGify().containsCycle())
    }
    
    func testDAGifySimpleCycleDisjoint() {
        let adjacencyList = AdjacencyList<Int>([1:[], 2:[3], 3:[4], 4:[2]])
        XCTAssertFalse(adjacencyList.DAGify().containsCycle())
    }
    
    func testDAGifySimpleNoCycleDisjoint() {
        let adjacencyList = AdjacencyList<Int>([1:[2], 2:[], 3:[4], 4:[5], 5:[]])
        XCTAssertFalse(adjacencyList.DAGify().containsCycle())
    }
}
