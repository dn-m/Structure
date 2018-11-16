import XCTest

extension AVLTreeTests {
    static let __allTests = [
        ("testInitSequence", testInitSequence),
        ("testManyValuesDecreasing", testManyValuesDecreasing),
        ("testManyValuesIncreasing", testManyValuesIncreasing),
        ("testManyValuesRandom", testManyValuesRandom),
        ("testSingleNodeHeight", testSingleNodeHeight),
        ("testThreeNodes", testThreeNodes),
        ("testTwoNodes", testTwoNodes),
    ]
}

extension ArrayExtensionsTests {
    static let __allTests = [
        ("testInsertingAtIndexAtBeginning", testInsertingAtIndexAtBeginning),
        ("testInsertingAtIndexAtEnd", testInsertingAtIndexAtEnd),
        ("testInsertingAtIndexInMiddle", testInsertingAtIndexInMiddle),
        ("testLastAmountEmpty", testLastAmountEmpty),
        ("testLastAmountEquiv", testLastAmountEquiv),
        ("testLastAmountTooMany", testLastAmountTooMany),
        ("testLastAmountValid", testLastAmountValid),
        ("testPenultimateNil", testPenultimateNil),
        ("testPenultimateValid", testPenultimateValid),
        ("testReplaceElementAtIndex", testReplaceElementAtIndex),
        ("testReplaceFirst", testReplaceFirst),
        ("testReplaceLast", testReplaceLast),
        ("testSafeSubscriptNil", testSafeSubscriptNil),
        ("testSafeSubscriptValid", testSafeSubscriptValid),
        ("testSecondNil", testSecondNil),
        ("testSecondVaild", testSecondVaild),
    ]
}

extension BimapTests {
    static let __allTests = [
        ("testInitEmpty", testInitEmpty),
        ("testKeySubscript", testKeySubscript),
        ("testRemoveAll", testRemoveAll),
        ("testRemoveKey", testRemoveKey),
        ("testRemoveValue", testRemoveValue),
        ("testUpdateKey", testUpdateKey),
        ("testUpdateValue", testUpdateValue),
        ("testValueSubscript", testValueSubscript),
        ("testCompose", testCompose),
        ("testComposeOperator", testComposeOperator),
    ]
}

extension BinaryHeapTests {
    static let __allTests = [
        ("testBalance", testBalance),
        ("testBasicInsertPop", testBasicInsertPop),
        ("testPopNil", testPopNil),
        ("testSimpleBalance", testSimpleBalance)
    ]
}

extension BinarySearchTreeTests {
    static let __allTests = [
        ("testInitSequence", testInitSequence),
    ]
}

extension CircularArrayTests {
    static let __allTests = [
        ("testCollection", testCollection),
        ("testElementAtTheEnd", testElementAtTheEnd),
        ("testElementAtZero", testElementAtZero),
        ("testElementInTheMiddle", testElementInTheMiddle),
        ("testElementOutOfNormalBounds", testElementOutOfNormalBounds),
        ("testEquatable", testEquatable),
        ("testRangeAfterUpToOutOfOrderOverflow", testRangeAfterUpToOutOfOrderOverflow),
        ("testRangeInOrderOverflow", testRangeInOrderOverflow),
        ("testRangeInOrderWithinBounds", testRangeInOrderWithinBounds),
        ("testRangeOutOfOrderOverflow", testRangeOutOfOrderOverflow),
        ("testReversed", testReversed),
        ("testSequence", testSequence),
    ]
}

extension ContiguousSegmentCollectionTests {
    static let __allTests = [
        ("testContains", testContains),
        ("testFragmentA", testFragmentA),
        ("testFragmentB", testFragmentB),
        ("testFragmentC", testFragmentC),
        ("testFragmentD", testFragmentD),
        ("testFragmentE", testFragmentE),
        ("testFragmentF", testFragmentF),
        ("testFragmentG", testFragmentG),
        ("testFragmentH", testFragmentH),
        ("testFragmentI", testFragmentI),
        ("testFragmentOfFragmentBodyBody", testFragmentOfFragmentBodyBody),
        ("testFragmentOfFragmentBodyTail", testFragmentOfFragmentBodyTail),
        ("testFragmentOfFragmentHeadBody", testFragmentOfFragmentHeadBody),
        ("testFragmentOfFragmentHeadHead", testFragmentOfFragmentHeadHead),
        ("testFragmnetOfFragmentTailTail", testFragmnetOfFragmentTailTail),
        ("testInitSegments", testInitSegments),
        ("testLength", testLength),
        ("testOffsets", testOffsets),
        ("testRandomAccess", testRandomAccess),
        ("testSegments", testSegments),
    ]
}

