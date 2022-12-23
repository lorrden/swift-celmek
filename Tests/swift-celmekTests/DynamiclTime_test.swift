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

final class DynamicalTime_tests : XCTestCase {
  func testDynamicalTime() {
    // Meeus, p 78
    let date0 = GregorianDate(year: 1990, month: .January, day: 27)
    let dt0 = deltaT(year: date0.years())
    XCTAssertEqual(dt0, 57, accuracy: 0.1)


    // Meeus, example 10.a
    let date1 = GregorianDate(year: 1977, month: .February, day: 18)
    let dt1 = deltaT(year: date1.years())
    XCTAssertEqual(dt1, 48, accuracy: 0.4)


    // Meeus, example 10.b
    let date2 = JulianDate(year: 333, month: .February, day: 6.3333333333)
    let dt2 = deltaT(year: date2.years())
    XCTAssertEqual(dt2, 6146, accuracy: 0.1)
  }
}
