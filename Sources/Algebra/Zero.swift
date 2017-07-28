//
//  Zero.swift
//  Algebra
//
//  Created by James Bean on 7/19/17.
//
//

/// Interface for types with a `zero` identity element.
public protocol Zero {

    /// Additive identity.
    static var zero: Self { get }
}
