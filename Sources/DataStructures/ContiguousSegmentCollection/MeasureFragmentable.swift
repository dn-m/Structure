//
//  MeasureFragmentable.swift
//  DataStructures
//
//  Created by James Bean on 8/24/18.
//

/// Interface for types which are `Measured` and `Fragmentable`, where the `Fragment` shares
/// the same `Metric`.
public protocol MeasuredFragmentable: Measured, Fragmentable where
    Fragment: Measured,
    Fragment.Metric == Self.Metric
{

    /// - Returns: `Fragment` within the given `range`.
    func fragment(in range: Range<Metric>) -> Fragment
}
