//
//  Stack.swift
//  Collections
//
//  Created by James Bean on 12/9/16.
//
//

import Algebra

/// Stack structure.
public struct Stack <Element> {

    fileprivate var elements: [Element] = []

    // MARK: - Instance Properties

    /// Top element of `Stack`.
    public var top: Element? {
        return elements.last
    }

    /// - returns: The `top` and the remaining items, if possible. Otherwise, `nil`.
    public var destructured: (Element, Stack<Element>)? {

        guard self.count > 0 else {
            return nil
        }

        var copy = self
        let top = copy.pop()!
        return (top, copy)
    }

    // MARK: - Initializers

    /// Create an empty `Stack`.
    public init() { }

    /// Create a `Stack` with the given sequence of `elements`.
    public init <S: Sequence> (_ elements: S) where S.Iterator.Element == Element {
        self.elements = Array(elements)
    }

    // MARK: - Instance Methods

    /// Push item to end of `Stack`.
    public mutating func push(_ item: Element) {
        elements.append(item)
    }

    /// - returns: A new `Stack` with the given `item` pushed to the top.
    public func pushing(_ item: Element) -> Stack<Element> {
        var copy = self
        copy.push(item)
        return copy
    }

    /// - returns: Item from top of `Stack` if there are any. Otherwise, `nil`.
    @discardableResult public mutating func pop() -> Element? {
        return elements.popLast()
    }

    /// - returns: `Stack` containing items popped from end of `Stack`
    public mutating func pop(amount: Int) -> Stack<Element>? {

        guard elements.count > amount else {
            return nil
        }

        var poppedItems = Stack<Element>()
        for _ in 0..<amount { poppedItems.push(pop()!) }
        return poppedItems
    }

    // TODO: - Returns: original, modified stack, with popped items, if possible. Otherwise, `nil`.
    // func popping(amount: Int) -> (Stack<Element>, Stack<Element>)? { ... }
}

extension Stack: Collection {

    // MARK: - `Collection`

    /// - Returns: Index after the given `index`.
    public func index(after index: Int) -> Int {
        assert(index < endIndex, "Cannot increment to \(index + 1).")
        return index + 1
    }

    /// - Start index.
    public var startIndex: Int {
        return 0
    }

    /// - End index.
    public var endIndex: Int {
        return elements.count
    }

    /// - returns: Element at the given `index`.
    public subscript (index: Int) -> Element {
        return elements[index]
    }
}

extension Stack: BidirectionalCollection {

    /// - Returns: Index before the given `index`.
    public func index(before index: Int) -> Int {
        assert(index > 0, "Cannot decrement index to \(index - 1)")
        return index - 1
    }

    /// Count of elements contained herein.
    ///
    /// - Complexity: O(_1_)
    ///
    public var count: Int {
        return elements.count
    }
}

extension Stack: ExpressibleByArrayLiteral {

    // MARK: - `ExpressibleByArrayLiteral`.

    /// - returns: Create a `SortedArray` with an array literal.
    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

extension Stack: Additive {

    // MARK: - Additive

    /// - Returns: Empty `Stack`.
    public static var zero: Stack<Element> {
        return Stack()
    }

    /// - Returns: `Stack` with the contents of two `Stack` values.
    public static func + (lhs: Stack, rhs: Stack) -> Stack {
        return Stack(lhs.elements + rhs.elements)
    }
}

extension Stack: Monoid {

    // MARK: - Monoid

    /// - Returns: Empty `Stack`.
    public static var identity: Stack<Element> {
        return .zero
    }

    /// - Returns: Composition of two of the same `Semigroup` type values.
    public static func <> (lhs: Stack<Element>, rhs: Stack<Element>) -> Stack<Element> {
        return lhs + rhs
    }
}

/// - returns: `true` if all items in both `Stack` structs are equivalent. Otherwise `false`.
public func == <T: Equatable> (lhs: Stack<T>, rhs: Stack<T>) -> Bool {
    return lhs.elements == rhs.elements
}
