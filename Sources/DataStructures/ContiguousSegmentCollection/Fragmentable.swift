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

    associatedtype Metric: SignedNumeric, Comparable
}

public protocol MeasuredFragmentable: Measured & Fragmentable where Fragment: MeasuredFragment, Fragment.Metric == Self.Metric  {
    /// - Returns: `Fragment` within the given `range`.
    func fragment(in range: Range<Metric>) -> Fragment
}

public protocol FragmentProtocol {
    associatedtype Whole
    init(whole: Whole)
}

public protocol MeasuredFragment: Measured, FragmentProtocol where
    Whole: MeasuredFragmentable, Whole.Metric == Self.Metric
{
    
}
