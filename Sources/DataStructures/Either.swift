//
//  Either.swift
//  Collections
//
//  Created by James Bean on 7/11/17.
//
//

/// Either of two values.
public enum Either <Left, Right> {

    /// The left value.
    case left(Left)
    /// The right value.
    case right(Right)

    /// - Returns: The left value, if it is exists. Otherwise, `nil`.
    public var left: Left? {
        guard case let .left(value) = self else { return nil }
        return value
    }

    /// - Returns: The right value, if it is exists. Otherwise, `nil`.
    public var right: Right? {
        guard case let .right(value) = self else { return nil }
        return value
    }
}

extension Either: Equatable where Left: Equatable, Right: Equatable { }