extension CrossTests {
    static let __allTests = [
        ("testComparableFalseEqual", testComparableFalseEqual),
        ("testComparableLexicographic", testComparableLexicographic),
        ("testComparableLexicographicFalse", testComparableLexicographicFalse),
        ("testMap", testMap),
    ]
}

extension DictionaryProtocolsTests {
    static let __allTests = [
        ("testDictionaryInitWithArrayOfTuples", testDictionaryInitWithArrayOfTuples),
        ("testDictionaryInitWithArrays", testDictionaryInitWithArrays),
        ("testEnsureDictionaryTypeValueNotYetExtant", testEnsureDictionaryTypeValueNotYetExtant),
        ("testEnsureDictionaryTypeValuePreexisting", testEnsureDictionaryTypeValuePreexisting),
        ("testEnsureRangeReplaceableCollectionValueForKeyNotYetExtant", testEnsureRangeReplaceableCollectionValueForKeyNotYetExtant),
        ("testEnsureRangeReplaceableCollectionValueForKeyPreexisting", testEnsureRangeReplaceableCollectionValueForKeyPreexisting),
        ("testEnsureSetAlgebraValueForKeyNotYetExtant", testEnsureSetAlgebraValueForKeyNotYetExtant),
        ("testEnsureSetAlgebraValueForKeyPreexisting", testEnsureSetAlgebraValueForKeyPreexisting),
        ("testEqualitySimple", testEqualitySimple),
        ("testMergedNestedDict", testMergedNestedDict),
        ("testMergedNewDictOvercomesOriginal", testMergedNewDictOvercomesOriginal),
        ("testMergeNestedDict", testMergeNestedDict),
        ("testMergeNewDictOvercomesOriginal", testMergeNewDictOvercomesOriginal),
        ("testSafelyAndUniquelyAppendValueNotExtant", testSafelyAndUniquelyAppendValueNotExtant),
        ("testSafelyAndUniquelyAppendValuePreexisting", testSafelyAndUniquelyAppendValuePreexisting),
        ("testSafelyAppendContentsToExisting", testSafelyAppendContentsToExisting),
        ("testSafelyAppendContentsToNotYetExtant", testSafelyAppendContentsToNotYetExtant),
        ("testSafelyAppendToExisting", testSafelyAppendToExisting),
        ("testSafelyAppendToNotYetExisting", testSafelyAppendToNotYetExisting),
        ("testSafelyFormUnionExisting", testSafelyFormUnionExisting),
        ("testSafelyFormUnionNotYetExtant", testSafelyFormUnionNotYetExtant),
        ("testSafelyInsertToExisting", testSafelyInsertToExisting),
        ("testSafelyInsertToNotYetExisting", testSafelyInsertToNotYetExisting),
    ]
}

extension DirectedGraphTests {
    static let __allTests = [
        ("testDirectedGraphInsertNodes", testDirectedGraphInsertNodes),
        ("testEdgesFromNode", testEdgesFromNode),
        ("testShortestPathThreeNodes", testShortestPathThreeNodes),
        ("testShortestUnweightedPathSingleNode", testShortestUnweightedPathSingleNode),
        ("testShortestUnweightedPathTwoDirectionallyConnectedNodes", testShortestUnweightedPathTwoDirectionallyConnectedNodes),
        ("testShortestUnweightedPathTwoUnconnectedNodes", testShortestUnweightedPathTwoUnconnectedNodes),
    ]
}

extension EitherTests {
    static let __allTests = [
        ("testEquatable", testEquatable),
    ]
}

extension GraphTests {
    static let __allTests = [
        ("testBreadthFirstSearch", testBreadthFirstSearch),
        ("testEdgesCount", testEdgesCount),
        ("testInsertNodes", testInsertNodes),
        ("testNeighbors", testNeighbors),
        ("testNeighborsInSet", testNeighborsInSet),
        ("testNodesCount", testNodesCount),
        ("testRemoveEdge", testRemoveEdge),
    ]
}

