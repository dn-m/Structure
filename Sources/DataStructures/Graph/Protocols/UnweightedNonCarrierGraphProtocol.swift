//
//  UnweightedNonCarrierGraphProtocol.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

public protocol UnweightedNonCarrierGraphProtocol:
    UnweightedGraphProtocol,
    NonCarrierGraphProtocol
{
    // MARK: - Initializers
    
    /// Creates an `UnweightedNonCarrierGraphProtocol`-conforming type value with the given
    /// set of `nodes` and the given set of `edges`.
    init(_ nodes: Set<Node>, _ edges: Set<Edge>)
}

extension UnweightedNonCarrierGraphProtocol {
    
    /// Creates an `UnweightedGraphProtocol`-conforming type value which is composed a path of
    /// nodes.
    @inlinable
    public init <S> (path: S) where S: Sequence, S.Element == Node {
        self.init(Set(path), Set(path.pairs.map(Edge.init)))
    }
}

extension UnweightedNonCarrierGraphProtocol {
    
    /// - Returns: A new graph with the union of the nodes and edges of the two given graphs.
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        return .init(lhs.nodes.union(rhs.nodes), lhs.edges.union(rhs.edges))
    }
}
