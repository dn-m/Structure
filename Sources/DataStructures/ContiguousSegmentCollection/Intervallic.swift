//
//  Intervallic.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

import Algebra

public protocol Intervallic {

    // MARK: - Associated Types

    /// Type of the `length` of the `Intervallic` type.
    associatedtype Metric: SignedNumeric, Comparable

    // MARK: - Instance Properties

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

extension Intervallic where Metric: Additive, Self: MeasuredFragmentable {
    
    /// - Returns: A fragment of self from lower bound to the given `offset`.
    public func to(_ offset: Metric) -> Fragment {
        precondition(offset <= length)
        let range = .zero ..< offset
        return fragment(in: range)
    }

    /// - Returns: A fragment of self from the given `offset` to upper bound.
    public func from(_ offset: Metric) -> Fragment {
        precondition(offset >= .zero)
        let range = offset ..< length
        return fragment(in: range)
    }
}
