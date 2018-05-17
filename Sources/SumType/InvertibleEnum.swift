//
//  InvertibleEnum.swift
//  SumType
//
//  Created by James Bean on 5/17/18.
//

public protocol InvertibleEnum: CaseIterable, Equatable where Self.AllCases.Index == Int { }

extension InvertibleEnum {
    public var inverse: Self {
        let index = Self.allCases.index(of: self)!
        let inverseIndex = Self.allCases.count - 1 - index
        return Self.allCases[inverseIndex]
    }
}
