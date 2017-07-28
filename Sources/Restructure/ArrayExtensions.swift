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
        guard let element = rhs else { return lhs }
        return lhs.appending(element)
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
}