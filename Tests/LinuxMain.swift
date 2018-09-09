import XCTest

import DataStructuresTests
import AlgebraPerformanceTests
import AlgebraTests
import DataStructuresPerformanceTests
import AlgorithmsTests
import DestructureTests
import AlgorithmsPerformanceTests

var tests = [XCTestCaseEntry]()
tests += DataStructuresTests.__allTests()
tests += AlgebraPerformanceTests.__allTests()
tests += AlgebraTests.__allTests()
tests += DataStructuresPerformanceTests.__allTests()
tests += AlgorithmsTests.__allTests()
tests += DestructureTests.__allTests()
tests += AlgorithmsPerformanceTests.__allTests()

XCTMain(tests)
