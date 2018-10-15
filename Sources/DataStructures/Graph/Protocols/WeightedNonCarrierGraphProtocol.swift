//
//  WeightedNonCarrierGraphProtocol.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

public protocol WeightedNonCarrierGraphProtocol:
    WeightedGraphProtocol,
    NonCarrierGraphProtocol
{ }

extension WeightedGraphProtocol {
    
    // MARK: - Transforming into unweighted graphs
    
    /// - Returns: An unweighted version of this `WeightedGraphProtocol`-conforming type value.
    @inlinable
    public func unweighted <U> () -> U where U: UnweightedGraphProtocol, U.Edge == Edge {
        return .init(nodes, Set(weights.keys.lazy))
    }
}
