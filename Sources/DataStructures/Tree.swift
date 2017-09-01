//
//  ImmutableTree.swift
//  Collections
//
//  Created by James Bean on 12/9/16.
//
//

import Restructure
import Algebra
import SumType

/// Value-semantic, immutable Tree structure.
public enum Tree <Branch,Leaf> {

    /// Things that can go wrong when doing things to a `Tree`.
    public enum Error: Swift.Error {
        case indexOutOfBounds
        case branchOperationPerformedOnLeaf
        case illFormedIndexPath
    }

    /// Transforms for `branch` and `leaf` cases.
    public struct Transform <B,L> {

        let branch: (Branch) -> B
        let leaf: (Leaf) -> L

        public init(branch: @escaping (Branch) -> B, leaf: @escaping (Leaf) -> L) {
            self.branch = branch
            self.leaf = leaf
        }
    }

    /// Navigate an immutable n-ary `Tree` structure.
    //
    // FIXME: Move to own file when SR-631 is resolved.
    public struct Zipper {

        // MARK: - Associated Types

        /// Value of a `Tree` with its neighboring `Tree` values.
        //
        // FIXME: Move to own file when SR-631 is resolved.
        public struct Crumb {

            /// Associated value of the currently in-focus `tree`.
            public let value: Either<Branch,Leaf>

            /// The other trees to the left and right of the tree currently in focus.
            public let trees: ([Tree], [Tree])
        }

        /// Collection of `Crumb` values.
        public typealias Breadcrumbs = Stack<Crumb>

        // MARK: - Instance Properties

        /// The `Tree` wrapped by the `Zipper`.
        public let tree: Tree

        /// The stack of `Crumb` values that hold a history of the remaining parts of the tree
        /// that are not currently in focus.
        public let breadcrumbs: Breadcrumbs

        /// Move the `Zipper` up in the tree.
        public var up: Zipper? {
            guard let (latest, remaining) = breadcrumbs.destructured else { return nil }
            guard case let .left(branch) = latest.value else { fatalError() }
            let (left, right) = latest.trees
            return Zipper(.branch(branch, left + tree + right), remaining)
        }

        /// `Zipper` wrapping the `root` of the `Tree`.
        public var top: Zipper {
            return up?.top ?? self
        }

        /// - returns: `Zipper` values for each subtree contained by the wrapped `Tree`, if it is
        /// a `branch`.
        public var children: [Zipper] {
            guard case let .branch(_, trees) = tree else { return [] }
            return try! trees.indices.map(move)
        }

        /// - returns: `Zipper` values for each sibling subtree of the wrapped `Tree`.
        public var siblings: [Zipper] {
            return up?.children ?? []
        }

        // MARK: - Initializers

        /// Create a `Zipper` with a `Tree` and a history of remaining parts of the tree that
        /// are not currently in focus.
        public init(_ tree: Tree, _ breadcrumbs: Breadcrumbs = Breadcrumbs()) {
            self.tree = tree
            self.breadcrumbs = breadcrumbs
        }

        // MARK: - Instance Methods

        /// Move focus to the sub-tree with the given `index`.
        ///
        /// - throws: `TreeError` if index is out of bounds.
        public func move(to index: Int) throws -> Zipper {

            switch tree {

            // Should never be called on a `leaf`
            case .leaf:
                throw Tree.Error.branchOperationPerformedOnLeaf

            case .branch(let value, let trees):

                guard let (left, subTree, right) = trees.splitAndExtractElement(at: index) else {
                    throw Tree.Error.illFormedIndexPath
                }

                let crumb = Crumb(value: .left(value), trees: (left, right))
                return Zipper(subTree, breadcrumbs.pushing(crumb))
            }
        }

        /// Move focus to the sub-tree through the given `path`.
        ///
        /// - throws: `TreeError` if the given `path` is no good.
        public func move(through path: [Int]) throws -> Zipper {
            guard let (index, remaining) = path.destructured else { return self }
            return try move(to: index).move(through: Array(remaining))
        }

        /// Transform the value of the wrapped `Tree`.
        public func update(_ transform: Transform<Branch,Leaf>) -> Zipper {
            switch tree {
            case .leaf(let value):
                return Zipper(.leaf(transform.leaf(value)), breadcrumbs)
            case .branch(let value, let trees):
                return Zipper(.branch(transform.branch(value), trees), breadcrumbs)
            }
        }

        /// Transform the leaf value of the wrapped `Tree` with the given `value`.
        public func updateLeaf(_ transform: (Leaf) -> Leaf) -> Zipper {
            guard case let .leaf(leaf) = tree else { fatalError() }
            return Zipper(.leaf(transform(leaf)), breadcrumbs)
        }

        /// Update the leaf value of the wrapped `Tree` with the given `value`.
        public func updateLeaf(_ value: Leaf) -> Zipper {
            return updateLeaf { _ in value }
        }

