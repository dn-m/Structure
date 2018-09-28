//
//  GraphProtocol.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Interface for graph-like tyes.
public protocol GraphProtocol {

    // MARK: - Associated Types

    /// The type of nodes contained herein.
    associatedtype Node: Hashable

    /// The type of edges contained herein.
    associatedtype Edge: SymmetricPair & Hashable where Edge.A == Node

    // MARK: - Instance Properties

    /// All of the nodes contained herein.
    var nodes: Set<Node> { get set }

    /// All of the edges contained herein.
    var edges: Set<Edge> { get }

    // MARK: - Initializers

    /// Creates a `GraphProtocol`-conforming type value with the given set of `nodes`.
    init(_ nodes: Set<Node>)

    // MARK: - Instance Methods

    /// Removes the edge from the given `source` to the given `destination`.
    mutating func removeEdge(from source: Node, to destination: Node)

    /// - Returns: A set of edges containing the given `node`.
    func edges(containing node: Node) -> Set<Edge>
}

extension GraphProtocol {

    /// Inserts the given `node` without making any connections to other nodes contained herein.
    @inlinable
    public mutating func insert(_ node: Node) {
        nodes.insert(node)
    }

    /// - Returns: `true` if the `GraphProtocol`-conforming type value contains the given `node`.
    /// Otherwise, `false`.
    @inlinable
    public func contains(_ node: Node) -> Bool {
        return nodes.contains(node)
    }

    /// - Returns: A set of nodes connected to the given `source`, in the given set of
    /// `nodes`.
    ///
    /// If `nodes` is empty, then any nodes contained herein are able to be included in the
    /// resultant set.
    @inlinable
    public func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
        return (nodes ?? self.nodes).filter { edges.contains(Edge(source,$0)) }
    }
    
    /// - Returns: A set of edges that contain the given `node` (either incident or
    /// outgoing).
    @inlinable
    public func edges(containing node: Node) -> Set<Edge> {
        return edges(from: node).union(edges(to: node))
    }
    
    /// - Returns: A set of edges outgoing from the given `source`.
    @inlinable
    public func edges(from source: Node) -> Set<Edge> {
        return Set(neighbors(of: source).map { Edge(source, $0) })
    }
    
    /// - Returns: A set of edges incident to the given `destination`.
    @inlinable
    public func edges(to destination: Node) -> Set<Edge> {
        return Set(nodes.lazy.map { Edge($0, destination) }.filter(edges.contains))
    }

    /// - Returns: An array of `Node` values in breadth first order.
    @inlinable
    public func breadthFirstSearch(from source: Node, to destination: Node? = nil) -> [Node] {
        var visited: [Node] = []
        var queue = Queue<Node>()
        queue.enqueue(source)
        visited.append(source)
        while !queue.isEmpty {
            let node = queue.dequeue()
            for neighbor in neighbors(of: node) where !visited.contains(neighbor) {
                queue.enqueue(neighbor)
                visited.append(neighbor)
                if neighbor == destination { return visited }
            }
        }
        return visited
    }

    /// - Returns: An array of `Node` values from the given `source` to the given `destination`.
    ///
    /// In the case that there are more than one paths from the given `source` to the given
    /// `destination`, the path with the fewest edges is returned.
    @inlinable
    public func shortestUnweightedPath(from source: Node, to destination: Node) -> [Node]? {
        var breadcrumbs: [Node: Node] = [:]
        func backtrace() -> [Node] {
            var path = [destination]
            var cursor = destination
            while cursor != source {
                path.insert(breadcrumbs[cursor]!, at: 0)
                cursor = breadcrumbs[cursor]!
            }
            return path
        }
        if source == destination { return .init([source]) }
        var unvisited = nodes
        var queue = Queue<Node>()
        queue.enqueue(source)
        while !queue.isEmpty {
            let node = queue.dequeue()
            for neighbor in neighbors(of: node, in: unvisited) {
                queue.enqueue(neighbor)
                unvisited.remove(neighbor)
                breadcrumbs[neighbor] = node
                if neighbor == destination { return backtrace() }
            }
        }
        return nil
    }
}
