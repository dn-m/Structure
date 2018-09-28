//
//  DirectedGraphProtocol.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Interface for directed graphs.
public protocol DirectedGraphProtocol: GraphProtocol where Edge == OrderedPair<Node> {

    // MARK: - Instance Methods

    /// - Returns: A set of edges which emanate from the given `source` node.
    func edges(from source: Node) -> Set<Edge>
}
