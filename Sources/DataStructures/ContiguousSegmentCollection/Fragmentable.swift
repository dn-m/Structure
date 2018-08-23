//
//  Fragmentable.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

/// Interface for types which can be fragmented into smaller pieces.
public protocol Fragmentable {

    // MARK: - Associated Types

    /// Type of fragment that is created from this type.
    associatedtype Fragment
}

public protocol MeasuredFragmentable: Measured & Fragmentable where
    Fragment: Measured,
    Fragment.Metric == Self.Metric
{

    /// - Returns: `Fragment` within the given `range`.
    func fragment(in range: Range<Metric>) -> Fragment
}
