//
//  Combinatorics
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

import Destructure

/// - returns: All combinations of elements of two arrays.
public func combinations <T, U> (_ a: [T], _ b: [U]) -> [(T, U)] {
    return a.reduce([]) { accum, a in accum + b.map { b in (a,b) } }
}

// FIXME: Move to Combinatorics module
// FIXME: Abstract to Sequence
extension Array {

    public var permutations: [[Element]] {
        return Structure.permutations(self)
    }
}

private func permutations <T> (_ values: [T]) -> [[T]] {
    guard let (head, tail) = values.destructured else { return [[]] }
    return permutations(Array(tail)).flatMap { injecting(head, into: $0) }
}

internal func injecting <T> (_ value: T, into values: [T]) -> [[T]] {
    guard let (head, tail) = values.destructured else { return [[value]] }
    return  [[value] + values] + injecting(value, into: Array(tail)).map { [head] + $0 }
}
