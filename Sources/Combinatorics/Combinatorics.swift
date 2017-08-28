//
//  Combinatorics
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

import Destructure

/// - Returns: All combinations of elements of two arrays.
public func combinations <T,U> (_ a: [T], _ b: [U]) -> [(T, U)] {
    return a.flatMap { a in b.map { b in (a,b) } }
}

// FIXME: Abstract to Sequence
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
