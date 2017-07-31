//
//  LinkedList.swift
//  Collections
//
//  Adapted and modified from Airspeed Velocity and Chris Eidhof.
//  Created by Jeremy Corren on 12/28/16.
//
//

/// The `LinkedList`.
public enum LinkedList <T> {

    /// Last node in list.
    case end

    /// Node with pointer to next node.
    indirect case node(T, next: LinkedList<T>)
}

extension LinkedList {

    /// Construct a new list with the given `value` held by a node at the front.
    func cons(value: T) -> LinkedList {
        return .node(value, next: self)
    }
}

extension LinkedList {

    /// Push a node holding the given `value` onto the front of the list.
    public mutating func push(x: T) {
        self = self.cons(value: x)
    }

    /// - returns: The element contained by the node at the front of the list, if the
    /// list is not empty. Otherwise, `nil`.
    public mutating func pop() -> T? {

        switch self {
        case .end:
            return nil
        case let .node(x, next: xs):
            self = xs
            return x
        }
    }
}

extension LinkedList: Collection {

    // MARK: - `Collection`

    /// Index after given index `i`.
    public func index(after i: Int) -> Int {
        return i + 1
    }

    /// Start index.
    public var startIndex: Int {
        return 0
    }

    /// End index.
    public var endIndex: Int {

        switch self {
        case .end:
            return 0
        case .node(_, let tail):
            return 1 + tail.endIndex
        }
    }

    /// - returns: Element at the given `index`.
    public subscript(position: Int) -> T {

        switch (self, position) {
        case (.end, _):
            fatalError("Index out of bounds")
        case (.node(let x, _), 0):
            return x
        case (.node(_, let tail), _):
            return tail[position - 1]
        }
    }
}

extension LinkedList: ExpressibleByArrayLiteral {

    // - MARK: `ExpressibleByArrayLiteral`

    /// Create a `LinkedList` with an array literal.
    public init(arrayLiteral elements: T...) {
        self = elements
            .lazy
            .reversed()
            .reduce(.end) { $0.cons(value: $1) }
    }
}
