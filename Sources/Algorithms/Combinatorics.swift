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

extension Collection {

    /// - Returns: All combinations of with a given `cardinality` (i.e., how many elements chosen
    /// per combination).
    public func subsets(cardinality k: Int) -> [[Element]] {

        func subsets(cardinality k: Int, appendingTo prefix: [Element], at index: Index)
            -> [[Element]]
        {
            guard k > 0 else { return [prefix] }
            if index < endIndex {
                let next = indices.index(after: index)
                return (
                    subsets(cardinality: k - 1, appendingTo: prefix + [self[index]], at: next) +
                    subsets(cardinality: k, appendingTo: prefix, at: next)
                )
            }
            return []
        }

        return subsets(cardinality: k, appendingTo: [], at: startIndex)
    }

    /// All of the permutations of each of the elements in each of the given sequences.
    public var permutations: [[Element]] {
        func permute <C> (_ values: C) -> [[Element]] where C: Collection, C.Element == Element {
            guard let (head, tail) = values.destructured else { return [[]] }
            return permute(tail).flatMap { injecting(head, into: $0) }
        }
        return permute(self)
    }
}

/// Inject the given `value` into each possible index of the given `values`.
internal func injecting <C> (_ value: C.Element, into values: C) -> [[C.Element]]
    where C: Collection
{
    guard let (head, tail) = values.destructured else { return [[value]] }
    return [[value] + values] + injecting(value, into: tail).map { [head] + $0 }
}


