//
//  SequenceExtensions.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Sequence {

    // MARK: - Predicates

    /**
     - parameter compare:      Function the takes two values of the type of the given
     `extractedValue`, for the purpose of sorting this `SequenceType`.
     - parameter extractValue: Function that takes a value of the type of this `SequenceType`,
     and returns a given instance property of the value.

     - returns: The elements containing the value

     **Example:**

     ```
     struct S: Equatable { let value: Int }
     let array = [S(value: 1), S(value: 3), S(value: 2), S(value: 3)]
     ```

     ```
     let greatestElements = array.extremeElements(>) { $0.value }
     let leastElements = array.extremeElements(<) { $0.value }
     ```

     ```
     greatestElements == [S(value: 3), S(value: 3)]
     leastElements == [S(value: 1)]
     ```
     */
    public func extremeElements <T: Comparable> (
        _ compare: (T, T) -> Bool,
        valueToCompare extractValue: (Iterator.Element) -> T
    ) -> [Iterator.Element]
    {
        let sorted = self.sorted { compare(extractValue($0), extractValue($1)) }
        guard let first = sorted.first else { return [] }
        let most = extractValue(first)
        return sorted.filter { extractValue($0) == most }
    }

    /// - returns: The greatest value held by an element held herein, if there are more than 0
    /// elements. Otherwise, `nil`.
    public func greatest <T: Comparable> (valueToCompare extractValue: (Iterator.Element) -> T)
        -> T?
    {
        return extremity(>, valueToCompare: extractValue)
    }

    /// - returns: The least value held by an element held herein, if there are more than 0
    /// elements. Otherwise, `nil`.
    public func least <T: Comparable> (valueToCompare extractValue: (Iterator.Element) -> T)
        -> T?
    {
        return extremity(<, valueToCompare: extractValue)
    }

    /// - returns: The most extreme value held by an element held herein, if there are more
    /// than 0 elements. Otherwise, `nil`.
    public func extremity <T: Comparable> (
        _ compare: (T, T) -> Bool,
        valueToCompare extractValue: (Iterator.Element) -> T
    ) -> T?
    {
        guard let first = sorted (by: { compare(extractValue($0), extractValue($1)) }).first
            else { return nil }

        return extractValue(first)
    }

    /// - returns: `true` if all elements satisfy the given `predicate`. Otherwise, `false`.
    public func all(satisfy predicate: (Iterator.Element) -> Bool) -> Bool {
        for element in self {
            if !predicate(element) {
                return false
            }
        }
        return true
    }

    /// - returns: `true` if any elements satisfy the given `predicate`. Otherwise, `false`.
    public func any(satisfy predicate: (Iterator.Element) -> Bool) -> Bool {
        for element in self {
            if predicate(element) {
                return true
            }
        }
        return false
    }

    /// - returns: `true` if no elements satisfy the given `predicate`. Otherwise, `false`.
    public func none(satisfy predicate: (Iterator.Element) -> Bool) -> Bool {
        return !any(satisfy: predicate)
    }
}

extension Sequence where Iterator.Element: Equatable {

    /// - returns: `true` if there are one or fewer elements in `self`, or if all elements in
    /// `self` are logically equivalent.
    public var isHomogeneous: Bool {

        var initialElement: Iterator.Element?

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
    for (a,b) in zip(lhs,rhs) where a != b {
        return false
    }
    return true
}

/// - Returns: `true` if the given `array` contains the given `value`.
public func ~= <S: Sequence> (array: S, value: S.Iterator.Element) -> Bool
    where S.Iterator.Element: Equatable
{
    return array.contains(value)
}

/// - Returns: `true` if the given `set` contains the given `value`.
public func ~= <S: SetAlgebra> (set: S, value: S.Element) -> Bool {
    return set.contains(value)
}
