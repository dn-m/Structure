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

public struct IntervallicFragment <Whole: Fragmentable & Intervallic> {
    let whole: Whole
    let range: Range<Whole.Metric>
    init(whole: Whole, in range: Range<Whole.Metric>) {
        self.whole = whole
        self.range = range
    }
}

extension IntervallicFragment: IntervallicFragmentable where Whole: Measured & Intervallic {
    func fragment(in range: Range<Whole.Metric>) -> IntervallicFragment<IntervallicFragment<Whole>> {
        fatalError()
    }


    public typealias Metric = Whole.Metric

    public var length: Whole.Metric {
        return range.length
    }

    public func fragment(in range: Range<Metric>) -> IntervallicFragment {
        return .init(whole: whole, in: range)
    }

    public typealias Fragment = IntervallicFragment
}

extension IntervallicFragment: Fragmentable {

}
