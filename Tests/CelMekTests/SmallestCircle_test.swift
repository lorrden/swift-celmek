//
// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2023 Mattias Holm
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

final class SmallestCircle_tests : XCTestCase {
  func testSmallestCircle() {
    // Meeus, Example 20.a
    let mercury = EquatorialCoordinate(rightAscension:
                                    HourAngle(hours: 12,
                                              minutes: 41,
                                              seconds: 8.63).toRad(),
                                  declination:
                                    AngleOfArc(degrees: -5,
                                               minutes: 37,
                                               seconds: 54.2).toRad())
    let jupiter = EquatorialCoordinate(rightAscension:
                                    HourAngle(hours: 12,
                                              minutes: 52,
                                              seconds: 5.21).toRad(),
                                  declination:
                                    AngleOfArc(degrees: -4,
                                               minutes: 22,
                                               seconds: 26.2).toRad())
    let saturn = EquatorialCoordinate(rightAscension:
                                    HourAngle(hours: 12,
                                              minutes: 39,
                                              seconds: 28.11).toRad(),
                                  declination:
                                    AngleOfArc(degrees: -1,
                                               minutes: 50,
                                               seconds: 3.7).toRad())
    let d = smallestCircle(mercury, jupiter, saturn)

    XCTAssertEqual(d, 4.26364.deg, accuracy: 0.000005)
  }
}

