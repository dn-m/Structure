//
//  UnweightedGraphProtocol.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Interface for unweighted graphs.
public protocol UnweightedGraphProtocol: GraphProtocol {

    // MARK: - Instance Properties

    /// All of the edges contained herein.
    var edges: Set<Edge> { get set }

}

extension UnweightedGraphProtocol {

    // MARK: - Modifying

    /// Inserts an edge between the given `source` and `destination` nodes.
    ///
    /// If the `source` or `destination` nodes are not yet contained herein, they are inserted.
    /// - TODO: Implement error-raising for `source` or `destination` absent.
    @inlinable
    public mutating func insertEdge(from source: Node, to destination: Node) {
        edges.insert(Edge(source,destination))
    }

    /// Removes the edge between the given `source` and `destination` nodes.
    @inlinable
    public mutating func removeEdge(from source: Node, to destination: Node) {
        edges.remove(Edge(source,destination))
    }
}

extension UnweightedGraphProtocol {

    /// - Returns: A new graph with the union of the nodes and edges of the two given graphs.
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        return .init(lhs.nodes.union(rhs.nodes), lhs.edges.union(rhs.edges))
    }
}
