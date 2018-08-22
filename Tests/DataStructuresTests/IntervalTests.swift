//
//  IntervalTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 8/22/18.
//

import XCTest
import DataStructures

class IntervalTests: XCTestCase {

    func testAPI() {
        let _ = Interval(.open(1), .open(5))
        let _ = Interval(.open(1), .closed(5))
        let _ = Interval(.closed(1), .closed(5))
        let _ = Interval(.closed(1), .open(5))
        let _ = .open(1) .. .open(5)
        let _ = .open(1) .. .closed(5)
        let _ = .closed(1) .. .closed(5)
        let _ = .closed(1) .. .open(5)
    }

    func testContainsOpenOpen() {
        let interval = Interval(.open(1), .open(3))
        XCTAssertFalse(interval.contains(1))
        XCTAssertTrue(interval.contains(2))
        XCTAssertFalse(interval.contains(3))
    }

    func testContainsOpenClosed() {
        let interval = Interval(.open(1), .closed(3))
        XCTAssertFalse(interval.contains(1))
        XCTAssertTrue(interval.contains(2))
        XCTAssertTrue(interval.contains(3))
    }

    func testContainsClosedClosed() {
        let interval = Interval(.closed(1), .closed(3))
        XCTAssertTrue(interval.contains(1))
        XCTAssertTrue(interval.contains(2))
        XCTAssertTrue(interval.contains(3))
    }

    func testContainsClosedOpen() {
        let interval = Interval(.closed(1), .open(3))
        XCTAssertTrue(interval.contains(1))
        XCTAssertTrue(interval.contains(2))
        XCTAssertFalse(interval.contains(3))
    }
}
