//
//  WeightedGraphProtocol.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Interface for weighted graphs.
public protocol WeightedGraphProtocol: GraphProtocol {

    // MARK: - Associated Type

    /// The type of the weight of an `Edge`.
    associatedtype Weight: Numeric

    // MARK: - Instance Properties

    /// The storage of weights by the applicable edge.
    var weights: [Edge: Weight] { get set }
}

extension WeightedGraphProtocol {

    // MARK: - Transforming into unweighted graphs

    /// - Returns: An unweighted version of this `WeightedGraphProtocol`-conforming type value.
    @inlinable
    public func unweighted <U> () -> U where U: UnweightedGraphProtocol, U.Edge == Edge {
        return .init(nodes, Set(weights.keys.lazy))
    }
}

extension WeightedGraphProtocol {

    // MARK: - Querying

    /// - Returns: All of the edges contained herein.
    @inlinable
    public var edges: Set<Edge> {
        return Set(weights.keys.lazy)
    }

    /// - Returns: The weight for the edge connecting the given `source` and `destination` nodes,
    /// if the given `edge` is contained herein. Otherwise, `nil`.
    @inlinable
    public func weight(from source: Node, to destination: Node) -> Weight? {
        return weight(Edge(source,destination))
    }

    /// - Returns: The weight for the given `edge`, if the given `edge` is contained herein.
    /// Otherwise, `nil`.
    @inlinable
    public func weight(_ edge: Edge) -> Weight? {
        return weights[edge]
    }
}

extension WeightedGraphProtocol {

    // MARK: - Modifying

    /// Inserts an edge between the given `source` and `destination` nodes, with the given `weight`.
    ///
    /// If the `source` or `destination` nodes are not yet contained herein, they are inserted.
    @inlinable
    public mutating func insertEdge(from source: Node, to destination: Node, weight: Weight) {
        nodes.insert(source)
        nodes.insert(destination)
        weights[Edge(source,destination)] = weight
    }

    /// Removes the edge between the given `source` and `destination` nodes.
    @inlinable
    public mutating func removeEdge(from source: Node, to destination: Node) {
        removeEdge(Edge(source, destination))
    }

    @inlinable
    public mutating func removeEdge(_ edge: Edge) {
        weights[edge] = nil
    }

    /// Inserts the given `edge` with the given `weight`.
    @inlinable
    public mutating func insertEdge(_ edge: Edge, weight: Weight) {
        weights[edge] = weight
    }

    /// Updates the weight of the edge between the given `source` and `destination` nodes by the
    /// given `transform`.
    @inlinable
    public mutating func updateEdge(
        from source: Node,
        to destination: Node,
        by transform: (Weight) -> Weight
        )
    {
        updateEdge(Edge(source,destination), by: transform)
    }

    /// Updates the weight of the given `edge` by the given `transform`.
    @inlinable
    public mutating func updateEdge(_ edge: Edge, by transform: (Weight) -> Weight) {
        guard let weight = weight(edge) else { return }
        insertEdge(edge, weight: transform(weight))
    }
}