extension HomogeneityTests {
    static let __allTests = [
        ("testIsHeterogeneousFalse", testIsHeterogeneousFalse),
        ("testIsHomoegeneous", testIsHomoegeneous),
        ("testIsHomogeneousFail", testIsHomogeneousFail),
        ("testIsHomogenousEmptyTrue", testIsHomogenousEmptyTrue),
        ("testIsHomogenousSingleElementTrue", testIsHomogenousSingleElementTrue),
    ]
}

extension IntervalRelationTests {
    static let __allTests = [
        ("testContains", testContains),
        ("testDuring", testDuring),
        ("testEquals", testEquals),
        ("testFinishedBy", testFinishedBy),
        ("testFinishes", testFinishes),
        ("testInverseOfContainedByIsContains", testInverseOfContainedByIsContains),
        ("testInverseOfEqualsIsEquals", testInverseOfEqualsIsEquals),
        ("testInverseOfPrecedesIsPrecededBy", testInverseOfPrecedesIsPrecededBy),
        ("testMeets", testMeets),
        ("testMetBy", testMetBy),
        ("testOverlappedBy", testOverlappedBy),
        ("testOverlaps", testOverlaps),
        ("testPrecededBy", testPrecededBy),
        ("testPrecedes", testPrecedes),
        ("testStartedBy", testStartedBy),
        ("testStarts", testStarts),
    ]
}

extension InvertibleEnumTests {
    static let __allTests = [
        ("testEventCountInverse", testEventCountInverse),
        ("testOddCountInverse", testOddCountInverse),
    ]
}

extension LinkedListTests {
    static let __allTests = [
        ("testCollection", testCollection),
        ("testEquatable", testEquatable),
        ("testInitArray", testInitArray),
        ("testInitEmpty", testInitEmpty),
        ("testPop", testPop),
        ("testPopTail", testPopTail),
        ("testPush", testPush),
    ]
}

extension MatrixTests {
    static let __allTests = [
        ("testEquivalenceFalse", testEquivalenceFalse),
        ("testEquivalenceTrue", testEquivalenceTrue),
        ("testInit", testInit),
        ("testPrint", testPrint),
        ("testRowAndColumnSubscriptsGetter", testRowAndColumnSubscriptsGetter),
        ("testRowAndColumnSubscriptsSetter", testRowAndColumnSubscriptsSetter),
        ("testRowsAndColumns", testRowsAndColumns),
        ("testSequence", testSequence),
        ("testSubscript", testSubscript),
    ]
}

extension MetatypeTests {
    static let __allTests = [
        ("testEquatable", testEquatable),
        ("testEquatableFalse", testEquatableFalse),
        ("testHashableEqual", testHashableEqual),
        ("testHashableNotEqual", testHashableNotEqual),
        ("testInit", testInit),
    ]
}

extension MutableGraphTests {
    static let __allTests = [
        ("testBidirectionalRelationshipIsTwoDirectedRelationships", testBidirectionalRelationshipIsTwoDirectedRelationships),
        ("testEdgeBetweenTwoVertices", testEdgeBetweenTwoVertices),
        ("testMultipleAttemptsToAddSameNode", testMultipleAttemptsToAddSameNode),
        ("testSingleVertex", testSingleVertex),
        ("testWeightFromSingleEdge", testWeightFromSingleEdge),
    ]
}

extension NewTypeTests {
    static let __allTests = [
        ("testCollection", testCollection),
        ("testComparable", testComparable),
        ("testExpressibleByFloatLiteral", testExpressibleByFloatLiteral),
        ("testExpressibleByIntegerLiteral", testExpressibleByIntegerLiteral),
        ("testNumeric", testNumeric),
        ("testSequence", testSequence),
        ("testSignedNumeric", testSignedNumeric),
    ]
}

extension OrderedDictionaryTests {
    static let __allTests = [
        ("testAppend", testAppend),
        ("testAppendContentsOfEmptyDict", testAppendContentsOfEmptyDict),
        ("testAppendContentsOfEmptyToNonEmptyDict", testAppendContentsOfEmptyToNonEmptyDict),
        ("testAppendContentsOfNonEmptyToEmptyDict", testAppendContentsOfNonEmptyToEmptyDict),
        ("testEquatable", testEquatable),
        ("testInit", testInit),
        ("testInsert", testInsert),
        ("testIterationOrdered", testIterationOrdered),
        ("testSubscriptIntValid", testSubscriptIntValid),
        ("testSubscriptKeyNil", testSubscriptKeyNil),
        ("testSubscriptKeyValid", testSubscriptKeyValid),
    ]
}

