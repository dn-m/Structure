//
//  MatrixTests.swift
//  Structure
//
//  Created by James Bean on 12/10/16.
//
//

import XCTest
import DataStructures

class MatrixTests: XCTestCase {

    func testInit() {
        let amountRows = 2
        let amountColumns = 3
        let matrix = Matrix(height: amountRows, width: amountColumns, initial: 0)
        for row in 0 ..< amountRows {
            for column in 0 ..< amountColumns {
                XCTAssertEqual(matrix[row, column], 0)
            }
        }
    }

    func testSubscript() {
        var matrix = Matrix(height: 2, width: 3, initial: 0)
        matrix[1,2] = 1
        XCTAssertEqual(matrix[1,2], 1)
    }

    func testSequence() {
        let matrix = Matrix(height: 3, width: 3, initial: 0)
        XCTAssertEqual(matrix.map { $0 }.count, 9)
    }

    func testEquivalenceTrue() {
        var a = Matrix(height: 2, width: 3, initial: 0)
        var b = Matrix(height: 2, width: 3, initial: 0)
        a[1,2] = 1
        b[1,2] = 1
        XCTAssertEqual(a,b)
    }

    func testEquivalenceFalse() {
        var a = Matrix(height: 2, width: 3, initial: 0)
        var b = Matrix(height: 2, width: 3, initial: 0)
        a[1,2] = 1
        b[1,2] = 0
        XCTAssertNotEqual(a,b)
    }

    func testRowsAndColumns() {
        var matrix = Matrix(height: 2, width: 2, initial: "")
        matrix[0,0] = "top left"
        matrix[0,1] = "top right"
        matrix[1,0] = "bottom left"
        matrix[1,1] = "bottom right"
        XCTAssertEqual(matrix.rows[0], ["top left", "top right"])
        XCTAssertEqual(matrix.rows[1], ["bottom left", "bottom right"])
        XCTAssertEqual(matrix.columns[0], ["top left", "bottom left"])
        XCTAssertEqual(matrix.columns[1], ["top right", "bottom right"])
    }

    func testRowAndColumnSubscriptsGetter() {
        var matrix = Matrix(height: 2, width: 2, initial: "")
        matrix[0,0] = "top left"
        matrix[0,1] = "top right"
        matrix[1,0] = "bottom left"
        matrix[1,1] = "bottom right"
        XCTAssertEqual(matrix[row: 0], ["top left", "top right"])
        XCTAssertEqual(matrix[column: 1], ["top right", "bottom right"])
    }

    func testRowAndColumnSubscriptsSetter() {
        var matrix = Matrix(height: 2, width: 2, initial: "")
        matrix[row: 0] = ["top left", "top right"]
        matrix[column: 1] = ["top right", "bottom right"]
        XCTAssertEqual(matrix[row: 0], ["top left", "top right"])
        XCTAssertEqual(matrix[column: 1], ["top right", "bottom right"])
    }

    func testPrint() {
        var matrix = Matrix(height: 2, width: 2, initial: "")
        matrix[0,0] = "top left"
        matrix[0,1] = "top right"
        matrix[1,0] = "bottom left"
        matrix[1,1] = "bottom right"
        print(matrix)
    }
}
