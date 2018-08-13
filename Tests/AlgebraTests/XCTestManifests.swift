import XCTest

extension AccumulateTests {
    static let __allTests = [
        ("testAccumulatingProduct", testAccumulatingProduct),
        ("testFloatArrayAccumulatingSum", testFloatArrayAccumulatingSum),
        ("testIntArrayAccumulatingSum", testIntArrayAccumulatingSum),
    ]
}

extension SequenceAlgebraTests {
    static let __allTests = [
        ("testSetIntersections", testSetIntersections),
        ("testSumOfAdditiveSemigroup", testSumOfAdditiveSemigroup),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AccumulateTests.__allTests),
        testCase(SequenceAlgebraTests.__allTests),
    ]
}
#endif
