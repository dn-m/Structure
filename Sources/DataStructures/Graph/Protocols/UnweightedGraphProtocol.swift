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

    // MARK: - Initializers

    /// Creates an `UnweightedGraphProtocol`-conforming type value with the given set of `nodes`
    /// and the given set of `edges`.
    init(_ nodes: Set<Node>, _ edges: Set<Edge>)
}

extension UnweightedGraphProtocol {

    /// Creates an `UnweightedGraphProtocol`-conforming type value which is composed a path of
    /// nodes.
    @inlinable
    public init <S> (path: S) where S: Sequence, S.Element == Node {
        self.init(Set(path), Set(path.pairs.map(Edge.init)))
    }
}

extension UnweightedGraphProtocol {

    // MARK: - Modifying

    /// Inserts an edge between the given `source` and `destination` nodes.
    ///
    /// If the `source` or `destination` nodes are not yet contained herein, they are inserted.
    @inlinable
    public mutating func insertEdge(from source: Node, to destination: Node) {
        insert(source)
        insert(destination)
        edges.insert(Edge(source,destination))
    }
    
    /// Removes `edge` from graph.
    @inlinable
    public mutating func remove(_ edge: Edge) {
        edges.remove(edge)
    }
}

extension UnweightedGraphProtocol {

    /// - Returns: A new graph with the union of the nodes and edges of the two given graphs.
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        return .init(lhs.nodes.union(rhs.nodes), lhs.edges.union(rhs.edges))
    }
}
