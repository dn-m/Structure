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
