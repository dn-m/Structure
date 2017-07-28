////
////  KeyPath.swift
////  Collections
////
////  Created by James Bean on 12/23/16.
////
////
//
//import Foundation
//
//public struct KeyPath {
//
//    fileprivate let keys: [AnyHashable]
//
//    /// Create a `KeyPath` with the given `keys`.
//    public init(_ keys: [AnyHashable]) {
//        self.keys = keys
//    }
//}
//
//extension KeyPath: ExpressibleByArrayLiteral {
//
//    // MARK: - `ExpressibleByArrayLiteral`
//
//    /// Create a `KeyPath` with an array literal.
//    public init(arrayLiteral elements: AnyHashable...) {
//        self.keys = elements
//    }
//}
//
//extension KeyPath: ExpressibleByStringLiteral {
//
//    /// Create a `KeyPath` with a string literal.
//    public init(stringLiteral value: String) {
//        self.keys = value.components(separatedBy: ".")
//    }
//
//    /// Create a `KeyPath` with an extendedGraphemeCluster literal.
//    public init(extendedGraphemeClusterLiteral value: String) {
//        self.init(stringLiteral: value)
//    }
//
//    /// Create a `KeyPath` with an unicodeScalar literal.
//    public init(unicodeScalarLiteral value: String) {
//        self.init(stringLiteral: value)
//    }
//}
//
//extension KeyPath: Collection {
//
//    // MARK: - `Collection`
//
//    /// Index after given index `i`.
//    public func index(after i: Int) -> Int {
//
//        guard i != endIndex else {
//            fatalError("Cannot increment endIndex")
//        }
//
//        return i + 1
//    }
//
//    /// Start index.
//    public var startIndex: Int {
//        return 0
//    }
//
//    /// End index.
//    public var endIndex: Int {
//        return keys.count
//    }
//
//    /// - returns: Element at the given `index`.
//    public subscript (index: Int) -> AnyHashable {
//        return keys[index]
//    }
//}

