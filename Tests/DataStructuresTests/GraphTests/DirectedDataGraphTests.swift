//
//  DirectedDataGraphTests.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

import XCTest
import DataStructures

class DirectedDataGraphTests: XCTestCase {
    
    func testDirectedDataGraphInsertNodes() {
        var result = DirectedDataGraph<String,Int>()
        ["Zero": 0, "One": 1].forEach { result.insert($0, value: $1) }
        result.insertEdge(from: "Zero", to: "One")
        let expected = DirectedDataGraph(["Zero": 0,"One": 1], [.init("Zero","One")])
        XCTAssertEqual(result, expected)
    }
    
    func testEdgesFromNode() {
        var graph = DirectedDataGraph<String,Int>()
        ["a":0,"b":1,"c":2,"d":3,"e":4].forEach { graph.insert($0, value: $1) }
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.insertEdge(from: "b", to: "d")
        graph.insertEdge(from: "d", to: "e")
        XCTAssertEqual(graph.edges(from: "b"), [OrderedPair("b","c"),OrderedPair("b","d")])
    }
    
    func testShortestUnweightedPathSingleNode() {
        var graph = DirectedDataGraph<String,Int>()
        graph.insert("a", value: 1)
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "a"), ["a"])
    }
    
    func testShortestUnweightedPathTwoUnconnectedNodes() {
        var graph = DirectedDataGraph<String, Int>()
        graph.insert("a", value: 0)
        graph.insert("b", value: 1)
        XCTAssertNil(graph.shortestUnweightedPath(from: "a", to: "b"))
    }
    
    func testShortestUnweightedPathTwoDirectionallyConnectedNodes() {
        var graph = DirectedDataGraph<String, Int>()
        graph.insert("a", value: 0)
        graph.insert("b", value: 1)
        graph.insertEdge(from: "a", to: "b")
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "b"), ["a", "b"])
        XCTAssertNil(graph.shortestUnweightedPath(from: "b", to: "a"))
    }
    
    func testShortestPathThreeNodes() {
        var graph = DirectedDataGraph<String, Int>()
        graph.insert("a", value: 0)
        graph.insert("b", value: 1)
        graph.insert("c", value: 2)
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.insertEdge(from: "c", to: "b")
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "c"), ["a", "b", "c"])
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "b"), ["a", "b"])
    }
}
