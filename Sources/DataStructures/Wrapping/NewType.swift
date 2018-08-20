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
