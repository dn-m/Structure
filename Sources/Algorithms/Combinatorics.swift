//
//  Combinatorics.swift
//  Algorithms
//
//  Created by James Bean on 7/11/18.
//

import Destructure

/// - Returns: Cartesian product of two sequences.
public func cartesianProduct <T,U> (_ a: T, _ b: U) -> [(T.Element, U.Element)]
    where T: Sequence, U: Sequence
{
    return a.flatMap { a in b.map { b in (a,b) } }
}

extension Array {

    #warning("Attempt to generalize to RangeReplaceableCollection")

    public var permutations: [[Element]] {

        // FIXME: Use `ArraySlice` to avoid conversion to `Array`.
        func permute(_ values: [Element]) -> [[Element]] {
            guard let (head, tail) = values.destructured else { return [[]] }
            return permute(Array(tail)).flatMap { injecting(head, into: $0) }
        }

        return permute(self)
    }
}

// FIXME: Use `ArraySlice` to avoid conversion to `Array`.
internal func injecting <T> (_ value: T, into values: [T]) -> [[T]] {
    guard let (head, tail) = values.destructured else { return [[value]] }
    return  [[value] + values] + injecting(value, into: Array(tail)).map { [head] + $0 }
}
