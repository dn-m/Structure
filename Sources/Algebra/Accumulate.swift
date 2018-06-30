//
//  Accumulate.swift
//  Algebra
//
//  Created by James Bean on 8/1/17.
//

extension Sequence {

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

    public var accumulatingSum: [Element] {
        return accumulating(.zero, +)
    }
}

extension Sequence where Element: Multiplicative {

    public var accumulatingProduct: [Element] {
        return accumulating(.one, *)
    }
}

extension Collection {

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

    public var accumulatingSum: [Element] {
        return accumulating(.zero,+)
    }
}

extension Collection where Element: Multiplicative {

    public var accumulatingProduct: [Element] {
        return accumulating(.one,*)
    }
}
