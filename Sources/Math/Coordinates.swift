//
// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2020-2022 Mattias Holm
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

fileprivate let B1950_RIGHT_ASCENSION_NORTH_POLE: Double = 192.25.deg
fileprivate let B1950_DECLINATION_NORTH_POLE: Double = 27.4.deg

@frozen
public struct GeographicCoordinate {
  public var latitude: Double
  public var longitude: Double // Positive in westward direction
  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}

@frozen
public struct HorizontalCoordinate {
  public var altitude: Double
  public var azimuth: Double // From south, westward
  public init(altitude: Double, azimuth: Double) {
    self.altitude = altitude
    self.azimuth = azimuth
  }
}


@frozen
public struct EquatorialCoordinate {
  public var rightAscension: Double
  public var declination: Double
  public init(rightAscension: Double, declination: Double) {
    self.rightAscension = rightAscension
    self.declination = declination
  }
}


@frozen
public struct EclipticCoordinate {
  public var latitude: Double
  public var longitude: Double // From vernal equinox
  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}

@frozen
public struct GalacticCoordinate {
  public var latitude: Double
  public var longitude: Double // From vernal equinox
  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}


extension EclipticCoordinate {
  public init(equatorial: EquatorialCoordinate, obliquityOfEcliptic: Double) {
    let 𝛼 = equatorial.rightAscension
    let 𝛿 = equatorial.declination
    let 𝜀 = obliquityOfEcliptic

    let 𝜆 = atan2(sin(𝛼) * cos(𝜀) + tan(𝛿) * sin(𝜀), cos(𝛼))
    let sin𝛽 = sin(𝛿) * cos(𝜀) - cos(𝛿) * sin(𝜀) * sin(𝛼)

    let 𝛽 = asin(sin𝛽)

    self.init(latitude: 𝛽, longitude: 𝜆)
  }
}


extension EquatorialCoordinate {
  public init(ecliptic: EclipticCoordinate, obliquityOfEcliptic: Double) {
    let 𝜆 = ecliptic.longitude
    let 𝛽 = ecliptic.latitude
    let 𝜀 = obliquityOfEcliptic

    let 𝛼 = atan2(sin(𝜆) * cos(𝜀) - tan(𝛽) * sin(𝜀), cos(𝜆))
    let sin𝛿 = sin(𝛽) * cos(𝜀) + cos(𝛽) * sin(𝜀) * sin(𝜆)

    let 𝛿 = asin(sin𝛿)

    self.init(rightAscension: 𝛼, declination: 𝛿)
  }


  public init(horizontal: HorizontalCoordinate, localSiderealTime: Double, observerLatitude: Double) {
    let A = horizontal.azimuth
    let h = horizontal.altitude
    let 𝜑 = observerLatitude
    let 𝜃 = localSiderealTime

    let H = atan2(sin(A), (cos(A) * sin(𝜑) + tan(h) * cos(𝜑)))
    let sin𝛿 = sin(𝜑) * sin(h) - cos(𝜑) * cos(h) * cos(A)

    let 𝛿 = asin(sin𝛿)
    let 𝛼 = 𝜃 - H

    self.init(rightAscension: 𝛼, declination: 𝛿)
  }

  public init(horizontal: HorizontalCoordinate, greenwichSiderealTime: Double, observerLatitude: Double, observerLongitude: Double) {
    let A = horizontal.azimuth
    let h = horizontal.altitude
    let 𝜑 = observerLatitude
    let 𝜃₀ = greenwichSiderealTime
    let L = observerLongitude
    let H = atan2(sin(A), (cos(A) * sin(𝜑) + tan(h) * cos(𝜑)))
    let sin𝛿 = sin(𝜑) * sin(h) - cos(𝜑) * cos(h) * cos(A)

    let 𝛿 = asin(sin𝛿)
    let 𝛼 = 𝜃₀ - L - H

    self.init(rightAscension: 𝛼, declination: 𝛿)
  }
}

extension HorizontalCoordinate {
  public init(localHourAngle: Double, observerLatitude: Double, declination: Double) {
    let 𝛿 = declination
    let H = localHourAngle
    let 𝜑 = observerLatitude

    let A = atan2(sin(H), (cos(H) * sin(𝜑) - tan(𝛿) * cos(𝜑)))
    let sinh = sin(𝜑) * sin(𝛿) + cos(𝜑) * cos(𝛿) * cos(H)

    let h = asin(sinh)

    self.init(altitude: h, azimuth: A)
  }
}

