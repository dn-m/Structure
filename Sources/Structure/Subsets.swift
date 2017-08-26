//
//  Subsets.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Collection {

    // MARK: - Subsets

    /// - returns: All combinations of with a given cardinality
    /// (how many elements chosen per combination).
    public func subsets(cardinality k: Int) -> [[Element]] {

        func subsets(cardinality k: Int, appendingTo prefix: [Element], at index: Int)
            -> [[Element]]
        {
            guard k > 0 else { return [prefix] }
            if index < count {
                let idx = index as! Index
                return (
                    subsets(cardinality: k - 1, appendingTo: prefix + [self[idx]], at: index + 1) +
                    subsets(cardinality: k, appendingTo: prefix, at: index + 1)
                )
            }
            return []
        }

        return subsets(cardinality: k, appendingTo: [], at: 0)
    }
}
