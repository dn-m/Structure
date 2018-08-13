import XCTest

extension BinaryHeapPerformanceTests {
    static let __allTests = [
        ("testInsert_O_1", testInsert_O_1),
        ("testPop_O_1", testPop_O_1),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BinaryHeapPerformanceTests.__allTests),
    ]
}
#endif
