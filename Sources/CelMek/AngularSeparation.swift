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
// Meeus, chapter 17

fileprivate func angularSeparation(a0: Double, b0: Double, a1: Double, b1: Double) -> Double
{
  // Meeus, p115
  let 𝛼₁ = a0
  let 𝛿₁ = b0
  let 𝛼₂ = a1
  let 𝛿₂ = b1

  let x = cos(𝛿₁) * sin(𝛿₂) - sin(𝛿₁) * cos(𝛿₂) * cos(𝛼₂ - 𝛼₁)
  let y = cos(𝛿₂) * sin(𝛼₂ - 𝛼₁)
  let z = sin(𝛿₁) * sin(𝛿₂) + cos(𝛿₁) * cos(𝛿₂) * cos(𝛼₂ - 𝛼₁)
  let d = atan(sqrt(x*x + y*y) / z)
  return d
}

public func angularSeparation(_ c1:EquatorialCoordinate, _ c2: EquatorialCoordinate) -> Double {
  return angularSeparation(a0: c1.rightAscension, b0: c1.declination,
                           a1: c2.rightAscension, b1: c2.declination)
}

public func angularSeparation(_ c1:EclipticCoordinate, _ c2: EclipticCoordinate) -> Double {
  return angularSeparation(a0: c1.longitude, b0: c1.latitude,
                           a1: c2.longitude, b1: c2.latitude)
}


public func relativePositionAngle(_ c1:EquatorialCoordinate, _ c2: EquatorialCoordinate) -> Double {
  // Equation, p116

  let 𝛼₁ = c1.rightAscension
  let 𝛿₁ = c1.declination
  let 𝛼₂ = c2.rightAscension
  let 𝛿₂ = c2.declination
  let deltaA = 𝛼₁  - 𝛼₂

  return atan2(sin(deltaA), cos(𝛿₂) * tan(𝛿₁) - sin(𝛿₂) * cos(deltaA))
}
