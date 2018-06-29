//
//  Adapters.swift
//  Algebra
//
//  Created by James Bean on 7/29/17.
//

extension Set {

    public func inserting(_ element: Element) -> Set {
        var copy = self
        copy.insert(element)
        return copy
    }

    public static func + (lhs: Set, rhs: Element?) -> Set {
        guard let element = rhs else { return lhs }
        return lhs.inserting(element)
    }

    public static func + (lhs: Element?, rhs: Set) -> Set {
        guard let element = lhs else { return rhs }
        return rhs.inserting(element)
    }
}

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

    /// - returns: New `Array` with the first element `head`, and the remaining elements of `tail`.
    public static func + (head: Element, tail: Array) -> Array {
        return [head] + tail
    }
}
