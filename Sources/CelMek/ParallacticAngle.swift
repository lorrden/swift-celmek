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

public func parallacticAngle(geographicLatitudeOfObserver: Double, declination: Double, rightAscension: HourAngle) -> Double {
  // Meeus, Equation 14.1
  let 𝜑 = geographicLatitudeOfObserver
  let 𝛿 = declination
  let H = rightAscension.toRad()

  let q = atan2(sin(H), tan(𝜑) * cos(𝛿) - sin(𝛿) * cos(H))
  return q
}

// TODO: Function should have better name
public func eclipticAndHorizon(obliquityOfEcliptic: Double, geographicLatitudeOfObserver: Double, localSiderealTime: Double) -> (Double, Double){
  // Meeus, Equation 14.2 and 14.3
  let 𝜑 = geographicLatitudeOfObserver
  let 𝜃 = localSiderealTime
  let 𝜀 = obliquityOfEcliptic

  let 𝜆 = atan2(-cos(𝜃), sin(𝜀)*tan(𝜑) + cos(𝜀) * sin(𝜃)) // Eq 14.2 (longitude of ecliptic)
  let I = acos(cos(𝜀) * sin(𝜑) - sin(𝜀) * cos(𝜑) * sin(𝜃)) // Eq 14.3 (angle between ecliptic and horizon)
  return (𝜆, I)
}

public func extremeEclipticHorizonAngles(obliquityOfEcliptic: Double, geographicLatitudeOfObserver: Double) -> (Double, Double) {
  let 𝜑 = geographicLatitudeOfObserver
  let 𝜀 = obliquityOfEcliptic

  let I0 = 90.deg - 𝜑 + 𝜀
  let I1 = 90.deg - 𝜑 - 𝜀
  return (I0, I1)
}

public func angleBetweenNorthCelestialAndEclipticPoles(eclipticCoordinateOfStar: EclipticCoordinate, obliquityOfEcliptic: Double) -> Double {
  let 𝜆 = eclipticCoordinateOfStar.longitude
  let 𝛽 = eclipticCoordinateOfStar.latitude
  let 𝜀 = obliquityOfEcliptic

  let q = atan2(cos(𝜆) * tan(𝜀), sin(𝛽) * sin(𝜆) * tan(𝜀) - cos(𝛽))
  return q
}

public func angleBetweenEclipticAndEastWest(eclipticLongitude: Double, obliquityOfEcliptic: Double) -> Double {
  let 𝜆 = eclipticLongitude
  let 𝜀 = obliquityOfEcliptic
 
  let q0 = -cos(𝜆) * tan(𝜀)
  return q0
}

public func angleOfDiurnalPath(declination: Double, geographicLatitudeOfObserver: Double) -> Double {
  let 𝛿 = declination
  let 𝜑 = geographicLatitudeOfObserver

  let B = tan(𝛿) * tan(𝜑)
  let C = sqrt(1 - B * B)
  let J = atan2(C * cos(𝛿), tan(𝜑))
  return J
}
