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

import Foundation

public struct Quaternion {
  var elements: SIMD4<Double>
  public var x : Double { get { return elements.x } set { elements.x = newValue }}
  public var y : Double { get { return elements.y } set { elements.y = newValue }}
  public var z : Double { get { return elements.z } set { elements.z = newValue }}
  public var w : Double { get { return elements.w } set { elements.w = newValue }}
  public var vector: SIMD3<Double> { get { return SIMD3<Double>(x, y, z) } }
  public var scalar: Double { get { return w } }
  public init(x: Double, y: Double, z: Double, w: Double) {
    elements = SIMD4(x, y, z, w)
  }

  public init(vector: SIMD4<Double>) {
    elements = vector
  }
  public init(angle: Double, axis: SIMD3<Double>) {
    elements = SIMD4(axis, angle)
    let  Omega = angle * 0.5
    let sin_Omega = sin(Omega)
    let sincos = SIMD4(sin_Omega, sin_Omega, sin_Omega, cos(Omega))
    elements *= sincos
  }
  public init() {
    elements = SIMD4(repeating: 0)
  }

//  init(from: SIMD3<Double>, to: SIMD3<Double>) {
//  }
  public var angle : Double {
    get {
      elements.w
    }
  }
  public var axis : SIMD3<Double> {
    get {
      SIMD3<Double>(elements.x, elements.y, elements.z)
    }
  }
  public var matrix: Matrix3x3 {
    get {

      let n = Quaternion.dot(lhs: self, rhs: self);
      let a : Double = (n > 0.0) ? 2.0 / n : 0.0;

      let xa = x * a, ya = y * a, za = z * a
      let xx = x * xa, xy = x * ya, xz = x * za
      let yy = y * ya, yz = y * za, zz = z * za
      let wx = w * xa, wy = w * ya, wz = w * za

      let result = Matrix3x3(elements: [1-(yy+zz), xy-wz, xz+wy,
                                        xy+wz, 1-(xx+zz), yz-wx,
                                        xz-wy, yz+wx, 1.0-(xx+yy)])

      return result
    }
  }
  public var invMatrix: Matrix3x3 {
    get {
      let n = Quaternion.dot(lhs: self, rhs: self);
      let a : Double = (n > 0) ? 2 / n : 0;

      let xa = x * a, ya = y * a, za = z * a;
      let xx = x * xa, xy = x * ya, xz = x * za;
      let yy = y * ya, yz = y * za, zz = z * za;
      let wx = w * xa, wy = w * ya, wz = w * za;

      let result = Matrix3x3(elements: [1-(yy+zz), xy+wz, xz-wy,
                                        xy-wz, 1-(xx+zz), yz+wx,
                                        xz+wy, yz-wx, 1-(xx+yy)])
      return result
    }
  }

  // inverse
  // normalized
  // length
  public var conj : Quaternion {
    get {
      return Quaternion(vector: elements * SIMD4<Double>(repeating: -1))
    }
  }

  public static func *(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
    let result: Quaternion
      = Quaternion(x: lhs.x * rhs.w + lhs.w * rhs.x + lhs.y * rhs.z - lhs.z * rhs.y,
                   y: lhs.y * rhs.w + lhs.w * rhs.y + lhs.z * rhs.x - lhs.x * rhs.z,
                   z: lhs.z * rhs.w + lhs.w * rhs.z + lhs.x * rhs.y - lhs.y * rhs.x,
                   w: lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z)
    return result
  }
  public static func +(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
    let result = Quaternion(vector: lhs.elements + rhs.elements)
    return result
  }
  public static func -(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
    let result = Quaternion(vector: lhs.elements - rhs.elements)
    return result
  }
  public static prefix func -(lhs: Quaternion) -> Quaternion {
    let result = Quaternion(vector: -lhs.elements)
    return result
  }
  public static func *(lhs: Quaternion, rhs: Double) -> Quaternion {
    let result = Quaternion(vector: lhs.elements * rhs)
    return result
  }
  public static func *(lhs: Double, rhs: Quaternion) -> Quaternion {
    let result = Quaternion(vector: lhs * rhs.elements)
    return result
  }

  public static func /(lhs: Quaternion, rhs: Double) -> Quaternion {
    let result = Quaternion(vector: lhs.elements / rhs)
    return result
  }
  // slerp
  public static func slerp(lhs: Quaternion, rhs: Quaternion, t: Double) -> Quaternion {
    if t >= 1 { return rhs }
    if t <= 0 { return lhs }

    var qdot = dot(lhs: lhs, rhs: rhs)

    var q1prim: Quaternion
    if qdot < 0.0 {
      q1prim = -rhs
      qdot = -qdot
    } else {
      q1prim = rhs
    }

    if qdot < -1 { qdot = -1 }
    if qdot > 1 { qdot = 1 }
    assert(qdot >= -1)
    assert(qdot <= 1)

    let qang = acos(qdot)
    let s0 = sin((1-t)*qang) / sin(qang)
    let s1 = sin(t*qang) / sin(qang)

    if abs(qang) > 0 {
      let res = s0 * lhs + s1 * q1prim
      return res
    }

    // If slerping between the same points, qang will be 0, so s0 will be NaN or Inf.
    // Thus, return left hand side here
    return lhs

  }

  public static func dot(lhs: Quaternion, rhs: Quaternion) -> Double {
    let tmp = lhs.elements * rhs.elements
    return tmp.sum()
  }

  public static let identity = Quaternion(x: 0, y: 0, z: 0, w: 1)
}
