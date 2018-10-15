//
//  WeightedCarrierGraphProtocol.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

public protocol WeightedCarrierGraphProtocol:
    WeightedGraphProtocol,
    CarrierGraphProtocol
{ }

extension WeightedCarrierGraphProtocol {
    
    // MARK: - Transforming into unweighted graphs
    
    /// - Returns: An unweighted version of this `WeightedNonCarrierGraphProtocol`-conforming
    /// type value.
    @inlinable
    public func unweighted <U> () -> U where U: UnweightedCarrierGraphProtocol,
        U.Edge == Edge,
        U.Node == Node,
        U.Data == Data
    {
        return .init(data, Set(weights.keys.lazy))
    }
}
