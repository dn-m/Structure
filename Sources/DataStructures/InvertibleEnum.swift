//
//  InvertibleEnum.swift
//  SumType
//
//  Created by James Bean on 5/17/18.
//

/// Interface for `enum` values whose values can be inverted.
public protocol InvertibleEnum: CaseIterable, Equatable {
    /// - Returns: Inverse of `self`.
    var inverse: Self { get }
}

extension InvertibleEnum where AllCases.Index == Int {

    /// - Returns: Inverse of `self`.
    public var inverse: Self {
        let index = Self.allCases.index(of: self)!
        let inverseIndex = Self.allCases.count - (1 + index)
        return Self.allCases[inverseIndex]
    }
}
