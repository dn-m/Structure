//
//  SegmentTreeTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 12/4/17.
//

import XCTest
@testable import DataStructures

class SegmentTreeTests: XCTestCase {

    func testIntervalContainsTrue() {
        let interval = Interval(5,10)
        let offset = 9
        XCTAssert(interval.contains(offset, including: .start))
    }

    func testIntervalContainsFalse() {
        let interval = Interval(5,10)
        let offset = 12
        XCTAssertFalse(interval.contains(offset, including: .start))
    }

    func testIntervalContainsIncludingStart() {
        let interval = Interval(5,10)
        let offset = 5
        XCTAssert(interval.contains(offset, including: .start))
    }

    func testIntervalContainsIncludingEnd() {
        let interval = Interval(5,10)
        let offset = 10
        XCTAssert(interval.contains(offset, including: .end))
    }

    func testEqualityTrueLeaves() {
        let a = SegmentTree.leaf(Interval(0,5))
        let b = SegmentTree.leaf(Interval(0,5))
        XCTAssertEqual(a,b)
    }

    func testEqualityTreeBranches() {
        let a = SegmentTree.leaf(Interval(0,5))
        let b = SegmentTree.leaf(Interval(1,9))
        XCTAssertNotEqual(a,b)
    }
    
    func testInitWithOffsetsTwoValues() {
        let offsets = [0,8]
        let segmentTree = SegmentTree(offsets: offsets)
        let expected = SegmentTree.leaf(Interval(0,8))
        XCTAssertEqual(segmentTree, expected)
    }

    func testInitWithOffsetsThreeValues() {
        let offsets = [0,8,11]
        let segmentTree = SegmentTree(offsets: offsets)
        let expected = SegmentTree.branch(
            .leaf(Interval(0,8)),
            Interval(0,11),
            .leaf(Interval(8,11))
        )
        XCTAssertEqual(segmentTree, expected)
    }

    func testInitWithOffsetsFourValues() {
        let offsets = [0,8,11,14]
        let segmentTree = SegmentTree(offsets: offsets)
        let expected = SegmentTree.branch(
            .branch(
                .leaf(Interval(0,8)),
                Interval(0,11),
                .leaf(Interval(8,11))
            ),
            Interval(0,14),
            .leaf(Interval(11,14))
        )
        XCTAssertEqual(segmentTree,expected)
    }

    func testInitWithManyOffsets() {
        let offsets = [0,8,11,14,20,23,25,31,45]
        let segmentTree = SegmentTree(offsets: offsets)
        let expected = SegmentTree.branch(
            .branch(
                .branch(
                    .leaf(Interval(0,8)),
                    Interval(0,11),
                    .leaf(Interval(8,11))
                ),
                Interval(0,20),
                .branch(
                    .leaf(Interval(11,14)),
                    Interval(11,20),
                    .leaf(Interval(14,20))
                )
            ),
            Interval(0,45),
            .branch(
                .branch(
                    .leaf(Interval(20,23)),
                    Interval(20,25),
                    .leaf(Interval(23,25))
                ),
                Interval(20,45),
                .branch(
                    .leaf(Interval(25,31)),
                    Interval(25,45),
                    .leaf(Interval(31,45))
                )
            )
        )
        XCTAssertEqual(segmentTree, expected)
    }

    func testIntervalContainingOffsetNone() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        XCTAssertNil(segmentTree.interval(containing: 46, including: .start))
    }

    func testIntervalContainingOffsetSome() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        let expected = Interval(14,20)
        XCTAssertEqual(segmentTree.interval(containing: 15, including: .end), expected)
    }

    func testIntervalContainingOffsetIncludingStart() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        let expected = Interval(14,20)
        XCTAssertEqual(segmentTree.interval(containing: 14, including: .start), expected)
    }

    func testIntervalContainingOffsetIncludingEnd() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        let expected = Interval(14,20)
        XCTAssertEqual(segmentTree.interval(containing: 20, including: .end), expected)
    }

    func testIntervalsFromNil() {
        let segmentTree = SegmentTree(offsets: [14,20,23,25,31,45])
        let offset = 46
        XCTAssertNil(segmentTree[from: offset])
    }

    func testIntervalsFromSingle() {
        let segmentTree = SegmentTree(offsets: [4,9])
        let offset = 5
        let result = segmentTree[from: offset]!
        let expected = SegmentTree(offsets: [5,9])
        XCTAssertEqual(result, expected)
    }

    func testIntervalsFromMultiple() {
        let segmentTree = SegmentTree(offsets: [0,8,11])
        let offset = 5
        let result = segmentTree[from: offset]!
        let expected = SegmentTree(offsets: [5,8,11])
        XCTAssertEqual(result, expected)
    }

    func testIntervalsFromMany() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        let offset = 9
        let result = segmentTree[from: offset]!
        let expected = SegmentTree(offsets: [9,11,14,20,23,25,31,45])
        XCTAssertEqual(result, expected)
    }

    func testIntervalsToMultiple() {
        let segmentTree = SegmentTree(offsets: [14,20,23,25,31,45])
        let offset = 25
        let result = segmentTree[to: offset]!
        let expected = SegmentTree(offsets: [14,20,23,25])
        XCTAssertEqual(result, expected)
    }

    func testIntervalsToMany() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        let offset = 29
        let result = segmentTree[to: offset]!
        let expected = SegmentTree(offsets: [0,8,11,14,20,23,25,29])
        XCTAssertEqual(result, expected)
    }

    func testIntervalNil() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        XCTAssertNil(segmentTree[Interval(49,50)])
    }

    func testIntervalSame() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        let interval = Interval(12,13)
        let result = segmentTree[interval]
        let expected = SegmentTree(offsets: [12,13])
        XCTAssertEqual(result, expected)
    }

    func testInterval() {
        let segmentTree = SegmentTree(offsets: [0,8,11,14,20,23,25,31,45])
        let interval = Interval(9,26)
        let result = segmentTree[interval]
        let expected = SegmentTree(offsets: [9,11,14,20,23,25,26])
        XCTAssertEqual(result, expected)
    }
}
