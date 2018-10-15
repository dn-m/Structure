//
//  DirectedGraphTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 9/27/18.
//

import XCTest
import DataStructures

class DirectedGraphTests: XCTestCase {

    func testDirectedGraphInsertNodes() {
        var result = DirectedGraph<String>()
        ["Zero","One"].forEach { result.insert($0) }
        result.insertEdge(from: "Zero", to: "One")
        let expected = DirectedGraph(["Zero","One"], [.init("Zero","One")])
        XCTAssertEqual(result, expected)
    }

    func testEdgesFromNode() {
        var graph = DirectedGraph<String>()
        ["a","b","c","d","e"].forEach { graph.insert($0) }
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.insertEdge(from: "b", to: "d")
        graph.insertEdge(from: "d", to: "e")
        XCTAssertEqual(graph.edges(from: "b"), [OrderedPair("b","c"),OrderedPair("b","d")])
    }

    func testShortestUnweightedPathSingleNode() {
        var graph = DirectedGraph<String>()
        graph.insert("a")
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "a"), ["a"])
    }

    func testShortestUnweightedPathTwoUnconnectedNodes() {
        var graph = DirectedGraph<String>()
        graph.insert("a")
        graph.insert("b")
        XCTAssertNil(graph.shortestUnweightedPath(from: "a", to: "b"))
    }

    func testShortestUnweightedPathTwoDirectionallyConnectedNodes() {
        var graph = DirectedGraph<String>()
        graph.insert("a")
        graph.insert("b")
        graph.insertEdge(from: "a", to: "b")
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "b"), ["a", "b"])
        XCTAssertNil(graph.shortestUnweightedPath(from: "b", to: "a"))
    }

    func testShortestPathThreeNodes() {
        var graph = DirectedGraph<String>()
        graph.insert("a")
        graph.insert("b")
        graph.insert("c")
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.insertEdge(from: "c", to: "b")
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "c"), ["a", "b", "c"])
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "b"), ["a", "b"])
    }
}
