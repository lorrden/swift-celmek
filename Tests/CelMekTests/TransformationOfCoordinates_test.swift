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

final class TransformationOfCoordinates_tests : XCTestCase {
  func testEclipticalFromEquatorial() {
    // Meeus, p 95, example 13.a
    let eq = EquatorialCoordinate(rightAscension: 116.328942.toRad(), declination: 28.026183.toRad())
    let ecl = EclipticCoordinate(equatorial: eq, obliquityOfEcliptic: J2000_OBLIQUITY_OF_ECLIPTIC)
    
    let 𝜆 = ecl.longitude
    let 𝛽 = ecl.latitude

    XCTAssertEqual(𝜆, 113.215630.toRad(), accuracy: 0.00000005)
    XCTAssertEqual(𝛽, 6.684170.toRad(), accuracy: 0.00000005)
  }
  
  func testEquatorialFromEcliptical() {
    // Meeus, p 95, example 13.a
    let ecl = EclipticCoordinate(latitude: 6.684170.toRad(), longitude: 113.215630.toRad())
    let eq = EquatorialCoordinate(ecliptic: ecl, obliquityOfEcliptic: J2000_OBLIQUITY_OF_ECLIPTIC)

    XCTAssertEqual(eq.rightAscension, 116.328942.toRad(), accuracy: 0.00000005)
    XCTAssertEqual(eq.declination, 28.026183.toRad(), accuracy: 0.00000005)
  }

  // TODO: Add example 13.b when nutations have been implemented
  func testGalacticFromEquatorial() {
    // Meeus, p 96 exercise
    let eq = EquatorialCoordinate(
      rightAscension: HourAngle(hours: 17, minutes: 48, seconds: 59.74).toRad(),
      declination: AngleOfArc(degrees: -14, minutes: 43, seconds: 8.2).toRad())
    let gal = GalacticCoordinate(equatorial: eq)
    
    
    XCTAssertEqual(gal.latitude, 6.0463.toRad(), accuracy: 0.00005)
    XCTAssertEqual(gal.longitude, 12.9593.toRad(), accuracy: 0.00005)
  }


}

