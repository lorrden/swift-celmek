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
import Foundation

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

func normalize(secondsInDay: Double) -> Double {
  let tmp = secondsInDay.remainder(dividingBy: 3600*24)
  if tmp < 0 {
    return tmp + 3600*24
  }
  return tmp
}


struct RightAscension {
  var hours: Int
  var minutes: Int
  var seconds: Double
}


extension RightAscension {
  init(seconds: Double) {
    let tmpSeconds = normalize(secondsInDay: seconds)
    self.seconds = tmpSeconds
    self.minutes = Int(tmpSeconds / 60)
    self.hours = self.minutes / 60
    self.minutes = normalize(minutes: self.minutes)
    self.seconds = normalize(seconds: self.seconds)
  }
  
  init(degrees: Double) {
    let h = degrees / DEGREES_PER_HOUR
    let m = modf(h).1 * 60.0
    let s = modf(m).1 * 60.0

    hours = Int(h)
    minutes = Int(m)
    seconds = s
  }

  static func +(lhs: RightAscension, rhs: RightAscension) -> RightAscension {
    var ra = RightAscension(hours: lhs.hours + rhs.hours, minutes: lhs.minutes + rhs.minutes, seconds: lhs.seconds + rhs.seconds)
    
    ra.minutes += Int(ra.seconds / 60)
    ra.seconds = normalize(seconds: ra.seconds)
    ra.hours += Int(ra.minutes / 60)
    ra.minutes = normalize(minutes: ra.minutes)
    ra.hours = normalize(hours: ra.hours)
    return ra
  }

  
  func toDeg() -> Double {
    let totalHours = Double(abs(self.hours)) + Double(self.minutes) / MINUTES_PER_HOUR + self.seconds / SECONDS_PER_HOUR

    if self.hours >= 0 {
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
