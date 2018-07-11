//
//  Split.swift
//  Algorithms
//
//  Created by James Bean on 7/11/18.
//

extension Collection {

    /// - Returns: A two-tuple containing two arrays of `Elements` split at the given `index`,
    /// if the given `index` is in the bounds of `self.` Otherwise, `nil`.
    public func split(at index: Index) -> (SubSequence, SubSequence)? {
        guard index >= startIndex && index <= endIndex else { return nil }
        return (self[startIndex ..< index], self[index ..< endIndex])
    }

    /// - returns: A three-tuple containing:
    ///
    /// - The elements to the left of the element at the given `index`
    /// - The element at the given `index`
    /// - The elements to the right of the element at the given `index`
    ///
    /// if the given `index` is in the bounds of `self.` Otherwise, `nil`.
    public func splitAndExtractElement(at index: Index) -> (SubSequence, Element, SubSequence)? {
        guard count > 0 else { return nil }
        guard index >= startIndex && index < endIndex else { return nil }
        let element = self[index]
        let left = self[startIndex ..< index]
        let right = self[self.index(after: index) ..< endIndex]
        return (left, element, right)
    }
}
