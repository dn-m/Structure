//
//  Number.swift
//  ArithmeticTools
//
//  Created by James Bean on 7/18/17.
//  Copyright © 2017 James Bean. All rights reserved.
//

import Algebra

extension Int: Additive {
    public static let zero: Int = 0
}

extension Int: Multiplicative {
    public static let one: Int = 1
}

extension Float: Additive {
    public static let zero: Float = 0
}

extension Float: Multiplicative {
    public static let one: Float = 1
}

extension Double: Additive {
    public static let zero: Double = 0
}

extension Double: Multiplicative {
    public static let one: Double = 1
}

// FIXME: Flesh out
