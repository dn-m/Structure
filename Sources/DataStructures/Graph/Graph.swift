//
//  Graph.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Unweighted, undirected graph.
public struct Graph <Node: Hashable>: UnweightedGraphProtocol, UndirectedGraphProtocol {

    // MARK: - Instance Properties

    /// All of the nodes contained herein.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    public var nodes: Set<Node>

    /// All of the edges contained herein.
    ///
    /// An `Edge` is an `UnorderedPair` of `Node` values.
    public var edges: Set<Edge>
}

extension Graph {

    // MARK: - Type Aliases

    /// The type of edges which connect nodes.
    public typealias Edge = UnorderedPair<Node>
}

extension Graph {

    // MARK: - Initializers

    /// Creates a `Graph` with the given set of nodes, with no edges between the nodes.
    @inlinable
    public init(_ nodes: Set<Node> = []) {
        self.nodes = nodes
        self.edges = []
    }

    /// Creates a `Graph` with the given set of nodes and the given set of edges connecting the
    /// nodes.
    @inlinable
    public init(_ nodes: Set<Node> = [], _ edges: Set<Edge> = []) {
        self.init(nodes)
        self.edges = edges
    }
}

extension Graph {

    // MARK: - Instance Methods

    /// - Returns: A set of nodes connected to the given `source`, in the given set of
    /// `nodes`.
    ///
    /// If `nodes` is empty, then any nodes contained herein are able to be included in the
    /// resultant set.
    @inlinable
    public func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
        return (nodes ?? self.nodes).filter { edges.contains(Edge(source,$0)) }
    }
}

extension Graph: Equatable { }
extension Graph: Hashable { }

