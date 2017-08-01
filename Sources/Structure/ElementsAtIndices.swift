//
//  ElementsAtIndices.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Array {

    // MARK: - Elements At Indices

    /// - returns: `Element` at index if present. Otherwise `nil`.
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

    /// Second `Element` in an `Array`
    public var second: Element? {

        guard count > 1 else {
            return nil
        }

        return self[1]
    }

    /// Second-to-last `Element` in `Array`
    public var penultimate: Element? {

        guard count > 1 else {
            return nil
        }

        return self[self.count - 2]
    }

    /// An array with the given `amount` of elements from the end of `self`.
    public func last(amount: Int) -> [Element] {

        guard count >= amount else {
            return []
        }

        return Array(self[(self.count - amount)..<self.count])
    }
}
