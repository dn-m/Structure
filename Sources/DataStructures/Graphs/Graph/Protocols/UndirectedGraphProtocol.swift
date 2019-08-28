//
//  UndirectedGraphProtocol.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Interface for undirected graphs.
public protocol UndirectedGraphProtocol: GraphProtocol where Edge == UnorderedPair<Node> { }
