//
//  Combinations.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

/// - returns: All combinations of elements of two arrays.
public func combinations <T, U> (_ a: [T], _ b: [U]) -> [(T, U)] {
    return a.reduce([]) { accum, a in
        accum + b.map { b in (a,b) }
    }
}
