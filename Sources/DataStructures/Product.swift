//
//  Product.swift
//  Combinatorics
//
//  Created by James Bean on 8/28/17.
//

/// - Returns: Cartesian product of two arrays.
public func * <T,U> (_ a: T, _ b: U) -> [(T.Element, U.Element)] where T: Sequence, U: Sequence {
    return a.flatMap { a in b.map { b in (a,b) } }
}
