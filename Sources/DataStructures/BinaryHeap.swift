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
    
    mutating func insert (_ element: Element, _ value: Value) {
        storage.append((element, value))
        var i = storage.count - 1
        while (i != 0) {
            if (storage[i].1 < storage[(i-1)/2].1) {
                storage.swapAt(i, (i-1)/2)
                i /= 2
            }
            else { break }
        }
    }
    
    mutating func pop () -> (Element, Value)? {
        guard let minimum = storage.first else { return nil }
        storage[0] = storage.removeLast()
        #warning("TODO: balance heap")
        return minimum
    }
    
    mutating func balance () {
        
        func argmin(_ i: Int, _ j: Int) -> Int {
            return storage[i].1 == min(storage[i].1, storage[j].1) ? i : j
        }
        
    }
    
    // MARK: - Initializers
    
    init () {
        storage = []
    }
}
