//
//  ContiguousSegmentCollection.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

import Algebra

/// A generic collection of contiguous `Intervallic`-type value wherein `Intervallic` types are
/// stored by their offset.
///
/// **Example Usage**
///
///     let collection = ContiguousSegmentCollection([1,2,1,3])
///
/// This creates a `ContiguousSegmentCollection<Int,Int>`, where the `Metric` and `Interallic` types
/// are both `Int`. Each segment is the length of a given value, and is stored by the accumulating
/// offset.
///
/// The resulting structure could be represented like this:
///
///     offset: 0 1  3 4   7
///             |-|--|-|---|
///     length:  1  2 1  3
///
public struct ContiguousSegmentCollection <Metric: Hashable & Additive, Segment: Intervallic>
    where Metric == Segment.Metric
{
    private let storage: SortedDictionary<Metric,Segment>
}

extension ContiguousSegmentCollection {

    // MARK: - Initializers

    /// Creates a `ContiguousSegmentCollection` with the given `presorted` `SortedDictionary` of
    /// values.
    public init(_ presorted: SortedDictionary<Metric,Segment>) {
        self.storage = presorted
    }
}

extension ContiguousSegmentCollection: RandomAccessCollectionWrapping {

    // MARK: - RandomAccessCollectionWrapping

    /// - Returns: A view of the underlying storage producing a `RandomAccessCollection` interface.
    public var base: SortedDictionary<Metric,Segment> {
        return storage
    }
}

extension ContiguousSegmentCollection {

    // MARK: - Type Properties

    /// `ContiguousSegmentCollection` with no segments.
    public static var empty: ContiguousSegmentCollection { return .init([:]) }
}

extension ContiguousSegmentCollection {

    /// Creates a `ContiguousSegmentCollection` with the given `sequence` of segments.
    public init <S: Sequence> (offset: Metric = .zero, _ sequence: S) where S.Element == Segment {
        var ordered: OrderedDictionary<Metric,Segment> = [:]
        var accum: Metric = .zero
        for segment in sequence {
            ordered.append(segment, key: accum)
            accum += segment.length
        }
        self.init(SortedDictionary(presorted: ordered))
    }

    /// Creates a `ContiguousSegmentCollection` with the given `collection` of segments.
    public init <C: Collection> (offset: Metric = .zero, _ collection: C) where C.Element == Segment {
        var ordered = OrderedDictionary<Metric,Segment>(minimumCapacity: collection.count)
        var accum: Metric = .zero
        for segment in collection {
            ordered.append(segment, key: accum)
            accum += segment.length
        }
        self.init(SortedDictionary(presorted: ordered))
    }
}

extension ContiguousSegmentCollection {

    // MARK: - Computed Properties

    /// - Returns: A collection of the offsets of each spanner contained herein.
    public var offsets: AnyCollection<Metric> {
        return AnyCollection(storage.keys)
    }

    /// - Returns: A collection of the spanners contained herein.
    public var segments: AnyCollection<Segment> {
        return AnyCollection(storage.values)
    }
}

extension ContiguousSegmentCollection {

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

extension ContiguousSegmentCollection: Intervallic {

    // MARK: - Intervallic

    /// - Returns: The length of `ContiguousSegmentCollection`.
    public var length: Metric {
        return segments.map { $0.length }.sum
    }

    /// - Returns: `true` if the `target` is within the bounds of this `ContiguousSegmentCollection`.
    public func contains(_ target: Metric) -> Bool {
        guard let first = first, let last = last else { return false }
        let start = first.0
        let end = last.0 + last.1.length
        return (start ..< end).contains(target)
    }
}

extension ContiguousSegmentCollection: Fragmentable where Metric: Zero, Segment: IntervallicFragmentable {

    // MARK: - Nested Types

    /// A fragment of a `ContiguousSegmentCollection`.
    public struct Fragment {

        enum Segments {
            case empty
            case single(Segment.Fragment)
            case double(Segment.Fragment, Segment.Fragment)
            case multiple(Segment.Fragment?, [Segment], Segment.Fragment?)
        }

        // MARK: - Type Properties

        /// - Returns: A `Fragment` with no elements.
        public static var empty: Fragment {
            return .init(.empty, offsetBy: .zero)
        }

        // MARK: - Instance Properties

        /// The offset of this `Fragment`.
        let offset: Metric

        /// The segments contained herein.
        let segments: Segments

        // MARK: - Initializers

        init(_ segments: Segments, offsetBy offset: Metric = .zero) {
            self.offset = offset
            self.segments = segments
        }

        /// Creates a `ContiguousSegmentCollection.Fragment` with the given `single` segment
        /// fragment, offset by the given `offset`.
        public init(_ single: Segment.Fragment, offsetBy offset: Metric) {
            self.init(.single(single), offsetBy: offset)
        }

