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

func normalize(degrees: Double) -> Double {
  let tmp = degrees.remainder(dividingBy: 360.0)
  if tmp < 0.0 {
    return tmp + 360.0
  }
  return tmp
}

func normalize(seconds: Double) -> Double {
  let tmp = seconds.remainder(dividingBy: 60.0)
  if tmp < 0.0 {
    return tmp + 60.0
  }
  return tmp
}

func normalize(minutes: Int) -> Int {
  let tmp = minutes % 60
  if tmp < 0 {
    return tmp + 60
  }
  return tmp
}

func normalize(hours: Int) -> Int {
  let tmp = hours % 24
  if tmp < 0 {
    return tmp + 24
  }
  return tmp
}



func meanSideralTimeUT0(jd: Double) -> RightAscension {
  let jd_ = floor(jd) + 0.5
  let T =  (jd_ - 2451545) / 36525
  let ra0 = RightAscension(hours: 6, minutes: 41, seconds: 50.54841)
  
  let ra1 = RightAscension(seconds: 8640184.812866 * T + 0.093104 * T * T - 0.0000062 * T * T * T)

  let result = ra0 + ra1
  return result
}


func meanSideralTimeDegreesUT0(jd: Double) -> Double {
  let jd_ = floor(jd) + 0.5
  let T =  (jd_ - 2451545) / 36525
  let 𝛩₀ = 100.46061837 + 36000.770053608 * T + 0.000387933 * T * T - T * T * T / 38710000
  return normalize(degrees: 𝛩₀)
}

func meanSiderealTimeDegrees(jd: Double) -> Double {
  let 𝛩₀ = meanSideralTimeDegreesUT0(jd: jd)
  let 𝜃₀ = modf(jd).1
  return 𝛩₀ + 𝜃₀ * 1.00273790935
}

func meanSiderealTimeDegrees0(jd: Double) -> Double {
  let T = (jd - 2451545) / 36525
  let 𝜃₀ = 280.46061837 + 360.98564736629 * (jd - 2451545.0) + 0.000387933 * T * T - T * T * T / 38710000
  return normalize(degrees: 𝜃₀)
}

func apparentSiderealTimeDegrees(jd: Double) -> Double {
  let 𝛥_𝜓 = 0.0
  let 𝜖 = 0.0
  return 0.0
}
