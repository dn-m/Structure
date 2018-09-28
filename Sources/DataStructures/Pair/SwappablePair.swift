//
//  SwappablePair.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// A `SymmetricPair` whose values can be interchanged.
public protocol SwappablePair: SymmetricPair { }

extension SwappablePair {
    
    /// - Returns: A `SwappablePair` wherein the values are swapped for one another.
    public var swapped: Self { return .init(b,a) }
}
