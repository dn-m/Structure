//
//  ContiguousSegmentCollectionTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 8/22/18.
//

import XCTest
@testable import DataStructures

extension Int: Fragmentable {
    public func fragment(in range: Range<Int>) -> Int.Fragment {
        return Fragment(self, in: range)
    }

    public struct Fragment: Intervallic {
        public var length: Int { return range.length }
        let value: Int
        let range: Range<Metric>
        init(_ value: Int, in range: Range<Metric>) {
            self.value = value
            self.range = range
        }
    }
}

extension Int.Fragment: FragmentProtocol, Fragmentable {
    public typealias WholeMetric = Int
    public typealias Whole = Int
    public typealias Metric = Int
    public typealias Fragment = Int.Fragment
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

    func testFragmentA() {
        let collection = ContiguousSegmentCollection([4,4,4,4])
        let fragment = collection.fragment(in: 9..<11)
        let expected = ContiguousSegmentCollection<Int,Int.Fragment>([Int.Fragment(4, in: 1..<3)])
        XCTAssertEqual(fragment.base, expected.base)
    }

//    func testFragmentB() {
//        let collection = IntSegmentCollection([4,4,4,4])
//    }
//
//    func testFragmentC() {
//        let collection = IntSegmentCollection([4,4,4,4])
//    }
//
//    func testFragmentD() {
//        let collection = IntSegmentCollection([4,4,4,4])
//    }
//
//    func testFragmentE() {
//        let collection = IntSegmentCollection([4,4,4,4])
//    }
//
//    func testFragmentF() {
//        let collection = IntSegmentCollection([4,4,4,4])
//    }
//
//    func testFragmentG() {
//        let collection = IntSegmentCollection([4,4,4,4])
//    }
//
//    func testFragmentH() {
//        let collection = IntSegmentCollection([4,4,4,4])
//    }
//
//    func testFragmentI() {
//        let collection = IntSegmentCollection([4,4,4,4])
//    }
}
