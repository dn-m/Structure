//
//  Sequence+Monoid.swift
//  Collections
//
//  Created by James Bean on 7/19/17.
//
//

import Destructure

extension Sequence where Element: Monoid {

    /// - Returns: The values contained herein, reduced from the `.identity` value of the `Monoid`,
    /// composing with the `<>` operation of the `Monoid`.
    public var reduced: Element {
        return reduce(.identity, <>)
    }
}

extension Sequence where Element: MonoidView {

    /// - Returns: The values contained herein, reduced from the `.identity` value of the `Monoid`,
    /// composing with the `<>` operation of the `Monoid`.
    public var reduced: Element.Value {
        return reduce(.identity, <>).value
    }
}

extension Sequence where Element: Multiplicative {

    /// - Returns: Product of all values contained herein.
    public var product: Element {
        return map { $0.product }.reduced
    }
}

extension Sequence where Element: Additive {

    /// - Returns: Sum of all values contained herein.
    public var sum: Element {
        return map { $0.sum }.reduced
    }
}

extension Collection where Element: AdditiveSemigroup {

    public var nonEmptySum: Element? {
        guard let (head,tail) = destructured else { return nil }
        return tail.reduce(head, +)
    }
}

extension Collection where Element: MultiplicativeSemigroup {

    public var nonEmptyProduct: Element? {
        guard let (head,tail) = destructured else { return nil }
        return tail.reduce(head, *)
    }
}

