//
//  RangeProtocol+Algebra.swift
//  DataStructures
//
//  Created by James Bean on 5/17/18.
//

import Algebra

// TODO: Consider moving to the `Algebra` module.
extension ClosedRange: Zero where Bound: Zero {
    
    public static var zero: ClosedRange {
        return ClosedRange(uncheckedBounds: (lower: .zero, upper: .zero))
    }
}

extension ClosedRange: AdditiveSemigroup where Bound: Zero {

    public static func + (lhs: ClosedRange, rhs: ClosedRange) -> ClosedRange {
        let lower = Swift.min(lhs.lowerBound, rhs.lowerBound)
        let upper = Swift.max(lhs.upperBound, rhs.upperBound)
        return ClosedRange(uncheckedBounds: (lower: lower, upper: upper))
    }
}

extension ClosedRange: Additive where Bound: Zero { }
