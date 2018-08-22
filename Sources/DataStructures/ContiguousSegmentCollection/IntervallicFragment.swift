//
//  IntervallicFragment.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

import Algebra

/// Interface extending `Intervallic` types, which also carry with them a range of operation.
public protocol IntervallicFragment: Intervallic where IntervallicBase.Metric == Metric {

    // MARK: - Instance Properties

    associatedtype IntervallicBase: Intervallic
    associatedtype Metric

    var interval: IntervallicBase { get }

    /// The range of operation.
    var range: Range<Metric> { get }

    init(_ interval: IntervallicBase, in range: Range<Metric>)
}

extension IntervallicFragment where Metric: Additive {
    init(_ interval: IntervallicBase) {
        self.init(interval, in: .zero ..< interval.length)
    }
}

extension IntervallicFragment {

    /// The length of `SpanningFragment`.
    public var length: Metric {
        return range.length
    }
}

//
//extension IntervallicFragment where Metric: Additive, Self: Fragmentable {
//
//    /// - Returns: A fragment of self from lower bound to the given `offset`.
//    public func to(_ offset: Metric) -> Fragment {
//        precondition(offset <= length)
//        let range = .zero ..< offset
//        return self[range]
//    }
//
//    /// - Returns: A fragment of self from the given `offset` to upper bound.
//    public func from(_ offset: Metric) -> Fragment {
//        precondition(offset >= .zero)
//        let range = offset ..< length
//        return self[range]
//    }
//}
//
//extension IntervallicFragment where Self: Fragmentable, Self.Fragment == Self {
//
//    // MARK: - Fragmentable
//
//    /// - Returns: A fragment of self from lower bound to the given `offset`.
//    public func to(_ offset: Metric) -> Self {
//        precondition(offset <= self.range.upperBound)
//        let range = self.range.lowerBound ..< offset
//        return self[range]
//    }
//
//    /// - Returns: A fragment of self from the given `offset` to upper bound.
//    public func from(_ offset: Metric) -> Self {
//        precondition(offset >= self.range.lowerBound)
//        let range = offset ..< self.range.upperBound
//        return self[range]
//    }
//}
