//
//  Either.swift
//  Collections
//
//  Created by James Bean on 7/11/17.
//
//

/// Either of two values.
public enum Either <Left, Right> {

    case left(Left)
    case right(Right)

    public var left: Left? {
        guard case let .left(value) = self else { return nil }
        return value
    }

    public var right: Right? {
        guard case let .right(value) = self else { return nil }
        return value
    }
}

extension Either: Equatable where Left: Equatable, Right: Equatable {

    /// - Returns: `true` if two `Either` values are equivalent. Otherwise, `false`.
    public static func == (lhs: Either, rhs: Either) -> Bool {
        switch (lhs,rhs) {
        case let (.left(a), .left(b)):
            return a == b
        case let (.right(a), .right(b)):
            return a == b
        default:
            return false
        }
    }
}
