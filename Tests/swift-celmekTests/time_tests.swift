//
// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2020 Mattias Holm
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest
@testable import swift_celmek;

final class time_tests: XCTestCase {
  func testDateTime() {
    let dt0 = DateTime(isoDate: "2020-12-12")
    XCTAssertNotNil(dt0)
    XCTAssertEqual(dt0!.date.year, 2020)
    XCTAssertEqual(dt0!.date.month, Month.December)
    XCTAssertEqual(dt0!.date.day, 12)

    let dt1 = DateTime(isoDate: "2020-0-12")
    XCTAssertNil(dt1)
    
  }
  func testIsLeap() {
    XCTAssertTrue(isLeapYear(2000))
    XCTAssertTrue(isLeapYear(1996))
    XCTAssertTrue(isLeapYear(2004))
    XCTAssertFalse(isLeapYear(1900))
    XCTAssertFalse(isLeapYear(2001))
    XCTAssertFalse(isLeapYear(1999))
  }

  static var allTests = [
    ("testDateTime", testDateTime),
    ("testIsLeap", testIsLeap),
  ]
}


