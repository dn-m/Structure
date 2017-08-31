//
//  ReplaceElements.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Array {

    // MARK: - Replace Elements

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
