//
//  AdjacencyList.swift
//  DataStructures
//
//  Created by Benjamin Wetherfield on 5/23/19.
//

public struct AdjacencyList<Node: Hashable> {
    
    let adjacencies: [Node: Set<Node>]
    
    init(_ adjacencies: [Node: Set<Node>]) {
        self.adjacencies = adjacencies
    }
}

extension AdjacencyList {
    
    // Tarjan's algorithm to find strongly connected components
    func findStronglyConnectedComponent ()
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
}
