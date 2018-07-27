//
//  Group.swift
//  Algebra
//
//  Created by James Bean on 7/26/18.
//

/// Interface defining objects which operate as a group. `Group` extends the requirements of
/// `Monoid` by adding the `Invertible` requirement.
public protocol Group: Monoid, Invertible { }
