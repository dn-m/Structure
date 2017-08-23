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
        reverse(start: 0, end: positions - 1)
        reverse(start: positions, end: count - 1)
        reverse(start: 0, end: count - 1)
    }

    private mutating func reverse(start: Int, end: Int) {
        guard start >= 0 && end < count && start < end else { return }
        var start = start
        var end = end
        while start < end, start != end {
            swapAt(start, end)
            start += 1
            end -= 1
        }
    }
}
