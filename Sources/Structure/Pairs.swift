//
//  Pairs.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension BidirectionalCollection where IndexDistance == Int, Index == Int {

    /// - Returns: An array with same elements as this one, but with the first appended to the end.
    public var wrapped: [Element] {
        guard !isEmpty else { return [] }
        return self + [self[0]]
    }
}

extension Sequence where SubSequence: Sequence {

    /// - Returns: `Zip2Sequence` of 2-tuples comosed of adjacent values.
    public var pairs: Zip2Sequence<Self,SubSequence> {
        return zip(self,dropFirst())
    }
}
