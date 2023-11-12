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
import Math

final class SiderealTime_tests : XCTestCase {
  func testSiderealTimeUT0() {
    // Meeus, example 12.a
    // TODO: Calculate also apperent time
    let 𝛩₀ = meanSideralTimeUT0(jd: 2446895.5)
    let expected = HourAngle(hours: 13, minutes: 10, seconds: 46.3668).toDeg()
    XCTAssertEqual(𝛩₀.toDeg(), expected, accuracy: 0.000005)
    XCTAssertEqual(𝛩₀.hours, 13)
    XCTAssertEqual(𝛩₀.minutes, 10)
    XCTAssertEqual(𝛩₀.seconds, 46.3668, accuracy: 0.00005)
  }
  
  func testMeanSiderealTimeDegrees0() {
    // Meeus, example 12.b
    let 𝜃₀ = meanSiderealTimeDegrees0(jd: 2446896.30625)
    XCTAssertEqual(𝜃₀, 128.7378734, accuracy: 0.0000005)
    let ra = HourAngle(degrees: 𝜃₀)
    XCTAssertEqual(ra.hours, 8)
    XCTAssertEqual(ra.minutes, 34)
    XCTAssertEqual(ra.seconds, 57.0896, accuracy: 0.00005)
  }

  func testSiderealTimeCorrection() {
    // Meeus, example 12.a
    let correction = apparentSiderealTimeCorrection(jd: 2446895.5)
    XCTAssertEqual(correction, -0.2317.arcsec, accuracy: 0.00005)
  }


  func testApparentSiderealTimeUT0() {
    // Meeus, example 12.a
    // TODO: Calculate also apperent time
    let 𝛩₀ = apparentSiderealTimeUT0(jd: 2446895.5)
    let expected = HourAngle(hours: 13, minutes: 10, seconds: 46.1351).toDeg()
    XCTAssertEqual(𝛩₀.toDeg(), expected, accuracy: 0.000005)
    XCTAssertEqual(𝛩₀.hours, 13)
    XCTAssertEqual(𝛩₀.minutes, 10)
    XCTAssertEqual(𝛩₀.seconds, 46.1351, accuracy: 0.00005)
  }

  func testApparentSiderealTimeDegreesUT0() {
    // Meeus, example 12.a
    let 𝛩₀ = apparentSiderealTimeDegreesUT0(jd: 2446895.5)
    let expected = HourAngle(hours: 13, minutes: 10, seconds: 46.1351).toDeg()
    XCTAssertEqual(𝛩₀, expected, accuracy: 0.005)
  }
}
