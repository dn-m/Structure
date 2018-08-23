//
//  ContiguousSegmentCollection.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

import Algebra

public struct ContiguousSegmentCollection <Metric: Hashable & Comparable, Segment: Intervallic> {

    // MARK: - Instance Properties

    private let storage: SortedDictionary<Metric,Segment>
}

extension ContiguousSegmentCollection {

    // MARK: - Initializers

    init(_ presorted: SortedDictionary<Metric,Segment>) {
        self.storage = presorted
    }
}

extension ContiguousSegmentCollection: RandomAccessCollectionWrapping {
    public var base: SortedDictionary<Metric,Segment> {
        return storage
    }
}

extension ContiguousSegmentCollection {

    // MARK: - Type Properties

    /// `ContiguousSegmentCollection` with no segments.
    public static var empty: ContiguousSegmentCollection { return .init([:]) }
}

extension ContiguousSegmentCollection where Segment.Metric == Metric, Metric: Additive {

    init <S> (_ sequence: S) where S: Sequence, S.Element == Segment {
        var ordered: OrderedDictionary<Metric,Segment> = [:]
        var accum: Metric = .zero
        for segment in sequence {
            ordered.append(segment, key: accum)
            accum += segment.length
        }
        self.init(SortedDictionary(presorted: ordered))
    }

    /// Creates a `ContiguousSegmentCollection` with a collection of segments.
    public init <C> (_ collection: C) where C: Collection, C.Element == Segment {
        var ordered = OrderedDictionary<Metric,Segment>(minimumCapacity: collection.count)
        var accum: Metric = .zero
        for segment in collection {
            ordered.append(segment, key: accum)
            accum += segment.length
        }
        self.init(SortedDictionary(presorted: ordered))
    }
}

extension ContiguousSegmentCollection where Segment.Metric == Metric, Metric: Additive & SignedNumeric {

    /// - Returns: A `ContiguousSegmentCollection` with all `offsets` reduced such that the first
    /// offset is `0`.
    public var normalized: ContiguousSegmentCollection {
        guard let initial = first?.0 else { return .empty }
        return .init(SortedDictionary(map { (offset,value) in (offset - initial, value) }))
    }

    /// - Returns: A `ContiguousSegmentCollection` with the `offsets` offset by the given `amount`.
    public func offsetBy(_ amount: Metric) -> ContiguousSegmentCollection {
        return .init(SortedDictionary(map { (offset,value) in (offset + amount, value)} ))
    }
}

extension ContiguousSegmentCollection: Intervallic where Segment.Metric == Metric, Metric: Additive {

    // MARK: - Intervallic

    /// - Returns: The length of `ContiguousSegmentCollection`.
    public var length: Metric {
        return storage.values.map { $0.length }.sum
    }

    /// - Returns: `true` if the `target` is within the bounds of this `ContiguousSegmentCollection`.
    public func contains(_ target: Metric) -> Bool {
        return (.zero ..< length).contains(target)
    }
}

extension ContiguousSegmentCollection {

    // MARK: - Offsets and Segments

    /// - Returns: A collection of the offsets of each spanner contained herein.
    public var offsets: AnyCollection<Metric> {
        return AnyCollection(storage.keys)
    }

    /// - Returns: A collection of the spanners contained herein.
    public var segments: AnyCollection<Segment> {
        return AnyCollection(storage.values)
    }
}

extension ContiguousSegmentCollection: FragmentProtocol where Metric: SignedNumeric {

    public init(whole: ContiguousSegmentCollection<Metric, Segment>) {
        self.storage = whole.storage
    }

    public typealias Whole = ContiguousSegmentCollection
    public typealias WholeMetric = Metric
}

