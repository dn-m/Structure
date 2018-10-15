//
//  CarrierGraphProtocol.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 15/10/2018.
//

public protocol CarrierGraphProtocol: GraphProtocol {
    
    associatedtype Data
    
    var data: [Node: Data] { get set }
    
}

extension CarrierGraphProtocol {
    
    @inlinable
    public var nodes: Set<Node> {
        return Set(data.keys.lazy)
    }
    
    /// Inserts the given `node` with the given data `value`.
    @inlinable
    public mutating func insert(_ node: Node, value: Data) {
        data[node] = value
    }
}
