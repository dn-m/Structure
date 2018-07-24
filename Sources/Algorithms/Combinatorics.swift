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

        func injecting <S> (_ value: S.Element, into values: S) -> [[S.Element]] where S: Sequence {
            guard let (head, tail) = values.destructured else { return [[value]] }
            return [[value] + values] + injecting(value, into: tail).map { [head] + $0 }
        }

        func permute <S> (_ values: S) -> [[Element]] where S: Sequence, S.Element == Element {
            guard let (head, tail) = values.destructured else { return [[]] }
            return permute(tail).flatMap { injecting(head, into: $0) }
        }

        return self.isEmpty ? [] : permute(self)
    }
}

extension Sequence where SubSequence: Sequence {

    /// - Returns: `Zip2Sequence` of 2-tuples composed of adjacent values.
    public var pairs: Zip2Sequence<Self,SubSequence> {
        return zip(self,dropFirst())
    }
}
