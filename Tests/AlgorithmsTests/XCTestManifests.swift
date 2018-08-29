import XCTest

extension CombinatoricsTests {
    static let __allTests = [
        ("testCartesianProductOfTwoArrays", testCartesianProductOfTwoArrays),
        ("testPermutations", testPermutations),
        ("testPermutationsEmpty", testPermutationsEmpty),
    ]
}

extension OrderedTests {
    static let __allTests = [
        ("testOrderedEqual", testOrderedEqual),
        ("testOrderInOrder", testOrderInOrder),
        ("testOrderNeedsOrdering", testOrderNeedsOrdering),
    ]
}

extension RotateTests {
    static let __allTests = [
        ("testRotateBy0", testRotateBy0),
        ("testRotateBy1", testRotateBy1),
        ("testRotateByGreaterThanCount", testRotateByGreaterThanCount),
        ("testRotateByNegative1", testRotateByNegative1),
    ]
}

extension SplitTests {
    static let __allTests = [
        ("testSplitAndExtractEmpty", testSplitAndExtractEmpty),
        ("testSplitAndExtractMutlple", testSplitAndExtractMutlple),
        ("testSplitAndExtractSingle", testSplitAndExtractSingle),
    ]
}

extension StableSortTests {
    static let __allTests = [
        ("testStableSort", testStableSort),
    ]
}

extension SwapTests {
    static let __allTests = [
        ("testImmutableSwapped", testImmutableSwapped),
        ("testImmutableSwappedWithPredicateFalse", testImmutableSwappedWithPredicateFalse),
        ("testImmutableSwappedWithPredicateTrue", testImmutableSwappedWithPredicateTrue),
        ("testInoutSwapWithPredicateFalse", testInoutSwapWithPredicateFalse),
        ("testInoutSwapWithPredicateTrue", testInoutSwapWithPredicateTrue),
    ]
}

extension TupleMapTests {
    static let __allTests = [
        ("testMapAB", testMapAB),
        ("testMapABC", testMapABC),
        ("testMapTupleAB", testMapTupleAB),
        ("testMapTupleABC", testMapTupleABC),
    ]
}

extension UnzipTests {
    static let __allTests = [
        ("testEmpty", testEmpty),
        ("testNonEmpty", testNonEmpty),
        ("testPerformance", testPerformance),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CombinatoricsTests.__allTests),
        testCase(OrderedTests.__allTests),
        testCase(RotateTests.__allTests),
        testCase(SplitTests.__allTests),
        testCase(StableSortTests.__allTests),
        testCase(SwapTests.__allTests),
        testCase(TupleMapTests.__allTests),
        testCase(UnzipTests.__allTests),
    ]
}
#endif
