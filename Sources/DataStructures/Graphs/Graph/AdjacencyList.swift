//
//  AdjacencyList.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 5/23/19.
//

// Adjacency list representation of a graph
public struct AdjacencyList<Node: Hashable> {
    
    // MARK: - Instance Properties
    
    // Stores the set of nodes adjacent to each node
    public let adjacencies: [Node: Set<Node>]
        
    // MARK: - Initializers

    public init(_ adjacencies: [Node: Set<Node>]) {
        self.adjacencies = adjacencies
    }
    
    // Safe initializer that ensures there are no hanging nodes inside of a "value" `Set` that are not within
    // the "keys" of `adjancencies`.
    public init(safe adjacencies: [Node: Set<Node>]) {
        self.adjacencies = adjacencies.reduce(into: [Node: Set<Node>]()) { completed, pair in
            let (node, neighbors) = pair
            completed[node] = neighbors
            neighbors.forEach { neighbor in
                if !completed.keys.contains(neighbor) { completed[neighbor] = [] }
            }
        }
    }
}

extension AdjacencyList {
    
    // MARK: - Instance Methods
    
    // Tarjan's algorithm to find strongly connected components
    func getStronglyConnectedComponent ()
        -> (Node) -> Set<Node> {
            
            func reducer(
                _ map: inout [Node: Set<Node>],
                _ pair: (key: Node, value: Set<Node>)
                ) -> () {
                
                func strongConnect (
                    _ map: inout [Node: Set<Node>],
                    _ indexAt: inout [Node: Int],
                    _ lowLinkAt: inout [Node: Int],
                    _ counter: inout Int,
                    _ stack: inout Stack<Node>,
                    _ stackSet: inout Set<Node>,
                    _ pair: (key: Node, value: Set<Node>)
                    ) -> () {
                    let (cursor, neighbors) = pair
                    indexAt[cursor] = counter
                    lowLinkAt[cursor] = counter
                    counter += 1
                    stack.push(cursor)
                    stackSet.insert(cursor)
                    
                    neighbors.forEach { neighbor in
                        if !indexAt.keys.contains(neighbor) {
                            strongConnect(&map,&indexAt, &lowLinkAt, &counter, &stack, &stackSet,
                                          (key: neighbor, value: adjacencies[neighbor]!))
                            lowLinkAt[cursor] = min(lowLinkAt[cursor]!, lowLinkAt[neighbor]!)
                        } else if stackSet.contains(neighbor) {
                            lowLinkAt[cursor] = min(lowLinkAt[cursor]!, indexAt[neighbor]!)
                        }
                    }
                    
                    if indexAt[cursor]! == lowLinkAt[cursor]! {
                        var tempSet: Set<Node> = []
                        while stack.top! != cursor {
                            let next = stack.pop()!
                            tempSet.insert(next)
                            stackSet.remove(next)
                        }
                        tempSet.insert(stack.pop()!)
                        stackSet.remove(cursor)
                        tempSet.forEach { node in map[node] = tempSet }
                    }
                }
                
                var indexAt: [Node: Int] = [:]
                var lowLinkAt: [Node: Int] = [:]
                var counter: Int = 0
                var stack: Stack<Node> = []
                var stackSet: Set<Node> = []
                
                let _ = strongConnect(&map, &indexAt, &lowLinkAt, &counter, &stack, &stackSet, pair)
            }
            
            let map = adjacencies.reduce(into: [:], reducer)
            return { map[$0]! }
    }
    
    // Group nodes according to the set-forming function `nodeClumper` and return the resulting
    // `AdjacencyList`, removing self-loops that arise.
    func clumpify (via nodeClumper: @escaping (Node) -> Set<Node>) -> AdjacencyList<Set<Node>> {
        return AdjacencyList<Set<Node>>(
            adjacencies.reduce(into: [Set<Node>: Set<Set<Node>>]()) { list, adjacencyPair in
                let (node, adjacentNodes) = adjacencyPair
                let clump = nodeClumper(node)
                let adjacentClumps = Set(adjacentNodes.map(nodeClumper))
                if let existingSet = list[clump] {
                    list[clump] = existingSet.union(adjacentClumps)
                } else {
                    list[clump] = adjacentClumps
                }
                list[clump]!.remove(clump)
        })
    }
    
    // Group nodes according to the function that sends a node to its strongly connected component, as found
    // by the implementation of Tarjan's algorithm, hence forming a Directed Acyclic Graph (DAG) version of
    // original `AdjacencyList` (`self`).
    public func DAGify () -> AdjacencyList<Set<Node>> {
        return clumpify (via: getStronglyConnectedComponent())
    }
    
    // Determines whether the graph represented by the `AdjacencyList` contains a cycle.
    public func containsCycle () -> Bool {
        
        var flag = false
        
        func cycleSearch(_ visited: inout Set<Node>, _ keyValue: (key: Node, value: Set<Node>)) {
            
            func depthFirstSearch (
                _ visited: inout Set<Node>,
                _ active: inout Set<Node>,
                _ keyValue: (key: Node, value: Set<Node>)
                ) -> Bool
            {
                let (node, neighbors) = keyValue
                if visited.contains(node) { return false }
                visited.insert(node)
                active.insert(node)
                let foundCycle = neighbors.reduce(false) { outcome, neighbor in
                    if active.contains(neighbor) {
                        return true
                    } else if !visited.contains(neighbor) {
                        return outcome ||
                            depthFirstSearch(&visited, &active, (neighbor, adjacencies[neighbor]!))
                    } else {
                        return outcome
                    }
                }
                active.remove(node)
                return foundCycle
            }
            
            var active: Set<Node> = []
            if flag == true { return }
            if depthFirstSearch(&visited, &active, keyValue) {
                flag = true
            }
        }
        
        let _ = adjacencies.reduce(into: [], cycleSearch)
        return flag
    }
}

extension AdjacencyList: Equatable { }
extension AdjacencyList: Hashable { }
extension AdjacencyList: Codable where Node: Codable { }
