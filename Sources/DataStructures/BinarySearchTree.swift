//
//  BinarySearchTree.swift
//  DataStructures
//
//  Created by James Bean on 9/1/18.
//

public enum BinarySearchTree <Value: Comparable> {

    // MARK: - Cases

    case empty
    case leaf(Value)
    indirect case node(BinarySearchTree, Value, BinarySearchTree)
}

extension BinarySearchTree {

    public init <S> (_ sequence: S) where S: Sequence, S.Element == Value {
        var tree: BinarySearchTree = .empty
        sequence.forEach { tree = tree.inserting($0) }
        self = tree
    }
}

extension BinarySearchTree {

    // MARK: - Computed Properties

    /// - Returns: The amount of nodes contained herein.
    public var count: Int {
        switch self {
        case .empty:
            return 0
        case .leaf:
            return 1
        case .node(let left, _, let right):
            return left.count + 1 + right.count
        }
    }

    /// - Returns: The height of this `BinarySearchTree`.
    public var height: Int {
        switch self {
        case .empty:
            return 0
        case .leaf:
            return 1
        case .node(let left, _, let right):
            return 1 + max(left.height, right.height)
        }
    }

    /// - Returns: The values of the nodes contained herein in `inOrder` (sorted) order.
    ///
    /// - Complexity: O(*n*)
    public var inOrder: [Value] {
        func traverse(_ node: BinarySearchTree, into result: [Value]) -> [Value] {
            switch node {
            case .empty:
                return result
            case .leaf(let value):
                return result + [value]
            case .node(let left, let value, let right):
                return left.inOrder + [value] + right.inOrder
            }
        }
        return traverse(self, into: [])
    }

    /// - Returns: The left-most descendent.
    public var minDescendent: BinarySearchTree {
        var node = self
        var prev = node
        while case let .node(next, _, _) = node {
            prev = node
            node = next
        }
        if case .leaf = node {
            return node
        }
        return prev
    }

    /// - Returns: The right-most descendent.
    public var maxDescendent: BinarySearchTree {
        var node = self
        var prev = node
        while case let .node(_, _, next) = node {
            prev = node
            node = next
        }
        if case .leaf = node {
            return node
        }
        return prev
    }
}

extension BinarySearchTree {

    // MARK: - Instance Methods

    /// - Returns: A `BinarySearchTree` with the given `newValue` inserted in the appropriate place.
    public func inserting(_ newValue: Value) -> BinarySearchTree {
        switch self {
        case .empty:
            return .leaf(newValue)
        case .leaf(let value):
            if newValue < value {
                return .node(.leaf(newValue), value, .empty)
            } else {
                return .node(.empty, value, .leaf(newValue))
            }
        case .node(let left, let value, let right):
            if newValue < value {
                return .node(left.inserting(newValue), value, right)
            } else {
                return .node(left, value, right.inserting(newValue))
            }
        }
    }

    /// - Returns: `true` if this `BinarySearchTree` contains the given `value`. Otherwise, `false`.
    public func contains(_ value: Value) -> Bool {
        return search(for: value) != nil
    }

    /// - Returns: The `BinarySearchTree` which contains the given `target`, if it exists.
    /// Otherwise, `nil`.
    public func search(for target: Value) -> BinarySearchTree? {
        switch self {
        case .empty:
            return nil
        case .leaf(let value):
            return target == value ? self : nil
        case .node(let left, let value, let right):
            if target < value {
                return left.search(for: target)
            } else if value < target {
                return right.search(for: target)
            } else {
                return self
            }
        }
    }
}

extension BinarySearchTree: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: Value...) {
        self.init(elements)
    }
}
