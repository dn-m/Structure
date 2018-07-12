//
//  Accumulate.swift
//  Algebra
//
//  Created by James Bean on 8/1/17.
//

extension Sequence {

    /// - Returns: Array of `Element` values starting with the given `initial`, followed by each
    /// element combined with the accumulation with the given `op`.
    ///
    ///     let numbers = [1,2,3]
    ///     let accumulatedAdditionFrom10 = numbers.accumulating(10,+) // => [10,11,13]
    ///
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

    /// - Returns: Array of `Element` from `.zero`, applying `+` to each element contained herein
    /// and the accumulative value.
    ///
    ///     let numbers = [2,1,2]
    ///     let accumulated = numbers.accumulatingSum // => [0,2,3]
    ///
    public var accumulatingSum: [Element] {
        return accumulating(.zero, +)
    }
}

extension Sequence where Element: Multiplicative {

    /// - Returns: Array of `Element` from `.one`, applying `*` to each element contained herein
    /// and the accumulative value.
    ///
    ///     let numbers = [2,1,2]
    ///     let accumulated = numbers.accumulatingProduct // => [1,2,2]
    ///
    public var accumulatingProduct: [Element] {
        return accumulating(.one, *)
    }
}

extension Collection {

    /// - Returns: Array of `Element` values starting with the given `initial`, followed by each
    /// element combined with the accumulation with the given `op`.
    ///
    ///     let numbers = [1,2,3]
    ///     let accumulatedAdditionFrom10 = numbers.accumulating(10,+) // => [10,11,13]
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

    /// - Returns: Array of `Element` from `.zero`, applying `+` to each element contained herein
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

    /// - Returns: Array of `Element` from `.one`, applying `*` to each element contained herein
    /// and the accumulative value.
    ///
    ///     let numbers = [2,1,2]
    ///     let accumulated = numbers.accumulatingProduct // => [1,2,2]
    ///
    public var accumulatingProduct: [Element] {
        return accumulating(.one,*)
    }
}
