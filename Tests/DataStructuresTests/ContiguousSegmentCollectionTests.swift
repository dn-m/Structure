//
//  ContiguousSegmentCollectionTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 8/22/18.
//

import XCTest
@testable import DataStructures

extension Int: MeasuredFragmentable {

    public struct Fragment: Intervallic {
        public var length: Int { return range.length }
        let value: Int
        let range: Range<Metric>
        init(_ value: Int, in range: Range<Metric>) {
            self.value = value
            self.range = range
        }
    }

    public func fragment(in range: Range<Int>) -> Int.Fragment {
        return Fragment(self, in: range)
    }
}

extension Int.Fragment: MeasuredFragment, MeasuredFragmentable {
    public typealias Fragment = Int.Fragment
    public typealias WholeMetric = Int
    public init(whole: Int) {
        self.init(whole, in: 0..<whole.length)
    }
    public func fragment(in range: Range<Int>) -> Int.Fragment {
        return .init(value, in: range)
    }
}

extension Int.Fragment: Equatable { }

class ContiguousSegmentCollectionTests: XCTestCase {

    func testInitSegments() {
        let collection = ContiguousSegmentCollection([1,2,3,5,8,13,21])
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
    var collection = ContiguousSegmentCollection([4,4,4,4])

    ///          xx
    /// |---|---|---|---|
    func testFragmentA() {
        let fragment = collection.fragment(in: 9..<11)
        let expected = ContiguousSegmentCollection([Int.Fragment(4, in: 1..<3)]).offsetBy(9)
        XCTAssertEqual(fragment, expected)
    }

    ///         x x
    /// |---|---|---|---|
    func testFragmentB() {
        let fragment = collection.fragment(in: 8..<10)
        let expected = ContiguousSegmentCollection([Int.Fragment(4, in: 0..<2)]).offsetBy(8)
        XCTAssertEqual(fragment, expected)
    }

    ///           x x
    /// |---|---|---|---|
    func testFragmentC() {
        let fragment = collection.fragment(in: 10..<12)
        let expected = ContiguousSegmentCollection([Int.Fragment(4, in: 2..<4)]).offsetBy(10)
        XCTAssertEqual(fragment, expected)
    }

    ///         x   x
    /// |---|---|---|---|
    func testFragmentD() {
        let fragment = collection.fragment(in: 8..<12)
        let expected = ContiguousSegmentCollection([Int.Fragment(4, in: 0..<4)]).offsetBy(8)
        XCTAssertEqual(fragment, expected)
    }

    ///     x     x
    /// |---|---|---|---|
    func testFragmentE() {
        let fragment = collection.fragment(in: 4..<10)
        let expected = ContiguousSegmentCollection([
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<2)
        ]).offsetBy(4)
        XCTAssertEqual(fragment, expected)
    }

    ///       x     x
    /// |---|---|---|---|
    func testFragmentF() {
        let fragment = collection.fragment(in: 6..<12)
        let expected = ContiguousSegmentCollection([
            Int.Fragment(4, in: 2..<4),
            Int.Fragment(4, in: 0..<4)
        ]).offsetBy(6)
        XCTAssertEqual(fragment, expected)
    }

    ///   x             x
    /// |---|---|---|---|
    func testFragmentG() {
        let fragment = collection.fragment(in: 2..<16)
        let expected = ContiguousSegmentCollection([
            Int.Fragment(4, in: 2..<4),
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<4)
        ]).offsetBy(2)
        XCTAssertEqual(fragment, expected)
    }

    /// x             x
    /// |---|---|---|---|
    func testFragmentH() {
        let fragment = collection.fragment(in: 0..<14)
        let expected = ContiguousSegmentCollection([
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<2)
        ])
        XCTAssertEqual(fragment, expected)
    }

    /// x               x
    /// |---|---|---|---|
    func testFragmentI() {
        let fragment = collection.fragment(in: 0..<16)
        let expected = ContiguousSegmentCollection([
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<4),
            Int.Fragment(4, in: 0..<4)
        ])
        XCTAssertEqual(fragment, expected)
    }
}
