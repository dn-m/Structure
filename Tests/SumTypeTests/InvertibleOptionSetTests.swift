//
//  InvertibleOptionSetTests.swift
//  SumTypeTests
//
//  Created by James Bean on 7/29/17.
//

import XCTest
import SumType

class InvertibleOptionSetTests: XCTestCase {

    struct EvenCountInvertibleSet: InvertibleOptionSet {

        static let a = EvenCountInvertibleSet(rawValue: 1 << 0)
        static let b = EvenCountInvertibleSet(rawValue: 1 << 1)
        static let c = EvenCountInvertibleSet(rawValue: 1 << 2)
        static let d = EvenCountInvertibleSet(rawValue: 1 << 3)

        var optionsCount: Int {
            return 4
        }

        var rawValue: Int

        init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    struct OddCountInvertibleSet: InvertibleOptionSet {

        static let a = OddCountInvertibleSet(rawValue: 1 << 0)
        static let b = OddCountInvertibleSet(rawValue: 1 << 1)
        static let c = OddCountInvertibleSet(rawValue: 1 << 2)
        static let d = OddCountInvertibleSet(rawValue: 1 << 3)
        static let e = OddCountInvertibleSet(rawValue: 1 << 4)

        var optionsCount: Int {
            return 5
        }

        var rawValue: Int

        init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    func testEvenAInverseOfD() {

        let a = EvenCountInvertibleSet.a
        let d = EvenCountInvertibleSet.d

        XCTAssertEqual(a.inverse, d)
        XCTAssertEqual(d.inverse, a)
    }

    func testEvenBInverseOfC() {

        let b = EvenCountInvertibleSet.b
        let c = EvenCountInvertibleSet.c

        XCTAssertEqual(b.inverse, c)
        XCTAssertEqual(c.inverse, b)
    }

    func testOddAInverseOfE() {

        let a = OddCountInvertibleSet.a
        let e = OddCountInvertibleSet.e

        XCTAssertEqual(a.inverse, e)
        XCTAssertEqual(e.inverse, a)
    }

    func testOddBInverseOfD() {

        let b = OddCountInvertibleSet.b
        let d = OddCountInvertibleSet.d

        XCTAssertEqual(b.inverse, d)
        XCTAssertEqual(d.inverse, b)
    }

    func testOddCInverseOfC() {
        let c = OddCountInvertibleSet.c
        XCTAssertEqual(c.inverse, c)
    }
}