extension OrderedPairTests {
    static let __allTests = [
        ("testMap", testMap),
    ]
}

extension PairsTests {
    static let __allTests = [
        ("testPairs", testPairs),
    ]
}

extension QueueTests {
    static let __allTests = [
        ("testEnqueuedDequeue", testEnqueuedDequeue),
        ("testEnqueuedNotEmpty", testEnqueuedNotEmpty),
        ("testEnqueuedPeekNotNil", testEnqueuedPeekNotNil),
        ("testInitEmpty", testInitEmpty),
        ("testInitPeekNil", testInitPeekNil),
    ]
}

extension ReferenceTreeProtocolTests {
    static let __allTests = [
        ("testAddChild", testAddChild),
        ("testAddChildrenArray", testAddChildrenArray),
        ("testAddChildrenVariadic", testAddChildrenVariadic),
        ("testAncestorAtDistanceGrandchild", testAncestorAtDistanceGrandchild),
        ("testAncestorAtDistanceOnlyChild", testAncestorAtDistanceOnlyChild),
        ("testAncestorAtDistanceSingleNil", testAncestorAtDistanceSingleNil),
        ("testAncestorAtDistanceSingleValid", testAncestorAtDistanceSingleValid),
        ("testChildAtIndexNil", testChildAtIndexNil),
        ("testChildAtIndexNilEmpty", testChildAtIndexNilEmpty),
        ("testChildAtIndexValidMultiple", testChildAtIndexValidMultiple),
        ("testChildAtIndexValidSingle", testChildAtIndexValidSingle),
        ("testDepthGrandchild_2", testDepthGrandchild_2),
        ("testDepthOnlyChild_1", testDepthOnlyChild_1),
        ("testDepthRoot_1", testDepthRoot_1),
        ("testHasAncestorGrandchild", testHasAncestorGrandchild),
        ("testHasAncestorOnlyChild", testHasAncestorOnlyChild),
        ("testHasAncestorSingleNode", testHasAncestorSingleNode),
        ("testHasChildFalse", testHasChildFalse),
        ("testHasChildFalseEmpty", testHasChildFalseEmpty),
        ("testHasChildTrue", testHasChildTrue),
        ("testHasDescendentFalseSingleNode", testHasDescendentFalseSingleNode),
        ("testHasDescendentGrandparent", testHasDescendentGrandparent),
        ("testHasDescendentParent", testHasDescendentParent),
        ("testHeightGrandparent_2", testHeightGrandparent_2),
        ("testHeightParent_1", testHeightParent_1),
        ("testHeightSingleNode_0", testHeightSingleNode_0),
        ("testInsertChildAtIndexThrows", testInsertChildAtIndexThrows),
        ("testInsertChildAtIndexValidEmpty", testInsertChildAtIndexValidEmpty),
        ("testInsertChildAtIndexValidNotEmpty", testInsertChildAtIndexValidNotEmpty),
        ("testIsContainerFalse", testIsContainerFalse),
        ("testIsContainerTrue", testIsContainerTrue),
        ("testIsLeafFalse", testIsLeafFalse),
        ("testIsLeafTrueLeaf", testIsLeafTrueLeaf),
        ("testIsLeafTrueRoot", testIsLeafTrueRoot),
        ("testIsRootTrueContainer", testIsRootTrueContainer),
        ("testIsRootTrueSingleNode", testIsRootTrueSingleNode),
        ("testLeafAtIndexNilLeaf", testLeafAtIndexNilLeaf),
        ("testLeafAtIndexNilMultipleDepth", testLeafAtIndexNilMultipleDepth),
        ("testLeafAtIndexNilNoLeaves", testLeafAtIndexNilNoLeaves),
        ("testLeafAtIndexNilSingleDepth", testLeafAtIndexNilSingleDepth),
        ("testLeafAtIndexSelf", testLeafAtIndexSelf),
        ("testLeafAtIndexValidMultipleDepth", testLeafAtIndexValidMultipleDepth),
        ("testLeafAtIndexValidSingleDepth", testLeafAtIndexValidSingleDepth),
        ("testPathToRootGrandchild", testPathToRootGrandchild),
        ("testPathToRootOnlyChild", testPathToRootOnlyChild),
        ("testPathToRootSingleNode", testPathToRootSingleNode),
        ("testRemoveChildAtIndexThrows", testRemoveChildAtIndexThrows),
        ("testRemoveChildAtIndexValid", testRemoveChildAtIndexValid),
        ("testRemoveChildThrows", testRemoveChildThrows),
        ("testRemoveChildValid", testRemoveChildValid),
        ("testRootGrandchild", testRootGrandchild),
        ("testRootOnlyChild", testRootOnlyChild),
        ("testRootSelfSingleNode", testRootSelfSingleNode),
        ("testUnbalancedGrandParent_2", testUnbalancedGrandParent_2),
    ]
}

