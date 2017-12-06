//
//  SegmentTree.swift
//  DataStructures
//
//  Created by James Bean on 12/4/17.
//

import Combinatorics
import Destructure

public struct Interval {

    enum Bound {
        case start
        case end
    }

    let start: Int
    let end: Int

    public init(_ start: Int, _ end: Int) {
        precondition(end >= start)
        self.start = start
        self.end = end
    }
}

extension Interval: Equatable {
    public static func == (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

enum SegmentTree {

    public var interval: Interval {
        switch self {
        case .leaf(let interval):
            return interval
        case .branch(_, let interval, _):
            return interval
        }
    }

    case leaf(Interval)
    indirect case branch(SegmentTree, Interval, SegmentTree)

    init(_ a: SegmentTree, _ b: SegmentTree) {
        precondition(a.interval.end == b.interval.start)
        self = .branch(a, Interval(a.interval.start, b.interval.end), b)
    }

    init(_ interval: Interval) {
        self = .leaf(interval)
    }

    init(offsets: [Int]) {

        func clump(_ trees: [SegmentTree]) -> ([(SegmentTree, SegmentTree)], SegmentTree?) {
            precondition(!trees.isEmpty)
            let pairs = stride(from: trees.startIndex, to: trees.endIndex - 1, by: 2).map { index in
                return (trees[index], trees[index + 1])
            }
            let last = trees.count % 2 != 0 ? trees.last! : nil
            return (pairs,last)
        }

        func join(_ trees: [SegmentTree]) -> SegmentTree {
            guard trees.count > 1 else { return trees.first! }
            let (pairs,last) = clump(trees)
            let left = join(pairs.map(SegmentTree.init))
            if let last = last {
                return SegmentTree(left,last)
            } else {
                return left
            }
        }

        switch offsets.count {
        case 0,1:
            fatalError("Not enough points to create an IntervalTree")
        default:
            self = join(offsets.pairs.map(Interval.init).map(SegmentTree.init))
        }
    }

    func interval(containing offset: Int, including bound: Interval.Bound) -> Interval? {

        let startCompare: (Int,Int) -> Bool = bound == .start ? (>=) : (>)
        let endCompare: (Int,Int) -> Bool = bound == .end ? (<=) : (<)

        guard startCompare(offset, interval.start) && endCompare(offset, interval.end) else {
            return nil
        }

        switch self {
        case .branch(let left, let interval, let right):
            if !startCompare(offset, right.interval.start) {
                return left.interval(containing: offset, including: bound)
            } else if !endCompare(offset, left.interval.end) {
                return right.interval(containing: offset, including: bound)
            } else {
                return interval
            }
        case .leaf(let interval):
            return interval
        }
    }
}

extension SegmentTree: Equatable {
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
