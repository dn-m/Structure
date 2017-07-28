//
//  StableSortTests.swift
//  Structure
//
//  Created by James Bean on 12/23/16.
//
//

import XCTest
import Algorithms

class StableSortTests: XCTestCase {

    struct S {
        let a: Int
        let b: Int
        init(_ a: Int, _ b: Int) {
            self.a = a
            self.b = b
        }
    }

    func testStableSort() {

        let items = [
            (2,0), (1,1), (1,2),
            (1,0), (0,2), (0,0),
            (2,2), (0,1), (2,1)
        ].map(S.init)

        let sortA = items.stableSort { $0.a < $1.a }
        XCTAssertEqual(sortA.map { $0.a }, [0,0,0,1,1,1,2,2,2])

        let sortB = sortA.stableSort { $0.b < $1.b }
        XCTAssertEqual(sortB.map { $0.b }, [0,0,0,1,1,1,2,2,2])

        let sortA2 = sortB.stableSort { $0.a < $1.a }
        XCTAssertEqual(sortA2.map { $0.a }, [0,0,0,1,1,1,2,2,2])
        XCTAssertEqual(sortA2.map { $0.b }, [0,1,2,0,1,2,0,1,2])
    }
}