extension ReferenceTreeTests {
    static let __allTests = [
        ("testAddChild", testAddChild),
        ("testAddChildrenArray", testAddChildrenArray),
        ("testAddChildrenVariadic", testAddChildrenVariadic),
        ("testAncestorAtDistanceGrandchild", testAncestorAtDistanceGrandchild),
        ("testAncestorAtDistanceOnlyChild", testAncestorAtDistanceOnlyChild),
        ("testAncestorAtDistanceSingleNil", testAncestorAtDistanceSingleNil),
        ("testAncestorAtDistanceSingleValid", testAncestorAtDistanceSingleValid),
        ("testChildAtIndexNil", testChildAtIndexNil),
        ("testChildAtIndexNilEmpty", testChildAtIndexNilEmpty),
        ("testChildAtIndexValidMultiple", testChildAtIndexValidMultiple),
        ("testChildAtIndexValidSingle", testChildAtIndexValidSingle),
        ("testDepthGrandchild_2", testDepthGrandchild_2),
        ("testDepthOnlyChild_1", testDepthOnlyChild_1),
        ("testDepthRoot_1", testDepthRoot_1),
        ("testHasAncestorGrandchild", testHasAncestorGrandchild),
        ("testHasAncestorOnlyChild", testHasAncestorOnlyChild),
        ("testHasAncestorSingleNode", testHasAncestorSingleNode),
        ("testHasChildFalse", testHasChildFalse),
        ("testHasChildFalseEmpty", testHasChildFalseEmpty),
        ("testHasChildTrue", testHasChildTrue),
        ("testHasDescendentFalseSingleNode", testHasDescendentFalseSingleNode),
        ("testHasDescendentGrandparent", testHasDescendentGrandparent),
        ("testHasDescendentParent", testHasDescendentParent),
        ("testHeightGrandparent_2", testHeightGrandparent_2),
        ("testHeightParent_1", testHeightParent_1),
        ("testHeightSingleNode_0", testHeightSingleNode_0),
        ("testInsertChildAtIndexThrows", testInsertChildAtIndexThrows),
        ("testInsertChildAtIndexValidEmpty", testInsertChildAtIndexValidEmpty),
        ("testInsertChildAtIndexValidNotEmpty", testInsertChildAtIndexValidNotEmpty),
        ("testIsContainerFalse", testIsContainerFalse),
        ("testIsContainerTrue", testIsContainerTrue),
        ("testIsLeafFalse", testIsLeafFalse),
        ("testIsLeafTrueLeaf", testIsLeafTrueLeaf),
        ("testIsLeafTrueRoot", testIsLeafTrueRoot),
        ("testIsRootTrueContainer", testIsRootTrueContainer),
        ("testIsRootTrueSingleNode", testIsRootTrueSingleNode),
        ("testLeafAtIndexNilLeaf", testLeafAtIndexNilLeaf),
        ("testLeafAtIndexNilMultipleDepth", testLeafAtIndexNilMultipleDepth),
        ("testLeafAtIndexNilNoLeaves", testLeafAtIndexNilNoLeaves),
        ("testLeafAtIndexNilSingleDepth", testLeafAtIndexNilSingleDepth),
        ("testLeafAtIndexSelf", testLeafAtIndexSelf),
        ("testLeafAtIndexValidMultipleDepth", testLeafAtIndexValidMultipleDepth),
        ("testLeafAtIndexValidSingleDepth", testLeafAtIndexValidSingleDepth),
        ("testPathToRootGrandchild", testPathToRootGrandchild),
        ("testPathToRootOnlyChild", testPathToRootOnlyChild),
        ("testPathToRootSingleNode", testPathToRootSingleNode),
        ("testRemoveChildAtIndexThrows", testRemoveChildAtIndexThrows),
        ("testRemoveChildAtIndexValid", testRemoveChildAtIndexValid),
        ("testRemoveChildThrows", testRemoveChildThrows),
        ("testRemoveChildValid", testRemoveChildValid),
        ("testRootGrandchild", testRootGrandchild),
        ("testRootOnlyChild", testRootOnlyChild),
        ("testRootSelfSingleNode", testRootSelfSingleNode),
        ("testUnbalancedGrandParent_2", testUnbalancedGrandParent_2),
    ]
}

