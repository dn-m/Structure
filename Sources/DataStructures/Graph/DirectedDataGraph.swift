//
//  DirectedDataGraph.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

/// Unweighted, directed graph with data carrying nodes.
public struct DirectedDataGraph <Node: Hashable, Data: Hashable>:
    DirectedGraphProtocol,
    UnweightedCarrierGraphProtocol
{
    
    // MARK: - Instance Properties
    
    /// All of the nodes contained herein.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    public var data: [Node: Data]
    
    /// All of the edges contained herein.
    ///
    /// An `Edge` is an `OrderedPair` of `Node` values.
    public var edges: Set<Edge>
}

extension DirectedDataGraph {
    
    // MARK: - Type Aliases
    
    /// The type of edges which connect nodes.
    public typealias Edge = OrderedPair<Node>
}

extension DirectedDataGraph {
    
    // MARK: - Initializers
    
    /// Creates a `DirectedGraph` with the given node `data`, with no edges between the nodes.
    @inlinable
    public init(_ data: [Node: Data] = [:]) {
        self.data = data
        self.edges = []
    }
    
    /// Creates a `DirectedGraph` with the given node `data` and the given set of edges connecting the
    /// nodes.
    @inlinable
    public init(_ data: [Node: Data] = [:], _ edges: Set<Edge> = []) {
        self.init(data)
        self.edges = edges
    }
}

extension DirectedDataGraph: Equatable { }
extension DirectedDataGraph: Hashable { }
