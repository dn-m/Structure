//
//  CollectionExtensions.swift
//  DataStructures
//
//  Created by James Bean on 6/29/18.
//

import Destructure

extension Collection where Element: Equatable {

    /// - Returns: `true` if there are one or fewer elements in `self`, or if all elements in
    /// `self` are logically equivalent.
    public var isHomogeneous: Bool {
        guard let (head,tail) = destructured else { return true }
        for element in tail where element != head { return false }
        return true
    }

    /// - Returns: `false` if there are one or fewer elements in `self`, or if any elements in
    /// `self` are not logically equivalent.
    public var isHeterogeneous: Bool {
        guard let (head,tail) = destructured else { return false }
        for element in tail where element == head { return false }
        return false
    }
}

extension Collection {

    #warning("Move to Algorithms module")
    /// - Returns: All combinations of with a given cardinality
    /// (how many elements chosen per combination).
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
}

extension MutableCollection where Self: BidirectionalCollection {

    #warning("Move to Algorithms module")
    /// - Returns: A mutable and bidirectional collection with its elements rotated by the given
    /// `amount`.
    public func rotated(by amount: Int) -> Self {
        var copy = self
        copy.rotate(by: amount)
        return copy
    }

    /// Rotates the elements contained herein by the given `amount`.
    public mutating func rotate(by amount: Int) {
        guard amount != 0 else { return }
        let amount = (amount < 0 ? count + amount : amount) % count
        let amountIndex = index(startIndex, offsetBy: amount)
        reverse(in: startIndex ..< index(before: amountIndex))
        reverse(in: amountIndex ..< index(before: endIndex))
        reverse(in: startIndex ..< index(before: endIndex))
    }

    private mutating func reverse(in range: Range<Index>) {
        guard count > 1 else { return }
        assert(range.lowerBound >= startIndex)
        assert(range.upperBound < endIndex)
        var start = range.lowerBound
        var end = range.upperBound
        while start < end, start != end {
            swapAt(start, end)
            start = index(after: start)
            end = index(before: end)
        }
    }
}

