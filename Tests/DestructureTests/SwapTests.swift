//
//  SwapTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Destructure

class SwapTests: XCTestCase {

    func testImmutableSwapped() {

        let a = 0
        let b = 1
        let (newA, newB) = swapped(a,b)

        XCTAssertEqual(newA, b)
        XCTAssertEqual(newB, a)
    }

    func testImmutableSwappedWithPredicateFalse() {

        let a = 0
        let b = 1
        let predicate = { false }
        let (newA, newB, didSwap) = swapped(a, b, if: predicate)

        XCTAssertFalse(didSwap)
        XCTAssertEqual(newA, a)
        XCTAssertEqual(newB, b)
    }

    func testImmutableSwappedWithPredicateTrue() {

        let a = 0
        let b = 1
        let predicate = { true }
        let (newA, newB, didSwap) = swapped(a, b, if: predicate)

        XCTAssert(didSwap)
        XCTAssertEqual(newA, b)
        XCTAssertEqual(newB, a)
    }

    func testInoutSwapWithPredicateFalse() {

        var a = 0
        var b = 1
        let predicate = { false }
        let didSwap = swap(&a, &b, if: predicate)

        XCTAssertFalse(didSwap)
        XCTAssertEqual(a, 0)
        XCTAssertEqual(b, 1)
    }

    func testInoutSwapWithPredicateTrue() {

        var a = 0
        var b = 1
        let predicate = { true }
        let didSwap = swap(&a, &b, if: predicate)

        XCTAssert(didSwap)
        XCTAssertEqual(a, 1)
        XCTAssertEqual(b, 0)
    }
}
