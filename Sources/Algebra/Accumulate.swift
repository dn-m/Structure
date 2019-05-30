//
//  Accumulate.swift
//  Algebra
//
//  Created by James Bean on 8/1/17.
//

extension Sequence {

    ///     let numbers = [1,2,3]
    ///     let accumulatedAdditionFrom10 = numbers.accumulating(10,+) // => [10,11,13]
    ///
    /// - Returns: An array of values starting with the given `initial`, followed by each
    /// element combined with the accumulation with the given `op`.
    ///x
    public func accumulating(
        _ initial: Element,
        _ op: (Element,Element) -> Element
    ) -> [Element]
    {
        var result: [Element] = []
        var accum: Element = initial
        for el in self {
            result.append(accum)
            accum = op(accum,el)
        }
        return result
    }
}

extension Sequence where Element: Additive {

    ///     let numbers = [2,1,2]
    ///     let accumulated = numbers.accumulatingSum // => [0,2,3]
    ///
    /// - Returns: An array of values from `.zero`, applying `+` to each element contained herein
    /// and the accumulative value.
    ///
    public var accumulatingSum: [Element] {
        return accumulating(.zero, +)
    }
}

extension Sequence where Element: Multiplicative {

    ///     let numbers = [2,1,2]
    ///     let accumulated = numbers.accumulatingProduct // => [1,2,2]
    ///
    /// - Returns: An array of values from `.one`, applying `*` to each element contained herein
    /// and the accumulative value.
    ///
    public var accumulatingProduct: [Element] {
        return accumulating(.one, *)
    }
}

extension Collection {

    ///     let numbers = [1,2,3]
    ///     let accumulatedAdditionFrom10 = numbers.accumulating(10,+) // => [10,11,13]
    ///
    /// - Returns: An array of values starting with the given `initial`, followed by each
    /// element combined with the accumulation with the given `op`.
    ///
    public func accumulating(
        _ initial: Element,
        _ op: (Element,Element) -> Element
    ) -> [Element]
    {
        var result: [Element] = []
        result.reserveCapacity(count)
        var accum: Element = initial
        for el in self {
            result.append(accum)
            accum = op(accum,el)
        }
        return result
    }
}

extension Collection where Element: Additive {

    /// - Returns: An array of values from `.zero`, applying `+` to each element contained herein
    /// and the accumulative value.
    ///
    ///     let numbers = [2,1,2]
    ///     let accumulated = numbers.accumulatingSum // => [0,2,3]
    ///
    public var accumulatingSum: [Element] {
        return accumulating(.zero,+)
    }
}

extension Collection where Element: Multiplicative {

    ///     let numbers = [2,1,2]
    ///     let accumulated = numbers.accumulatingProduct // => [1,2,2]
    ///
    /// - Returns: An array of values from `.one`, applying `*` to each element contained herein
    /// and the accumulative value.
    ///
    public var accumulatingProduct: [Element] {
        return accumulating(.one,*)
    }
}
