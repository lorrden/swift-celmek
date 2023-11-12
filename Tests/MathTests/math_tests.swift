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
@testable import Math;

final class math_tests : XCTestCase {
  func testRadToDeg() {
    XCTAssertEqual(0.0.asDeg, 0.0);
    XCTAssertEqual(1.0.asDeg, 57.2958, accuracy:  0.00005);
  }
  
  func testDegToRad() {
    XCTAssertEqual(0.0.deg, 0.0);
    XCTAssertEqual(1.0.deg, 0.0174533, accuracy:  0.00000005);
  }
  
  func testDegToHours() {
    XCTAssertEqual(0.0.degAsHours, 0.0);
    XCTAssertEqual(15.0.degAsHours, 1.0);
  }
  func testHoursToDeg() {
    XCTAssertEqual(0.0.hoursAsDeg, 0.0);
    XCTAssertEqual(1.0.hoursAsDeg, 15.0);
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

  func testQuaternionMult() {
    let a = Quaternion(x: 1.4, y: 5.7, z: 2.0, w: -2.1)
    let b = Quaternion(x: 0.2, y: 0.1, z: 1.0, w: 8.0)

    let r = a * b
    
    XCTAssertEqual(r.x, 16.28)
    XCTAssertEqual(r.y, 44.390)
    XCTAssertEqual(r.z, 12.900)
    XCTAssertEqual(r.w, -19.65, accuracy:  0.00000001)
  }

  func testMatrixZero() {
    let m = Matrix3x3.zero
    for i in 0..<3 {
      for j in 0..<3 {
        XCTAssertEqual(m[i, j], 0)
      }
    }
  }
  func testMatrixIdent() {
    let m = Matrix3x3.identity
    for i in 0..<3 {
      for j in 0..<3 {
        if i == j {
          XCTAssertEqual(m[i, j], 1)
        } else {
          XCTAssertEqual(m[i, j], 0)
        }
      }
    }
  }
  func testMatrixVectorMultiply() {
    let v = SIMD3<Double>(2, 1, 3)
    let a = Matrix3x3(elements: [1,2,3,
                                 4,5,6,
                                 7,8,9])
    let r = a * v

    XCTAssertEqual(r[0], 13)
    XCTAssertEqual(r[1], 31)
    XCTAssertEqual(r[2], 49)
  }

  func testMatrixMatrixMultiply() {
    let a = Matrix3x3(elements: [2, 3, 1,
                                 7, 4, 1,
                                 9,-2, 1])
    let b = Matrix3x3(elements: [9,-2,-1,
                                 5, 7, 3,
                                 8, 1, 0])
    let r = a * b

    let expected = Matrix3x3(elements: [41, 18,  7,
                                        91, 15,  5,
                                        79,-31,-15])
    for i in 0..<3 {
      for j in 0..<3 {
        XCTAssertEqual(expected[i,j], r[i,j])
      }
    }
  }
  func testMatrixToQuaternion() {
    let identMatrix = Matrix3x3.identity
    let qFromIdentity = identMatrix.quaternion
    let qExpected = Quaternion.identity

    XCTAssertEqual(qFromIdentity.x, qExpected.x)
    XCTAssertEqual(qFromIdentity.y, qExpected.y)
    XCTAssertEqual(qFromIdentity.z, qExpected.z)
    XCTAssertEqual(qFromIdentity.w, qExpected.w)
    
    // Second test, 90 degree around x
    let m = Matrix3x3(elements: [1, 0, 0,
                                 0, 0,-1,
                                 0, 1, 0])
    let q = m.quaternion
    XCTAssertEqual(q.x, 0.7071067811865475)
    XCTAssertEqual(q.y, 0.0)
    XCTAssertEqual(q.z, 0.0)
    XCTAssertEqual(q.w, 0.7071067811865476)
  }

  func testQuaternionToMatrix() {
    let identityQuaternion = Quaternion.identity
    let mFromIdentiy = identityQuaternion.matrix
    let mExpected = Matrix3x3.identity

    for i in 0..<3 {
      for j in 0..<3 {
        XCTAssertEqual(mExpected[i,j], mFromIdentiy[i,j])
      }
    }

    // Second test, 90 degree around x
    let mExpected90 = Matrix3x3(elements: [1, 0, 0,
                                           0, 0,-1,
                                           0, 1, 0])
    let q = Quaternion(x: 0.7071067811865475, y: 0, z: 0, w: 0.7071067811865476)
    let m = q.matrix
    for i in 0..<3 {
      for j in 0..<3 {
        XCTAssertEqual(m[i,j], mExpected90[i,j], accuracy: 0.000000001)
      }
    }
  }

  func testCubeToSphere() {
    // Cube sphere mapping test data. Center points for each cube face are
    // supposed to be mapped to identical coordinates.
    // The side centers can easily be computed using spherical to rectangular
    // coordinate mappings.
    // Is there an easy way to compute the corners?

    let testdata: [[SIMD3<Double>]] = [
      // Center points on each side
      [SIMD3(  1.0,  0.0,  0.0), SIMD3(  1.0,  0.0,  0.0)],
      [SIMD3( -1.0,  0.0,  0.0), SIMD3( -1.0,  0.0,  0.0)],
      [SIMD3(  0.0,  1.0,  0.0), SIMD3(  0.0,  1.0,  0.0)],
      [SIMD3(  0.0, -1.0,  0.0), SIMD3(  0.0, -1.0,  0.0)],
      [SIMD3(  0.0,  0.0,  1.0), SIMD3(  0.0,  0.0,  1.0)],
      [SIMD3(  0.0,  0.0, -1.0), SIMD3(  0.0,  0.0, -1.0)],

      // Center up, low and right points on each face

      // Front +x face
      [SIMD3( 1.0,  0.0,  1.0), SIMD3(sin(.pi/4)*cos(0),
        sin(.pi/4)*sin(0),
        cos(.pi/4))],
      [SIMD3( 1.0,  0.0, -1.0), SIMD3(sin(3.0 * .pi/4)*cos(0),
        sin(3.0 * .pi/4)*sin(0),
        cos(3.0 * .pi/4))],
      [SIMD3( 1.0,  1.0,  0.0), SIMD3(sin(.pi/2)*cos(.pi/4),
        sin(.pi/2)*sin(.pi/4),
        cos(.pi/2))],

      // +y face
      [SIMD3( 0.0,  1.0,  1.0), SIMD3(sin(.pi/4)*cos(.pi/2),
        sin(.pi/4)*sin(.pi/2),
        cos(.pi/4))],
      [SIMD3( 0.0,  1.0, -1.0), SIMD3(sin(3.0 * .pi/4)*cos(.pi/2),
        sin(3.0 * .pi/4)*sin(.pi/2),
        cos(3.0 * .pi/4))],
      [SIMD3(-1.0,  1.0,  0.0), SIMD3(sin(.pi/2)*cos(.pi/2 + .pi/4),
        sin(.pi/2)*sin(.pi/2 + .pi/4),
        cos(.pi/2))],


      // -x face
      [SIMD3(-1.0,  0.0,  1.0), SIMD3(sin(.pi/4)*cos(.pi),
        sin(.pi/4)*sin(.pi),
        cos(.pi/4))],
      [SIMD3(-1.0,  0.0, -1.0), SIMD3(sin(3.0 * .pi/4)*cos(.pi),
        sin(3.0 * .pi/4)*sin(.pi),
        cos(3.0 * .pi/4))],
      [SIMD3(-1.0, -1.0,  0.0), SIMD3(sin(.pi/2)*cos(.pi + .pi/4),
        sin(.pi/2)*sin(.pi + .pi/4),
        cos(.pi/2))],

      // -y face
      [SIMD3( 0.0, -1.0,  1.0), SIMD3(sin(.pi/4)*cos(.pi + .pi/2),
        sin(.pi/4)*sin(.pi + .pi/2),
        cos(.pi/4))],
      [SIMD3( 0.0, -1.0, -1.0), SIMD3(sin(3.0 * .pi/4)*cos(.pi + .pi/2),
        sin(3.0 * .pi/4)*sin(.pi + .pi/2),
        cos(3.0 * .pi/4))],
      [SIMD3( 1.0, -1.0,  0.0), SIMD3(sin(.pi/2)*cos(.pi + .pi/2 + .pi/4),
        sin(.pi/2)*sin(.pi + .pi/2 + .pi/4),
        cos(.pi/2))],

    ]

    for testCase in testdata {
      let res = cubeToSphere(testCase[0])
      XCTAssertEqual(res.x, testCase[1].x, accuracy: 0.00000001)
      XCTAssertEqual(res.y, testCase[1].y, accuracy: 0.00000001)
      XCTAssertEqual(res.z, testCase[1].z, accuracy: 0.00000001)
    }
  }

  func testSphereToCube() {
    // Same test data as for test_cube_sphere_map, only the reverse mapping
    // is tested.
    let testdata: [[SIMD3<Double>]] = [
      // Center points on each side
      [SIMD3(  1.0,  0.0,  0.0), SIMD3(  1.0,  0.0,  0.0)],
      [SIMD3( -1.0,  0.0,  0.0), SIMD3( -1.0,  0.0,  0.0)],
      [SIMD3(  0.0,  1.0,  0.0), SIMD3(  0.0,  1.0,  0.0)],
      [SIMD3(  0.0, -1.0,  0.0), SIMD3(  0.0, -1.0,  0.0)],
      [SIMD3(  0.0,  0.0,  1.0), SIMD3(  0.0,  0.0,  1.0)],
      [SIMD3(  0.0,  0.0, -1.0), SIMD3(  0.0,  0.0, -1.0)],

      // Center up, low and right points on each face

      // Front +x face
      [SIMD3( 1.0,  0.0,  1.0), SIMD3(sin(.pi/4)*cos(0),
        sin(.pi/4)*sin(0),
        cos(.pi/4))],
      [SIMD3( 1.0,  0.0, -1.0), SIMD3(sin(3.0 * .pi/4)*cos(0),
        sin(3.0 * .pi/4)*sin(0),
        cos(3.0 * .pi/4))],
      [SIMD3( 1.0,  1.0,  0.0), SIMD3(sin(.pi/2)*cos(.pi/4),
        sin(.pi/2)*sin(.pi/4),
        cos(.pi/2))],

      // +y face
      [SIMD3( 0.0,  1.0,  1.0), SIMD3(sin(.pi/4)*cos(.pi/2),
        sin(.pi/4)*sin(.pi/2),
        cos(.pi/4))],
      [SIMD3( 0.0,  1.0, -1.0), SIMD3(sin(3.0 * .pi/4)*cos(.pi/2),
        sin(3.0 * .pi/4)*sin(.pi/2),
        cos(3.0 * .pi/4))],
      [SIMD3(-1.0,  1.0,  0.0), SIMD3(sin(.pi/2)*cos(.pi/2 + .pi/4),
        sin(.pi/2)*sin(.pi/2 + .pi/4),
        cos(.pi/2))],


      // -x face
      [SIMD3(-1.0,  0.0,  1.0), SIMD3(sin(.pi/4)*cos(.pi),
        sin(.pi/4)*sin(.pi),
        cos(.pi/4))],
      [SIMD3(-1.0,  0.0, -1.0), SIMD3(sin(3.0 * .pi/4)*cos(.pi),
        sin(3.0 * .pi/4)*sin(.pi),
        cos(3.0 * .pi/4))],
      [SIMD3(-1.0, -1.0,  0.0), SIMD3(sin(.pi/2)*cos(.pi + .pi/4),
        sin(.pi/2)*sin(.pi + .pi/4),
        cos(.pi/2))],

      // -y face
      [SIMD3( 0.0, -1.0,  1.0), SIMD3(sin(.pi/4)*cos(.pi + .pi/2),
        sin(.pi/4)*sin(.pi + .pi/2),
        cos(.pi/4))],
      [SIMD3( 0.0, -1.0, -1.0), SIMD3(sin(3.0 * .pi/4)*cos(.pi + .pi/2),
        sin(3.0 * .pi/4)*sin(.pi + .pi/2),
        cos(3.0 * .pi/4))],
      [SIMD3( 1.0, -1.0,  0.0), SIMD3(sin(.pi/2)*cos(.pi + .pi/2 + .pi/4),
        sin(.pi/2)*sin(.pi + .pi/2 + .pi/4),
        cos(.pi/2))],

    ]

    for testCase in testdata {
      let res = sphereToCube(testCase[1])
      XCTAssertEqual(res.x, testCase[0].x, accuracy: 0.000001)
      XCTAssertEqual(res.y, testCase[0].y, accuracy: 0.000001)
      XCTAssertEqual(res.z, testCase[0].z, accuracy: 0.000001)
    }
  }
}
