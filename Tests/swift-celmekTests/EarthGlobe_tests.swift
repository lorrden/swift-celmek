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

final class EarthGlobe_tests : XCTestCase {
  func testPComp() {
    // Meeus, example 11.a
    let (psin, pcos) = pcomp(H: 1706, geographicLat: 33.356111.toRad())
    XCTAssertEqual(psin, 0.546861, accuracy: 0.0000005)
    XCTAssertEqual(pcos, 0.836339, accuracy: 0.0000005)
  }
  
  func testRadiusOfCurvatureOfMeridian() {
    // Meeus, p84
    let eqRad = radiusOfCurvatureOfMeridian(geographicalLat: 0.0)
    XCTAssertEqual(eqRad, 6335.44, accuracy: 0.005)
    let polRad = radiusOfCurvatureOfMeridian(geographicalLat: 90.0.toRad())
    XCTAssertEqual(polRad, 6399.60, accuracy: 0.005)
    
    // Meeus, example 11.b
    let chicagoRad = radiusOfCurvatureOfMeridian(geographicalLat: 42.0.toRad())
    XCTAssertEqual(chicagoRad, 6364.033, accuracy: 0.0005)
  }
  
  func testParallelOfLatitudeRadius() {
    // Meeus, p84
    let eqRad = parallelOfLatitudeRadius(geographicalLat: 0.0)
    XCTAssertEqual(eqRad, EARTH_EQUATORIAL_RADIUS_KM, accuracy: 0.000005)
    let polRad = parallelOfLatitudeRadius(geographicalLat: 90.0.toRad())
    XCTAssertEqual(polRad, 0.0, accuracy: 0.00001)
    
    // Meeus, example 11.b
    let chicagoRad = parallelOfLatitudeRadius(geographicalLat: 42.0.toRad())
    XCTAssertEqual(chicagoRad, 4747.001, accuracy: 0.0005)
  }
  
  func testGeodesicDistanceFast() {
    let paris = GeographicCoordinate(
      latitude: AngleOfArc(degrees: 48, minutes: 50, seconds: 11).toRad(),
      longitude: AngleOfArc(degrees: -2, minutes: 20, seconds: 14).toRad())
    
    let washington = GeographicCoordinate(
      latitude: AngleOfArc(degrees: 38, minutes: 55, seconds: 17).toRad(),
      longitude: AngleOfArc(degrees: 77, minutes: 3, seconds: 56).toRad())
    let s = geodesicDistanceFast(p0: paris, p1: washington)
    XCTAssertEqual(s, 6166, accuracy: 0.5)
  }

  func testGeodesicDistance() {
    let paris = GeographicCoordinate(
      latitude: AngleOfArc(degrees: 48, minutes: 50, seconds: 11).toRad(),
      longitude: AngleOfArc(degrees: -2, minutes: 20, seconds: 14).toRad())
    
    let washington = GeographicCoordinate(
      latitude: AngleOfArc(degrees: 38, minutes: 55, seconds: 17).toRad(),
      longitude: AngleOfArc(degrees: 77, minutes: 3, seconds: 56).toRad())
    let s = geodesicDistance(p0: paris, p1: washington)
    XCTAssertEqual(s, 6181.63, accuracy: 0.005)
  }
}
