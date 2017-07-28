//
//  MutableTree.swift
//  Collections
//
//  Created by James Bean on 1/16/17.
//
//

/// Mutable Tree structure.
public class MutableTree {

    /**
     Error thrown when doing bad things to a `MutableTree` objects.
     */
    public enum Error: Swift.Error {

        /// Error thrown when trying to insert a MutableTree at an invalid index
        case insertionError

        /// Error thrown when trying to remove a MutableTree from an invalid index
        case removalError

        /// Error thrown when trying to insert a MutableTree at an invalid index
        case nodeNotFound
    }

    // MARK: - Instance Properties

    /// Parent `MutableTree`. The root of a tree has no parent.
    public weak var parent: MutableTree?

    /// Children `MutableTree` objects.
    public var children: [MutableTree]

    /// - returns: `true` if there are no children. Otherwise, `false`.
    public var isLeaf: Bool { return children.count == 0 }

    /// All leaves.
    public var leaves: [MutableTree] {

        func descendToGetLeaves(of node: MutableTree, result: inout [MutableTree]) {

            if node.isLeaf {
                result.append(node)
            } else {
                for child in node.children {
                    descendToGetLeaves(of: child, result: &result)
                }
            }
        }

        var result: [MutableTree] = []
        descendToGetLeaves(of: self, result: &result)
        return result
    }

    /// - returns: `true` if there is at least one child. Otherwise, `false`.
    public var isContainer: Bool {
        return children.count > 0
    }

    /// - returns: `true` if there is no parent. Otherwise, `false`.
    public var isRoot: Bool {
        return parent == nil
    }

    /// - returns: `true` if there is no parent. Otherwise, `false`.
    public var root: MutableTree {

        func ascendToGetRoot(of node: MutableTree) -> MutableTree {
            guard let parent = node.parent else { return node }
            return ascendToGetRoot(of: parent)
        }

        return ascendToGetRoot(of: self)
    }

    /// Array of all MutableTree objects between (and including) `self` up to `root`.
    public var pathToRoot: [MutableTree] {

        func ascendToGetPathToRoot(of node: MutableTree, result: [MutableTree]) -> [MutableTree] {
            guard let parent = node.parent else { return result + node }
            return ascendToGetPathToRoot(of: parent, result: result + node)
        }

        return ascendToGetPathToRoot(of: self, result: [])
    }

    /// Height of node.
    public var height: Int {

        func descendToGetHeight(of node: MutableTree, result: Int) -> Int {
            if node.isLeaf { return result }
            return node.children
                .map { descendToGetHeight(of: $0, result: result + 1) }
                .reduce(0, max)
        }

        return descendToGetHeight(of: self, result: 0)
    }

    /// Height of containing tree.
    public var heightOfTree: Int { return root.height }

    /// Depth of node.
    public var depth: Int {

        func ascendToGetDepth(of node: MutableTree, depth: Int) -> Int {
            guard let parent = node.parent else { return depth }
            return ascendToGetDepth(of: parent, depth: depth + 1)
        }

        return ascendToGetDepth(of: self, depth: 0)
    }

    // MARK: - Initializers

    /**
     Create a `MutableTree`.
     */
    public init(parent: MutableTree? = nil, children: [MutableTree] = []) {
        self.parent = parent
        self.children = children
    }

    // MARK: - Instance Methods

    /**
     Add the given `node` to `children`.
     */
    public func addChild(_ node: MutableTree) {
        children.append(node)
        node.parent = self
    }

    /**
     Append the given `nodes` to `children`.
     */
    public func addChildren(_ nodes: [MutableTree]) {
        nodes.forEach(addChild)
    }

    /**
     Insert the given `node` at the given `index` of `children`.

     - throws: `Error.insertionError` if `index` is out of bounds.
     */
    public func insertChild(_ node: MutableTree, at index: Int) throws {
        if index > children.count { throw Error.insertionError }
        children.insert(node, at: index)
        node.parent = self
    }

    /**
     Remove the given `node` from `children`.

     - throws: `Error.removalError` if the given `node` is not held in `children`.
     */
    public func removeChild(_ node: MutableTree) throws {

        guard let index = children.index(where: { $0 === node }) else {
            throw Error.nodeNotFound
        }

        try removeChild(at: index)
    }

    /**
     Remove the node at the given `index`.

     - throws: `Error.removalError` if `index` is out of bounds.
     */
    public func removeChild(at index: Int) throws {

        if index >= children.count {
            throw Error.nodeNotFound
        }

        children.remove(at: index)
    }

    /**
     - returns: `true` if the given node is contained herein. Otherwise, `false`.
     */
    public func hasChild(_ child: MutableTree) -> Bool {
        return children.any { $0 === child }
    }

    /**
     - returns: Child node at the given `index`, if present. Otherwise, `nil`.
     */
    public func child(at index: Int) -> MutableTree? {
        guard children.indices.contains(index) else { return nil }
        return children[index]
    }

    /**
     - returns: Returns the leaf node at the given `index`, if present. Otherwise, `nil`.
     */
    public func leaf(at index: Int) -> MutableTree? {
        guard index >= 0 && index < leaves.count else { return nil }
        return leaves[index]
    }

    /**
     - returns: `true` if the given node is a leaf. Otherwise, `false`.
     */
    public func hasLeaf(_ node: MutableTree) -> Bool {
        return leaves.contains { $0 === node }
    }

    /**
     - returns: `true` if the given node is an ancestor. Otherwise, `false`.
     */
    public func hasAncestor(_ node: MutableTree) -> Bool {
        return self === node ? false : pathToRoot.any { $0 === node }
    }

    /**
     - returns: Ancestor at the given distance, if present. Otherwise, `nil`.
     */
    public func ancestor(at distance: Int) -> MutableTree? {
        guard distance < pathToRoot.count else { return nil }
        return pathToRoot[distance]
    }

    /**
     - returns: `true` if the given node is a descendent. Otherwise, `false`.
     */
    public func hasDescendent(_ node: MutableTree) -> Bool {
        if isLeaf { return false }
        if hasChild(node) { return true }
        return children
            .map { $0.hasChild(node) }
            .filter { $0 == true }
            .count > 0
    }
}
