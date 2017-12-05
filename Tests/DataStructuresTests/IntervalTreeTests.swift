//
//  IntervalTreeTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 12/4/17.
//

import XCTest
@testable import DataStructures

class IntervalTreeTests: XCTestCase {
    
    func testInitWithOffsetsTwoValues() {
        let offsets = [0,8]
        let intervalTree = IntervalTree(offsets: offsets)
        let expected = IntervalTree.leaf(Interval(0,8))
        XCTAssert(intervalTree == expected)
    }

    func testInitWithOffsetsThreeValues() {
        let offsets = [0,8,11]
        let intervalTree = IntervalTree(offsets: offsets)
        let expected = IntervalTree.branch(Interval(0,11), [
            .leaf(Interval(0,8)),
            .leaf(Interval(8,11))
        ])
        XCTAssert(intervalTree == expected)
    }

    func testInitWithOffsetsFourValues() {
        let offsets = [0,8,11,14]
        let intervalTree = IntervalTree(offsets: offsets)
        let expected = IntervalTree.branch(Interval(0,14), [
            .branch(Interval(0,11), [
                .leaf(Interval(0,8)),
                .leaf(Interval(8,11))
            ]),
            .leaf(Interval(11,14))
        ])
        XCTAssert(intervalTree == expected)
    }

    func testInitWithManyOffsets() {
        let offsets = [0,8,11,14,20,23,25,31,45]
        let intervalTree = IntervalTree(offsets: offsets)
        let expected = IntervalTree.branch(Interval(0,45), [
            .branch(Interval(0,20), [
                .branch(Interval(0,11), [
                    .leaf(Interval(0,8)),
                    .leaf(Interval(8,11))
                ]),
                .branch(Interval(11,20), [
                    .leaf(Interval(11,14)),
                    .leaf(Interval(14,20))
                ])
            ]),
            .branch(Interval(20,45), [
                .branch(Interval(20,25), [
                    .leaf(Interval(20,23)),
                    .leaf(Interval(23,25))
                ]),
                .branch(Interval(25,45), [
                    .leaf(Interval(25,31)),
                    .leaf(Interval(31,45))
                ])
            ])
        ])
        XCTAssert(intervalTree == expected)
    }

    func testIntervalContainingOffset() {
        let intervalTree = IntervalTree.branch(Interval(0,45), [
            .branch(Interval(0,20), [
                .branch(Interval(0,11), [
                    .leaf(Interval(0,8)),
                    .leaf(Interval(8,11))
                ]),
                .branch(Interval(11,20), [
                    .leaf(Interval(11,14)),
                    .leaf(Interval(14,20))
                ])
            ]),
            .branch(Interval(20,45), [
                .branch(Interval(20,25), [
                    .leaf(Interval(20,23)),
                    .leaf(Interval(23,25))
                ]),
                .branch(Interval(25,45), [
                    .leaf(Interval(25,31)),
                    .leaf(Interval(31,45))
                ])
            ])
        ])
        let offset = 19
        let expected = Interval(14,20)
        XCTAssertEqual(intervalTree.interval(containing: offset), expected)
    }
}
