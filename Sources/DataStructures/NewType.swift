//
//  NewType.swift
//  DataStructures
//
//  Created by James Bean on 8/20/18.
//

public protocol NewType {
    associatedtype Value
    var value: Value { get }
    init(value: Value)
}

extension NewType where Value: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Value.IntegerLiteralType) {
        self.init(value: Value(integerLiteral: value))
    }
}
