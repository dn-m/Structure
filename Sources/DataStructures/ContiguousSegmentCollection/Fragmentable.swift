//
//  Fragmentable.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

/// Interface for types which can be fragmented into smaller pieces.
public protocol Fragmentable where Fragment.WholeMetric == Metric {

    // MARK: - Associated Types

    /// Type of metric by which the domain of the fragment may be calculated.
    associatedtype Metric

    /// Type of fragment that is created.
    associatedtype Fragment: FragmentProtocol

    // MARK: - Subscripts

    /// - Returns: `Fragment` within the given `range`.
    func fragment(in range: Range<Metric>) -> Fragment
}

public protocol FragmentProtocol {
    associatedtype WholeMetric: SignedNumeric & Comparable
    associatedtype Whole
    init(whole: Whole)
}
