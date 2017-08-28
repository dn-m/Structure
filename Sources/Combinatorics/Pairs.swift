//
//  Pairs.swift
//  Combinatorics
//
//  Created by James Bean on 8/28/17.
//

extension Sequence where SubSequence: Sequence {

    /// - Returns: `Zip2Sequence` of 2-tuples composed of adjacent values.
    public var pairs: Zip2Sequence<Self,SubSequence> {
        return zip(self,dropFirst())
    }
}
