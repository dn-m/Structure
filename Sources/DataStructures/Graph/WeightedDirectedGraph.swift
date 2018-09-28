//
//  WeightedDirectedGraph.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Weighted, directed graph.
public struct WeightedDirectedGraph <Node: Hashable, Weight: Numeric>:
    WeightedGraphProtocol,
    DirectedGraphProtocol
{
    // MARK: - Instance Properties

    public var nodes: Set<Node>
    public var adjacents: [Edge: Weight]
}

extension WeightedDirectedGraph {

    // MARK: - Type Aliases

    /// The type of edges which connect nodes.
    public typealias Edge = OrderedPair<Node>
}

extension WeightedDirectedGraph {

    // MARK: - Initializers

    /// Creates a `Graph` with the given set of nodes, with no edges between the nodes.
    @inlinable
    public init(_ nodes: Set<Node> = []) {
        self.nodes = nodes
        self.adjacents = [:]
    }

    /// Creates a `Graph` with the given set of nodes and the given dictionary of weights
    /// stored by the applicable edge.
    @inlinable
    public init(_ nodes: Set<Node> = [], _ adjacents: [Edge: Weight] = [:]) {
        self.init(nodes)
        self.adjacents = adjacents
    }
}

extension WeightedDirectedGraph {

    // MARK: - Instance Methods

    /// - Returns: A set of edges which emanate from the given `source` node.
    @inlinable
    public func edges(from source: Node) -> Set<Edge> {
        return Set(adjacents.keys.lazy.filter { $0.a == source })
    }

    /// - Returns: A set of nodes connected to the given `source`, in the given set of
    /// `nodes`.
    ///
    /// If `nodes` is empty, then any nodes contained herein are able to be included in the
    /// resultant set.
    @inlinable
    public func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
        return (nodes ?? self.nodes).filter { adjacents.keys.contains(Edge(source,$0)) }
    }
}

extension WeightedDirectedGraph: Equatable { }
extension WeightedDirectedGraph: Hashable where Weight: Hashable { }

