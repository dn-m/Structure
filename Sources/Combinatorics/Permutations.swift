//
//  Permutations.swift
//  Combinatorics
//
//  Created by James Bean on 8/28/17.
//

import Destructure

extension Array {

    public var permutations: [[Element]] {

        // FIXME: Use `ArraySlice` to avoid conversion to `Array`.
        func permute(_ values: [Element]) -> [[Element]] {
            guard let (head, tail) = values.destructured else { return [[]] }
            return permute(Array(tail)).flatMap { injecting(head, into: $0) }
        }

        return permute(self)
    }
}

// FIXME: Use `ArraySlice` to avoid conversion to `Array`.
internal func injecting <T> (_ value: T, into values: [T]) -> [[T]] {
    guard let (head, tail) = values.destructured else { return [[value]] }
    return  [[value] + values] + injecting(value, into: Array(tail)).map { [head] + $0 }
}
