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

final class math_tests : XCTestCase {
  func testRadToDeg() {
    XCTAssertEqual(0.0.toDeg(), 0.0);
    XCTAssertEqual(1.0.toDeg(), 57.2958, accuracy:  0.00005);
  }
  
  func testDegToRad() {
    XCTAssertEqual(0.0.toRad(), 0.0);
    XCTAssertEqual(1.0.toRad(), 0.0174533, accuracy:  0.00000005);
  }
  
  func testDegToHours() {
    XCTAssertEqual(0.0.degToHours(), 0.0);
    XCTAssertEqual(15.0.degToHours(), 1.0);
  }
  func testHoursToDeg() {
    XCTAssertEqual(0.0.hoursToDeg(), 0.0);
    XCTAssertEqual(1.0.hoursToDeg(), 15.0);
  }
  
  func testHourAngleToDeg() {
    // Meeus, Astronomical Algorithms 2nd edition, Example 1.a
    let ra = HourAngle(hours: 9, minutes: 14, seconds: 55.8)
    XCTAssertEqual(ra.toDeg(), 138.73250, accuracy: 0.000005);
  }
  
  func testHourAngleToRad() {
    // Meeus, p8 Example 1.a
    let ra = HourAngle(hours: 9, minutes: 14, seconds: 55.8)
    XCTAssertEqual(ra.toRad(), 2.4213389045, accuracy: 1.0e-6);
  }
  
  func testAngleOfArcToDeg() {
    let angle = AngleOfArc(degrees: -14, minutes: 43, seconds: 8.2)
    XCTAssertEqual(angle.toDeg(), -14.718944, accuracy: 0.0000005)

  }
}


