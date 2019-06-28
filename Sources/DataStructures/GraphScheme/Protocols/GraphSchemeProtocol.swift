//
//  GraphSchemeProtocol.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 6/27/19.
//

public protocol GraphSchemeProtocol {
    associatedtype Node
    associatedtype Edge: SymmetricPair where Edge.A == Node
}

extension GraphProtocol {
    func adjacencyScheme <G> () -> G where
        G: UnweightedGraphSchemeProtocol,
        G.Edge == Edge,
        G.Node == Node
    {
        return G(self.contains)
    }
}
