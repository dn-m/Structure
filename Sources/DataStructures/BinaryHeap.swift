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
    private var indices: [Element: Int]
    
    // MARK: - Instance Methods
    
    private func lessAt(_ i: Int, than j: Int) -> Bool {
        return lookup[storage[i]]! < lookup[storage[j]]!
    }
    
    mutating func insert (_ element: Element, _ value: Value) {
        storage.append(element)
        lookup[element] = value
        bubbleUp(from: storage.count - 1)
    }
    
    mutating func pop () -> (Element, Value)? {
        if storage.isEmpty { return nil }
        else {
            if storage.count > 1 { swapAt(0, storage.count - 1) }
            let least = removeLast()
            balance()
            return (least, lookup[least]!)
        }
    }
    
    mutating func suggestDecrease(of element: Element, to value: Value) {
        if value < lookup[element]! {
            decreaseValue(of: element, to: value)
        }
    }
    
    private mutating func value(of element: Element) -> Value {
        return lookup[element]!
    }
    
    private mutating func decreaseValue(of element: Element, to value: Value) {
        updateValue(of: element, to: value)
        bubbleUp(from: index(of: element))
    }
    
    private mutating func updateIndex (of element: Element, to i: Int?) {
        indices[element] = i
    }
    
    private mutating func updateValue (of element: Element, to value: Value) {
        lookup[element] = value
    }
    
    private func index(of element: Element) -> Int {
        return indices[element]!
    }
    
    private mutating func removeLast () -> Element {
        let element = storage.removeLast()
        updateIndex (of: element, to: nil)
        return element
    }
    
    private mutating func swapAt (_ i: Int, _ j: Int) {
        storage.swapAt(i, j)
        updateIndex(of: storage[i], to: j)
        updateIndex(of: storage[j], to: i)
    }
    
    private mutating func bubbleUp (from i: Int) {
        var i = i
        while (i != 0) {
            let j = (i-1)/2
            if lessAt(i, than: j) {
                swapAt(i, j)
                i = j
            }
            else { return }
        }
    }
    
    private mutating func balance () {
        
        func argmin(_ i: Int, _ j: Int) -> Int {
            return lookup[storage[i]]! == min(lookup[storage[i]]!, lookup[storage[j]]!) ? i : j
        }
        
        func hasOneChild(_ i: Int) -> Bool {
            return 2 * i + 2 == storage.count
        }
        
        var i = 0
        while (2 * i + 1 <= storage.count - 1) {
            let j = hasOneChild(i) ? 2 * i + 1 : argmin(2 * i + 1, 2 * i + 2)
            if lessAt(j,than: i) {
                swapAt(i,j)
                i = j
            }
            else { break }
        }
    }
    
    // MARK: - Initializers
    
    init () {
        storage = []
        lookup = [:]
        indices = [:]
    }
}
