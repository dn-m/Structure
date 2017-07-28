//
//  RawRepresentable+Equatable.swift
//  Collections
//
//  Created by James Bean on 1/8/17.
//
//

extension RawRepresentable where RawValue: Equatable {

    // MARK: - `Equatable`

    /// - returns: `true` if the `rawValue` of the left value is equivalent to the `rawValue`
    /// of the right value. Otherwise, `nil`.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
