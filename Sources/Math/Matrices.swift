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
import Accelerate

struct Matrix3x3 {
  var elements: [SIMD3<Double>]

  init() {
    elements = [SIMD3<Double>.zero, SIMD3<Double>.zero, SIMD3<Double>.zero]
  }

  init(diagonal: SIMD3<Double>) {
    elements = [SIMD3<Double>.zero, SIMD3<Double>.zero, SIMD3<Double>.zero]
    self[0, 0] = diagonal.x
    self[1, 1] = diagonal.y
    self[2, 2] = diagonal.z
  }

  init(rows: [SIMD3<Double>]) {
    elements = rows
  }
  init(columns: [SIMD3<Double>]) {
    self.init()
    for i in columns.indices {
      for j in columns[i].indices {
        self[j, i] = columns[i][j]
      }
    }
  }
  init(elements: [Double]) {
    self.elements = [SIMD3<Double>(elements[0], elements[1], elements[2]),
                     SIMD3<Double>(elements[3], elements[4], elements[5]),
                     SIMD3<Double>(elements[6], elements[7], elements[8])]
  }
  static var identity : Matrix3x3 {
    get {
      return Matrix3x3(diagonal: SIMD3<Double>(repeating: 1))
    }
  }
  static var zero : Matrix3x3 {
    get {
      return Matrix3x3()
    }
  }

  subscript(index:Int) -> SIMD3<Double> {
    get {
      return elements[index]
    }
    set {
      elements[index] = newValue
    }
  }

  subscript(a: Int, b: Int) -> Double {
    get {
      return elements[a][b]
    }
    set {
      elements[a][b] = newValue
    }
  }
  func column(index: Int) -> SIMD3<Double> {
    return SIMD3<Double>(self[0, index], self[1, index], self[2, index])
  }

  static func *(lhs: borrowing Matrix3x3, rhs: borrowing Matrix3x3) -> Matrix3x3 {
    var result = Matrix3x3.zero
    for i in 0..<3 {
      let row = lhs[i]
      for j in 0..<3 {
        let column = rhs.column(index: j)
        result[i, j] = (row * column).sum()
      }
    }
    return result
  }
  static func *(lhs: borrowing Matrix3x3, rhs: Double) -> Matrix3x3{
    var result = Matrix3x3(rows: [lhs[0] * rhs, lhs[1], lhs[2]])
    result[0] *= rhs
    result[1] *= rhs
    result[2] *= rhs
    return result
  }

  static func *(lhs: borrowing Matrix3x3, rhs: SIMD3<Double>) -> SIMD3<Double>{
    return SIMD3<Double>((lhs[0] * rhs).sum(),
                         (lhs[1] * rhs).sum(),
                         (lhs[2] * rhs).sum())
  }

  var quaternion : Quaternion {
    get {
      var q = Quaternion()
      var s: Double

      let tr = self[0, 0] + self[1, 1] + self[2, 2]

      if (tr >= 0) {
        s = sqrt(tr+1);
        q.w = s*0.5;
        s = 0.5 / s;
        q.x = (self[2,1] - self[1,2]) * s;
        q.y = (self[0,2] - self[2,0]) * s;
        q.z = (self[1,0] - self[0,1]) * s;
      } else if (self[0,0] > self[1,1] && self[0,0] > self[2,2]) {
        s =  2.0 * sqrt(self[0,0] - self[1,1] - self[2,2] + 1.0);
        q.x = 0.25 * s;
        q.y = (self[0,1] + self[1,0] ) / s;
        q.z = (self[0,2] + self[2,0] ) / s;
        q.w = (self[2,1] - self[1,2] ) / s;
      } else if (self[1,1] > self[2,2]) {
        s = 2.0 * sqrt(self[1,1] - self[0,0] - self[2,2] + 1.0);
        q.x = (self[0,1] + self[1,0] ) / s;
        q.y = 0.25 * s;
        q.z = (self[1,2] + self[2,1] ) / s;
        q.w = (self[0,2] - self[2,0] ) / s;
      } else {
        s = 2.0 * sqrt(self[2,2] - self[0,0] - self[1,1] + 1.0);
        q.x = (self[0,2] + self[2,0]) / s;
        q.y = (self[1,2] + self[2,1]) / s;
        q.z = 0.25 * s;
        q.w = (self[1,0] - self[0,1]) / s;
      }

      return q;
    }

  }
}

//struct Matrix4x4 {
//
//}