extension ContiguousSegmentCollection: Fragmentable where
    Segment.Metric == Metric,
    Metric: Additive,
    Segment: Intervallic & Fragmentable,
    Segment.Fragment: Intervallic,
    Segment.Fragment.Whole == Segment,
    Segment.Metric == Segment.Fragment.Metric
{

    public typealias Fragment = ContiguousSegmentCollection<Metric, Segment.Fragment>

    /// - Returns: New `ContiguousSegmentCollection` in the given `range` of metrics.
    public func fragment (in range: Range<Metric>) -> Fragment {
        guard
            let range = normalizedRange(range),
            let (startIndex,endIndex) = indices(containingBoundsOf: range)
        else {
            return .empty
        }
        if endIndex == startIndex {
            let (offset, element) = storage[startIndex]
            let only = element.fragment(in: range.lowerBound - offset ..< range.upperBound - offset)
            return .init([range.lowerBound: only])
        }
        let start = offsetAndSegment(from: range.lowerBound, at: startIndex)
        let end = offsetAndSegment(to: range.upperBound, at: endIndex)
        guard endIndex > startIndex + 1 else { return .init(SortedDictionary([start,end])) }
        return .init(SortedDictionary([start] + innards(in: startIndex + 1 ..< endIndex) + [end]))
    }

    public func innards(in range: Range<Int>) -> [(Metric,Segment.Fragment)] {
        return base[range].map { element in
            let (offset,segment) = element
            return (offset, Segment.Fragment(whole: segment))
        }
    }

    public func offsetAndSegment(from offset: Metric, at index: Int) -> (Metric,Segment.Fragment) {
        let (segmentOffset, segment) = storage[index]
        return (offset, segment.from(offset - segmentOffset))
    }

    public func offsetAndSegment(to offset: Metric, at index: Int) -> (Metric,Segment.Fragment) {
        let (segmentOffset, segment) = storage[index]
        return (segmentOffset, segment.to(offset - segmentOffset))
    }
//
//    /// - Returns: Segment at the given `index`, spanning from the given (global) `offset` to its
//    /// upper bound.
//    public func segment(from offset: Metric, at index: Int) -> Segment.Fragment {
//        let (elementOffset, segment) = storage[index]
//        return segment.from(offset - elementOffset)
//    }
//
//    /// - Returns: Segment at the given `index`, spanning from its lower bound, to the given
//    /// (global) offset.
//    public func segment(to offset: Metric, at index: Int) -> Segment.Fragment {
//        let (elementOffset, fragment) = storage[index]
//        return fragment.to(offset - elementOffset)
//    }

    /// - Returns: A `Range<Metric>` which clamps the given `range` to the bounds of this
    /// `ContiguousSegmentCollection`.
    private func normalizedRange(_ range: Range<Metric>) -> Range<Metric>? {
        guard let first = first?.0 else { return nil }
        return range.clamped(to: first ..< length)
    }

    /// - Returns: A tuple of the start index and end index of segments containing the bounds of
    /// the given `interval`.
    func indices(containingBoundsOf interval: Range<Metric>) -> (Int,Int)? {
        guard
            let startIndex = index(containing: interval.lowerBound, for: .lower),
            let endIndex = index(containing: interval.upperBound, for: .upper)
        else {
            return nil
        }
        return (startIndex,endIndex)
    }

    enum Bound {
        case lower, upper
        var lowerCompare: (Metric,Metric) -> Bool { return self == .lower ? (>=) : (>) }
        var upperCompare: (Metric,Metric) -> Bool { return self == .lower ? (<) : (<=) }
    }

    /// - Returns: The index of the element containing the given `target` offset.
    func index(containing target: Metric, for bound: Bound) -> Int? {
        var start = 0
        var end = segments.count
        while start < end {
            let mid = start + (end - start) / 2
            let (offset, element) = storage[mid]
            let lowerBound = offset
            let upperBound = offset + element.length
            if bound.lowerCompare(target,lowerBound) && bound.upperCompare(target,upperBound) {
                return mid
            } else if bound.lowerCompare(target,upperBound) {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return nil
    }
}

extension ContiguousSegmentCollection: Equatable where Segment: Equatable { }
