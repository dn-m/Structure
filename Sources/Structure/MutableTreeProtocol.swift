//
//  MutableTreeProtocol.swift
//  Collections
//
//  Created by James Bean on 1/16/17.
//
//

/// Error for when you do bad things to a `MutableTreeProtocol`-conforming type.
public enum MutableTreeError: Error {

    /// Error thrown when trying to insert a Node at an invalid index
    case insertionError

    /// Error thrown when trying to remove a Node from an invalid index
    case removalError

    /// Error thrown when trying to insert a Node at an invalid index
    case nodeNotFound
}


/// Interface for nodes in tree structures.
///
/// Provides default implementations for many tree structure operations.
///
/// > Useable only by `final class` types.
public protocol MutableTreeProtocol: class {

    // MARK: - Instance Properties

    /// Parent node.
    var parent: Self? { get set }

    /// Child nodes.
    var children: [Self] { get set }

    /// - returns: `true` if there are no children. Otherwise, `false`.
    var isLeaf: Bool { get }

    /// - returns: `true` if there is at least one child. Otherwise, `false`.
    var isContainer: Bool { get }

    /// - returns: `true` if there is no parent. Otherwise, `false`.
    var isRoot: Bool { get }

    /// All leaves.
    var leaves: [Self] { get }

    /// Root.
    var root: Self { get }

    /// Array of all Node objects between (and including) `self` up to `root`.
    var pathToRoot: [Self] { get }

    /// Depth of node.
    var depth: Int { get }

    /// Height of node.
    var height: Int { get }

    /// Height of containing tree.
    var heightOfTree: Int { get }

    // MARK: - Instance Methods

    /// Append a child node.
    func addChild(_ node: Self)

    /// Append an array of Child nodes.
    func addChildren(_ nodes: [Self])

    /// Insert the given child node at the given `index`.
    ///
    /// - throws: `MutableTreeError.Error.insertionError` if the given `index` is out of bounds.
    func insertChild(_ node: Self, at index: Int) throws

    /// Remove the given child node.
    ///
    /// - throws: `MutableTreeError.Error.removalError` if the given node is not contained herein.
    func removeChild(_ node: Self) throws

    /// Remove the child node at the given `index`.
    ///
    /// - throws: `MutableTreeError.Error.removalError` if the given `index` is out of bounds.
    func removeChild(at index: Int) throws

    /// - returns: Child node at the given `index`, if present. Otherwise, `nil`.
    func child(at index: Int) -> Self?

    /// - returns: Returns the leaf node at the given `index`, if present. Otherwise, `nil`.
    func leaf(at index: Int) -> Self?

    /// - returns: `true` if the given node is contained herein. Otherwise, `false`.
    func hasChild(_ child: Self) -> Bool

    /// - returns: `true` if the given node is a leaf. Otherwise, `false`.
    func hasLeaf(_ node: Self) -> Bool

    /// - returns: `true` if the given node is an ancestor. Otherwise, `false`.
    func hasAncestor(_ node: Self) -> Bool

    /// - returns: Ancestor at the given distance, if present. Otherwise, `nil`.
    func ancestor(at distance: Int) -> Self?

    /// - returns: `true` if the given node is a descendent. Otherwise, `false`.
    func hasDescendent(_ node: Self) -> Bool
}

public extension MutableTreeProtocol {

    /// Add the given `node` to `children`.
    func addChild(_ node: Self) {
        children.append(node)
        node.parent = self
    }

    /// Append the given `nodes` to `children`.
    func addChildren(_ nodes: [Self]) {
        nodes.forEach(addChild)
    }

    /// Insert the given `node` at the given `index` of `children`.
    ///
    /// - throws: `MutableTreeError.insertionError` if `index` is out of bounds.
    func insertChild(_ node: Self, at index: Int) throws {

        guard index <= children.endIndex else {
            throw MutableTreeError.insertionError
        }

        children.insert(node, at: index)
        node.parent = self
    }

    /// Remove the given `node` from `children`.
    ///
    /// - throws: `MutableTreeError.removalError` if the given `node` is not held in `children`.
    func removeChild(_ node: Self) throws {

        guard let index = children.index(where: { $0 === node }) else {
            throw MutableTreeError.nodeNotFound
        }

        try removeChild(at: index)
    }

