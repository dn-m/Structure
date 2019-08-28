//
//  RangeProtocol.swift
//  DataStructures
//
//  Created by James Bean on 5/17/18.
//

/// Unifying interface for `Range` and `ClosedRange` types.
///
/// TODO: Consider using Standard Library's `RangeExpression` protocol instead.
public protocol RangeProtocol {
    associatedtype Bound: Comparable
    var lowerBound: Bound { get }
    var upperBound: Bound { get }
    init(uncheckedBounds: (lower: Bound, upper: Bound))
}

extension Range: RangeProtocol { }
extension ClosedRange: RangeProtocol { }

extension RangeProtocol where Bound: SignedNumeric {

    /// - Returns: The length of this range (upperBound - lowerBound).
    public var length: Bound {
        return upperBound - lowerBound
    }
}

extension RangeProtocol where Bound: Numeric {

    /// - Returns: A new range equal to this range with bounds shifted by the given amount.
    public func shifted(by amount: Bound) -> Self {
        return Self(uncheckedBounds: (lower: lowerBound + amount, upper: upperBound + amount))
    }
}