        /// Creates a `ContiguousSegmentCollection.Fragment` with the given pair of segment
        /// fragments, offset by the given `offset`.
        public init(_ head: Segment.Fragment, _ tail: Segment.Fragment, offsetBy offset: Metric) {
            self.init(.double(head,tail), offsetBy: offset)
        }

        /// Creates a `ContiguousSegmentCollection.Fragment` with the given pair of segment
        /// fragments and the segments in-between, offset by the given `offset`.
        public init(
            head: Segment.Fragment,
            body: [Segment],
            tail: Segment.Fragment,
            offsetBy offset: Metric
        )
        {
            self.init(.multiple(head, body, tail), offsetBy: offset)
        }
    }

    /// Returns: A fragment in the given `range`.
    ///
    /// > The offsets are preserved from the initial collection.
    ///
    public func fragment(in range: Range<Metric>) -> Fragment {

        guard
            let range = normalizedRange(range),
            let (startIndex,endIndex) = indices(containingBoundsOf: range)
        else {
            return .empty
        }

        // Single fragment
        if startIndex == endIndex {
            let (offset, element) = storage[startIndex]
            let localRange = range.shifted(by: -offset)
            return Fragment(element.fragment(in: localRange), offsetBy: range.lowerBound)
        }

        let (offset,start) = offsetAndSegment(from: range.lowerBound, at: startIndex)
        let (_,end) = offsetAndSegment(to: range.upperBound, at: endIndex)

        // Two fragments
        guard endIndex > startIndex + 1 else { return Fragment(start, end, offsetBy: offset) }

        // Two fragments and body
        return Fragment(
            head: start,
            body: segments(in: startIndex + 1 ..< endIndex),
            tail: end,
            offsetBy: offset
        )
    }

    private func offsetAndSegment(from offset: Metric, at index: Int) -> (Metric,Segment.Fragment) {
        let (segmentOffset, segment) = storage[index]
        return (offset, segment.fragment(in: (offset - segmentOffset)...))
    }

    private func offsetAndSegment(to offset: Metric, at index: Int) -> (Metric,Segment.Fragment) {
        let (segmentOffset, segment) = storage[index]
        return (segmentOffset, segment.fragment(in: ..<(offset - segmentOffset)))
    }

    private func segments(in range: Range<Int>) -> [Segment] {
        return self[range].map { _, segment in segment }
    }
}


extension ContiguousSegmentCollection {

    /// - Returns: The index of the segment containing the given `offset`, if it exists. Otherwise,
    /// `nil`.
    public func indexOfSegment(containing offset: Metric) -> Int? {
        return index(containing: offset, for: .lower)
    }

    /// - Returns: A tuple of the start index and end index of segments containing the bounds of
    /// the given `interval`.
    ///
    /// - TODO: For a performance optimization, only search indices `startIndex...` to find the
    /// `endIndex`. This would require adding a parameter to `index(containing:for:)` describing
    /// the `searchRange`.
    private func indices(containingBoundsOf interval: Range<Metric>) -> (Int,Int)? {
        guard let startIndex = index(
            containing: interval.lowerBound,
            for: .lower
        ) else { return nil }
        guard let endIndex = index(
            containing: interval.upperBound,
            for: .upper,
            in: startIndex ..< count
        ) else { return nil }
        return (startIndex,endIndex)
    }

    private enum Bound {
        case lower, upper
        var lowerCompare: (Metric,Metric) -> Bool { return self == .lower ? (>=) : (>) }
        var upperCompare: (Metric,Metric) -> Bool { return self == .lower ? (<) : (<=) }
    }

    /// - Returns: The index of the element containing the given `target` offset.
    ///
    /// - TODO: Add `searchRange` parameter
    private func index(
        containing target: Metric,
        for bound: Bound,
        in searchRange: Range<Int>? = nil
    ) -> Int?
    {
        let searchRange = searchRange ?? 0..<count
        var start = searchRange.lowerBound
        var end = searchRange.upperBound
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

    /// - Returns: A `Range<Metric>` which clamps the given `range` to the bounds of this
    /// `ContiguousSegmentCollection`.
    private func normalizedRange(_ range: Range<Metric>) -> Range<Metric>? {
        guard let first = first?.0 else { return nil }
        return range.clamped(to: first ..< length)
    }
}

extension ContiguousSegmentCollection.Fragment.Segments: Equatable where
    Segment: Equatable, Segment.Fragment: Equatable
{
}

extension ContiguousSegmentCollection.Fragment: Equatable where
    Segment: Equatable, Segment.Fragment: Equatable
{
}

extension ContiguousSegmentCollection: Equatable where Segment: Equatable { }
extension ContiguousSegmentCollection: Hashable where Segment: Hashable { }
