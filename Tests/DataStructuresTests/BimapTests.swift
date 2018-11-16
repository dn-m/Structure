//
//  BimapTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 8/31/18.
//

import XCTest
import DataStructures

class BimapTests: XCTestCase {

    func testInitEmpty() {
        let bimap: Bimap<Int,Int> = [:]
        XCTAssertEqual(bimap.count, 0)
        XCTAssert(bimap.isEmpty)
    }

    func testKeySubscript() {
        var bimap: Bimap<Int,Int> = [:]
        bimap[key: 0] = 10
        XCTAssertEqual(bimap[key: 0], 10)
    }

    func testValueSubscript() {
        var bimap: Bimap<Int,Int> = [:]
        bimap[value: 10] = 0
        XCTAssertEqual(bimap[value: 10], 0)
    }

    func testUpdateValue() {
        var bimap: Bimap = [0: 10, 1: 11, 2: 12, 3: 13]
        bimap.updateValue(111, forKey: 1)
        XCTAssertEqual(bimap[key: 0], 10)
        XCTAssertEqual(bimap[key: 1], 111)
        XCTAssertEqual(bimap[key: 2], 12)
        XCTAssertEqual(bimap[key: 3], 13)
    }

    func testUpdateKey() {
        var bimap: Bimap = [10: 0, 11: 1, 12: 2, 13: 3]
        bimap.updateKey(111, forValue: 1)
        XCTAssertEqual(bimap[value: 0], 10)
        XCTAssertEqual(bimap[value: 1], 111)
        XCTAssertEqual(bimap[value: 2], 12)
        XCTAssertEqual(bimap[value: 3], 13)
    }

    func testRemoveValue() {
        var bimap: Bimap = [0: 10, 1: 11, 2: 12, 3: 13]
        bimap.removeValue(forKey: 1)
        XCTAssertEqual(bimap[key: 0], 10)
        XCTAssertEqual(bimap[key: 1], nil)
        XCTAssertEqual(bimap[key: 2], 12)
        XCTAssertEqual(bimap[key: 3], 13)
    }

    func testRemoveKey() {
        var bimap: Bimap = [10: 0, 11: 1, 12: 2, 13: 3]
        bimap.removeKey(forValue: 1)
        XCTAssertEqual(bimap[value: 0], 10)
        XCTAssertEqual(bimap[value: 1], nil)
        XCTAssertEqual(bimap[value: 2], 12)
        XCTAssertEqual(bimap[value: 3], 13)
    }

    func testRemoveAll() {
        var bimap: Bimap = [0: 0, 1: 1, 2: 2, 3: 3]
        bimap.removeAll()
        XCTAssertEqual(bimap.count, 0)
        XCTAssert(bimap.isEmpty)
    }
    
    func testCompose() {
        let bimap1: Bimap = [0: "a", 2: "b"]
        let bimap2: Bimap = ["b": 35, "c": 200]
        let bimap3 = bimap1.compose(with: bimap2)
        XCTAssertEqual(bimap3, [2: 35])
    }
    
    func testComposeOperator() {
        let bimap1: Bimap = [0: "Test", 1: "Operator"]
        let bimap2: Bimap = ["Good": "A", "Idea": "to", "Test": "That"]
        let bimap3 = bimap1 * bimap2
        XCTAssertEqual(bimap3, [0: "That"])
    }
}
