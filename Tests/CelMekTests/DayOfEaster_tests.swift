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

final class dayOfEaster_tests : XCTestCase {
  func testGregorianDateOfEaster() {
    // Meeus, p68
    let date_0 = gregorianDateOfEaster(year: 1991)
    XCTAssertEqual(date_0.year, 1991)
    XCTAssertEqual(date_0.month, .March)
    XCTAssertEqual(date_0.day, 31)

    let date_1 = gregorianDateOfEaster(year: 1992)
    XCTAssertEqual(date_1.year, 1992)
    XCTAssertEqual(date_1.month, .April)
    XCTAssertEqual(date_1.day, 19)

    let date_2 = gregorianDateOfEaster(year: 1993)
    XCTAssertEqual(date_2.year, 1993)
    XCTAssertEqual(date_2.month, .April)
    XCTAssertEqual(date_2.day, 11)

    let date_3 = gregorianDateOfEaster(year: 1954)
    XCTAssertEqual(date_3.year, 1954)
    XCTAssertEqual(date_3.month, .April)
    XCTAssertEqual(date_3.day, 18)

    let date_4 = gregorianDateOfEaster(year: 2000)
    XCTAssertEqual(date_4.year, 2000)
    XCTAssertEqual(date_4.month, .April)
    XCTAssertEqual(date_4.day, 23)

    let date_5 = gregorianDateOfEaster(year: 1818)
    XCTAssertEqual(date_5.year, 1818)
    XCTAssertEqual(date_5.month, .March)
    XCTAssertEqual(date_5.day, 22)
  }
  
  func testJulianDateOfEaster() {
    let date_0 = julianDateOfEaster(year: 179)
    XCTAssertEqual(date_0.year, 179)
    XCTAssertEqual(date_0.month, .April)
    XCTAssertEqual(date_0.day, 12)

    let date_1 = julianDateOfEaster(year: 711)
    XCTAssertEqual(date_1.year, 711)
    XCTAssertEqual(date_1.month, .April)
    XCTAssertEqual(date_1.day, 12)

    let date_2 = julianDateOfEaster(year: 1243)
    XCTAssertEqual(date_2.year, 1243)
    XCTAssertEqual(date_2.month, .April)
    XCTAssertEqual(date_2.day, 12)
  }
}

