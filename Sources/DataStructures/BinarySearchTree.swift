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

    // MARK: - Computed Properties

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

    public func contains(_ value: Value) -> Bool {
        return search(for: value) != nil
    }

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
