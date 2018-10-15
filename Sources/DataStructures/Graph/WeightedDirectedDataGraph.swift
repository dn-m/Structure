//
//  WeightedDirectedDataGraph.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

/// Weighted, directed graph with data carrying nodes.
public struct WeightedDirectedDataGraph <Node: Hashable, Data: Hashable, Weight: Numeric>:
    DirectedGraphProtocol,
    WeightedCarrierGraphProtocol
{
    // MARK: - Instance Properties
    
    public var data: [Node: Data]
    public var weights: [Edge: Weight]
}

extension WeightedDirectedDataGraph {
    
    // MARK: - Type Aliases
    
    /// The type of edges which connect nodes.
    public typealias Edge = OrderedPair<Node>
}

extension WeightedDirectedDataGraph {
    
    // MARK: - Initializers
    
    /// Creates a `Graph` with the given node `data`, with no edges between the nodes.
    @inlinable
    public init(_ data: [Node: Data] = [:]) {
        self.data = data
        self.weights = [:]
    }
    
    /// Creates a `Graph` with the given node `data` and the given dictionary of `weights`
    /// stored by the applicable edge.
    @inlinable
    public init(_ data: [Node: Data] = [:], _ weights: [Edge: Weight] = [:]) {
        self.init(data)
        self.weights = weights
    }
}

extension WeightedDirectedDataGraph: Equatable { }
extension WeightedDirectedDataGraph: Hashable where Weight: Hashable { }


