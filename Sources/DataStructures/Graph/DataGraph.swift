//
//  DataGraph.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

/// Unweighted, undirected graph with data carrying nodes.
public struct DataGraph <Node: Hashable, Data: Hashable>:
    UndirectedGraphProtocol,
    UnweightedCarrierGraphProtocol
{
    
    // MARK: - Instance Properties
    
    /// All of the nodes contained herein and the data they carry.
    ///
    /// A `Node` is any `Hashable`-conforming value.
    public var data: [Node: Data]
    
    /// All of the edges contained herein.
    ///
    /// An `Edge` is an `UnorderedPair` of `Node` values.
    public var edges: Set<Edge>
}

extension DataGraph {
    
    // MARK: - Type Aliases
    
    /// The type of edges which connect nodes.
    public typealias Edge = UnorderedPair<Node>
}

extension DataGraph {
    
    // MARK: - Initializers
    
    /// Creates a `Graph` with the given set of nodes, with no edges between the nodes.
    @inlinable
    public init(_ data: [Node: Data] = [:]) {
        self.data = data
        self.edges = []
    }
    
    /// Creates a `Graph` with the given set of nodes and the given set of edges connecting the
    /// nodes.
    @inlinable
    public init(_ data: [Node: Data] = [:], _ edges: Set<Edge> = []) {
        self.init(data)
        self.edges = edges
    }
}

extension DataGraph: Equatable { }
extension DataGraph: Hashable { }
