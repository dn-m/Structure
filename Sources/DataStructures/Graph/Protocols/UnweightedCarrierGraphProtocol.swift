//
//  UnweightedCarrierGraphProtocol.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

public protocol UnweightedCarrierGraphProtocol:
    UnweightedGraphProtocol,
    CarrierGraphProtocol
{
    // MARK: - Initializers
    
    /// Creates an `UnweightedCarrierGraphProtocol`-conforming type value with the given
    /// set of `nodes` and the given set of `edges`.
    init(_ data: [Node: Data], _ edges: Set<Edge>)
}
