//
//  BinarySearchTreeTests.swift
//  DataStructuresTests
//
//  Created by James Bean on 9/1/18.
//

import XCTest
import DataStructures

class BinarySearchTreeTests: XCTestCase {

    func testInitSequence() {
        let bst: BinarySearchTree<Int> = [5,1,4,3,2,6,7]
        XCTAssertEqual(bst.inOrder, [1,2,3,4,5,6,7])
    }
}
