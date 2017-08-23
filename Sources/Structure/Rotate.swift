//
//  Rotate.swift
//  Structure
//
//  Created by James Bean on 8/23/17.
//

extension Array {

    public func rotated(by amount: Int) -> Array {
        var copy = self
        copy.rotate(by: amount)
        return copy
    }

    public mutating func rotate(by positions: Int) {
        guard positions != 0 else { return }
        let positions = (positions < 0 ? count + positions : positions) % count
        reverse(in: 0 ..< positions - 1)
        reverse(in: positions ..< count - 1)
        reverse(in: 0 ..< count - 1)
    }

    private mutating func reverse(in range: CountableRange<Int>) {
        guard count > 1 else { return }
        assert(range.lowerBound >= startIndex)
        assert(range.upperBound < endIndex)
        var start = range.lowerBound
        var end = range.upperBound
        while start < end, start != end {
            swapAt(start, end)
            start += 1
            end -= 1
        }
    }
}
