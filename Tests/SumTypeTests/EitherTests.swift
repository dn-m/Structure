//
//  EitherTests.swift
//  SumTypeTests
//
//  Created by James Bean on 5/17/18.
//

import XCTest
import SumType

class EitherTests: XCTestCase {
    
    func testEquatable() {
        let a: Either<Int,String> = .left(0)
        let b: Either<Int,String> = .left(0)
        XCTAssertEqual(a,b)
    }
}
