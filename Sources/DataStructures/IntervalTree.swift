//
//  IntervalTree.swift
//  DataStructures
//
//  Created by James Bean on 12/4/17.
//

import Combinatorics
import Destructure

// TODO: Abstract Int to SignedNumeric

public struct Interval {
    let start: Int
    let end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

extension Interval: Equatable {
    public static func == (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

public typealias IntervalTree = Tree<Interval,Interval>

// Restructure as Binary Tree !
extension Tree where Branch == Interval, Leaf == Interval {

    public var start: Int {
        switch self {
        case .leaf(let interval):
            return interval.start
        case .branch(let interval, _):
            return interval.start
        }
    }

    public var end: Int {
        switch self {
        case .leaf(let interval):
            return interval.end
        case .branch(let interval, _):
            return interval.end
        }
    }

    public init(lengths: [Int]) {
        self.init(offsets: lengths.accumulatingSum)
    }

    public init(_ a: Int, _ b: Int) {
        self = .leaf(Interval(a,b))
    }

    public init(_ a: Int, _ b: Int, _ c: Int) {
        self = .branch(Interval(a,c), [
            .leaf(Interval(a,b)),
            .leaf(Interval(b,c))
        ])
    }

    // Meant only to create a new tree from 2 or 3 trees
    // Assumes they are valid neighbors
    internal init(_ trees: [IntervalTree]) {
        switch trees.count {
        case 0:
            preconditionFailure("Must have more than one IntervalTree")
        case 1:
            self = trees.first!
        default:
            self = .branch(Interval(trees.first!.start, trees.last!.end), trees)
        }
    }

    public init(offsets: [Int]) {

        func join(_ trees: [IntervalTree]) -> IntervalTree {
            guard trees.count > 1 else { return trees.first! }
            return join(clump(trees).map(IntervalTree.init))
        }

        switch offsets.count {
        case 0,1:
            fatalError("Not enough points to create an IntervalTree")
        default:
            self = join(offsets.pairs.map(IntervalTree.init))
        }

        // clump into pairs or single values (if odd amount of intervals)
        func clump(_ trees: [IntervalTree]) -> [[IntervalTree]] {
            return stride(from: trees.startIndex, to: trees.endIndex, by: 2).map { index in
                if index < trees.endIndex - 1 {
                    return [trees[index], trees[index + 1]]
                } else {
                    return [trees[index]]
                }
            }
        }
    }

    func interval(containing offset: Int) -> Interval? {
        guard (start...end).contains(offset) else { return nil }
        switch self {
        case .leaf(let interval):
            return interval
        case .branch(_, let children):
            for child in children where (child.start...child.end).contains(offset) {
                return child.interval(containing: offset)
            }
            preconditionFailure("")
        }
    }
}
