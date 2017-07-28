//
//  MutableGraph+Edge.swift
//  Collections
//
//  Created by James Bean on 1/16/17.
//
//

extension MutableGraph {

    public class Edge {

        // MARK: - Instance Properties

        /// Source `Node`.
        public let source: Node

        /// Source `Destination`.
        public let destination: Node

        /// Weight of the `Edge`.
        public let weight: Float?

        // MARK: - Initializers

        /**
         Create an `Edge`.
         */
        public init(from source: Node, to destination: Node, weight: Float? = nil) {
            self.source = source
            self.destination = destination
            self.weight = weight
        }
    }
}
