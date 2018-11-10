//
//  AdditiveGroup.swift
//  Algebra
//
//  Created by Benjamin Wetherfield on 10/11/2018.
//

public protocol AdditiveGroup: Additive, Invertible {
    
    static prefix func - (_ element: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
}

extension AdditiveGroup {
    
    static prefix func - (_ element: Self) -> Self {
        return element.inverse
    }
    
    static func - (lhs: Self, rhs: Self) -> Self {
        return lhs + -rhs
    }
}
