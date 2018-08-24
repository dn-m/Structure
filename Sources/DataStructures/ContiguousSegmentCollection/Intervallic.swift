//
//  Intervallic.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

import Algebra

public protocol Intervallic: Measured {

    // MARK: - Instance Properties

    associatedtype Metric

    /// Length of the `Spanning` type in the given `Metric`.
    var length: Metric { get }
}

extension Numeric where Self: Comparable {

    /// - Returns: Self as its length.
    public var length: Self {
        return self
    }
}

extension Int: Intervallic { }
extension Float: Intervallic { }
extension Double: Intervallic { }
