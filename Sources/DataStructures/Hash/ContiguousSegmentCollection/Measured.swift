//
//  Measured.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

/// Interface for types which are measured by some `Metric` type.
public protocol Measured {

    // MARK: - Associated Types

    /// The type which is used to measure this type.
    associatedtype Metric: SignedNumeric, Comparable
}
