//
//  Split.swift
//  Collections
//
//  Created by James Bean on 2/2/17.
//
//

/// - TODO: Generalize to `Sequence`
extension Array {

    /// - returns: A two-tuple containing two arrays of `Elements` split at the given `index`,
    /// if the given `index` is in the bounds of `self.` Otherwise, `nil`.
    public func split(at index: Index) -> ([Element], [Element])? {

        guard index >= startIndex && index <= endIndex else {
            return nil
        }

        let left = Array(self[startIndex ..< index])
        let right = index == endIndex ? [] : Array(self[index ..< endIndex])

        return (left, right)
    }

    /// - returns: A three-tuple containing:
    ///
    /// - The elements to the left of the element at the given `index`
    /// - The element at the given `index`
    /// - The elements to the right of the element at the given `index`
    ///
    /// if the given `index` is in the bounds of `self.` Otherwise, `nil`.
    public func splitAndExtractElement(at index: Int) -> ([Element], Element, [Element])? {

        guard count > 0 else {
            return nil
        }

        guard index >= startIndex && index < endIndex else {
            return nil
        }

        let element = self[index]
        let left = Array(self[startIndex ..< index])
        let right = index == endIndex ? [] : Array(self[index + 1 ..< endIndex])
        return (left, element, right)
    }
}
