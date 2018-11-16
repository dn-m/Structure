//
//  ContiguousSegmentCollectionTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 8/22/18.
//

import XCTest
import DataStructures

extension Int: IntervallicFragmentable {
    public struct Fragment: Intervallic {
        public typealias Metric = Int
        public var length: Int { return range.length }
        let value: Int
        let range: Range<Int>
        init(_ value: Int, in range: Range<Int>) {
            self.value = value
            self.range = range
        }
    }
    public func fragment(in range: Range<Int>) -> Int.Fragment { return Fragment(self, in: range) }
}

extension Int.Fragment: IntervallicFragmentable, Totalizable, Equatable {
    public init(whole: Int) {
        self.init(whole, in: 0..<whole.length)
    }
    public func fragment(in range: Range<Int>) -> Int.Fragment {
        return .init(value, in: range.clamped(to: self.range))
    }
}

class ContiguousSegmentCollectionTests: XCTestCase {

    func testInitSegments() {
        let collection: ContiguousSegmentCollection = [1,2,3,5,8,13,21]
        let expected: SortedDictionary = [0: 1, 1: 2, 3: 3, 6: 5, 11: 8, 19: 13, 32: 21]
        XCTAssertEqual(collection.base, expected)
    }

    func testOffsets() {
        let collection = ContiguousSegmentCollection([1,2,3,5,8,13,21])
        XCTAssertEqual(Array(collection.offsets), [0,1,3,6,11,19,32])
    }

    func testSegments() {
        let collection = ContiguousSegmentCollection([1,2,3,5,8,13,21])
        XCTAssertEqual(Array(collection.segments), [1,2,3,5,8,13,21])
    }

    func testLength() {
        let collection = ContiguousSegmentCollection([1,2,3,5,8,13,21])
        XCTAssertEqual(collection.length, 53)
    }

    func testContains() {
        let collection = ContiguousSegmentCollection([1,2,3,5,8,13,21])
        XCTAssertTrue(collection.contains(0))
        XCTAssertTrue(collection.contains(40))
        XCTAssertFalse(collection.contains(53))
    }

    func testRandomAccess() {
        let collection = ContiguousSegmentCollection([1,2,3,5,8,13,21])
        let fourthSegment = collection[3]
        XCTAssertEqual(fourthSegment.0, 6)
        XCTAssertEqual(fourthSegment.1, 5)
    }

    /// |---|---|---|---|
    let collection = ContiguousSegmentCollection([4,4,4,4])

    ///          xx
    /// |---|---|---|---|
    func testFragmentA() {
        let fragment = collection.fragment(in: 9..<11)
        let single = Int.Fragment(4, in: 1..<3)
        let expected = ContiguousSegmentCollection<Int>.Fragment(single, offset: 9)
        XCTAssertEqual(fragment, expected)
    }

    ///         x x
    /// |---|---|---|---|
    func testFragmentB() {
        let fragment = collection.fragment(in: 8..<10)
        let single = Int.Fragment(4, in: 0..<2)
        let expected = ContiguousSegmentCollection<Int>.Fragment(single, offset: 8)
        XCTAssertEqual(fragment, expected)
    }

    ///           x x
    /// |---|---|---|---|
    func testFragmentC() {
        let fragment = collection.fragment(in: 10..<12)
        let single = Int.Fragment(4, in: 2..<4)
        let expected = ContiguousSegmentCollection<Int>.Fragment(single, offset: 10)
        XCTAssertEqual(fragment, expected)
    }

    ///         x   x
    /// |---|---|---|---|
    func testFragmentD() {
        let fragment = collection.fragment(in: 8..<12)
        let body = ContiguousSegmentCollection([4], offset: 8)
        let expected = ContiguousSegmentCollection<Int>.Fragment(body: body)
        XCTAssertEqual(fragment, expected)
    }

    ///     x     x
    /// |---|---|---|---|
    func testFragmentE() {
        let fragment = collection.fragment(in: 4..<10)
        let expected = ContiguousSegmentCollection<Int>.Fragment(
            body: ContiguousSegmentCollection([4], offset: 4),
            tail: Int.Fragment(4, in: 0..<2)
        )
        XCTAssertEqual(fragment, expected)
    }