    /// Remove the node at the given `index`.
    ///
    /// - throws: `MutableTreeError.removalError` if `index` is out of bounds.
    func removeChild(at index: Int) throws {

        guard children.indices.contains(index) else {
            throw MutableTreeError.nodeNotFound
        }

        children.remove(at: index)
    }

    /// - returns: `true` if the given node is contained herein. Otherwise, `false`.
    func hasChild(_ child: Self) -> Bool {
        return children.any { $0 === child }
    }

    /// - returns: Child node at the given `index`, if present. Otherwise, `nil`.
    func child(at index: Int) -> Self? {

        guard children.indices.contains(index) else {
            return nil
        }

        return children[index]
    }

    /// - returns: `true` if there are no children. Otherwise, `false`.
    var isLeaf: Bool {
        return children.count == 0
    }

    /// - returns: All leaves.
    var leaves: [Self] {

        func descendToGetLeaves(of node: Self, result: inout [Self]) {
            if node.isLeaf { result.append(node) }
            else {
                for child in node.children {
                    descendToGetLeaves(of: child, result: &result)
                }
            }
        }

        var result: [Self] = []
        descendToGetLeaves(of: self, result: &result)
        return result
    }

    /// - returns: Returns the leaf node at the given `index`, if present. Otherwise, `nil`.
    func leaf(at index: Int) -> Self? {
        guard index >= 0 && index < leaves.count else { return nil }
        return leaves[index]
    }

    /// - returns: `true` if the given node is a leaf. Otherwise, `false`.
    func hasLeaf(_ node: Self) -> Bool {
        return leaves.contains { $0 === node }
    }

    /// - returns: `true` if there is at least one child. Otherwise, `false`.
    var isContainer: Bool {
        return children.count > 0
    }

    /// - returns: `true` if there is no parent. Otherwise, `false`.
    var isRoot: Bool {
        return parent == nil
    }

    /// - returns: `true` if there is no parent. Otherwise, `false`.
    var root: Self {

        func ascendToGetRoot(of node: Self) -> Self {

            guard let parent = node.parent else {
                return node
            }

            return ascendToGetRoot(of: parent)
        }

        return ascendToGetRoot(of: self)
    }

    /// Array of all Node objects between (and including) `self` up to `root`.
    var pathToRoot: [Self] {

        func ascendToGetPathToRoot(of node: Self, result: [Self]) -> [Self] {
            guard let parent = node.parent else { return result + node }
            return ascendToGetPathToRoot(of: parent, result: result + node)
        }

        return ascendToGetPathToRoot(of: self, result: [])
    }

    /// - returns: `true` if the given node is an ancestor. Otherwise, `false`.
    func hasAncestor(_ node: Self) -> Bool {
        return self === node ? false : pathToRoot.any { $0 === node }
    }

    /// - returns: Ancestor at the given distance, if present. Otherwise, `nil`.
    func ancestor(at distance: Int) -> Self? {

        guard distance < pathToRoot.count else {
            return nil
        }

        return pathToRoot[distance]
    }

    /// - returns: `true` if the given node is a descendent. Otherwise, `false`.
    func hasDescendent(_ node: Self) -> Bool {

        if isLeaf {
            return false
        }

        if hasChild(node) {
            return true
        }

        return children
            .map { $0.hasChild(node) }
            .filter { $0 == true }
            .count > 0
    }

    /// Height of node.
    var height: Int {

        func descendToGetHeight(of node: Self, result: Int) -> Int {

            if node.isLeaf {
                return result
            }

            return node.children
                .map { descendToGetHeight(of: $0, result: result + 1) }
                .reduce(0, max)
        }


        return descendToGetHeight(of: self, result: 0)
    }

    /// Height of containing tree.
    var heightOfTree: Int {
        return root.height
    }

    /// Depth of node.
    var depth: Int {

        func ascendToGetDepth(of node: Self, depth: Int) -> Int {

            guard let parent = node.parent else {
                return depth
            }

            return ascendToGetDepth(of: parent, depth: depth + 1)
        }

        return ascendToGetDepth(of: self, depth: 0)
    }
}
