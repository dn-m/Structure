//
//  Totalizable.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

/// Interface for fragment types which can create a fragment version of a whole instance of the
/// type.
public protocol Totalizable {

    // MARK: - Associated Types

    /// The type of the given `Whole`.
    associatedtype Whole

    // MARK: - Initializers

    /// Creates a `Totalizable` fragment with an instance of the `Whole` type.
    init(whole: Whole)
}
