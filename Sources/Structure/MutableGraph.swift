//
//  MutableGraph.swift
//  Collections
//
//  Created by James Bean on 1/16/17.
//
//

/// - TODO: Make Generic over some type.
public class MutableGraph {

    private var adjacencyList = AdjacencyList()

    // MARK: - Instance Properties

    /// All vertices contained herein.
    public var vertices: [Node] {
        return adjacencyList.reduce([]) { vertices, edgeList in vertices + [edgeList.vertex] }
    }

    /// All edges contained herein.
    public var edges: [Edge] {
        return adjacencyList.reduce([]) { edges, edgeList in edges + edgeList.edges }
    }

    public var weight: Float? { return nil }

    // MARK: - Initializers

    public init() { }

    // MARK: - Instance Methods

    /// Add the given `vertex`.
    public func addVertex(_ vertex: Node) {
        adjacencyList.addVertex(vertex)
    }

    /// Add a directed edge from one vertex to another, with an optional weight.
    public func addDirectedEdge(
        from source: Node,
        to destination: Node,
        weight: Float? = nil
    )
    {
        adjacencyList.addDirectedEdge(from: source, to: destination, weight: weight)
    }

    /// - returns: The weight between two nodes, if such an edge exists, and it has a weight.
    /// Otherwise, `nil`.
    public func weight(from source: Node, to destination: Node) -> Float? {
        let edgeList = adjacencyList[source]
        return edgeList?.weight(to: destination)
    }

    /// - returns: All `Edge` values emanating from the given `source` vertex.
    public func edges(from source: Node) -> [Edge] {
        return adjacencyList[source]?.edges ?? []
    }
}
