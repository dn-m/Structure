//
//  SingleTypedTree.swift
//  Collections
//
//  Created by James Bean on 7/11/17.
//
//

extension Tree where Branch == Leaf {

    /// The payload of a given `Tree`.
    public var value: Leaf {
        switch self {
        case .leaf(let value):
            return value
        case .branch(let value, _):
            return value
        }
    }

    /// Create a single-depth `TreeNode.branch` with leaves defined by a given `Sequence`
    /// parameretized over `T`.
    ///
    /// In the case of initializing with an empty array:
    ///
    ///     let tree = Tree(1, [])
    ///
    /// A branch is created, populated with a single value matching the given `value`:
    ///
    ///     self = .branch(value, [.leaf(value)])
    ///
    public init <S: Sequence> (_ value: Leaf, _ sequence: S) where S.Iterator.Element == Leaf {

        if let array = sequence as? Array<Leaf>, array.isEmpty {
            self = .branch(value, [.leaf(value)])
            return
        }

        self = .branch(value, sequence.map(Tree.leaf))
    }

    /// - returns: A new `Tree` with the given `value` as payload.
    public func updating(value: Leaf) -> Tree {
        switch self {
        case .leaf:
            return .leaf(value)
        case .branch(_, let trees):
            return .branch(value, trees)
        }
    }

    /// Apply a given `transform` to all nodes in a `Tree`.
    public func map <Result> (_ transform: (Leaf) -> Result) -> Tree<Result,Result> {
        switch self {
        case .leaf(let value):
            return .leaf(transform(value))
        case .branch(let value, let trees):
            return .branch(transform(value), trees.map { $0.map(transform) })
        }
    }
}
