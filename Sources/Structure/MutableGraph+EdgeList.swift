//
//  MutableGraph+EdgeList.swift
//  Collections
//
//  Created by James Bean on 1/16/17.
//
//

extension MutableGraph {

    public class EdgeList {

        var edges: [Edge] = []
        let vertex: Node

        init(vertex: Node) {
            self.vertex = vertex
        }

        func weight(to destination: Node) -> Float? {
            for edge in edges {
                if edge.destination === destination {
                    return edge.weight
                }
            }
            return nil
        }

        func addEdge(to destination: Node, weight: Float? = nil) {
            let edge = Edge(from: vertex, to: destination, weight: weight)
            addEdge(edge)
        }

        func addEdge(_ edge: Edge) {
            edges.append(edge)
        }
    }
}
