//
//  DirectedGraphProtocol.swift
//  DataStructures
//
//  Created by James Bean on 9/27/18.
//

/// Interface for directed graphs.
public protocol DirectedGraphProtocol: GraphProtocol where Edge == OrderedPair<Node> { }
