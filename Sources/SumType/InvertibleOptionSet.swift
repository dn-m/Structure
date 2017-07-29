//
//  InvertibleOptionSet.swift
//  SumType
//
//  Created by James Bean on 7/29/17.
//

import Bitwise

/// Interface for types which have an inverse.
public protocol Invertible {

    /// Inverse of `self`.
    var inverse: Self { get }
}

/// Interface for `OptionSet` types which are symmetrically defined.
///
/// - invariant: The options are defined with `rawValue` values of
/// `(1 << 0) ... (1 << optionsCount - 1)`.
///
/// - TODO: Infer `optionsCount` from memory rather than making it user-specified.
public protocol InvertibleOptionSet: OptionSet, Invertible {

    /// Amount of options in `self`.
    var optionsCount: Int { get }
}

extension InvertibleOptionSet where RawValue == Int {

    /// Inverse of the current option.
    public var inverse: Self {
        let ordinal = countTrailingZeros(rawValue)
        let inverseOrdinal = (optionsCount - 1) - ordinal
        return Self(rawValue: 1 << inverseOrdinal)!
    }
}
