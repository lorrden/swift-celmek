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

func parallacticAngle(geographicLatitudeOfObserver: Double, declination: Double, rightAscension: HourAngle) -> Double {
  // Meeus, Equation 14.1
  let 𝜑 = geographicLatitudeOfObserver
  let 𝛿 = declination
  let H = rightAscension.toRad()
  
  let q = atan2(sin(H), tan(𝜑) * cos(𝛿) - sin(𝛿) * cos(H))
  return q
}

// TODO: Function should have better name
func ecliptic(obliquityOfEcliptic: Double, geographicLatitudeOfObserver: Double, localSiderealTime: Double) -> (Double, Double){
  // Meeus, Equation 14.2 and 14.3
  let 𝜑 = geographicLatitudeOfObserver
  let 𝜃 = localSiderealTime
  let 𝜀 = obliquityOfEcliptic

  let 𝜆 = atan2(-cos(𝜃), sin(𝜀)*tan(𝜑) + cos(𝜀) * sin(𝜃)) // Eq 14.2
  let I = acos(cos(𝜀) * sin(𝜑) - sin(𝜀) * cos(𝜑) * sin(𝜃)) // Eq 14.3
  return (𝜆, I)
}
