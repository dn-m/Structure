//
//  IntervalRelationTests.swift
//  SumTypeTests
//
//  Created by James Bean on 5/17/18.
//

import XCTest
import DataStructures

class IntervalRelationTests: XCTestCase {
    
    func testInverse() {
        let precedes = IntervalRelation.precedes
        let precededBy = precedes.inverse
        XCTAssertEqual(.precededBy, precededBy)
    }
}
