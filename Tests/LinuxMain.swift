import XCTest

import AlgebraPerformanceTests
import AlgebraTests
import AlgorithmsPerformanceTests
import AlgorithmsTests
import DataStructuresPerformanceTests
import DataStructuresTests
import DestructureTests

var tests = [XCTestCaseEntry]()
tests += AlgebraPerformanceTests.__allTests()
tests += AlgebraTests.__allTests()
tests += AlgorithmsPerformanceTests.__allTests()
tests += AlgorithmsTests.__allTests()
tests += DataStructuresPerformanceTests.__allTests()
tests += DataStructuresTests.__allTests()
tests += DestructureTests.__allTests()

XCTMain(tests)
