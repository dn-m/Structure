//
//  Accumulate.swift
//  Algebra
//
//  Created by James Bean on 7/31/17.
//

extension Collection where Iterator.Element: Additive {

    typealias M = Iterator.Element

    /// - returns: An array of the values contained herein accumulating the running sum to the
    /// right, start with `.unit`.
    public var accumulatingRight: [Iterator.Element] {

        func accumulate(_ array: [M], result: [M], sum: M) -> [M] {

            guard let (head, tail) = array.destructured else {
                return result
            }

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