extension SortedArrayTests {
    static let __allTests = [
        ("testAdd", testAdd),
        ("testEndIndex", testEndIndex),
        ("testIndex", testIndex),
        ("testInitEmpty", testInitEmpty),
        ("testInitWithArraySorted", testInitWithArraySorted),
        ("testInitWithPresorted", testInitWithPresorted),
        ("testInsertAtBeginning", testInsertAtBeginning),
        ("testInsertAtEnd", testInsertAtEnd),
        ("testInsertElements", testInsertElements),
        ("testInsertInMiddle", testInsertInMiddle),
        ("testRemove", testRemove),
        ("testStartIndex", testStartIndex),
        ("testSubscript", testSubscript),
    ]
}

extension SortedDictionaryTests {
    static let __allTests = [
        ("testGetSubscript", testGetSubscript),
        ("testInitPresorted", testInitPresorted),
        ("testInsert", testInsert),
        ("testInsertContentsOfSortedDictionary", testInsertContentsOfSortedDictionary),
        ("testIterationSorted", testIterationSorted),
        ("testRemoveViaSubscript", testRemoveViaSubscript),
        ("testSetSubscript", testSetSubscript),
        ("testSorted", testSorted),
        ("testSubscriptWithFloatKey", testSubscriptWithFloatKey),
        ("testValueItIndex", testValueItIndex),
    ]
}

extension StackTests {
    static let __allTests = [
        ("testDestructured", testDestructured),
        ("testEquatable", testEquatable),
        ("testInitStackWithArray", testInitStackWithArray),
        ("testPop", testPop),
        ("testPopAmountNotNil", testPopAmountNotNil),
        ("testPopTooManyNil", testPopTooManyNil),
        ("testPush", testPush),
        ("testTop", testTop),
    ]
}

extension SubsetsTests {
    static let __allTests = [
        ("testSubsetsCarinalityGreaterThanCountEmpty", testSubsetsCarinalityGreaterThanCountEmpty),
        ("testSubsetsDouble", testSubsetsDouble),
        ("testSubsetsEmptyEmpty", testSubsetsEmptyEmpty),
        ("testSubsetsQuadruple", testSubsetsQuadruple),
        ("testSubsetsTriple", testSubsetsTriple),
    ]
}

extension TreeTests {
    static let __allTests = [
        ("testHeightBranchSingleDepthOne", testHeightBranchSingleDepthOne),
        ("testHeightLeafZero", testHeightLeafZero),
        ("testHeightMany", testHeightMany),
        ("testHeightNested", testHeightNested),
        ("testInitWithSequence", testInitWithSequence),
        ("testInitWithValueAndEmptyArray", testInitWithValueAndEmptyArray),
        ("testInsertBranchAtBeginningSingleDepth", testInsertBranchAtBeginningSingleDepth),
        ("testInsertBranchAtEndSingleDepth", testInsertBranchAtEndSingleDepth),
        ("testInsertBranchInMiddleSingleDepth", testInsertBranchInMiddleSingleDepth),
        ("testInsertBranchReallyNested", testInsertBranchReallyNested),
        ("testInsertLeafAtBeginningSingleDepth", testInsertLeafAtBeginningSingleDepth),
        ("testInsertLeafNested", testInsertLeafNested),
        ("testInsertLeafNestedLessNested", testInsertLeafNestedLessNested),
        ("testLeafInit", testLeafInit),
        ("testLeavesBranchMultipleTrees", testLeavesBranchMultipleTrees),
        ("testLeavesBranchSingleChild", testLeavesBranchSingleChild),
        ("testLeavesLeaf", testLeavesLeaf),
        ("testLeavesMany", testLeavesMany),
        ("testLeavesMultipleDepth", testLeavesMultipleDepth),
        ("testMap", testMap),
        ("testPath", testPath),
        ("testPathLeaf", testPathLeaf),
        ("testReplaceAtPathNested", testReplaceAtPathNested),
        ("testReplaceLeafAtPath", testReplaceLeafAtPath),
        ("testReplacingLeafAtBegining", testReplacingLeafAtBegining),
        ("testReplacingLeafAtEnd", testReplacingLeafAtEnd),
        ("testReplacingLeafInMiddle", testReplacingLeafInMiddle),
        ("testTreeZip", testTreeZip),
        ("testUpdateValueBranch", testUpdateValueBranch),
        ("testUpdatingValueLeaf", testUpdatingValueLeaf),
        ("testZipLeaves", testZipLeaves),
        ("testZipLeavesWithTransform", testZipLeavesWithTransform),
    ]
}

