//
//  CollectionExtensions.swift
//  DataStructures
//
//  Created by James Bean on 6/29/18.
//

import Destructure

extension Collection where Element: Equatable {

    /// - Returns: `true` if there are one or fewer elements in `self`, or if all elements in
    /// `self` are logically equivalent.
    public var isHomogeneous: Bool {
        guard let (head,tail) = destructured else { return true }
        for element in tail where element != head { return false }
        return true
    }

    /// - Returns: `false` if there are one or fewer elements in `self`, or if any elements in
    /// `self` are not logically equivalent.
    public var isHeterogeneous: Bool {
        guard let (head,tail) = destructured else { return false }
        for element in tail where element == head { return false }
        return false
    }
}

extension MutableCollection where Self: BidirectionalCollection {

    /// - Returns: A mutable and bidirectional collection with its elements rotated by the given
    /// `amount`.
    public func rotated(by amount: Int) -> Self {
        var copy = self
        copy.rotate(by: amount)
        return copy
    }

    /// Rotates the elements contained herein by the given `amount`.
    public mutating func rotate(by amount: Int) {
        guard amount != 0 else { return }
        let amount = (amount < 0 ? count + amount : amount) % count
        let amountIndex = index(startIndex, offsetBy: amount)
        reverse(in: startIndex ..< index(before: amountIndex))
        reverse(in: amountIndex ..< index(before: endIndex))
        reverse(in: startIndex ..< index(before: endIndex))
    }

    private mutating func reverse(in range: Range<Index>) {
        guard count > 1 else { return }
        assert(range.lowerBound >= startIndex)
        assert(range.upperBound < endIndex)
        var start = range.lowerBound
        var end = range.upperBound
        while start < end, start != end {
            swapAt(start, end)
            start = index(after: start)
            end = index(before: end)
        }
    }
}

extension RangeReplaceableCollection where Index == Int  {

    public func stableSort(_ isOrderedBefore: @escaping (Element, Element) -> Bool) -> [Element] {

        var result = self
        let count = result.count

        var aux: [Element] = []
        aux.reserveCapacity(numericCast(count))

        func merge(_ lo: Index, _ mid: Index, _ hi: Index) {

            aux.removeAll(keepingCapacity: true)

            var i = lo
            var j = mid

            while i < mid && j < hi {
                if isOrderedBefore(result[j], result[i]) {
                    aux.append(result[j])
                    j += 1
                }
                else {
                    aux.append(result[i])
                    i += 1
                }
            }

            aux.append(contentsOf: result[i ..< mid])
            aux.append(contentsOf: result[j ..< hi])
            result.replaceSubrange(lo ..< hi, with: aux)
        }

        var sz: Int = 1
        while sz < count {
            for lo in stride(from: result.startIndex, to: result.endIndex - sz, by: sz * 2) {
                merge(lo, lo + sz, (lo + (sz * 2)).limited(notToExceed: count))
            }
            sz *= 2
        }
        return Array(result)
    }
}

extension Int {
    func limited(notToExceed maximum: Int) -> Int {
        return self >= maximum ? maximum : self
    }
}
