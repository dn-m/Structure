//
//  Accumulate.swift
//  Algebra
//
//  Created by James Bean on 7/31/17.
//

extension Sequence {

    public func accumulating(
        _ initial: Element,
        with op: (Element,Element) -> Element
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
        return accumulating(.zero, with: +)
    }
}

extension Sequence where Element: Multiplicative {

    public var accumulatingProduct: [Element] {
        return accumulating(.one, with: *)
    }
}

extension Array {

    public func accumulating(
        _ initial: Element,
        with op: (Element,Element) -> Element
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

extension Array where Element: Additive {

    public var accumulatingSum: [Element] {
        return accumulating(.zero, with: +)
    }
}

extension Array where Element: Multiplicative {

    public var accumulatingProduct: [Element] {
        return accumulating(.one, with: *)
    }
}
