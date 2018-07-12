//
//  CollectionExtensions.swift
//  DataStructures
//
//  Created by James Bean on 6/29/18.
//

extension Array {

    /// - Returns: Array with the `element` appended.
    public func appending(_ element: Element) -> Array {
        var copy = self
        copy.append(element)
        return copy
    }

    /// - Returns: Left-hand-side value appending the right-hand-side value, if it exists.
    /// Otherwise, the left-hand-side value.
    public static func + (lhs: Array, rhs: Element?) -> Array {
        guard let element = rhs else { return lhs }
        return lhs.appending(element)
    }

    /// - Returns: New `Array` with the first element `head`, and the remaining elements of `tail`.
    public static func + (head: Element, tail: Array) -> Array {
        return [head] + tail
    }
}

extension Collection {

    /// - Returns: `Element` at index if present. Otherwise `nil`.
    public subscript (safe index: Index) -> Element? {
        return indices ~= index ? self[index] : nil
    }

    /// - Returns: The permutations of the values contained herein.
    public var permutations: [[Element]] {
        func permute <C> (_ values: C) -> [[Element]] where C: Collection, C.Element == Element {
            guard let (head, tail) = values.destructured else { return [[]] }
            return permute(tail).flatMap { injecting(head, into: $0) }
        }
        return permute(self)
    }
}

extension MutableCollection where Self: BidirectionalCollection {

    /// - Returns: The second `Element` in an `Array`, if not empty. Otherwise, `nil`.
    public var second: Element? {
        guard count > 1 else { return nil }
        return self[index(after: startIndex)]
    }
}

extension BidirectionalCollection {

    /// - Returns: The second-to-last `Element` in `Array`, if not empty. Otherwise, `nil`.
    public var penultimate: Element? {
        guard count > 1 else { return nil }
        return self[index(endIndex, offsetBy: -2)]
    }

    /// - Returns: An array with the given `amount` of elements from the end of `self`.
    public func last(amount: Int) -> SubSequence? {
        guard count >= amount else { return nil }
        return self[index(endIndex, offsetBy: -amount) ..< endIndex]
    }
}

extension RangeReplaceableCollection {

    /// Replace element at given `index` with the given `element`.
    @discardableResult
    public mutating func replaceElement(at index: Index, with element: Element) -> Element {
        assert(indices.contains(index))
        let replaced = remove(at: index)
        insert(element, at: index)
        return replaced
    }

    /// Immutable version of `replaceElement(at:with:)`
    public func replacingElement(at index: Index, with element: Element) -> Self {
        var copy = self
        _ = copy.replaceElement(at: index, with: element)
        return copy
    }

    /// Replace first element in Array with a new element.
    @discardableResult
    public mutating func replaceFirst(with element: Element) -> Element {
        assert(!isEmpty)
        let replaced = removeFirst()
        insert(element, at: startIndex)
        return replaced
    }

    /// - Returns: A new `Array` with the given `element` inserted at the given `index`, if
    /// possible.
    public func inserting(_ element: Element, at index: Index) -> Self {
        var copy = self
        copy.insert(element, at: index)
        return copy
    }
}

extension RangeReplaceableCollection where Self: BidirectionalCollection {

    /// Replace the last element in `Self` with the given `element`.
    @discardableResult
    public mutating func replaceLast(with element: Element) -> Element {
        assert(!isEmpty)
        let replaced = removeLast()
        append(element)
        return replaced
    }
}

/// - Returns: Two-dimensional array of `C.Element` values (helper for `Collection.permutations`).
func injecting <C> (_ value: C.Element, into values: C) -> [[C.Element]]
    where C: Collection
{
    guard let (head, tail) = values.destructured else { return [[value]] }
    return [[value] + values] + injecting(value, into: tail).map { [head] + $0 }
}
