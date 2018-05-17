//
//  RangeProtocol.swift
//  DataStructures
//
//  Created by James Bean on 5/17/18.
//

public protocol RangeProtocol {
    associatedtype Bound: Comparable
    var lowerBound: Bound { get }
    var upperBound: Bound { get }
    init(uncheckedBounds: (lower: Bound, upper: Bound))
}

extension Range: RangeProtocol { }
extension ClosedRange: RangeProtocol { }
