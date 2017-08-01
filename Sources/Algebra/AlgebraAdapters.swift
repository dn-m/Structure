//
//  Adapters.swift
//  Algebra
//
//  Created by James Bean on 7/29/17.
//

// - MARK: Collections

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


extension Collection where Element: AdditiveSemigroup {

    public var nonEmptySum: Iterator.Element? {
        guard let (head,tail) = destructured else { return nil }
        return tail.reduce(head, +)
    }
}

extension Collection where Element: MultiplicativeSemigroup {

    public var nonEmptyProduct: Iterator.Element? {
        guard let (head,tail) = destructured else { return nil }
        return tail.reduce(head, *)
    }
}

extension Sequence where Element: Additive {

    /// - Returns: Sum of all values contained herein.
    public var sum: Element {
        return map { $0.sum }.reduced
    }
}

extension Set: Additive {

    public static var zero: Set {
        return Set()
    }

    public static func + (lhs: Set, rhs: Set) -> Set {
        return lhs.union(rhs)
    }
}

extension Set: MultiplicativeSemigroup {

    public static func * (lhs: Set, rhs: Set) -> Set {
        return lhs.intersection(rhs)
    }
}

// - MARK: numeric types

extension Int: AdditiveSemigroup {
    public static let zero: Int = 0
}

extension Int: Additive { }

extension Int: MultiplicativeSemigroup {
    public static let one: Int = 1
}

extension Int: Multiplicative { }

extension Float: AdditiveSemigroup {
    public static let zero: Float = 0
}

extension Float: Additive { }

extension Float: MultiplicativeSemigroup {
    public static let one: Float = 1
}

extension Float: Multiplicative { }

extension Double: AdditiveSemigroup {
    public static let zero: Double = 0
}

extension Double: Additive { }

extension Double: MultiplicativeSemigroup {
    public static let one: Double = 1
}

extension Double: Multiplicative { }

// FIXME: Flesh out
