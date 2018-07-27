//
//  Invertible.swift
//  Algebra
//
//  Created by James Bean on 7/26/18.
//

/// Interface for types which have an inverse.
public protocol Invertible {
    var inverse: Self { get }
}
