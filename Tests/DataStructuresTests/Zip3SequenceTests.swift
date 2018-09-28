//
//  Zip3SequenceTests.swift
//  Structure
//
//  Created by James Bean on 2/13/17.
//
//

import XCTest
import DataStructures

class Zip3SequenceTests: XCTestCase {

    func testZip3Sequence() {

        let a = [1,2,3]
        let b = [1,2,3]
        let c = [1,2,3]

        zip(a,b,c).forEach { a,b,c in
            XCTAssertEqual(a,b)
            XCTAssertEqual(b,c)
        }
    }

    func testMany() {
        let a = (0..<1_000_000)
        let b = a.reversed()
        let c = zip(a,b).map(*)
        _ = zip(a,b,c).map { $0 }
    }
}
