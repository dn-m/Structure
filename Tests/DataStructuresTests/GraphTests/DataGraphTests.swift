//
//  DataGraphTests.swift
//  DataStructuresTests
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

import XCTest
import DataStructures

class DataGraphTests: XCTestCase {
    
    func testNodesCount() {
        var graph = DataGraph<Int,Int>()
        (0..<10).forEach { graph.insert($0, value: $0) }
        [(0,2), (1,4), (1,5), (4,7), (4,9)].forEach { graph.insertEdge(from: $0.0, to: $0.1) }
        XCTAssertEqual(graph.nodes.count, 10)
    }
    
    func testEdgesCount() {
        var graph = DataGraph<Int,Int>()
        (0..<10).forEach { graph.insert($0, value: $0) }
        [(0,2), (1,4), (1,5), (4,7), (4,9)].forEach { graph.insertEdge(from: $0.0, to: $0.1) }
        XCTAssertEqual(graph.edges.count, 5)
    }
    
    func testInsertNodes() {
        var result = DataGraph<Int,Int>()
        [0,1].forEach { result.insert($0, value: $0) }
        result.insertEdge(from: 0, to: 1)
        let expected = DataGraph([0:0,1:1], [.init(0,1)])
        XCTAssertEqual(result, expected)
    }
    
    func testRemoveEdge() {
        var graph = DataGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.removeEdge(from: "a", to: "b")
        XCTAssertEqual(graph.edges.count, 1)
    }
    
    func testNeighbors() {
        var graph = DataGraph<String,Int>()
        ["a":0,"b":1,"c":2].forEach { graph.insert($0, value: $1) }
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        XCTAssertEqual(graph.neighbors(of: "a"), ["b","c"])
    }
    
    func testNeighborsInSet() {
        var graph = DataGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        graph.insertEdge(from: "a", to: "d")
        graph.insertEdge(from: "a", to: "e")
        XCTAssertEqual(graph.neighbors(of: "a", in: ["c","d","f"]), ["c","d"])
    }
    
    func testBreadthFirstSearch() {
        var graph = DataGraph<String,Int>()
        ["a":0,"b":1,"c":2,"d":3,"e":4].forEach { graph.insert($0, value: $1) }
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.insertEdge(from: "c", to: "d")
        graph.insertEdge(from: "d", to: "e")
        XCTAssertEqual(graph.breadthFirstSearch(from: "e"), ["e","d","c","b","a"])
        XCTAssertEqual(graph.breadthFirstSearch(from: "a"), ["a","b","c","d","e"])
    }
}