        /// Transform the branch value of the wrapped `Tree` with the given `value`.
        public func updateBranch(_ transform: (Branch) -> Branch) -> Zipper {
            guard case let .branch(value, trees) = tree else { fatalError() }
            return Zipper(.branch(transform(value), trees), breadcrumbs)
        }

        /// Replace the branch value of the wrapped `Tree` with the given `value`.
        public func updateBranch(_ value: Branch) -> Zipper {
            return updateBranch { _ in value }
        }

        /// Replace the value of the wrapped `Tree` with the given `value`.
        public func update(value: Either<Branch,Leaf>) -> Zipper {
            let transform = Transform(
                branch: { _ -> Branch in
                    guard case let .left(branch) = value else { fatalError() }
                    return branch
                },
                leaf: { _ -> Leaf in
                    guard case let .right(leaf) = value else { fatalError() }
                    return leaf
                }
            )
            return update(transform)
        }
    }

    // MARK: - Cases

    /// Leaf.
    case leaf(Leaf)

    /// Branch.
    indirect case branch(Branch, [Tree])

    // MARK: - Instance Properties

    /// Leaves of this `Tree`.
    public var leaves: [Leaf] {

        func flattened(accum: [Leaf], tree: Tree) -> [Leaf] {

            switch tree {
            case .branch(_, let trees):
                return trees.reduce(accum, flattened)
            case .leaf(let value):
                return accum + [value]
            }
        }

        return flattened(accum: [], tree: self)
    }

    /// All of the values along the paths from this node to each leaf
    public var paths: [[Either<Branch,Leaf>]] {

        func traverse(_ tree: Tree, accum: [[Either<Branch,Leaf>]])
            -> [[Either<Branch,Leaf>]]
        {

            var accum = accum
            let path = accum.popLast() ?? []

            switch tree {
            case .leaf(let value):
                return accum + (path + .right(value))

            case .branch(let value, let trees):
                return trees.flatMap { traverse($0, accum: accum + (path + .left(value))) }
            }
        }

        return traverse(self, accum: [])
    }

    /// Height of a `Tree`.
    public var height: Int {

        func traverse(_ tree: Tree, height: Int) -> Int {
            switch tree {
            case .leaf:
                return height
            case .branch(_, let trees):
                return trees.map { traverse($0, height: height + 1) }.max()!
            }
        }

        return traverse(self, height: 0)
    }

    // MARK: - Initializers

    /// Replace the subtree at the given `index` for the given `tree`.
    ///
    /// - throws: `TreeError` if `self` is a `leaf`.
    public func replacingTree(at index: Int, with tree: Tree) throws -> Tree {
        switch self {
        case .leaf:
            throw Error.branchOperationPerformedOnLeaf
        case .branch(let value, let trees):
            return .branch(value, trees.replacingElement(at: index, with: tree))
        }
    }

    /// Replace the subtree at the given `path`.
    ///
    /// - throws: `TreeError` if the given `path` is valid.
    public func replacingTree(through path: [Int], with tree: Tree) throws -> Tree {

        func traverse(_ tree: Tree, inserting newTree: Tree, path: [Int]) throws -> Tree {

            switch tree {

            // This should never be called on a leaf
            case .leaf:
                throw Error.branchOperationPerformedOnLeaf

            // Either `traverse` futher, or replace at last index specified in `path`.
            case .branch(let value, let trees):

                // Ensure that the `indexPath` given is valid
                guard
                    let (index, remainingPath) = path.destructured,
                    let subTree = trees[safe: index]
                else {
                    throw Error.illFormedIndexPath
                }

                // We are done if only one `index` remaining in `indexPath`
                guard path.count > 1 else {
                    return .branch(value, trees.replacingElement(at: index, with: newTree))
                }

                // Otherwise, keep recursing down
                return try tree.replacingTree(
                    at: index,
                    with: try traverse(subTree, inserting: newTree, path: Array(remainingPath))
                )
            }
        }

        return try traverse(self, inserting: tree, path: path)
    }

    /// - returns: A new `Tree` with the given `tree` inserted at the given `index`, through
    /// the given `path`.
    ///
    /// - throws: `TreeError` in the case of ill-formed index paths and indexes out-of-range.
    public func inserting(_ tree: Tree, through path: [Int] = [], at index: Int) throws -> Tree {

        func traverse(_ tree: Tree, inserting newTree: Tree, through path: [Int], at index: Int)
            throws -> Tree
        {

            switch tree {

            // We should never get to a `leaf`.
            case .leaf:
                throw Error.branchOperationPerformedOnLeaf

            // Either `traverse` further, or insert to accumulated path
            case .branch(let value, let trees):

                // If we have exhausted our path, attempt to insert `newTree` at `index`
                guard let (head, tail) = path.destructured else {
                    return Tree.branch(value, try insert(newTree, into: trees, at: index))
                }

                guard let subTree = trees[safe: head] else {
                    throw Error.illFormedIndexPath
                }

                let newBranch = try traverse(subTree,
                    inserting: newTree,
                    through: Array(tail),
                    at: index
                )

                return try tree.replacingTree(at: index, with: newBranch)
            }
        }

        return try traverse(self, inserting: tree, through: path, at: index)
    }

