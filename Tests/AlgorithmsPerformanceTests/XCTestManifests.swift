import XCTest

extension StableSortPerformanceTests {
    static let __allTests = [
        ("testStableSort_O_nlogn", testStableSort_O_nlogn),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(StableSortPerformanceTests.__allTests),
    ]
}
#endif
