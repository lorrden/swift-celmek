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
  
  func testMoslemToJulian() {
    // Meeu,s example 9.b
    let date = JulianDate(
      moslemDate: MoslemDate(year: 1421,
                             month: .Muharram,
                             day: 1))
    
    XCTAssertEqual(date.year, 2000)
    XCTAssertEqual(date.dayOfYear(), 84.0)

    let jd = date.toJD()
    let gregDate = jd.toGregorian()
    XCTAssertEqual(gregDate.year, 2000)
    XCTAssertEqual(gregDate.month, .April)
    XCTAssertEqual(gregDate.day, 6.0)
  }
  
  func testJulianToMoslem() {
    // Meeu,s example 9.c
    let date = MoslemDate(
      julianDate: JulianDate(year: 1991,
                             month: .July,
                             day: 31))

    XCTAssertEqual(date.year, 1412)
    XCTAssertEqual(date.month, .Safar)
    XCTAssertEqual(date.day, 2)

    let julianDate = JulianDate(year: 2000, dayInYear: 84.0)!
    XCTAssertEqual(julianDate.year, 2000)
    XCTAssertEqual(julianDate.month, .March)
    XCTAssertEqual(julianDate.day, 24)
    
    let date2 = MoslemDate(julianDate: julianDate)
    XCTAssertEqual(date2.year, 1421)
    XCTAssertEqual(date2.month, .Muharram)
    XCTAssertEqual(date2.day, 1)
    // Currently incorrect
    // Gregorian date 2023-01-04
    // Julian date 2022-12-22
    // Islamic date: 1444-06-11 According to Wiki
    let date3 = MoslemDate(julianDate: JulianDate(year: 2022, month: .December, day: 22))
    XCTAssertEqual(date3.year, 1444)
    XCTAssertEqual(date3.month, .JumadaTTania)
    XCTAssertEqual(date3.day, 11)

  }
}
