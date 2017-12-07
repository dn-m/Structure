//
//  SegmentTree.swift
//  DataStructures
//
//  Created by James Bean on 12/4/17.
//

import Algebra
import Combinatorics
import Destructure

/// Interval between two values.
//
// FIXME: Move to own file.
public struct Interval <Metric: SignedNumeric & Comparable> {

    // MARK: - Nested Types

    /// Bounds.
    public enum Bound {
        case start
        case end
    }

    // MARK: Instance Properties

    /// Start value.
    let start: Metric

    /// End value.
    let end: Metric

    // MARK: - Initializers

    /// Creates an `Interval` with `start` and `end` values.
    public init(_ start: Metric, _ end: Metric) {
        precondition(end >= start)
        self.start = start
        self.end = end
    }

    // MARK: - Instance Methods

    /// - Returns: The intersection of this `Interval` and the given `other`.
    public func intersection(_ other: Interval) -> Interval? {
        let start = max(self.start, other.start)
        let end = min(self.end, other.end)
        guard end > start && start < end else { return nil }
        return Interval(start, end)
    }

    /// - Returns: Whether this `Interval` overlaps with the given `other`.
    public func overlaps(with other: Interval) -> Bool {
        return other.start > start || other.end < end
    }

    /// - Returns: Whether this `Interval` contains the given `offset` including the given `bound`.
    public func contains(_ offset: Metric, including bound: Bound) -> Bool {
        let startCompare: (Metric, Metric) -> Bool = bound == .start ? (>=) : (>)
        let endCompare: (Metric, Metric) -> Bool = bound == .end ? (<=) : (<)
        return startCompare(offset,start) && endCompare(offset,end)
    }
}

extension Interval: Equatable {

    /// - Returns: `true` if intervals are equivalent. Otherwise `false`.
    public static func == (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

/// Organizaes contiguous intervals into a binary tree structure for efficient searching.
public enum SegmentTree <Metric: SignedNumeric & Comparable> {

    // MARK: - Instance Properties

    /// The interval of this `SegmentTree`.
    public var interval: Interval<Metric> {
        switch self {
        case .leaf(let interval):
            return interval
        case .branch(_, let interval, _):
            return interval
        }
    }

    /// The leaf intervals contained herein.
    public var leaves: [Interval<Metric>] {

        func flattening(_ tree: SegmentTree, into accum: [Interval<Metric>]) -> [Interval<Metric>] {
            switch tree {
            case .branch(let left, _, let right):
                return left.leaves + right.leaves
            case .leaf(let interval):
                return accum + [interval]
            }
        }

        return flattening(self, into: [])
    }

    // MARK: - Cases

    /// Leaf Interval.
    case leaf(Interval<Metric>)

    /// Branch Interval containing `SegmentTree` values to the left and right.
    indirect case branch(SegmentTree, Interval<Metric>, SegmentTree)

    // MARK: - Initializers

    /// Creates a `SegmentTree` with the two given `SegmentTree` values.
    ///
    /// - Invariant: The end of the first `SegmentTree` is equal to the start of the second.
    public init(_ left: SegmentTree, _ right: SegmentTree) {
        precondition(left.interval.end == right.interval.start)
        self = .branch(left, Interval(left.interval.start, right.interval.end), right)
    }

    /// Creates a `SegmentTree` leaf with the given `interval`.
    public init(interval: Interval<Metric>) {
        self = .leaf(interval)
    }

    /// Creates a `SegmentTree` from an array of `SegmentTree` values.
    public init(segmentTrees: [SegmentTree<Metric>]) {
        precondition(!segmentTrees.isEmpty)
        self = join(segmentTrees)
    }

    /// Creates a `SegmentTree` from a given array of `intervals`.
    public init(intervals: [Interval<Metric>]) {
        precondition(!intervals.isEmpty)
        self.init(segmentTrees: intervals.map(SegmentTree.init))
    }

    /// Creates a `SegmentTree` from a given array of `offsets`.
    ///
    /// - Invariant: Offsets are in increasing order.
    public init(offsets: [Metric]) {
        precondition(offsets.count > 1)
        self.init(intervals: offsets.pairs.map(Interval.init))
    }

    // MARK: - Subscripts

    /// - Returns: A new `SegmentTree` from the given `offset` to the end.
    public subscript (from offset: Metric) -> SegmentTree? {
        guard offset < interval.end else { return nil }
        return self[Interval(offset, interval.end)]
    }

    /// - Returns: A new `SegmentTree` to the given `offset` from the start.
    public subscript (to offset: Metric) -> SegmentTree? {
        guard offset > interval.start else { return nil }
        return self[Interval(interval.start, offset)]
    }

    /// - Returns: A new `SegmentTree` in the given `interval`.
    public subscript (interval: Interval<Metric>) -> SegmentTree? {
        let intervals = leaves.flatMap { $0.intersection(interval) }
        if intervals.isEmpty { return nil }
        return SegmentTree(intervals: intervals)
    }

    // MARK: - Instance Methods

    /// - Returns: The interval containing the given `offset`, including the given `bound`.
    public func interval(
        containing offset: Metric,
        including bound: Interval<Metric>.Bound
    ) -> Interval<Metric>?
    {
        let startCompare: (Metric, Metric) -> Bool = bound == .start ? (>=) : (>)
        let endCompare: (Metric, Metric) -> Bool = bound == .end ? (<=) : (<)

        guard startCompare(offset, interval.start) && endCompare(offset, interval.end) else {
            return nil
        }

        switch self {
        case .leaf(let interval):
            return interval
        case .branch(let left, let interval, let right):
            if !startCompare(offset, right.interval.start) {
                return left.interval(containing: offset, including: bound)
            } else if !endCompare(offset, left.interval.end) {
                return right.interval(containing: offset, including: bound)
            } else {
                return interval
            }
        }
    }
}

extension SegmentTree where Metric: Additive {

    /// Creates a `SegmentTree` with the given `lengths`, starting at the `initial` value.
    public init(lengths: [Metric], from initial: Metric = .zero) {
        self.init(offsets: lengths.accumulating(initial,+))
    }
}

extension SegmentTree: Equatable {

    /// - Returns: `true` if `SegmentTree` values are equivalent. Otherwise, `false`.
    public static func == (lhs: SegmentTree, rhs: SegmentTree) -> Bool {
        switch (lhs,rhs) {
        case let (.leaf(a), .leaf(b)):
            return a == b
        case let (.branch(aLeft, a, aRight), .branch(bLeft, b, bRight)):
            return a == b && aLeft == bLeft && aRight == bRight
        default:
            return false
        }
    }
}

/// Join a non-empty array of `SegmentTree` values into a single `SegmentTree`.
///
/// - Invariant: The given `trees` are contiguous.
private func join <T> (_ trees: [SegmentTree<T>]) -> SegmentTree<T> {

    /// Groups the given `values` into pairs, with an optional last value in the case that there is
    /// an odd amount of values.
    func clump <T> (_ values: [T]) -> ([(T,T)], T?) {
        let indices = stride(from: values.startIndex, to: values.endIndex - 1, by: 2)
        let pairs = indices.map { index in (values[index], values[index + 1]) }
        let last = values.count % 2 != 0 ? values.last! : nil
        return (pairs,last)
    }

    precondition(!trees.isEmpty)
    guard trees.count > 1 else { return trees.first! }
    let (pairs,last) = clump(trees)
    let left = join(pairs.map(SegmentTree.init))
    return last == nil ? left : SegmentTree(left,last!)
}
