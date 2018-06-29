//
//  SequenceExtensions.swift
//  DataStructures
//
//  Created by James Bean on 6/29/18.
//

extension Sequence {

    /// All of the values which are the least or greatest given the `areInIncreasingOrder` closure.
    ///
    /// - NOTE: Consider returning (Element, count: Int)? instead of `Array`.
    public func extrema <T> (property: (Element) -> T, areInIncreasingOrder: (T,T) -> Bool)
        -> [Element] where T: Comparable
    {
        let sorted = self.sorted { areInIncreasingOrder(property($0), property($1)) }
        guard let extremum = sorted.first.flatMap(property) else { return [] }
        return sorted.filter { property($0) == extremum }
    }
}
