//
//  One.swift
//  Algebra
//
//  Created by James Bean on 7/19/17.
//
//

/// Interface for types with a `one` identity element.
public protocol One {

    /// Multiplicative identity.
    static var one: Self { get }
}