    ///       x     x
    /// |---|---|---|---|
    func testFragmentF() {
        let fragment = collection.fragment(in: 6..<12)
        let expected = ContiguousSegmentCollection<Int>.Fragment(
            head: Int.Fragment(4, in: 2..<4),
            body: ContiguousSegmentCollection([4], offset: 8)
        )
        XCTAssertEqual(fragment, expected)
    }

    ///   x             x
    /// |---|---|---|---|
    func testFragmentG() {
        let fragment = collection.fragment(in: 2..<16)
        let expected = ContiguousSegmentCollection<Int>.Fragment(
            head: Int.Fragment(4, in: 2..<4),
            body: ContiguousSegmentCollection<Int>([4,4,4], offset: 4)
        )
        XCTAssertEqual(fragment, expected)
    }

    /// x             x
    /// |---|---|---|---|
    func testFragmentH() {
        let fragment = collection.fragment(in: 0..<14)
        let expected = ContiguousSegmentCollection<Int>.Fragment(
            body: [4,4,4],
            tail: Int.Fragment(4, in: 0..<2)
        )
        XCTAssertEqual(fragment, expected)
    }

    /// x               x
    /// |---|---|---|---|
    func testFragmentI() {
        let fragment = collection.fragment(in: 0..<16)
        let expected = ContiguousSegmentCollection<Int>.Fragment(body: [4,4,4,4])
        XCTAssertEqual(fragment, expected)
    }

    // MARK: ContiguousSegment.Fragment

    ///  xx
    /// |--||---------||--|
    func testFragmentOfFragmentHeadHead() {
        let fragment = collection.fragment(in: 1 ..< 14)
        let subfragment = fragment.fragment(in: 2 ..< 4)
        let single = Int.Fragment(4, in: 2..<4)
        let expected = ContiguousSegmentCollection<Int>.Fragment(single, offset: 2)
        XCTAssertEqual(subfragment, expected)
    }

    ///  x       x
    /// |--||---------||--|
    func testFragmentOfFragmentHeadBody() {
        let fragment = collection.fragment(in: 1 ..< 14)
        let subfragment = fragment.fragment(in: 2 ..< 10)
        let expected = ContiguousSegmentCollection<Int>.Fragment(
            head: Int.Fragment(4, in: 2..<4),
            body: ContiguousSegmentCollection<Int>([4], offset: 4),
            tail: Int.Fragment(4, in: 0..<2)
        )
        XCTAssertEqual(subfragment, expected)
    }

    ///       x     x
    /// |--||---------||--|
    func testFragmentOfFragmentBodyBody() {
        let fragment = collection.fragment(in: 1 ..< 14)
        let subfragment = fragment.fragment(in: 6 ..< 10)
        let head = Int.Fragment(4, in: 2 ..< 4)
        let tail = Int.Fragment(4, in: 0 ..< 2)
        let expected = ContiguousSegmentCollection<Int>.Fragment(head, tail, offset: 6)
        XCTAssertEqual(subfragment, expected)
    }

    ///       x           x
    /// |--||---------||--|
    func testFragmentOfFragmentBodyTail() {
        let fragment = collection.fragment(in: 1..<14)
        let subfragment = fragment.fragment(in: 6..<14)
        let expected = ContiguousSegmentCollection<Int>.Fragment(
            head: Int.Fragment(4, in: 2..<4),
            body: ContiguousSegmentCollection<Int>([4], offset: 8),
            tail: Int.Fragment(4, in: 0..<2)
        )
        XCTAssertEqual(subfragment, expected)
    }

    ///                x  x
    /// |--||---------||--|
    func testFragmnetOfFragmentTailTail() {
        let fragment = collection.fragment(in: 1 ..< 14)
        let subfragment = fragment.fragment(in: 12 ..< 14)
        let single = Int.Fragment(4, in: 0..<2)
        let expected = ContiguousSegmentCollection<Int>.Fragment(single, offset: 12)
        XCTAssertEqual(subfragment, expected)
    }
}
