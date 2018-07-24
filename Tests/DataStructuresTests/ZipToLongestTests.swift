//
//  ZipToLongestTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 7/24/18.
//

import XCTest
import DataStructures

class ZipToLongestTests: XCTestCase {

    func testEqualLengths() {
        let zipped = zip([1,4,7], [2,5,8], [3,6,9], fill: 0).map { $0 }
        let expected = [(1,2,3),(4,5,6),(7,8,9)]
        zip(zipped,expected).forEach {
            XCTAssertEqual($0.0, $1.0)
            XCTAssertEqual($0.1, $1.1)
            XCTAssertEqual($0.2, $1.2)
        }
    }

    func testFirstLonger() {
        let zipped = zip([1,4,7], [2,5], [3,6], fill: 0).map { $0 }
        let expected = [(1,2,3),(4,5,6),(7,0,0)]
        zip(zipped,expected).forEach {
            XCTAssertEqual($0.0, $1.0)
            XCTAssertEqual($0.1, $1.1)
            XCTAssertEqual($0.2, $1.2)
        }
    }

    func testSecondLonger() {
        let zipped = zip([1,4], [2,5,8], [3,6], fill: 0).map { $0 }
        let expected = [(1,2,3),(4,5,6),(0,8,0)]
        zip(zipped,expected).forEach {
            XCTAssertEqual($0.0, $1.0)
            XCTAssertEqual($0.1, $1.1)
            XCTAssertEqual($0.2, $1.2)
        }
    }

    func testThirdLonger() {
        let zipped = zip([1,4], [2,5], [3,6,9], fill: 0).map { $0 }
        let expected = [(1,2,3),(4,5,6),(0,0,9)]
        zip(zipped,expected).forEach {
            XCTAssertEqual($0.0, $1.0)
            XCTAssertEqual($0.1, $1.1)
            XCTAssertEqual($0.2, $1.2)
        }
    }
}
