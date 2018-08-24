//
//  Fragmentable.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

import Algebra

/// Interface for types which can be fragmented into smaller pieces.
public protocol Fragmentable {

    // MARK: - Associated Types

    /// Type of fragment that is created from this type.
    associatedtype Fragment
}

public protocol IntervallicFragmentable: Intervallic, Fragmentable where Fragment: Intervallic, Fragment.Metric == Metric {
    func fragment(in range: Range<Metric>) -> Fragment
}

extension IntervallicFragmentable where Metric: Additive {
    public func fragment(in range: PartialRangeUpTo<Metric>) -> Fragment {
        return fragment(in: .zero ..< range.upperBound)
    }

    public func fragment(in range: PartialRangeFrom<Metric>) -> Fragment {
        return fragment(in: range.lowerBound ..< length)
    }
}
