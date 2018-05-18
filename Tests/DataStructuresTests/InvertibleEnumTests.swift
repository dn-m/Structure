//
//  InvertibleEnumTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 5/18/18.
//

import XCTest
import DataStructures

class InvertibleEnumTests: XCTestCase {

    enum OddCountEnum: InvertibleEnum {
        case one
        case two
        case three
        case four
        case five
    }

    enum EvenCountEnum: InvertibleEnum {
        case one
        case two
        case three
        case four
        case five
        case six
    }

    func testOddCountInverse() {
        let one = OddCountEnum.one
        let expected = OddCountEnum.five
        XCTAssertEqual(one.inverse, expected)
    }

    func testEventCountInverse() {
        let one = EvenCountEnum.one
        let expected = EvenCountEnum.six
        XCTAssertEqual(one.inverse, expected)
    }
}
