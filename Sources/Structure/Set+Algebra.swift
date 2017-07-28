//
//  Set+Algebra.swift
//  Collections
//
//  Created by James Bean on 7/19/17.
//
//

import Algebra

extension Set: Additive {

    public static var zero: Set {
        return Set()
    }

    public static func + (lhs: Set, rhs: Set) -> Set {
        return lhs.union(rhs)
    }
}

extension Set: MultiplicativeSemigroup {

    public static func * (lhs: Set, rhs: Set) -> Set {
        return lhs.intersection(rhs)
    }
}
