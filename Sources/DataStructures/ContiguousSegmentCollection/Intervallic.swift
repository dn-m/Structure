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

extension Intervallic where Self: MeasuredFragmentable, Metric: Additive {

    /// - Returns: A fragment of self from lower bound to the given `offset`.
    public func fragment(in range: PartialRangeFrom<Metric>) -> Fragment {
        return fragment(in: range.lowerBound ..< length)
    }

    /// - Returns: A fragment of self from the given `offset` to upper bound.
    public func fragment(in range: PartialRangeUpTo<Metric>) -> Fragment {
        return fragment(in: .zero ..< range.upperBound)
    }
}

