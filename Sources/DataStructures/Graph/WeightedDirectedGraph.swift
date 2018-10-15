//
//  WeightedDirectedGraph.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Weighted, directed graph.
public struct WeightedDirectedGraph <Node: Hashable, Weight: Numeric>:
    DirectedGraphProtocol,
    WeightedNonCarrierGraphProtocol
{
    // MARK: - Instance Properties

    public var nodes: Set<Node>
    public var weights: [Edge: Weight]
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
        self.weights = [:]
    }

    /// Creates a `Graph` with the given set of nodes and the given dictionary of weights
    /// stored by the applicable edge.
    @inlinable
    public init(_ nodes: Set<Node> = [], _ weights: [Edge: Weight] = [:]) {
        self.init(nodes)
        self.weights = weights
    }
}

extension WeightedDirectedGraph: Equatable { }
extension WeightedDirectedGraph: Hashable where Weight: Hashable { }

