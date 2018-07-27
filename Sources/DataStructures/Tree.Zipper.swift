//
//  Tree.Zipper.swift
//  DataStructures
//
//  Created by James Bean on 7/26/18.
//

extension Tree {

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

                let crumb = Crumb(value: .left(value), trees: (Array(left), Array(right)))
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
}
