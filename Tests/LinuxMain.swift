import XCTest

import AlgebraPerformanceTests
import AlgebraTests
import DataStructuresTests
import DataStructuresPerformanceTests
import AlgorithmsTests
import DestructureTests
import AlgorithmsPerformanceTests

var tests = [XCTestCaseEntry]()
tests += AlgebraPerformanceTests.__allTests()
tests += AlgebraTests.__allTests()
tests += DataStructuresTests.__allTests()
tests += DataStructuresPerformanceTests.__allTests()
tests += AlgorithmsTests.__allTests()
tests += DestructureTests.__allTests()
tests += AlgorithmsPerformanceTests.__allTests()

XCTMain(tests)
