//
//  StringExtensionsTests.swift
//  Structure
//
//  Created by James Bean on 1/16/17.
//
//

import XCTest
import Structure

class StringExtensionsTests: XCTestCase {

    func testHeadTailNil() {
        let string = ""
        XCTAssertNil(string.destructured)
    }

    func testHeadTailSingleCharacterNotNil() {
        let string = "1"
        guard let (head, tail) = string.destructured else { XCTFail(); return }
        XCTAssertEqual(head, "1")
        XCTAssertEqual(tail, "")
    }

    func testHeadTailMultipleCharactersNotNil() {
        let string = "123"
        guard let (head, tail) = string.destructured else { XCTFail(); return }
        XCTAssertEqual(head, "1")
        XCTAssertEqual(tail, "23")
    }

    func testSubscriptCharacterNil() {
        let string = ""
        let newVal: Character? = string[0]
        XCTAssertNil(newVal)
    }

    func testSubscriptCharacterValid() {
        let string = "string"
        let newVal: Character? = string[4]
        XCTAssertEqual(newVal!, Character("n"))
    }

    func testSubscriptStringNil() {
        let string = ""
        let newVal: String? = string[0]
        XCTAssertNil(newVal)
    }

    func testSubscriptStringValid() {
        let string = "string"
        let newVal: String? = string[2]
        XCTAssertEqual(newVal, "r")
    }

    func testIndentSingleLine() {
        var string = "abc"
        string.indent(prefix: "  ")
        XCTAssertEqual(string, "  abc\n")
    }

    func testIndentedSeveralLines() {
        var string = "abc\ndef\nghi\njkl"
        string.indent(prefix: "  ")
        XCTAssertEqual(string, "  abc\n  def\n  ghi\n  jkl\n")
    }

    func testPerformanceMutableBigFile() {

        var lines = (0..<1000)
            .map { _ in "abcdefghijklmnopqrstuvwxyz" }
            .joined(separator: "\n")

        measure { lines.indent(prefix: "  ") }
    }

    func testPerformanceImmutableBigFile() {

        let lines = (0..<1000)
            .map { _ in "abcdefghijklmnopqrstuvwxyz" }
            .joined(separator: "\n")

        measure { _ = lines.indented(prefix: "  ") }
    }
}
