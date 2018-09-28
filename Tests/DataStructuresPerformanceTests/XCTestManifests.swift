import XCTest

extension BinaryHeapPerformanceTests {
    static let __allTests = [
        ("testInsert_O_1", testInsert_O_1),
        ("testPop_O_1", testPop_O_1),
    ]
}

extension QueuePerformanceTests {
    static let __allTests = [
        ("testDequeue_O_n", testDequeue_O_n),
        ("testEnqueue_O_1", testEnqueue_O_1),
        ("testIsEmpty_O_1", testIsEmpty_O_1),
        ("testPeek_O_1", testPeek_O_1),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BinaryHeapPerformanceTests.__allTests),
        testCase(QueuePerformanceTests.__allTests),
    ]
}
#endif
