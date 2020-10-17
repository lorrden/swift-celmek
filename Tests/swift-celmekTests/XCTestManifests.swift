import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(vsop87_tests.allTests),
    testCase(time_tests.allTests),

  ]
}
#endif
