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

final class PlanetaryOrbits_tests : XCTestCase {
  func testMercuryMean() {
    // Meeus, Example 31.a
    let elements = elementsOfMercuryForMeanEquinox(jd: 2475460.5)
    XCTAssertEqual(elements.meanLongitude, 203.494701, accuracy: 0.0000005)
    XCTAssertEqual(elements.semimajorAxis, 0.387098310)
    XCTAssertEqual(elements.eccentricity, 0.20564510, accuracy: 0.0000005)
    XCTAssertEqual(elements.inclinationOnEclipticPlane, 7.006171, accuracy: 0.0000005)
    XCTAssertEqual(elements.longitudeOfAscendingNode, 49.107650, accuracy: 0.0000005)
    XCTAssertEqual(elements.longitudeOfPerihelion, 78.475382, accuracy: 0.0000005)
  }
}

