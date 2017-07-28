////
////  Zipper.swift
////  Collections
////
////  Created by James Bean on 2/5/17.
////
////
//
///// - TODO: Nest `Crumb` inside `Zipper` inside `Tree`.
//
///// Value of a `Tree` with its neighboring `Tree` values.
//public struct Crumb <Leaf,Branch> {
//
//    /// Associated value of the currently in-focus `tree`.
//    public let value: Either<Branch,Leaf>
//
//    /// The other trees to the left and right of the tree currently in focus.
//    public let trees: ([Tree<Leaf,Branch>], [Tree<Leaf,Branch>])
//}
//
///// Navigate an immutable n-ary `Tree` structure.
//public struct Zipper <Leaf,Branch> {
//
//    // MARK: - Associated Types
//
//    /// Collection of `Crumb` values.
//    public typealias Breadcrumbs = Stack<Crumb<Leaf,Branch>>
//
//    // MARK: - Instance Properties
//
//    /// The `Tree` wrapped by the `Zipper`.
//    public let tree: Tree<Leaf,Branch>
//
//    /// The stack of `Crumb` values that hold a history of the remaining parts of the tree
//    /// that are not currently in focus.
//    public let breadcrumbs: Breadcrumbs
//
//    /// Move the `Zipper` up in the tree.
//    public var up: Zipper<Leaf,Branch>? {
//
//        // If we are already at the top, our work is done.
//        guard let (latest, remaining) = breadcrumbs.destructured else {
//            return nil
//        }
//
//        let (left, right) = latest.trees
//        let trees = left + tree + right
//
//        return Zipper(.branch(latest.value, trees), remaining)
//    }
//
//    /// `Zipper` wrapping the `root` of the `Tree`.
//    public var top: Zipper<Leaf,Branch> {
//        return up?.top ?? self
//    }
//
//    /// - returns: `Zipper` values for each subtree contained by the wrapped `Tree`, if it is
//    /// a `branch`.
//    public var children: [Zipper<Leaf,Branch>] {
//
//        guard case let .branch(_, trees) = tree else {
//            return []
//        }
//
//        return try! trees.indices.map(move)
//    }
//
//    /// - returns: `Zipper` values for each sibling subtree of the wrapped `Tree`.
//    public var siblings: [Zipper<Leaf,Branch>] {
//        return up?.children ?? []
//    }
//
//    // MARK: - Initializers
//
//    /// Create a `Zipper` with a `Tree` and a history of remaining parts of the tree that
//    /// are not currently in focus.
//    public init(_ tree: Tree<Leaf,Branch>, _ breadcrumbs: Breadcrumbs = Breadcrumbs()) {
//        self.tree = tree
//        self.breadcrumbs = breadcrumbs
//    }
//
//    // MARK: - Instance Methods
//
//    /// Move focus to the sub-tree with the given `index`.
//    ///
//    /// - throws: `TreeError` if index is out of bounds.
//    public func move(to index: Int) throws -> Zipper<Leaf,Branch> {
//
//        switch tree {
//
//        // Should never be called on a `leaf`
//        case .leaf:
//            throw TreeError.branchOperationPerformedOnLeaf
//
//        case .branch(let value, let trees):
//
//            guard let (left, subTree, right) = trees.splitAndExtractElement(at: index) else {
//                throw TreeError.illFormedIndexPath
//            }
//
//            let crumb = Crumb(value: value, trees: (left, right))
//            return Zipper(subTree, breadcrumbs.pushing(crumb))
//        }
//    }
//
//    /// Move focus to the sub-tree through the given `path`.
//    ///
//    /// - throws: `TreeError` if the given `path` is no good.
//    public func move(through path: [Int]) throws -> Zipper<Leaf,Branch> {
//
//        // If `path` is empty, our work is done
//        guard let (index, remaining) = path.destructured else {
//            return self
//        }
//
//        return try move(to: index).move(through: remaining)
//    }
//
//    /// Transform the value of the wrapped `Tree`.
//    public func update(_ f: (T) -> T) -> Zipper<T> {
//
//        switch tree {
//        case .leaf(let value):
//            return Zipper(.leaf(f(value)), breadcrumbs)
//        case .branch(let value, let trees):
//            return Zipper(.branch(f(value), trees), breadcrumbs)
//        }
//    }
//
//    /// Replace the value of the wrapped `Tree` with the given `value`.
//    public func update(value: T) -> Zipper<T> {
//        return update { _ in value }
//    }
//}
