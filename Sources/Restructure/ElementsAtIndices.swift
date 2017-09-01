//
//  ElementsAtIndices.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Collection {

    /// - Returns: `Element` at index if present. Otherwise `nil`.
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    /// Second `Element` in an `Array`
    public var second: Element? {
        guard count > 1 else { return nil }
        return self[indices.index(after: startIndex)]
    }
}

extension BidirectionalCollection {

    /// Second-to-last `Element` in `Array`
    public var penultimate: Element? {
        guard count > 1 else { return nil }
        let lastElementIndex = indices.index(before: endIndex)
        return self[indices.index(before: lastElementIndex)]
    }
}

extension Array {

    // MARK: - Elements At Indices

    /// An array with the given `amount` of elements from the end of `self`.
    public func last(amount: Int) -> [Element] {
        guard count >= amount else { return [] }
        return Array(self[(self.count - amount)..<self.count])
    }
}
