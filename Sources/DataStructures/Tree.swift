//
//  ImmutableTree.swift
//  Collections
//
//  Created by James Bean on 12/9/16.
//
//

import Algebra
import Algorithms

/// A value-semantic, immutable Tree structure with two generic types for the branches and leaves.
///
/// **Example Usage**
///
/// A `Tree` can be used in pretty simple cases:
///
///     let justALeaf: Tree<(),Double> = .leaf(3.14159265359)
///
/// Or more nested cases:
///
///     let happyTree = Tree.branch("alpha", [
///         .leaf(1),
///         .branch("beta", [
///             .leaf(2),
///             .leaf(3),
///             .leaf(4)
///         ]),
///         .leaf(5),
///         .branch("gamma", [
///             .leaf(6),
///             .branch("delta", [
///                 .leaf(7),
///                 .leaf(8)
///             ])
///         ])
///     ])
///
public enum Tree <Branch,Leaf> {

    // MARK: - Cases

    /// The leaf case.
    case leaf(Leaf)

    /// The branch case, containing the value for this node, as well as all of its children nodes.
    indirect case branch(Branch, [Tree])
}

extension Tree {

    // MARK: - Instance Properties

    /// - Returns: The values contained by the leaves of this `Tree`.
    ///
    ///     let tree = Tree.branch("root", [
    ///         .leaf(0),
    ///         .branch("internal", [
    ///             .leaf(1)
    ///         ]),
    ///         .leaf(2)
    ///     ])
    ///     tree.leaves // => [0,1,2]
    ///
    @inlinable
    public var leaves: [Leaf] {
        func flatten(accum: inout [Leaf], tree: Tree) {
            switch tree {
            case .branch(_, let trees):
                accum = trees.reduce(into: accum, flatten)
            case .leaf(let value):
                accum.append(value)
            }
        }
        var result: [Leaf] = []
        flatten(accum: &result, tree: self)
        return result
    }

    /// - Returns: The number of edges on the longest path between the root and a leaf.
    ///
    ///     let tree = Tree.branch(0, [
    ///         .leaf(1),
    ///         .branch(2, [
    ///             .leaf(1),
    ///             .leaf(2)
    ///         ]),
    ///         .leaf(3)
    ///     ])
    ///     tree.height // => 2
    ///
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

    /// - Returns: All of the values along the paths from this node to each leaf.
    public var paths: [[Either<Branch,Leaf>]] {
        func traverse(_ tree: Tree, accum: [[Either<Branch,Leaf>]]) -> [[Either<Branch,Leaf>]] {
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
}

extension Tree {

    // MARK: - Instance Methods

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

        func traverse(_ tree: Tree, inserting newTree: Tree, through path: [Int], at index: Int) throws -> Tree
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

    /// - Returns: A `Tree` with leaves updated by the given `transform`.
    public func mapLeaves <T> (_ transform: @escaping (Leaf) -> T) -> Tree<Branch,T> {
        switch self {
        case .leaf(let value):
            return .leaf(transform(value))
        case let .branch(value, trees):
            return .branch(value, trees.map { $0.mapLeaves(transform) })
        }
    }

    /// - Returns: A `Tree` with its leaves replaced by the elements in the given `collection`.
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

    /// - Returns: A `Tree` with its branches and leaves modified by the given `transform`.
    public func map <B,L> (_ transform: Transform<B,L>) -> Tree<B,L> {
        switch self {
        case .leaf(let value):
            return .leaf(transform.leaf(value))
        case .branch(let value, let trees):
            return .branch(transform.branch(value), trees.map { $0.map(transform) })
        }
    }

    private func insert <A> (_ element: A, into elements: [A], at index: Int) throws -> [A] {
        guard let (left, right) = elements.split(at: index) else { throw Error.illFormedIndexPath }
        return left + [element] + right
    }
}

extension Tree {

    // MARK: - Errors

    /// Things that can go wrong when doing things to a `Tree`.
    public enum Error: Swift.Error {
        case indexOutOfBounds
        case branchOperationPerformedOnLeaf
        case illFormedIndexPath
    }

    // MARK: - Assosciated Types

    /// Transforms for `branch` and `leaf` cases.
    public struct Transform <B,L> {

        let branch: (Branch) -> B
        let leaf: (Leaf) -> L

        public init(branch: @escaping (Branch) -> B, leaf: @escaping (Leaf) -> L) {
            self.branch = branch
            self.leaf = leaf
        }
    }
}

extension Tree: CustomStringConvertible {

    // MARK: - CustomStringConvertible

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

/// - Returns: A new `Tree` resulting from applying the given function `f` to each
/// corresponding node in the given trees `a` and `b`.
///
/// - Invariant: `a` and `b` are the same shape.
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

extension Tree: Equatable where Leaf: Equatable, Branch: Equatable { }
extension Tree: Hashable where Leaf: Hashable, Branch: Hashable { }
