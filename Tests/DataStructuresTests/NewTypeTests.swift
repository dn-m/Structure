//
//  NewTypeTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 8/20/18.
//

import XCTest
import DataStructures

class NewTypeTests: XCTestCase {

    func testExpressibleByIntegerLiteral() {
        struct I: NewType, ExpressibleByIntegerLiteral { let value: Int }
        let _: I = 42
    }

    func testExpressibleByFloatLiteral() {
        struct F: NewType, ExpressibleByFloatLiteral { let value: Double }
        let _: F = 42.0
    }

    func testNumeric() {
        struct N: NewType, Numeric { let value: Double }
        let a: N = 42
        let b: N = 9000
        let _ = a + b
        let _ = a - b
        let _ = a * b
    }

    func testSignedNumeric() {
        struct SN: NewType, SignedNumeric { let value: Int }
        let n: SN = 1
        let _ = -n
    }

    func testSequence() {
        struct S: NewType, Sequence { let value: [Int] }
        let s = S([1,2,3])
        let _ = s.map { $0 }
    }
}
