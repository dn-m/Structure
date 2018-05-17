//
//  IntervalRelationTests.swift
//  SumTypeTests
//
//  Created by James Bean on 5/17/18.
//

import XCTest
import DataStructures

class IntervalRelationTests: XCTestCase {

    func testPrecedes() {

        let a = 1...2
        let b = 4...5

        XCTAssertEqual(a.relation(with: b), .precedes)
    }

    func testMeets() {

        let a = 1...2
        let b = 2...3

        XCTAssertEqual(a.relation(with: b), .meets)
    }

    func testOverlaps() {

        let a = 1...3
        let b = 2...4

        XCTAssertEqual(a.relation(with: b), .overlaps)
    }


    func testFinishedBy() {

        let a = 1...4
        let b = 3...4

        XCTAssertEqual(a.relation(with: b), .finishedBy)
    }

    func testContains() {

        let a = 1...4
        let b = 2...3

        XCTAssertEqual(a.relation(with: b), .contains)
    }

    func testStarts() {

        let a = 1...2
        let b = 1...4

        XCTAssertEqual(a.relation(with: b), .starts)
    }

    func testEquals() {

        let a = 1...2
        let b = 1...2

        XCTAssertEqual(a.relation(with: b), .equals)
        XCTAssertEqual(b.relation(with: a), .equals)
    }

    func testStartedBy() {

        let a = 1...4
        let b = 1...2

        XCTAssertEqual(a.relation(with: b), .startedBy)
    }

    func testDuring() {

        let a = 2...3
        let b = 1...4

        XCTAssertEqual(a.relation(with: b), .containedBy)
    }

    func testFinishes() {

        let a = 3...4
        let b = 1...4

        XCTAssertEqual(a.relation(with: b), .finishes)
    }

    func testOverlappedBy() {

        let a = 2...4
        let b = 1...3

        XCTAssertEqual(a.relation(with: b), .overlappedBy)
    }

    func testMetBy() {

        let a = 2...3
        let b = 1...2

        XCTAssertEqual(a.relation(with: b), .metBy)
    }

    func testPrecededBy() {

        let a = 4...5
        let b = 1...2

        XCTAssertEqual(a.relation(with: b), .precededBy)
    }

    func testInverseOfEqualsIsEquals() {

        let equals = IntervalRelation.equals

        XCTAssertEqual(equals.inverse, equals)
    }

    func testInverseOfPrecedesIsPrecededBy() {

        let precedes = IntervalRelation.precedes
        let precededBy = IntervalRelation.precededBy

        XCTAssertEqual(precedes.inverse, precededBy)
        XCTAssertEqual(precededBy.inverse, precedes)
    }

    func testInverseOfContainedByIsContains() {

        let contains = IntervalRelation.contains
        let containedBy = IntervalRelation.containedBy

        XCTAssertEqual(containedBy.inverse, contains)
        XCTAssertEqual(contains.inverse, containedBy)
    }
}
