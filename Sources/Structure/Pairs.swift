//
//  Pairs.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension BidirectionalCollection where IndexDistance == Int, Index == Int {

    /// - Returns: Array of 2-tuples comosed of adjacent values.
    public var pairs: [(Iterator.Element, Iterator.Element)] {
        guard !isEmpty else { return [] }
        return (0..<count-1).map { (self[$0], self[$0+1]) }
    }

    /// - Returns: An array with same elements as this one, but with the first appended to the end.
    public var wrapped: [Iterator.Element] {
        guard !isEmpty else { return [] }
        return self + [self[0]]
    }
}
