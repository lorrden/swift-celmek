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

final class jd_tests : XCTestCase {
  func testGregorianToJD() {
    // Meeus, example 7.a
    let date = GregorianDate(year: 1957, month: .October, day: 4.81)
    XCTAssertEqual(date.toJD(), 2436116.31)
  }
  
  func testJulianToJD() {
    // Meeus, example 7.b
    let date = JulianDate(year: 333, month: .January, day: 27.5)
    XCTAssertEqual(date.toJD(), 1842713.0)
  }
  
  func testGregorianConversions() {
    // Meeus, p 62
    let dates = [
      (GregorianDate(year: 2000, month: .January, day: 1.5), 2451545.0),
      (GregorianDate(year: 1999, month: .January, day: 1.0), 2451179.5),
      (GregorianDate(year: 1987, month: .January, day: 27.0), 2446822.5),
      (GregorianDate(year: 1987, month: .June, day: 19.5), 2446966.0),
      (GregorianDate(year: 1988, month: .January, day: 27.0), 2447187.5),
      (GregorianDate(year: 1988, month: .June, day: 19.5), 2447332.0),
      (GregorianDate(year: 1900, month: .January, day: 1.0), 2415020.5),
      (GregorianDate(year: 1600, month: .January, day: 1.0), 2305447.5),
      (GregorianDate(year: 1600, month: .December, day: 31.0), 2305812.5),
    ]
    
    for (date, jd) in dates {
      XCTAssertEqual(date.toJD(), jd)
      
      let gdate = jd.toGregorian()
      XCTAssertEqual(gdate.year, date.year)
      XCTAssertEqual(gdate.month, date.month)
      XCTAssertEqual(gdate.day, date.day)
    }
  }
  
  func testJulianConversion() {
    // Meeus, p 62
    let dates = [
      (JulianDate(year: 837, month: .April, day: 10.3), 2026871.8),
      (JulianDate(year: -123, month: .December, day: 31.0), 1676496.5),
      (JulianDate(year: -122, month: .January, day: 1.0), 1676497.5),
      (JulianDate(year: -1000, month: .July, day: 12.5), 1356001.0),
      (JulianDate(year: -1000, month: .February, day: 29.0), 1355866.5),
      (JulianDate(year: -1001, month: .August, day: 17.9), 1355671.4),
      (JulianDate(year: -4712, month: .January, day: 1.5), 0.0),
    ]
    
    for (date, jd) in dates {
      XCTAssertEqual(date.toJD(), jd)
    }
  }
  
  func testMJDConversion() {
    // Meeus, p 63
    let date = GregorianDate(year: 1858, month: .November, day: 17.0)
    XCTAssertEqual(date.toJD().toMJD(), 0.0)
  }
  
  func testWeekday() {
    // Meeus, p65
    let date = GregorianDate(year: 1954, month: .June, day: 30.1)
    XCTAssertEqual(date.toJD().weekday(), .Wednesday)
  }
  
  func testDayOfYear() {
    // Meeus, p65, examples 7.f and 7.g
    let date_7f = GregorianDate(year: 1978, month: .November, day: 14)
    XCTAssertEqual(date_7f.dayOfYear(), 318)
    
    let date_7g = GregorianDate(year: 1988, month: .April, day: 22)
    XCTAssertEqual(date_7g.dayOfYear(), 113)
  }

  func testGregorianDateFromDayInYear() {
    // Meeus, p65, examples 7.f and 7.g in reverse
    let date_7f = GregorianDate(year: 1978, dayInYear: 318)!
    XCTAssertEqual(date_7f.year, 1978)
    XCTAssertEqual(date_7f.month, .November)
    XCTAssertEqual(date_7f.day, 14)
    
    let date_7g = GregorianDate(year: 1988, dayInYear: 113)!
    XCTAssertEqual(date_7g.year, 1988)
    XCTAssertEqual(date_7g.month, .April)
    XCTAssertEqual(date_7g.day, 22)
  }
  
  func testJulianYears() {
    let date = JulianDate(year: 333, month: .February, day: 6.33333333333)
    XCTAssertEqual(date.years(), 333.1, accuracy: 0.01)
  }
  
  func testGregorianYears() {
    let date = GregorianDate(year: 1999, month: .February, day: 6.33333333333)
    XCTAssertEqual(date.years(), 1999.1, accuracy: 0.01)
  }

  func testJD0() {
    let jd0_1999 = jd0(year: 1999)
    let greg0_1999 = GregorianDate(year: 1999, month: .January, day: 0.0)
    let jd0_expect = greg0_1999.toJD()
    XCTAssertEqual(jd0_1999, jd0_expect)
  }
}

