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

    /// All of the permutations of each of the elements in each of the given sequences.
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
/// Inject the given `value` into each possible index of the given `values`.
internal func injecting <C> (_ value: C.Element, into values: C) -> [[C.Element]] where C: Collection {
    guard let (head, tail) = values.destructured else { return [[value]] }
    return  [[value] + values] + injecting(value, into: Array(tail)).map { [head] + $0 }
}