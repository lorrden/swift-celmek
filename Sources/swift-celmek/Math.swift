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

func cm_degToRad(_ deg: Double) -> Double {
  return deg * .pi / 180.0
}

func cm_radToDeg(_ rad: Double) -> Double {
  return rad * 180.0 / .pi
}

extension Double {
  func toRad() -> Double {
    return self * (.pi / 180.0)
  }
  func toDeg() -> Double {
    return self * (180.0 / .pi)
  }
  func degToHours() -> Double {
    return self / 15.0
  }
  func hoursToDeg() -> Double {
    return self * 15.0
  }
}

struct RightAscension {
  var hours: Double
  var minutes: Double
  var seconds: Double
}
extension RightAscension {
  func toDeg() -> Double {
    let totalHours = self.hours.magnitude + self.minutes / MINUTES_PER_HOUR + self.seconds / SECONDS_PER_HOUR

    if self.hours.sign == .plus {
      return totalHours.hoursToDeg()
    } else {
      return -totalHours.hoursToDeg()
    }
  }
  
  func toRad() -> Double {
    return toDeg().toRad()
  }
}

@frozen
public struct GeographicCoordinate {
  var latitude: Double
  var longitude: Double
}

struct AngleOfArc {
  var degrees: Double
  var minutes: Double
  var seconds: Double
}
extension AngleOfArc {
  func toDeg() -> Double {
    let totalDegrees = self.degrees.magnitude + self.minutes / MINUTES_OF_ARC_PER_DEGREE + self.seconds / SECONDS_OF_ARC_PER_DEGREE
    if self.degrees.sign == .plus {
      return totalDegrees
    } else {
      return -totalDegrees
    }
  }
  
  func toRad() -> Double {
    return toDeg().toRad()
  }
}
