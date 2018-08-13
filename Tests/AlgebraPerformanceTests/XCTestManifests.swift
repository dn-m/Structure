import XCTest

extension AccumulatePerformanceTests {
    static let __allTests = [
        ("testAccumulatingProductLinear", testAccumulatingProductLinear),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AccumulatePerformanceTests.__allTests),
    ]
}
#endif
