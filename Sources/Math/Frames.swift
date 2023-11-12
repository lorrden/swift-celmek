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

// Code is inspired by Orekit frames
import Foundation

/*
 Frames are related to parent frames with a transformation of:
  Position, Velocity and Accelleration
  Rotation, Rotational Velocity and Rotational Accelleration
 */

struct Transformation {
  var date: Double
  var position: SIMD3<Double>
  var velocity: SIMD3<Double>
  var accelleration: SIMD3<Double>

  var quaternion: Quaternion
  var rotationMatrix: Matrix3x3 {
    return quaternion.matrix
  }
  var rotationRate: SIMD3<Double>
  var rotationAccelleration: SIMD3<Double>
}

class Frame {
  weak var parent: Frame?
  var depth: Int
  var name: String
  var pseudoInertial: Bool

  init(parent: Frame? = nil, name: String, pseudoInertial: Bool) {
    self.parent = parent
    self.depth = parent == nil ? 0 : parent!.depth + 1
    self.name = name
    self.pseudoInertial = pseudoInertial
  }

  func getAncestorAt(distance: Int) -> Frame? {
    assert(depth >= distance)
    var frame: Frame = self
    for _ in 0 ..< distance {
      guard let parent = frame.parent else {
        return nil
      }
      frame = parent
    }
    return frame
  }

  static func getCommon(from: Frame, to: Frame) -> Frame? {
    let commonFrom = from.depth > to.depth ? from.getAncestorAt(distance: from.depth - to.depth) : from
    let commonTo = from.depth > to.depth ? to : to.getAncestorAt(distance: to.depth - from.depth)
    guard var commonFrom, var commonTo else {
      return nil
    }

    while commonFrom !== commonTo {
      if commonFrom.parent == nil || commonTo.parent == nil {
        return nil
      }

      commonFrom = commonFrom.parent!
      commonTo = commonTo.parent!
    }
    return commonFrom
  }
}


// GCRF
// ICRF
// Ecliptic
// EME2000
// TIRF
// ITRF
// CIRF
// GTOD
// TOD
