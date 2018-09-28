//
//  WeightedGraph.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Weighted, undirected graph.
public struct WeightedGraph <Node: Hashable, Weight: Numeric>:
    WeightedGraphProtocol,
    UndirectedGraphProtocol
{
    // MARK: - Instance Properties

    /// All of the nodes contained herein.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    public var nodes: Set<Node>

    /// All of the edges contained herein stored with their weight.
    ///
    /// An `Edge` is an `UnorderedPair` of `Node` values, and a `Weight` is any `Numeric`-conforming
    /// value.
    public var adjacents: [Edge: Weight]
}

extension WeightedGraph {

    // MARK: - Type Aliases

    /// The type of edges which connect nodes.
    public typealias Edge = UnorderedPair<Node>
}

extension WeightedGraph {

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

extension WeightedGraph {

    // MARK: - Instance Methods

    /// - Returns: A set of nodes connected to the given `source`, in the given set of
    /// `nodes`.
    ///
    /// If `nodes` is empty, then any nodes contained herein are able to be included in the
    /// resultant set.
    @inlinable
    public func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
        return (nodes ?? self.nodes).intersection(adjacents.keys.compactMap { $0.other(source) })
    }
}

extension WeightedGraph: Equatable { }
extension WeightedGraph: Hashable where Weight: Hashable { }
