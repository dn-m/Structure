//
//  Ordered.swift
//  Algorithms
//
//  Created by James Bean on 8/8/18.
//

///    let (lower,higher) = ordered(7,3) // => (3,7)
///
/// - Note: If both values are equal, they are returned in the order in which they were given
///
/// - Returns: 2-tuple of two given values, in order.
///
public func ordered <T: Comparable> (_ a: T, _ b: T) -> (T, T) {
    return a <= b ? (a,b) : (b,a)
}
