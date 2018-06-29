//
//  SequenceExtensions.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

import Destructure

// FIXME: Move to different module than Predicates
extension Sequence {

    public func extrema <T> (property: (Element) -> T, areInIncreasingOrder: (T,T) -> Bool)
        -> [Element] where T: Comparable
    {
        let sorted = self.sorted { areInIncreasingOrder(property($0), property($1)) }
        guard let extremum = sorted.first.flatMap(property) else { return [] }
        return sorted.filter { property($0) == extremum }
    }
}
