import XCTest

extension DestructureTests {
    static let __allTests = [
        ("testArrayDestructured", testArrayDestructured),
        ("testArrayDestructuredNil", testArrayDestructuredNil),
        ("testArraySliceDestructured", testArraySliceDestructured),
        ("testArraySliceDestructuredNil", testArraySliceDestructuredNil),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DestructureTests.__allTests),
    ]
}
#endif
