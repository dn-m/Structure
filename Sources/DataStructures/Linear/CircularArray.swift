//
//  CircularArray.swift
//  Collections
//
//  Created by James Bean on 6/6/17.
//
//

/// Array-like structure that allows retrieval of elements at indices outside of the bounds of
/// the internal storage.
///
/// **Example Usage**
///
///     let loop: CircularArray = [0,1,2,3,4,5]
///     loop[circular: 6] // => 0
///     loop[from: 2, through: 7] // => [2,3,4,5,0,1]
///
public struct CircularArray <Element> {

    private var storage: Array<Element>

    // MARK: - Initializers

    /// Creates a `CircularArray` with an sequence.
    public init <S: Sequence> (_ storage: S) where S.Element == Element {
        self.storage = Array(storage)
    }

    // MARK: - Instance Methods

    /// - Returns: Element at the given logical index.
    public subscript (circular index: Int) -> Element {
        return storage[circularIndex(index)]
    }

    /// - Returns: Array of elements from (and including) the given logical `start` index
    /// through (and including) the given logical `end` index.
    ///
    /// - Note: If the real start index is greater than the real end index (for the given
    /// logical indices), the resultant array will loop around the back, to the front of the
    /// internal storage.
    public subscript (from start: Int, through end: Int) -> [Element] {

        let start = circularIndex(start)
        let end = circularIndex(end)

        if start > end {
            let back = storage[start..<storage.count]
            let front = storage[0...end]
            return Array(back + front)
        }

        return Array(storage[start...end])
    }

    /// - Returns: Array of elements after (not including) the given logical `start` index
    /// up to (not including) the given logical `end` index.
    ///
    /// - Note: If the real start index is greater than the real end index (for the given
    /// logical indices), the resultant array will loop around the back, to the front of the
    /// internal storage.
    public subscript (after start: Int, upTo end: Int) -> [Element] {
        return self[from: start + 1, through: end - 1]
    }

    /// - Returns: A sorted copy of `CircularArray`.
    public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> CircularArray {
        return CircularArray(storage.sorted(by: areInIncreasingOrder))
    }

    private func circularIndex(_ index: Int) -> Int {
        return mod(index, storage.count)
    }
}

extension CircularArray: RandomAccessCollectionWrapping {

    // MARK: RandomAccessCollectionWrapping

    /// - Returns: The underlying, non-circular contiguous storage of elements.
    public var base: [Element] {
        return storage
    }
}

extension CircularArray: BidirectionalCollection {

    // MARK: - BidirectionalCollection

    /// Start index.
    public var startIndex: Int {
        return storage.startIndex
    }

    /// End index.
    public var endIndex: Int {
        return storage.endIndex
    }

    /// Element at index.
    public subscript (index: Int) -> Element {
        return storage[index]
    }

    /// Index after given `i`.
    public func index(after i: Int) -> Int {
        assert(i < endIndex)
        return i + 1
    }

    /// Index before given `i`.
    public func index(before i: Int) -> Int {
        assert(i > startIndex)
        return i - 1
    }
}

extension CircularArray: RangeReplaceableCollection {

    // MARK: - RangeReplaceableCollection

    /// Replaces the specified subrange of elements with the given collection.
    ///
    /// This method has the effect of removing the specified range of elements
    /// from the collection and inserting the new elements at the same location.
    /// The number of new elements need not match the number of elements being
    /// removed.
    ///
    /// In this example, three elements in the middle of an array of integers are
    /// replaced by the five elements of a `Repeated<Int>` instance.
    ///
    ///      var nums = [10, 20, 30, 40, 50]
    ///      nums.replaceSubrange(1...3, with: repeatElement(1, count: 5))
    ///      print(nums)
    ///      // Prints "[10, 1, 1, 1, 1, 1, 50]"
    ///
    /// If you pass a zero-length range as the `subrange` parameter, this method
    /// inserts the elements of `newElements` at `subrange.startIndex`. Calling
    /// the `insert(contentsOf:at:)` method instead is preferred.
    ///
    /// Likewise, if you pass a zero-length collection as the `newElements`
    /// parameter, this method removes the elements in the given subrange
    /// without replacement. Calling the `removeSubrange(_:)` method instead is
    /// preferred.
    ///
    /// Calling this method may invalidate any existing indices for use with this
    /// collection.
    ///
    /// - Parameters:
    ///   - subrange: The subrange of the collection to replace. The bounds of
    ///     the range must be valid indices of the collection.
    ///   - newElements: The new elements to add to the collection.
    ///
    /// - Complexity: O(*m*), where *m* is the combined length of the collection
    ///   and `newElements`. If the call to `replaceSubrange` simply appends the
    ///   contents of `newElements` to the collection, the complexity is O(*n*),
    ///   where *n* is the length of `newElements`.
    public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C)
        where C : Collection, C.Element == Element
    {
        self.storage.replaceSubrange(subrange, with: newElements)
    }

    /// Creates an empty `CircularArray`.
    public init() {
        self.storage = []
    }
}

extension CircularArray: ExpressibleByArrayLiteral {

    // MARK: - ExpressibleByArrayLiteral

    /// Creates a `CircularArray` with an array literal.
    public init(arrayLiteral elements: Element...) {
        self = CircularArray(elements)
    }
}

/// - Returns: "True" modulo (not "remainder", which is implemented by Swift's `%`).
private func mod <T: BinaryInteger> (_ dividend: T, _ modulus: T) -> T {
    let result = dividend % modulus
    return result < 0 ? result + modulus : result
}

extension Array {

    /// - Returns: `CircularArray` containing the elements contained herein.
    public var circular: CircularArray<Element> {
        return CircularArray(self)
    }
}

extension CircularArray: Equatable where Element: Equatable { }
extension CircularArray: Hashable where Element: Hashable { }
extension CircularArray: Codable where Element: Codable { }
