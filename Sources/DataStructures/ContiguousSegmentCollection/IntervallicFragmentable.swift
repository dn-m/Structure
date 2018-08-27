//
//  IntervallicFragmentable.swift
//  DataStructures
//
//  Created by James Bean on 8/24/18.
//

import Algebra

/// Interface for types which are `Intervallic`, and can be fragmented into a type which shares its
/// `Metric` type.
public protocol IntervallicFragmentable: Intervallic, Fragmentable
    where Fragment: Intervallic, Fragment.Metric == Metric
{

    // MARK: - Associated Types

    /// The fragment of an `IntervallicFragmentable` type.
    associatedtype Fragment

    // MARK: - Instance Methods

    /// - Returns: The `Fragment` in the given `range`.
    func fragment(in range: Range<Metric>) -> Fragment
}

extension IntervallicFragmentable where Metric: Zero {

    /// - Returns: The `Fragment` of this `IntervallicFragmentable`-conforming type value in the
    /// given `range`.
    public func fragment(in range: PartialRangeUpTo<Metric>) -> Fragment {
        return fragment(in: .zero ..< range.upperBound)
    }

    /// - Returns: The `Fragment` of this `IntervallicFragmentable`-conforming type value in the
    /// given `range`.
    public func fragment(in range: PartialRangeFrom<Metric>) -> Fragment {
        return fragment(in: range.lowerBound ..< length)
    }
}
