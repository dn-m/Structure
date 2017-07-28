//
//  ArrayExtensions.swift
//  Collections
//
//  Created by James Bean on 2/13/17.
//
//

extension Array {

    /// - Returns: Left-hand-side value appending the right-hand-side value, if it exists.
    /// Otherwise, the left-hand-side value.
    public static func + (lhs: Array, rhs: Element?) -> Array {

        if let element = rhs {
            return lhs.appending(element)
        }

        return lhs
    }

    /// - returns: New `Array` with the first element `head`, and the remaining elements of `tail`.
    public static func + (head: Element, tail: Array) -> Array {
        return [head] + tail
    }

    /// - Returns: Array with the `element` appended.
    public func appending(_ element: Element) -> Array {
        var copy = self
        copy.append(element)
        return copy
    }

    /// - Returns: Array with the element at the given `index` removed.
    public func removing(at index: Int) -> Array {
        var copy = self
        copy.remove(at: index)
        return copy
    }
}
