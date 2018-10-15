//
//  WeightedDataGraph.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

/// Weighted, undirected graph with data carrying nodes.
public struct WeightedDataGraph <Node: Hashable, Data, Weight: Numeric>:
    UndirectedGraphProtocol,
    WeightedCarrierGraphProtocol
{
    // MARK: - Instance Properties
    
    /// All of the node data contained herein.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    public var data: [Node: Data]
    
    /// All of the edges contained herein stored with their weight.
    ///
    /// An `Edge` is an `UnorderedPair` of `Node` values, and a `Weight` is any `Numeric`-conforming
    /// value.
    public var weights: [Edge: Weight]
}

extension WeightedDataGraph {
    
    // MARK: - Type Aliases
    
    /// The type of edges which connect nodes.
    public typealias Edge = UnorderedPair<Node>
}

extension WeightedDataGraph {
    
    // MARK: - Initializers
    
    /// Creates a `WeightedDataGraph` with the given `data`, with no edges between the nodes.
    @inlinable
    public init(_ data: [Node: Data] = [:]) {
        self.data = data
        self.weights = [:]
    }
    
    /// Creates a `WeightedDataGraph` with the given `data` and the given dictionary of `weights`
    /// stored by the applicable edge.
    @inlinable
    public init(_ data: [Node: Data] = [:], _ weights: [Edge: Weight] = [:]) {
        self.init(data)
        self.weights = weights
    }
}

extension WeightedDataGraph: Equatable where Data: Equatable { }
extension WeightedDataGraph: Hashable where Weight: Hashable, Data: Hashable { }
