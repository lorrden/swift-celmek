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
// Meeus, chapter 20

public func smallestCircle(_ p1: EquatorialCoordinate,
                           _ p2: EquatorialCoordinate,
                           _ p3: EquatorialCoordinate) -> Double {
  let x = angularSeparation(p1, p2)
  let y = angularSeparation(p1, p3)
  let z = angularSeparation(p2, p3)

  var a, b, c: Double
  if x >= y && x >= z {
    a = x
    b = y
    c = z
  } else if y >= x && y >= z {
    a = y
    b = x
    c = z
  } else {
    a = z
    b = x
    c = y
  }

  if a >= sqrt(b*b + c*c) {
    return a
  }
  let d = 2 * a * b * c
  let e = (a + b + c) * (a + b - c) * (b + c - a) * (a + c - b)
  return d / sqrt(e)
}
