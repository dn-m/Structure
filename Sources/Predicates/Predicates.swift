//
//  SequenceExtensions.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

import Destructure

// FIXME: Move to Predicates module
extension Sequence {

    // MARK: - Predicates

    /// - Returns: `true` if all elements satisfy the given `predicate`. Otherwise, `false`.
    public func all(satisfy predicate: (Element) -> Bool) -> Bool {
        for element in self where !predicate(element) { return false }
        return true
    }

    /// - Returns: `true` if any elements satisfy the given `predicate`. Otherwise, `false`.
    public func any(satisfy predicate: (Element) -> Bool) -> Bool {
        for element in self where predicate(element) { return true }
        return false
    }

    /// - Returns: `true` if no elements satisfy the given `predicate`. Otherwise, `false`.
    public func none(satisfy predicate: (Element) -> Bool) -> Bool {
        return !any(satisfy: predicate)
    }
}

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


// FIXME: Move to different module than Predicates
extension Sequence {

    public func extrema <T> (
        property: (Element) -> T,
        areInIncreasingOrder: (T,T) -> Bool
        ) -> [Element] where T: Comparable
    {
        let sorted = self.sorted { areInIncreasingOrder(property($0), property($1)) }
        guard let extremum = sorted.first.flatMap(property) else { return [] }
        return sorted.filter { property($0) == extremum }
    }
}
