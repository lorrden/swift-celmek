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

final class ParallaticAngle_tests : XCTestCase {
  func testEcliptic() {
    // Meeus, p99
    let (_, I0) = ecliptic(
      obliquityOfEcliptic: AngleOfArc(degrees: 23, minutes: 26, seconds: 0).toRad(),
      geographicLatitudeOfObserver: AngleOfArc(degrees: 48, minutes: 0, seconds: 0).toRad(),
      localSiderealTime: 90.deg)

    XCTAssertEqual(I0, AngleOfArc(degrees: 65, minutes: 26, seconds: 0).toRad(),
                   accuracy: 0.000000005)
    
    let (_, I1) = ecliptic(
      obliquityOfEcliptic: AngleOfArc(degrees: 23, minutes: 26, seconds: 0).toRad(),
      geographicLatitudeOfObserver: AngleOfArc(degrees: 48, minutes: 0, seconds: 0).toRad(),
      localSiderealTime: 270.deg)
    
    XCTAssertEqual(I1, AngleOfArc(degrees: 18, minutes: 34, seconds: 0).toRad(),
                   accuracy: 0.000000005)
    
    
    // Meeus, Example 14.a
    let (L, I2) = ecliptic(
      obliquityOfEcliptic: AngleOfArc(degrees: 23, minutes: 44, seconds: 0).toRad(),
      geographicLatitudeOfObserver: 51.deg,
      localSiderealTime: HourAngle(hours: 5, minutes: 0, seconds: 0).toRad())
    
    XCTAssertEqual(normalize(radians: L), AngleOfArc(degrees: 349, minutes: 21, seconds: 0).toRad(),
                   accuracy: 0.005)

    XCTAssertEqual(normalize(radians: I2), 62.deg,
                   accuracy: 0.005)
  }
}

