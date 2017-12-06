//
//  SegmentTreeTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 12/4/17.
//

import XCTest
@testable import DataStructures

class SegmentTreeTests: XCTestCase {

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

    func testEqualityFalseLeafAndBranch() {

    }

    func testEqualityFalseBranchAndLeaf() {

    }

    func testEqualityFalseLeaves() {

    }

    func testEqualityFalseBranches() {

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
}
