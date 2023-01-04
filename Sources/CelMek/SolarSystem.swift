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

func eccentricityOfUranus(T: Double) -> Double?
{
  // Meeus, Astronomical Algorithms 2nd edition, Equation 1.1
  // TODO: Test Case is missing
  if T.magnitude > 30.0 {
    return nil
  }
  return 0.04638122 - 0.000027293 * T + 0.0000000789 * T * T
}


func geometricLongitudeOfSun(T: Double) -> Double
{
  // Meeus, Astronomical Algorithms 2nd edition, Equation p16
  // TODO: Test Case is missing
  let L0 = AngleOfArc(degrees: 280, minutes:27, seconds:59.245).toDeg()
  let L1 = AngleOfArc(degrees: 0, minutes:0, seconds:129602771.380).toDeg()
  let L2 = AngleOfArc(degrees: 0, minutes:0, seconds:1.0915).toDeg()
  return L0 + L1 * T + L2 * T * T
}
