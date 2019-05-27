import XCTest

extension CombinatoricsPerformanceTests {
    static let __allTests = [
        ("testCartesianProduct_O_n", testCartesianProduct_O_n),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CombinatoricsPerformanceTests.__allTests),
    ]
}
#endif
