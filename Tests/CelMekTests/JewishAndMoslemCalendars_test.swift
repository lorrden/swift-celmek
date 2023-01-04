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
@testable import CelMek;

final class JewishCalendar_tests : XCTestCase {
  func testJewishEaster() {
    // Meeus, example 9.a
    let date = jewishEaster(gregorianYear: 1990)
    
    XCTAssertEqual(date.year, 1990)
    XCTAssertEqual(date.month, .April)
    XCTAssertEqual(date.day, 10.0)
  }
  
  func testJewishCommonYear() {
    // Meeu,s example 9.a
    let isCommon = jewishYearIsCommon(jewishYear: 5751)
    XCTAssertEqual(isCommon, true)
  }
  
  func testJewishYearStart() {
    // Meeu,s example 9.a
    let date = jewishYearStart(jewishYear: 5751)
    XCTAssertEqual(date.year, 1990)
    XCTAssertEqual(date.month, .September)
    XCTAssertEqual(date.day, 20.0)
  }
  
  func testDaysOfJewishYear() {
    // Meeu,s example 9.a
    let days = daysOfJewishYear(jewishYear: 5751)
    XCTAssertEqual(days, 354)
  }
}