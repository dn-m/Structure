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

    /// - Returns: The sum of the elements contained herein, if `!self.isEmpty`. Otherwise, `nil`.
    public var nonEmptySum: Element? {
        guard let (head,tail) = destructured else { return nil }
        return tail.reduce(head, +)
    }
}

extension Collection where Element: MultiplicativeSemigroup {

    /// - Returns: The product of the elements contained herein, if `!self.isEmpty`. Otherwise,
    /// `nil`.
    public var nonEmptyProduct: Element? {
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

    // MARK: - Additive

    /// - Returns: The empty set.
    public static var zero: Set {
        return Set()
    }

    /// - Returns: The union of the two given sets.
    public static func + (lhs: Set, rhs: Set) -> Set {
        return lhs.union(rhs)
    }
}

extension Set: MultiplicativeSemigroup {

    // MARK: - MultiplicativeSemigroup

    /// - Returns: The intersection of the two given sets.
    public static func * (lhs: Set, rhs: Set) -> Set {
        return lhs.intersection(rhs)
    }
}

// - MARK: Numeric types

extension Int: AdditiveSemigroup {

    // MARK: - AdditiveSemigroup

    /// `0`.
    public static let zero: Int = 0
}

extension Int: Additive { }

extension Int: MultiplicativeSemigroup {

    // MARK: - MultiplicativeSemigroup

    /// `1`.
    public static let one: Int = 1
}

extension Int: Multiplicative { }

extension Float: AdditiveSemigroup {

    // MARK: - AdditiveSemigroup

    /// `0`.
    public static let zero: Float = 0
}

extension Float: Additive { }

extension Float: MultiplicativeSemigroup {

    // MARK: - MultiplicativeSemigroup

    /// `1`.
    public static let one: Float = 1
}

extension Float: Multiplicative { }

extension Double: AdditiveSemigroup {

    // MARK: - AdditiveSemigroup

    /// `0`.
    public static let zero: Double = 0
}

extension Double: Additive { }

extension Double: MultiplicativeSemigroup {

    // MARK: - MultiplicativeSemigroup

    /// `1`.
    public static let one: Double = 1
}

extension Double: Multiplicative { }

// FIXME: Flesh out
