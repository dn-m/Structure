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


