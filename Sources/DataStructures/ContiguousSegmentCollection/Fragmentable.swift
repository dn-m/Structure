//
//  Fragmentable.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

/// Interface for types which can be fragmented into smaller pieces.
public protocol Fragmentable {

    // MARK: - Associated Types

    /// Type of fragment that is created.
    associatedtype Fragment: FragmentProtocol
}

public protocol Measured {

    // MARK: - Associated Types

    associatedtype Metric
}

public protocol MeasuredFragmentable: Measured & Fragmentable where Fragment.WholeMetric == Metric  {
    /// - Returns: `Fragment` within the given `range`.
    func fragment(in range: Range<Metric>) -> Fragment
}

public protocol FragmentProtocol {
    associatedtype WholeMetric: SignedNumeric & Comparable
    associatedtype Whole
    init(whole: Whole)
}
