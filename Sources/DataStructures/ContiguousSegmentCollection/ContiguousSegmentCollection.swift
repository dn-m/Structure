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
    where Metric: Zero, Segment: IntervallicFragmentable, Segment.Fragment: IntervallicFragmentable, Segment.Fragment.Fragment == Segment.Fragment
{

    // MARK: - Nested Types

    /// A fragment of a `ContiguousSegmentCollection`.
    public struct Fragment {

        struct Item {

            var end: Metric {
                return offset + fragment.length
            }

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
            head: Segment.Fragment?,
            body: ContiguousSegmentCollection<Segment>,
            tail: Segment.Fragment?
        )
        {
            precondition(!body.isEmpty)
            let offset = body.first!.0
            let head = head.flatMap { Item(offset: offset - $0.length, fragment: $0) }
            let tail = tail.flatMap { Item(offset: offset + body.length, fragment: $0) }
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
            return Fragment(
                body: ContiguousSegmentCollection([startSegment, endSegment], offset: range.lowerBound)
            )
        } else if startSegment.length == startFragment.length && endSegment.length != endFragment.length {
            return Fragment(
                body: ContiguousSegmentCollection([startSegment], offset: range.lowerBound),
                tail: endFragment
            )
        } else if startSegment.length != startFragment.length && endSegment.length == endFragment.length {
            return Fragment(
                head: startFragment,
                body: ContiguousSegmentCollection([endSegment], offset: endOffset)
            )
        } else {
            return Fragment(startFragment, endFragment, offset: range.lowerBound)
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
            return Fragment(
                head: startFragment,
                body: segments(in: startIndex + 1 ..< endIndex),
                tail: endFragment
            )
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

    /// - Returns: The offsets of each `Segment.Fragment` or `Segment` contained herein.
    public var offsets: [Metric] {
        let headOffset = head.map { [$0.offset] } ?? []
        let bodyOffsets = Array(body.offsets)
        let tailOffset = tail.map { [$0.offset] } ?? []
        return headOffset + bodyOffsets + tailOffset
    }
}

extension ContiguousSegmentCollection.Fragment: IntervallicFragmentable {

    // MARK: - Type Aliases

    /// A `ContiguousSegmentCollection.Fragment` produces itself as a `Fragment`.
    public typealias Fragment = ContiguousSegmentCollection<Segment>.Fragment

    /// A `ContiguousSegmentCollection` inherits its `Metric` from its `Segment`.
    public typealias Metric = Segment.Metric

    // MARK: - IntervallicFragmentable

    /// - Returns: The length of this `ContiguousSegmentCollection.Fragment`.
    //
    // FIXME: Consider storing this.
    public var length: Metric {
        let headLength = head?.fragment.length ?? .zero
        let bodyLength = body.length
        let tailLength = tail?.fragment.length ?? .zero
        return headLength + bodyLength + tailLength
    }

    /// - Returns: A `ContiguousSegmentCollection.Fragment` in the given `range`.
    //
    // FIXME: Refactor.
    public func fragment(in range: Range<Metric>) -> ContiguousSegmentCollection<Segment>.Fragment {

        guard let range = normalizedRange(range) else { return .empty }

        // If the `head` contains the lower bound of the search range.
        if let head = head, (head.offset ..< head.end).contains(range.lowerBound) {

            // If the `head` also contains the upper bound of the search range.
            if (range.lowerBound ... head.end).contains(range.upperBound) {
                let headFragment = head.fragment.fragment(in: range)
                return Fragment(headFragment, offset: range.lowerBound)
            }

            // Otherwise, concatenate the head fragment with the body fragment.
            let fragment = head.fragment.fragment(in: range)
            let b = body.fragment(in: range)
            return Fragment(head: fragment, body: b.body, tail: b.tail?.fragment)
        }

        // If the `tail` contains the upper bound of the search range.
        if let tail = tail, (tail.offset...tail.end).contains(range.upperBound) {

            // If the `tail` also contains the lower bound of the search range.
            if (tail.offset...tail.end).contains(range.lowerBound) {
                let tailFragment = tail.fragment.fragment(in: range.shifted(by: -tail.offset))
                return .init(tailFragment, offset: range.lowerBound)
            }

            // Otherwise, concatenate the body fragment with the tail fragment.
            let fragment = tail.fragment.fragment(in: range.shifted(by: -tail.offset))
            let b = body.fragment(in: range)
            return Fragment(head: b.head?.fragment, body: b.body, tail: fragment)
        }

        // Otherwise, simply return the fragment within the bounds of the body.
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
    private func indices(containingBoundsOf interval: Range<Metric>) -> (Int,Int)? {

        guard let startIndex = index(containing: interval.lowerBound, for: .lower) else {
            return nil
        }

        guard let endIndex = index(
            containing: interval.upperBound,
            for: .upper,
            in: startIndex ..< count
        ) else {
            return nil
        }

        return (startIndex,endIndex)
    }

    private enum Bound {
        case lower, upper
        var lowerCompare: (Metric,Metric) -> Bool { return self == .lower ? (>=) : (>) }
        var upperCompare: (Metric,Metric) -> Bool { return self == .lower ? (<) : (<=) }
    }

    /// - Returns: The index of the element containing the given `target` offset.
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
        return range.clamped(to: first ..< first + length)
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
