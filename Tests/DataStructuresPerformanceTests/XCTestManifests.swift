import XCTest

extension BinaryHeapPerformanceTests {
    static let __allTests = [
        ("testInsert_O_1", testInsert_O_1),
        ("testPop_O_1", testPop_O_1),
    ]
}

extension DirectedGraphPerformanceTests {
    static let __allTests = [
        ("testEdgesFromNode_O_1", testEdgesFromNode_O_1),
        ("testNeighborsOfNode_O_1", testNeighborsOfNode_O_1),
    ]
}

extension GraphPerformanceTests {
    static let __allTests = [
        ("testEdgeFromSourceInCompleteGraph_O_n", testEdgeFromSourceInCompleteGraph_O_n),
        ("testEdgesFromSourceInGraph_O_n", testEdgesFromSourceInGraph_O_n),
        ("testEdgesFromSourceNotInGraph_O_1", testEdgesFromSourceNotInGraph_O_1),
        ("testEdgesToDestinationInGraph_O_n", testEdgesToDestinationInGraph_O_n),
        ("testEdgesToDestinationNotInGraph_O_1", testEdgesToDestinationNotInGraph_O_1),
        ("testInsertEdge_O_1", testInsertEdge_O_1),
        ("testInsertNode_O_1", testInsertNode_O_1),
        ("testNeighborsOfNodeInGraph_O_n", testNeighborsOfNodeInGraph_O_n),
        ("testNeighborsOfNodeNotInGraph_O_1", testNeighborsOfNodeNotInGraph_O_1),
        ("testProfile", testProfile),
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

extension WeightedDirectedGraphPerformanceTests {
    static let __allTests = [
        ("testEdgesFromNode_O_1", testEdgesFromNode_O_1),
        ("testNeighborsOfNode_O_1", testNeighborsOfNode_O_1),
    ]
}

extension WeightedGraphPerformanceTests {
    static let __allTests = [
        ("testNeighborsOfNode_O_1", testNeighborsOfNode_O_1),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BinaryHeapPerformanceTests.__allTests),
        testCase(DirectedGraphPerformanceTests.__allTests),
        testCase(GraphPerformanceTests.__allTests),
        testCase(QueuePerformanceTests.__allTests),
        testCase(WeightedDirectedGraphPerformanceTests.__allTests),
        testCase(WeightedGraphPerformanceTests.__allTests),
    ]
}
#endif
