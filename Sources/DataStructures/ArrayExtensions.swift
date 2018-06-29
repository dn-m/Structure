//
//  ArrayExtensions.swift
//  DataStructures
//
//  Created by James Bean on 6/29/18.
//

extension Array {

    /// - Returns: `Element` at index if present. Otherwise `nil`.
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

    /// - Returns: The second `Element` in an `Array`, if not empty. Otherwise, `nil`.
    public var second: Element? {
        guard count > 1 else { return nil }
        return self[1]
    }

    /// - Returns: The second-to-last `Element` in `Array`, if not empty. Otherwise, `nil`.
    public var penultimate: Element? {
        guard count > 1 else { return nil }
        return self[self.count - 2]
    }

    /// - Returns: An array with the given `amount` of elements from the end of `self`.
    public func last(amount: Int) -> [Element] {
        guard count >= amount else { return [] }
        return Array(self[(self.count - amount)..<self.count])
    }

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

    /// - returns: New `Array` with the first element `head`, and the remaining elements of `tail`.
    public static func + (head: Element, tail: Array) -> Array {
        return [head] + tail
    }
}

extension Array {

    #warning("Attempt to generalize to RangeReplaceableCollection")

    /// - Returns: A two-tuple containing two arrays of `Elements` split at the given `index`,
    /// if the given `index` is in the bounds of `self.` Otherwise, `nil`.
    //
    // FIXME: Generalize to `Collection`
    // FIXME: Return (SubSequence,SubSequence)?
    public func split(at index: Index) -> ([Element], [Element])? {
        guard index >= startIndex && index <= endIndex else { return nil }
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
        guard count > 0 else { return nil }
        guard index >= startIndex && index < endIndex else { return nil }
        let element = self[index]
        let left = Array(self[startIndex ..< index])
        let right = index == endIndex ? [] : Array(self[index + 1 ..< endIndex])
        return (left, element, right)
    }

    /// Replace element at given `index` with the given `element`.
    @discardableResult
    public mutating func replaceElement(at index: Int, with element: Element) -> Element {
        assert(indices.contains(index))
        let replaced = remove(at: index)
        insert(element, at: index)
        return replaced
    }

    /// Immutable version of `replaceElement(at:with:)`
    public func replacingElement(at index: Int, with element: Element) -> Array {
        var copy = self
        _ = copy.replaceElement(at: index, with: element)
        return copy
    }

    /// Replace the last element in `Array` with the given `element`.
    @discardableResult
    public mutating func replaceLast(with element: Element) -> Element {
        assert(!isEmpty)
        let replaced = removeLast()
        append(element)
        return replaced
    }

    /// Replace first element in Array with a new element.
    ///
    /// - throws: `ArrayError.removalError` if `self` is empty.
    @discardableResult
    public mutating func replaceFirst(with element: Element) -> Element {
        assert(!isEmpty)
        let replaced = removeFirst()
        insert(element, at: 0)
        return replaced
    }

    /// - returns: A new `Array` with the given `element` inserted at the given `index`, if
    /// possible.
    ///
    /// - throws: `ArrayError` if the given `index` is out of range.
    public func inserting(_ element: Element, at index: Index) -> Array {
        var copy = self
        copy.insert(element, at: index)
        return copy
    }
}
