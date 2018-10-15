//
//  WeightedDirectedDataGraphTests.swift
//  DataStructuresTests
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

import XCTest
import DataStructures

class WeightedDirectedDataGraphTests: XCTestCase {
    
    func testWeightedDirectedDataGraphInsertNodes() {
        var result = WeightedDirectedDataGraph<String,Int,Double>()
        ["Zero":0,"One":1].forEach { result.insert($0, value: $1) }
        result.insertEdge(from: "Zero", to: "One", weight: 42.0)
        let expected = WeightedDirectedDataGraph(["Zero":0,"One":1], [.init("Zero","One"): 42.0])
        XCTAssertEqual(result, expected)
    }
    
    func testEdgesFromNode() {
        var graph = WeightedDirectedDataGraph<String,String,Int>()
        ["a","b","c","d","e"].forEach { graph.insert($0, value: $0) }
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        XCTAssertEqual(graph.edges(from: "b"), [OrderedPair("b","c"),OrderedPair("b","d")])
    }
    
    func testShortestPathTwoOptions() {
        var graph = WeightedDirectedDataGraph<String, Int, Double>()
        graph.insert("s", value: 0)
        graph.insert("a", value: 1)
        graph.insert("b", value: 0)
        graph.insert("t", value: 1)
        graph.insertEdge(from: "s", to: "a", weight: 2.0)
        graph.insertEdge(from: "s", to: "b", weight: 1.0)
        graph.insertEdge(from: "a", to: "t", weight: 3.0)
        graph.insertEdge(from: "b", to: "t", weight: 4.0)
        XCTAssertEqual(graph.shortestUnweightedPath(from: "s", to: "t")!.count, 3)
    }
}
