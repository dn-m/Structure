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
public struct ContiguousSegmentCollection <Segment: Intervallic>
    where Segment.Metric: Hashable & Additive
{

    // MARK: - Type Aliases

    /// The type which is used to measure the `Segment`.
    public typealias Metric = Segment.Metric

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
    public init <S: Sequence> (_ sequence: S, offset: Metric = .zero) where S.Element == Segment {
        var ordered: OrderedDictionary<Metric,Segment> = [:]
        var accum: Metric = offset
        for segment in sequence {
            ordered.append(segment, key: accum)
            accum += segment.length
        }
        self.init(SortedDictionary(presorted: ordered))
    }

    /// Creates a `ContiguousSegmentCollection` with the given `collection` of segments.
    public init <C: Collection> (_ collection: C, offset: Metric = .zero)
        where C.Element == Segment
    {
        var ordered = OrderedDictionary<Metric,Segment>(minimumCapacity: collection.count)
        var accum: Metric = offset
        for segment in collection {
            ordered.append(segment, key: accum)
            accum += segment.length
        }
        self.init(SortedDictionary(presorted: ordered))
    }

    /// Creates a `ContiguousSegmentCollection` with the given `presorted` collection of key-value
    /// pairs.
    public init <C: Collection> (presorted: C) where C.Element == Element {
        print("presorted: \(presorted)")
        self.init(SortedDictionary(presorted: presorted))
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

extension ContiguousSegmentCollection: Fragmentable
    where Metric: Zero, Segment: IntervallicFragmentable
{

    // MARK: - Nested Types

    /// A fragment of a `ContiguousSegmentCollection`.
    public struct Fragment {

        struct Item {
            let offset: Metric
            let fragment: Segment.Fragment

            func contains(_ target: Metric) -> Bool {
                return (offset ..< fragment.length).contains(target)
            }
        }

        // MARK: - Type Properties

        /// - Returns: A `Fragment` with no elements.
        public static var empty: Fragment {
            return .init()
        }

        // MARK: - Instance Properties

        public var offset: Metric {
            return head?.offset ?? body.first?.0 ?? .zero
        }

        let head: Item?
        let body: ContiguousSegmentCollection<Segment>
        let tail: Item?

        // MARK: - Initializers

        /// Creates a `ContiguousSegmentCollection.Fragment` with the given pair of segment
        /// fragments and the segments in-between, offset by the given `offset`.
        init(
            head: Item? = nil,
            body: ContiguousSegmentCollection = .empty,
            tail: Item? = nil
        )
        {
            self.head = head
            self.body = body
            self.tail = tail
        }

        public init(
            head: Segment.Fragment,
            body: ContiguousSegmentCollection<Segment>,
            tail: Segment.Fragment
        )
        {
            precondition(!body.isEmpty)
            let offset = body.first!.0
            let head = Item(offset: offset - head.length, fragment: head)
            let tail = Item(offset: offset + body.length, fragment: tail)
            self.init(head: head, body: body, tail: tail)
        }

        public init(head: Segment.Fragment, body: ContiguousSegmentCollection<Segment>) {
            precondition(!body.isEmpty)
            let offset = body.first!.0
            let head = Item(offset: offset - head.length, fragment: head)
            self.init(head: head, body: body)
        }

        public init(body: ContiguousSegmentCollection<Segment>, tail: Segment.Fragment) {
            precondition(!body.isEmpty)
            let offset = body.first!.0
            let tail = Item(offset: offset - tail.length, fragment: tail)
            self.init(body: body, tail: tail)
        }

        /// Creates a `ContiguousSegmentCollection.Fragment` with the given `single` segment
        /// fragment, offset by the given `offset`.
        public init(_ single: Segment.Fragment, offset: Metric = .zero) {
            let item = Item(offset: offset, fragment: single)
            self.init(head: item)
        }

        /// Creates a `ContiguousSegmentCollection.Fragment` with the given pair of segment
        /// fragments, offset by the given `offset`.
        public init(_ head: Segment.Fragment, _ tail: Segment.Fragment, offset: Metric = .zero) {
            let head = Item(offset: offset, fragment: head)
            let tail = Item(offset: offset + tail.length, fragment: tail)
            self.init(head: head, tail: tail)
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

        if startIndex == endIndex {
            return single(at: startIndex, in: range)
        } else if endIndex == startIndex + 1 {
            return adjacentPair(at: startIndex, in: range)
        } else {
            return spanning(from: startIndex, to: endIndex, in: range)
        }
    }

    private func single(at index: Int, in range: Range<Metric>) -> Fragment {
        let (offset, segment) = storage[index]
        let localRange = range.shifted(by: -offset)
        let fragment = segment.fragment(in: localRange)
        if fragment.length == segment.length {
            let body = ContiguousSegmentCollection([segment], offset: range.lowerBound)
            return Fragment(body: body)
        } else {
            return Fragment(segment.fragment(in: localRange), offset: range.lowerBound )
        }
    }

    private func adjacentPair(at index: Int, in range: Range<Metric>) -> Fragment {
        let (startOffset, startSegment) = storage[index]
        let startFragment = startSegment.fragment(in: (range.lowerBound - startOffset)...)
        let (endOffset, endSegment) = storage[index + 1]
        let endFragment = endSegment.fragment(in: ..<(range.upperBound - endOffset))
        if startSegment.length == startFragment.length && endSegment.length == endFragment.length {
            return Fragment(body: ContiguousSegmentCollection([startSegment, endSegment], offset: startOffset))
        } else if startSegment.length == startFragment.length && endSegment.length != endFragment.length {
            return Fragment(
                body: ContiguousSegmentCollection([startSegment], offset: startOffset),
                tail: endFragment
            )
        } else if startSegment.length != startFragment.length && endSegment.length == endFragment.length {
            return Fragment(
                head: startFragment,
                body: ContiguousSegmentCollection([endSegment], offset: endOffset)
            )
        } else {
            return Fragment(startFragment, endFragment, offset: startOffset)
        }
    }

    private func spanning(from startIndex: Int, to endIndex: Int, in range: Range<Metric>) -> Fragment {
        let (startOffset, startSegment) = storage[startIndex]
        let startFragment = startSegment.fragment(in: (range.lowerBound - startOffset)...)
        let (endOffset, endSegment) = storage[endIndex]
        let endFragment = endSegment.fragment(in: ..<(range.upperBound - endOffset))
        if startSegment.length == startFragment.length && endSegment.length == endFragment.length {
            return Fragment(body: segments(in: startIndex...endIndex))
        } else if startSegment.length == startFragment.length && endSegment.length != endFragment.length {
            return Fragment(body: segments(in: startIndex ..< endIndex), tail: endFragment)
        } else if startSegment.length != startFragment.length && endSegment.length == endFragment.length {
            return Fragment(head: startFragment, body: segments(in: startIndex + 1 ... endIndex))
        } else {
            return Fragment(startFragment, endFragment, offset: startOffset)
        }
    }

    private func segments(in range: Range<Int>) -> ContiguousSegmentCollection {
        return ContiguousSegmentCollection(presorted: self[range])
    }

    private func segments(in range: ClosedRange<Int>) -> ContiguousSegmentCollection {
        return ContiguousSegmentCollection(presorted: self[range])
    }
}

extension ContiguousSegmentCollection.Fragment {

    public var offsets: AnyCollection<Metric> {
        fatalError()
    }
}

extension ContiguousSegmentCollection.Fragment: IntervallicFragmentable {

    // MARK: - Type Aliases

    public typealias Fragment = ContiguousSegmentCollection<Segment>.Fragment
    public typealias Metric = Segment.Metric


    // MARK: - IntervallicFragmentable

    /// - Returns: The length of this `ContiguousSegmentCollection.Fragment`.
    //
    // FIXME: Consider storing this.
    public var length: Metric {
        return (head?.fragment.length ?? .zero) + body.segments.lazy.map { $0.length }.sum + (tail?.fragment.length ?? .zero)
    }

    public func fragment(in range: Range<Metric>) -> ContiguousSegmentCollection<Segment>.Fragment {
        guard let range = normalizedRange(range) else { return .empty }
        if let head = head {
            let headRange = head.offset ..< offset

        }
        return body.fragment(in: range)
    }

    private func normalizedRange(_ range: Range<Metric>) -> Range<Metric>? {
        guard head != nil || tail != nil || !body.isEmpty else { return nil }
        return range.clamped(to: offset ..< offset + length)
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

extension ContiguousSegmentCollection.Fragment.Item: Equatable where
    Segment: Equatable, Segment.Fragment: Equatable { }

extension ContiguousSegmentCollection.Fragment: Equatable where
    Segment: Equatable, Segment.Fragment: Equatable { }

extension ContiguousSegmentCollection: Equatable where Segment: Equatable { }
extension ContiguousSegmentCollection: Hashable where Segment: Hashable { }

extension ContiguousSegmentCollection: ExpressibleByArrayLiteral {

    // MARK: - ExpressibleByArrayLiteral

    /// Creates a `ContiguousSegmentCollection` with the given array literal.
    public init(arrayLiteral elements: Segment...) {
        self.init(elements)
    }
}

extension ContiguousSegmentCollection: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    public var description: String {
        return map { offset,segment in  "\(offset): \(segment)" }.joined(separator: "\n")
    }
}
