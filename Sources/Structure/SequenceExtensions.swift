//
//  SequenceExtensions.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Sequence {

    // MARK: - Predicates

    /// - returns: `true` if all elements satisfy the given `predicate`. Otherwise, `false`.
    public func all(satisfy predicate: (Element) -> Bool) -> Bool {
        for element in self where !predicate(element) { return false }
        return true
    }

    /// - returns: `true` if any elements satisfy the given `predicate`. Otherwise, `false`.
    public func any(satisfy predicate: (Element) -> Bool) -> Bool {
        for element in self where predicate(element) { return true }
        return false
    }

    /// - returns: `true` if no elements satisfy the given `predicate`. Otherwise, `false`.
    public func none(satisfy predicate: (Element) -> Bool) -> Bool {
        return !any(satisfy: predicate)
    }
}

extension Sequence where Element: Equatable {

    /// - returns: `true` if there are one or fewer elements in `self`, or if all elements in
    /// `self` are logically equivalent.
    public var isHomogeneous: Bool {

        var initialElement: Element?

        for element in self {

            guard let elementToCompare = initialElement else {
                initialElement = element
                continue
            }

            if element != elementToCompare {
                return false
            }
        }

        return true
    }


    /// - returns: `false` if there are one or fewer elements in `self`, or if any elements in
    /// `self` are not logically equivalent.
    public var isHeterogeneous: Bool {
        return !isHomogeneous
    }
}

/// - returns: `true` if all elements in both `AnySequence` values are equivalent. Otherwise,
/// `false`.
public func == <T: Equatable> (lhs: AnySequence<T>, rhs: AnySequence<T>) -> Bool {
    for (a,b) in zip(lhs,rhs) where a != b { return false }
    return true
}

// FIXME: Move to PatternMatching
/// - Returns: `true` if the given `array` contains the given `value`.
public func ~= <S: Sequence> (array: S, value: S.Element) -> Bool
    where S.Element: Equatable
{
    return array.contains(value)
}

/// - Returns: `true` if the given `set` contains the given `value`.
public func ~= <S: SetAlgebra> (set: S, value: S.Element) -> Bool {
    return set.contains(value)
}
