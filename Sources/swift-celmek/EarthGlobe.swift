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

func geocentricToGeographicLatitude(lat: Double) -> Double
{
  // Meeus p81, p82
  // 𝜑: Geographical latitude
  // 𝜑': Geocentric latidude
  
  return atan(tan(lat) / ((EARTH_POLAR_RADIUS_KM * EARTH_POLAR_RADIUS_KM) / (EARTH_EQUATORIAL_RADIUS_KM * EARTH_EQUATORIAL_RADIUS_KM)))
  
}

func geographicToGeocentricLatitude(lat: Double) -> Double
{
  // Meeus p81, p82
  // 𝜑: Geographical latitude
  // 𝜑': Geocentric latidude
  
  return atan(((EARTH_POLAR_RADIUS_KM * EARTH_POLAR_RADIUS_KM) / (EARTH_EQUATORIAL_RADIUS_KM * EARTH_EQUATORIAL_RADIUS_KM)) * tan(lat))
  
}

func pcomp(H: Double, geographicLat: Double) -> (Double, Double) {
  let u = atan((EARTH_POLAR_RADIUS_KM / EARTH_EQUATORIAL_RADIUS_KM ) * tan(geographicLat))
  let psin = EARTH_POLAR_RADIUS_KM / EARTH_EQUATORIAL_RADIUS_KM * sin(u) + H / 6378140 * sin(geographicLat)
  let pcos = cos(u) + H / 6378140 * cos(geographicLat)
  return (psin, pcos)
}

// Radius in longitudial direction
func parallelOfLatitudeRadius(geographicalLat: Double) -> Double {
  let a = EARTH_EQUATORIAL_RADIUS_KM
  let e = EARTH_ECCENTRICITY
  return (a * cos(geographicalLat)) / sqrt(1 - e * e * sin(geographicalLat) * sin(geographicalLat))
}

// Radius in latitudial direction
func radiusOfCurvatureOfMeridian(geographicalLat: Double) -> Double {
  let a = EARTH_EQUATORIAL_RADIUS_KM
  let e = EARTH_ECCENTRICITY
  return (a * (1 - e * e)) / pow(1 - e * e * sin(geographicalLat) * sin(geographicalLat), 3.0/2.0)
}

func geodesicDistanceFast(p0: GeographicCoordinate, p1: GeographicCoordinate) -> Double {
  let L₁ = p0.longitude
  let 𝜑₁ = p0.latitude
  
  let L₂ = p1.longitude
  let 𝜑₂ = p1.latitude

  let d = acos(sin(𝜑₁) * sin(𝜑₂) + cos(𝜑₁) * cos(𝜑₂) * cos(L₁-L₂))
  let s = 6371.0 * d
  return s
}

func geodesicDistance(p0: GeographicCoordinate, p1: GeographicCoordinate) -> Double {
  let L₁ = p0.longitude
  let 𝜑₁ = p0.latitude
  
  let L₂ = p1.longitude
  let 𝜑₂ = p1.latitude

  let F = (𝜑₁ + 𝜑₂) / 2
  let G = (𝜑₁ - 𝜑₂) / 2
  let 𝜆 = (L₁ - L₂) / 2
  
  let sin²G = sin(G) * sin(G)
  let cos²𝜆 = cos(𝜆) * cos(𝜆)
  let cos²F = cos(F) * cos(F)
  let sin²𝜆 = sin(𝜆) * sin(𝜆)
  let cos²G = cos(G) * cos(G)
  let sin²F = sin(F) * sin(F)

  let S = sin²G * cos²𝜆 + cos²F * sin²𝜆
  let C = cos²G * cos²𝜆 + sin²F * sin²𝜆
  let tan𝜔 = sqrt(S/C)
  let 𝜔 = atan(tan𝜔)
  let R = sqrt(S*C)/𝜔

  let a = EARTH_EQUATORIAL_RADIUS_KM
  
  let D = 2 * 𝜔 * a
  let H₁ = (3 * R - 1) / (2 * C)
  let H₂ = (3 * R + 1) / (2 * S)
  
  let f = EARTH_FLATTENING

  let s = D * (1 + f * H₁ * sin²F * cos²G - f * H₂ * cos²F * sin²G)
  return s
}
