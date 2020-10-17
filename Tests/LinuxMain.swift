import XCTest

import vsop87_tests
import time_tests

var tests = [XCTestCaseEntry]()
tests += vsop87_tests.allTests()
tests += time_tests.allTests()
XCTMain(tests)