func cubeToSphere(_ p: SIMD3<Double>) -> SIMD3<Double> {
  let tmp = SIMD3(sqrt(1.0-p.y*p.y*0.5-p.z*p.z*0.5+p.y*p.y*p.z*p.z/3.0),
                  sqrt(1.0-p.z*p.z*0.5-p.x*p.x*0.5+p.z*p.z*p.x*p.x/3.0),
                  sqrt(1.0-p.x*p.x*0.5-p.y*p.y*0.5+p.x*p.x*p.y*p.y/3.0))

  return p * tmp
}

// The sphere to cube mapping function is hardened against rounding error
// using the fmax calls.
// DO NOT REMOVE THEM, since we otherwise get values like 1e-16 passed to sqrt!
func sphereToCube(_ p: SIMD3<Double>) -> SIMD3<Double> {
  let pabs = SIMD3(fabs(p.x), fabs(p.y), fabs(p.z))
  var cp = SIMD3<Double>(repeating: 0)

  if pabs.x >= pabs.y && pabs.x >= pabs.z {
    cp.x = copysign(1, p.x)

    let y2 = 2 * p.y * p.y
    let z2 = 2 * p.z * p.z
    let y2z2_3 = -y2 + z2 - 3
    let inner = -sqrt(y2z2_3 * y2z2_3 - 12 * y2)

    if p.y == 0 {
      cp.y = 0
    } else {
      cp.y = copysign(sqrt(fmax(inner + y2 - z2 + 3, 0))/2.squareRoot(), p.y)
    }

    if p.z == 0 {
      cp.z = 0
    } else {
      cp.z = copysign(sqrt(fmax(inner - y2 + z2 + 3.0, 0))/2.squareRoot(), p.z)
    }
  } else if pabs.y >= pabs.x && pabs.y >= pabs.z {
    let z2 = 2 * p.z * p.z
    let x2 = 2 * p.x * p.x
    let z2x2_3 = -z2 + x2 - 3
    let inner = -sqrt(z2x2_3 * z2x2_3 - 12 * z2)

    if p.x == 0 {
      cp.x = 0
    } else {
      cp.x = copysign(sqrt(fmax(inner + x2 - z2 + 3, 0))/2.squareRoot(), p.x)
    }
    cp.y = copysign(1, p.y);

    if p.z == 0 {
      cp.z = 0
    } else {
      cp.z = copysign(sqrt(fmax(inner - x2 + z2 + 3, 0))/2.squareRoot(), p.z)
    }
  } else if pabs.z >= pabs.x && pabs.z >= pabs.y {
    let x2 = 2 * p.x * p.x
    let y2 = 2 * p.y * p.y
    let x2y2_3 = -x2+y2 - 3
    let inner = -sqrt(x2y2_3 * x2y2_3 - 12 * x2)

    if p.x == 0 {
      cp.x = 0
    } else {
      cp.x = copysign(sqrt(fmax(inner + x2 - y2 + 3, 0))/2.squareRoot(), p.x)
    }

    if (p.y == 0) {
      cp.y = 0
    } else {
      cp.y = copysign(sqrt(fmax(inner - x2 + y2 + 3, 0))/2.squareRoot(), p.y)
    }
    cp.z = copysign(1, p.z);
  } else {
    abort()
  }
  return cp
}



extension GalacticCoordinate {
  public init(equatorial: EquatorialCoordinate) {
    let 𝛼 = equatorial.rightAscension
    let 𝛼₁₉₅₀ = B1950_RIGHT_ASCENSION_NORTH_POLE
    let 𝛿 = equatorial.declination
    let 𝛿₁₉₅₀ = B1950_DECLINATION_NORTH_POLE

    let x = atan2(sin(𝛼₁₉₅₀ - 𝛼), cos(𝛼₁₉₅₀ - 𝛼) * sin(𝛿₁₉₅₀) - tan(𝛿) * cos(𝛿₁₉₅₀))
    let l = 303.0.deg - x
    let sinb = sin(𝛿) * sin(𝛿₁₉₅₀) + cos(𝛿) * cos(𝛿₁₉₅₀) * cos(𝛼₁₉₅₀ - 𝛼)
    let b = asin(sinb)

    self.init(latitude: b, longitude: normalize(radians: l))
  }
}

extension EquatorialCoordinate {
  public init(galactic: GalacticCoordinate) {
    let l = galactic.longitude
    let b = galactic.latitude
    let 𝛿₁₉₅₀ = B1950_DECLINATION_NORTH_POLE

    let y = atan2(sin(l - 123.0.deg), (cos(l - 123.0.deg) * sin(𝛿₁₉₅₀) - tan(b) * cos(𝛿₁₉₅₀)))
    let 𝛼 = y + 12.25.deg
    let sin𝛿 = sin(b) * sin(𝛿₁₉₅₀) + cos(b) * cos(𝛿₁₉₅₀) * cos(l - 123.0.deg)

    self.init(rightAscension: 𝛼, declination: asin(sin𝛿))
  }
}
