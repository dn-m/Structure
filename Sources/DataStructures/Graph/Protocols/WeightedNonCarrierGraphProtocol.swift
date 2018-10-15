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

extension WeightedNonCarrierGraphProtocol {
    
    // MARK: - Transforming into unweighted graphs
    
    /// - Returns: An unweighted version of this `WeightedNonCarrierGraphProtocol`-conforming
    /// type value.
    @inlinable
    public func unweighted <U> () -> U where U: UnweightedNonCarrierGraphProtocol, U.Edge == Edge {
        return .init(nodes, Set(weights.keys.lazy))
    }
}
