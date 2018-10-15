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
