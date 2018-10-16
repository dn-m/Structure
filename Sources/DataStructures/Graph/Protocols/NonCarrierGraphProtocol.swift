//
//  NonCarrierGraphProtocol.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

public protocol NonCarrierGraphProtocol: GraphProtocol {
    
    var nodes: Set<Node> { get set }
    
}

extension NonCarrierGraphProtocol {
    
    /// Inserts the given `node` without making any connections to other nodes contained herein.
    @inlinable
    public mutating func insert(_ node: Node) {
        nodes.insert(node)
    }
}