extension UnorderedPairTests {
    static let __allTests = [
        ("testEquatable", testEquatable),
        ("testHashValuesInt", testHashValuesInt),
        ("testHashValuesString", testHashValuesString),
        ("testManyHashValuesIntForCollisions", testManyHashValuesIntForCollisions),
        ("testManyHashValuesString", testManyHashValuesString),
        ("testManyHashValuesStringForCollisions", testManyHashValuesStringForCollisions),
        ("testMap", testMap),
    ]
}

extension WeightedDirectedGraphTests {
    static let __allTests = [
        ("testEdgesFromNode", testEdgesFromNode),
        ("testShortestPathTwoOptions", testShortestPathTwoOptions),
        ("testWeightedDirectedGraphInsertNodes", testWeightedDirectedGraphInsertNodes),
    ]
}

extension WeightedGraphTests {
    static let __allTests = [
        ("testContains", testContains),
        ("testInsertNodes", testInsertNodes),
        ("testNeighbors", testNeighbors),
        ("testRemoveEdge", testRemoveEdge),
        ("testUnweightedFromDirected", testUnweightedFromDirected),
        ("testUnweightedFromUndirected", testUnweightedFromUndirected),
        ("testUpdateEdge", testUpdateEdge),
        ("testWeightForEdge", testWeightForEdge),
    ]
}

extension Zip3SequenceTests {
    static let __allTests = [
        ("testMany", testMany),
        ("testZip3Sequence", testZip3Sequence),
    ]
}

extension ZipToLongestTests {
    static let __allTests = [
        ("testEqualLengths", testEqualLengths),
        ("testFirstLonger", testFirstLonger),
        ("testSecondLonger", testSecondLonger),
        ("testThirdLonger", testThirdLonger),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AVLTreeTests.__allTests),
        testCase(ArrayExtensionsTests.__allTests),
        testCase(BimapTests.__allTests),
        testCase(BinaryHeapTests.__allTests),
        testCase(BinarySearchTreeTests.__allTests),
        testCase(CircularArrayTests.__allTests),
        testCase(ContiguousSegmentCollectionTests.__allTests),
        testCase(CrossTests.__allTests),
        testCase(DictionaryProtocolsTests.__allTests),
        testCase(DirectedGraphTests.__allTests),
        testCase(EitherTests.__allTests),
        testCase(GraphTests.__allTests),
        testCase(HomogeneityTests.__allTests),
        testCase(IntervalRelationTests.__allTests),
        testCase(InvertibleEnumTests.__allTests),
        testCase(LinkedListTests.__allTests),
        testCase(MatrixTests.__allTests),
        testCase(MetatypeTests.__allTests),
        testCase(MutableGraphTests.__allTests),
        testCase(NewTypeTests.__allTests),
        testCase(OrderedDictionaryTests.__allTests),
        testCase(OrderedPairTests.__allTests),
        testCase(PairsTests.__allTests),
        testCase(QueueTests.__allTests),
        testCase(ReferenceTreeProtocolTests.__allTests),
        testCase(ReferenceTreeTests.__allTests),
        testCase(SortedArrayTests.__allTests),
        testCase(SortedDictionaryTests.__allTests),
        testCase(StackTests.__allTests),
        testCase(SubsetsTests.__allTests),
        testCase(TreeTests.__allTests),
        testCase(UnorderedPairTests.__allTests),
        testCase(WeightedDirectedGraphTests.__allTests),
        testCase(WeightedGraphTests.__allTests),
        testCase(Zip3SequenceTests.__allTests),
        testCase(ZipToLongestTests.__allTests),
    ]
}
#endif