    public func mapLeaves <T> (_ transform: @escaping (Leaf) -> T) -> Tree<Branch,T> {
        switch self {
        case .leaf(let value):
            return .leaf(transform(value))
        case let .branch(value, trees):
            return .branch(value, trees.map { $0.mapLeaves(transform) })
        }
    }

    public func zipLeaves <C: RangeReplaceableCollection> (_ collection: C)
        -> Tree<Branch, C.Element>
    {
        return zipLeaves(collection) { _, value in value }
    }

    // FIXME: Instead of copying `collection`, increment an `index`, pointing to `collection`.
    public func zipLeaves <C: RangeReplaceableCollection, T> (
        _ collection: C,
        _ transform: @escaping (Leaf, C.Element) -> T
    ) -> Tree<Branch,T>
    {
        var newValues = collection

        func traverse(_ tree: Tree) -> Tree<Branch,T> {

            switch tree {
            case .leaf(let leaf):

                guard let value = newValues.first else {
                    fatalError("Incompatible collection for leaves")
                }

                return .leaf(transform(leaf,value))

            case let .branch(branch, trees):

                var newTrees: [Tree<Branch,T>] = []

                for tree in trees {
                    switch tree {
                    case .leaf:
                        newTrees.append(traverse(tree))
                        newValues.removeFirst()
                    case .branch:
                        newTrees.append(traverse(tree))
                    }
                }

                return .branch(branch, newTrees)
            }
        }

        return traverse(self)
    }

    public func map <B,L> (_ transform: Transform<B,L>) -> Tree<B,L> {
        switch self {
        case .leaf(let value):
            return .leaf(transform.leaf(value))
        case .branch(let value, let trees):
            return .branch(transform.branch(value), trees.map { $0.map(transform) })
        }
    }

    private func insert <A> (_ element: A, into elements: [A], at index: Int) throws -> [A] {

        guard let (left, right) = elements.split(at: index) else {
            throw Error.illFormedIndexPath
        }

        return left + [element] + right
    }
}

extension Tree: CustomStringConvertible {

    /// Printed description.
    public var description: String {

        func indents(_ amount: Int) -> String {
            return (0 ..< amount).reduce("") { accum, _ in accum + "    " }
        }

        func traverse(tree: Tree, indentation: Int = 0) -> String {
            switch tree {
            case .leaf(let value):
                return indents(indentation) + "\(value)"
            case .branch(let value, let trees):
                return (
                    indents(indentation) + "\(value)\n" +
                    trees
                        .map { traverse(tree: $0, indentation: indentation + 1) }
                        .joined(separator: "\n")
                )
            }
        }

        return traverse(tree: self)
    }
}

/// - returns: A new `Tree` resulting from applying the given function `f` to each
/// corresponding node in the given trees `a` and `b`.
///
/// - invariant: `a` and `b` are the same shape.
public func zip <T,U,V> (_ a: Tree<T,T>, _ b: Tree<U,U>, _ f: (T, U) -> V) -> Tree<V,V> {
    switch (a,b) {
    case (.leaf(let a), .leaf(let b)):
        return .leaf(f(a,b))
    case (.branch(let a, let aTrees), .branch(let b, let bTrees)):
        return .branch(f(a,b), zip(aTrees,bTrees).map { a,b in zip(a,b,f) })
    default:
        fatalError("Incompatible trees")
    }
}

/// - TODO: Make extension, retroactively conforming to `Equatable` when Swift allows it

/// - returns: `true` if two `Tree` values are equivalent. Otherwise, `false`.
public func == <T: Equatable, U: Equatable> (lhs: Tree<T,U>, rhs: Tree<T,U>) -> Bool {

    switch (lhs, rhs) {
    case (.leaf(let a), .leaf(let b)):
        return a == b
    case (.branch(let valueA, let treesA), .branch(let valueB, let treesB)):
        return valueA == valueB && treesA == treesB
    default:
        return false
    }
}

/// - returns: `true` if two `Tree` values are not equivalent. Otherwise, `false`.
public func != <T: Equatable, U: Equatable> (lhs: Tree<T,U>, rhs: Tree<T,U>) -> Bool {
    return !(lhs == rhs)
}

/// - returns: `true` if two arrays of `Tree` values are equivalent. Otherwise, `false.`
public func == <T: Equatable, U: Equatable> (lhs: [Tree<T,U>], rhs: [Tree<T,U>]) -> Bool {

    guard lhs.count == rhs.count else {
        return false
    }

    for (lhs, rhs) in zip(lhs, rhs) {
        if lhs != rhs {
            return false
        }
    }

    return true
}
