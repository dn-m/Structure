//
//  Rotate.swift
//  Structure
//
//  Created by James Bean on 8/23/17.
//

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
