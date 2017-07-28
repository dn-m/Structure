//
//  Subsets.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Collection where Index == Int, IndexDistance == Int {

    // MARK: - Subsets

    /// - returns: All combinations of with a given cardinality
    /// (how many elements chosen per combination).
    public func subsets(cardinality k: Int) -> [[Iterator.Element]] {

        func subsets(
            cardinality k: Int,
            combinedWith prefix: [Iterator.Element],
            startingAt index: Int
        ) -> [[Iterator.Element]]
        {

            guard k > 0 else {
                return [prefix]
            }

            if index < count {
                let first = self[index]
                return (
                    subsets(
                        cardinality: k - 1,
                        combinedWith: prefix + [first],
                        startingAt: index + 1
                    ) +
                    subsets(
                        cardinality: k,
                        combinedWith: prefix,
                        startingAt: index + 1
                    )
                )
            }

            return []
        }

        return subsets(cardinality: k, combinedWith: [], startingAt: 0)
    }
}
