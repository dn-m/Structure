//
//  Accumulate.swift
//  Algebra
//
//  Created by James Bean on 7/31/17.
//

// TODO: Extend to Multiplicative types
extension Collection where Element: Additive {

    /// - returns: An array of the values contained herein accumulating the running sum to the
    /// right, start with `.unit`.
    public var accumulatingRight: [Element] {

        func accumulate(_ array: [Element], result: [Element], sum: Element) -> [Element] {
            guard let (head, tail) = array.destructured else { return result }
            return accumulate(tail, result: result + [sum], sum: sum + head)
        }

        return accumulate(Array(self), result: [], sum: .zero)
    }

    /// - returns: An array of the values contained herein accumulating the running sum to the
    /// left, start with `.unit`.
    public var accumulatingLeft: [Iterator.Element] {
        return reversed().accumulatingRight
    }
}
