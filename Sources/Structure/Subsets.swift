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

        func subsets(cardinality k: Int, appendingTo prefix: [Element], at index: Index)
            -> [[Element]]
        {
            guard k > 0 else { return [prefix] }
            if index < endIndex {
                return (
                    subsets(
                        cardinality: k - 1,
                        appendingTo: prefix + [self[index]],
                        at: indices.index(after: index)
                    ) +
                    subsets(
                        cardinality: k,
                        appendingTo: prefix,
                        at: indices.index(after: index)
                    )
                )
            }
            return []
        }

        return subsets(cardinality: k, appendingTo: [], at: startIndex)
    }
}
