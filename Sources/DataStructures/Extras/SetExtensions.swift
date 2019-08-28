//
//  SetExtensions.swift
//  DataStructures
//
//  Created by James Bean on 6/29/18.
//

// TODO: Consider moving to the `Algorithms` module.
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
