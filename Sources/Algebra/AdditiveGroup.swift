//
//  AdditiveGroup.swift
//  Algebra
//
//  Created by Benjamin Wetherfield on 10/11/2018.
//

/// The requirements for a type to display the behaviors of an `AdditiveGroup`.
///
/// The  `AdditiveGroup` builds upon the `AdditiveMonoid` with an `inverse` operation.
public protocol AdditiveGroup: Additive, Invertible {

    /// - Returns: The additive inverse of this `AdditiveGroup` element.
    static prefix func - (_ element: Self) -> Self

    /// - Returns: The difference between two `AdditiveGroup` elements.
    static func - (lhs: Self, rhs: Self) -> Self
}

extension AdditiveGroup {

    /// - Returns: The additive inverse of this `AdditiveGroup` element.
    public static prefix func - (_ element: Self) -> Self {
        return element.inverse
    }

    /// - Returns: The difference between two `AdditiveGroup` elements.
    public static func - (lhs: Self, rhs: Self) -> Self {
        return lhs + -rhs
    }
}
