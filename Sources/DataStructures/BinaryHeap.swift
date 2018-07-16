//
//  BinaryHeap.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/15/18.
//

struct BinaryHeap<Element, Value: Comparable> {

    // MARK: - Instance Properties
    
    private var storage: [(Element, Value)]
    
    // MARK: - Instance Methods
    
    mutating func insert(_ element: Element, _ value: Value) {
        storage.append((element, value))
    }
    
    // MARK: - Initializers
    
    init () {
        storage = []
    }
}
