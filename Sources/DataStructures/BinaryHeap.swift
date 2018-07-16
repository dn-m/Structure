//
//  BinaryHeap.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/15/18.
//

struct BinaryHeap<Element: Hashable, Value: Comparable> {

    // MARK: - Instance Properties
    
    private var storage: [Element]
    private var lookup: [Element: Value]
    
    // MARK: - Instance Methods
    
    mutating func insert (_ element: Element, _ value: Value) {
        storage.append(element)
        lookup[element] = value
        var i = storage.count - 1
        while (i != 0) {
            if (lookup[storage[i]]! < lookup[storage[(i-1)/2]]!) {
                storage.swapAt(i, (i-1)/2)
                i /= 2
            }
            else { break }
        }
    }
    
    mutating func pop () -> Element? {
        guard let minimum = storage.first else { return nil }
        storage[0] = storage.removeLast()
        balance()
        return minimum
    }
    
    mutating func balance () {
        
        func argmin(_ i: Int, _ j: Int) -> Int {
            return storage[i].1 == min(storage[i].1, storage[j].1) ? i : j
        }
        
        var i = 0
        while (2 * i + 1 <= storage.count - 1) {
            if (2 * i + 2 > storage.count - 1) {
                let j = 2 * i + 1
                if (storage[j].1 < storage[i].1) {
                    storage.swapAt(i, j)
                    i = j
                    continue
                }
            }
            let j = argmin(2 * i + 1, 2 * i + 2)
            if (storage[j].1 < storage[i].1) {
                storage.swapAt(i, j)
                i = j
                continue
            }
        }
    }
    
    // MARK: - Initializers
    
    init () {
        storage = []
        lookup = [:]
    }
}
