//
// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2022 Mattias Holm
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

public func meanSideralTimeUT0(jd: Double) -> HourAngle {
  // Meeus, Eq. 12.2
  let jd_ = floor(jd) + 0.5
  let T = julianCenturiesFromJ2000(jd: jd_)
  let T² = T * T
  let T³ = T * T * T
  let ra0 = HourAngle(hours: 6, minutes: 41, seconds: 50.54841)

  let ra1 = HourAngle(seconds: 8640184.812866 * T + 0.093104 * T² - 0.0000062 * T³)

  let result = ra0 + ra1
  return result
}

public func meanSideralTimeDegreesUT0(jd: Double) -> Double {
  // Meeus, Eq. 12.3
  let jd_ = floor(jd) + 0.5
  let T = julianCenturiesFromJ2000(jd: jd_)
  let T² = T * T
  let T³ = T * T * T
  let 𝛩₀ = 100.46061837 + 36000.770053608 * T + 0.000387933 * T² - T³ / 38710000
  return normalize(degrees: 𝛩₀)
}

public func meanSiderealTimeDegrees(jd: Double) -> Double {
  // Meeus, Eq. 12.3 and adjustments for any time of day
  let 𝛩₀ = meanSideralTimeDegreesUT0(jd: jd)
  let 𝜃₀ = modf(jd).1
  return 𝛩₀ + 𝜃₀ * 1.00273790935
}

public func meanSiderealTimeDegrees0(jd: Double) -> Double {
  // Meeus, Eq. 12.4
  let T = julianCenturiesFromJ2000(jd: jd)
  let T² = T * T
  let T³ = T * T * T
  let 𝜃₀ = 280.46061837 + 360.98564736629 * (jd - 2451545.0) + 0.000387933 * T² - T³ / 38710000
  return normalize(degrees: 𝜃₀)
}

func apparentSiderealTimeDegrees(jd: Double) -> Double {
  // Meeus, Eq.
  let 𝛥_𝜓 = 0.0
  let 𝜖 = 0.0
  return 0.0
}
