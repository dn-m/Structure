////
////  SequenceWrappingTests.swift
////  Collections
////
////  Created by James Bean on 12/9/16.
////
////
//
//import XCTest
//import Structure
//
//class SequenceWrappingTests: XCTestCase {
//
//    struct TestSequence: SequenceWrapping {
//
//        typealias Element = Int
//
//        var sequence: AnySequence<Int> {
//            return AnySequence(array)
//        }
//
//        let array: [Int]
//
//        init <S: Sequence> (_ sequence: S) where S.Iterator.Element == Element {
//            self.array = Array(sequence)
//        }
//
//        init(arrayLiteral elements: Int...) {
//            self.array = Array(elements)
//        }
//    }
//
//    func testIterator() {
//        let ts = TestSequence([1,2,3])
//        XCTAssertEqual(ts.map { $0 }, [1,2,3])
//    }
//}

