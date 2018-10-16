//
//  WeightedDataGraphTests.swift
//  DataStructuresTests
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

import XCTest
import DataStructures

class WeightedDataGraphTests: XCTestCase {
    
    func testInsertNodes() {
        var result = WeightedDataGraph<String,Int,Double>()
        ["a":0,"b":1].forEach { result.insert($0, value: $1) }
        result.insertEdge(from: "a", to: "b", weight: 42.0)
        let expected = WeightedDataGraph(["a":0,"b":1], [.init("b","a"): 42.0])
        XCTAssertEqual(result, expected)
    }
    
    func testWeightForEdge() {
        var graph = WeightedDataGraph<String,Int,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        XCTAssertNil(graph.weight(UnorderedPair("c","e")))
        XCTAssertEqual(graph.weight(UnorderedPair("b","c")), 7)
        XCTAssertEqual(graph.weight(from: "d", to: "e"), 13)
    }
    
    func testUpdateEdge() {
        var graph = WeightedDataGraph<String,Int,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 1)
        graph.updateEdge(from: "a", to: "b") { $0 * 2 }
        XCTAssertEqual(graph.weight(from: "a", to: "b"), 2)
    }
    
    func testContains() {
        var graph = WeightedDataGraph<String,Int,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        XCTAssertFalse(graph.contains(UnorderedPair("a","c")))
        XCTAssert(graph.contains(UnorderedPair("b","d")))
    }
    
    func testNeighbors() {
        var graph = WeightedDataGraph<String,String,Int>()
        ["a","b","c","d","e"].forEach { graph.insert($0, value: $0) }
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        XCTAssertEqual(graph.neighbors(of: "b"), ["a","c","d"])
        XCTAssertEqual(graph.neighbors(of: "f"), [])
    }
    
    func testRemoveEdge() {
        var graph = WeightedDataGraph<String,Int,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        graph.removeEdge(from: "b", to: "d")
        XCTAssertFalse(graph.contains(UnorderedPair("b","d")))
    }
    
    func testUnweightedFromUndirected() {
        var graph = WeightedDataGraph<String,Int,Int>()
        ["a":0,"b":1,"c":2,"d":3,"e":4].forEach { graph.insert($0, value: $1) }
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        let unweighted: DataGraph<String, Int> = graph.unweighted()
        let expected = DataGraph(
            ["a":0,"b":1,"c":2,"d":3,"e":4],
            [
                UnorderedPair("a","b"),
                UnorderedPair("b","c"),
                UnorderedPair("b","d"),
                UnorderedPair("d","e")
            ]
        )
        XCTAssertEqual(unweighted, expected)
    }
    
    func testUnweightedFromDirected() {
        var graph = WeightedDirectedDataGraph<String,Int,Int>()
        ["a":0,"b":0,"c":0,"d":0,"e":0].forEach { graph.insert($0, value: $1) }
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        let unweighted: DirectedDataGraph<String,Int> = graph.unweighted()
        let expected: DirectedDataGraph<String,Int> = DirectedDataGraph(
            ["a":0,"b":0,"c":0,"d":0,"e":0],
            [
                OrderedPair("a","b"),
                OrderedPair("b","c"),
                OrderedPair("b","d"),
                OrderedPair("d","e")
            ]
        )
        XCTAssertEqual(unweighted, expected)
    }
}

