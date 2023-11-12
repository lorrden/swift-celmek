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
import Math

// Meeus, chapter 22

fileprivate func meanElongationOfTheMoonFromTheSun(T: Double) -> Double {
  return normalize(degrees: 297.85036 + 445267.111480*T - 0.0019142*T*T + T*T*T/(189474))
}

fileprivate func meanAnomalyOfTheSun(T: Double) -> Double {
  return normalize(degrees: 357.52772 + 35999.050340*T - 0.0001603*T*T - T*T*T/(300000))
}

fileprivate func meanAnomalyOfTheMoon(T: Double) -> Double {
  return normalize(degrees: 134.96298 + 477198.867398*T + 0.0086972*T*T + T*T*T/(56250))
}
fileprivate func moonsArgumentOfLatitude(T: Double) -> Double {
  return normalize(degrees: 93.27191 + 483202.017538*T - 0.0036825*T*T + T*T*T/(327270))
}

fileprivate func longitudeOfAscendingNodeOfMoonsMeanOrbitOnEcliptic(T: Double) -> Double {
  return normalize(degrees: 125.04452 - 1934.136261*T + 0.0020708*T*T + T*T*T/(450000))
}

@frozen
public struct Nutation {
  let nutationInLongitude: Double
  let nutationInObliquity: Double
}

// Returns nutation in longitude and nutation in obliquity
public func fastNutation(jd: Double) -> Nutation {
  let T = julianCenturiesFromJ2000(jd: jd)
  let Omega = longitudeOfAscendingNodeOfMoonsMeanOrbitOnEcliptic(T: T).deg
  let L = normalize(degrees: (280.4665 + 36000.7698*T))
  let Lprime = normalize(degrees: (218.3165 + 481267.8813 * T)).deg
  let x = (-17.20 * sin(Omega)) - 1.32 * sin(2*L) - 0.23 * sin(2*Lprime) + 0.21 * sin(2*Omega)
  let y = 9.20 * cos(Omega) + 0.57 * cos(2*L) + 0.10 * cos(2*Lprime) - 0.09 * cos(2*Omega)
  return Nutation(nutationInLongitude: x.arcsec, nutationInObliquity: y.arcsec)
}

fileprivate struct NutationCoefficient {
  var D: Double
  var M: Double
  var Mprime: Double
  var F: Double
  var omega: Double
  var sinCoefficient0: Double
  var sinCoefficient1: Double
  var cosCoefficient0: Double
  var cosCoefficient1: Double

  init(_ D: Double, _ M: Double, _ Mprime: Double, _ F: Double, _ omega: Double,
       _ sinCoefficient0: Double, _ sinCoefficient1: Double,
       _ cosCoefficient0: Double, _ cosCoefficient1: Double) {
    self.D = D
    self.M = M
    self.Mprime = Mprime
    self.F = F
    self.omega = omega
    self.sinCoefficient0 = sinCoefficient0
    self.sinCoefficient1 = sinCoefficient1
    self.cosCoefficient0 = cosCoefficient0
    self.cosCoefficient1 = cosCoefficient1
  }
}
fileprivate let nutationCoefficients: [NutationCoefficient] = [
  NutationCoefficient( 0,  0,  0, 0, 1, -171996, -174.2, 92025,  8.9),
  NutationCoefficient(-2,  0,  0, 2, 2,  -13187,   -1.6,  5736, -3.1),
  NutationCoefficient( 0,  0,  0, 2, 2,   -2274,   -0.2,   977, -0.5),
  NutationCoefficient( 0,  0,  0, 0, 2,    2062,    0.2,  -895,  0.5),
  NutationCoefficient( 0,  1,  0, 0, 0,    1426,   -3.4,    45, -0.1),
  NutationCoefficient( 0,  0,  1, 0, 0,     712,    0.1,    -7,  0.0),
  NutationCoefficient(-2,  1,  0, 2, 2,    -517,    1.2,   224, -0.6),
  NutationCoefficient( 0,  0,  0, 2, 1,    -386,   -0.4,   200,  0.0),
  NutationCoefficient( 0,  0,  1, 2, 2,    -301,    0.0,   129, -0.1),
  NutationCoefficient(-2, -1,  0, 2, 2,     217,   -0.5,   -95,  0.3),
  NutationCoefficient(-2,  0,  1, 0, 0,    -158,    0,       0,  0),
  NutationCoefficient(-2,  0,  0, 2, 1,     129,    0.1,   -70,  0),
  NutationCoefficient( 0,  0, -1, 2, 2,     123,    0,     -53,  0),
  NutationCoefficient( 2,  0,  0, 0, 0,      63,    0,       0,  0),
  NutationCoefficient( 0,  0,  1, 0, 1,      63,    0.1,   -33,  0),
  NutationCoefficient( 2,  0, -1, 2, 2,     -59,    0,      26,  0),
  NutationCoefficient( 0,  0, -1, 0, 1,     -58,   -0.1,    32,  0),
  NutationCoefficient( 0,  0,  1, 2, 1,     -51,    0,      27,  0),
  NutationCoefficient(-2,  0,  2, 0, 0,      48,    0,       0,  0),
  NutationCoefficient( 0,  0, -2, 2, 1,      46,    0,     -24,  0),
  NutationCoefficient( 2,  0,  0, 2, 2,     -38,    0,      16,  0),
  NutationCoefficient( 0,  0,  2, 2, 2,     -31,    0,      13,  0),
  NutationCoefficient( 0,  0,  2, 0, 0,      29,    0,       0,  0),
  NutationCoefficient(-2,  0,  1, 2, 2,      29,    0,     -12,  0),
  NutationCoefficient( 0,  0,  0, 2, 0,      26,    0,       0,  0),
  NutationCoefficient(-2,  0,  0, 2, 0,     -22,    0,       0,  0),
  NutationCoefficient( 0,  0, -1, 2, 1,      21,    0,     -10,  0),
  NutationCoefficient( 0,  2,  0, 0, 0,      17,   -0.1,     0,  0),
  NutationCoefficient( 2,  0, -1, 0, 1,      16,    0,      -8,  0),
  NutationCoefficient(-2,  2,  0, 2, 2,     -16,    0.1,     7,  0),
  NutationCoefficient( 0,  1,  0, 0, 1,     -15,    0,       9,  0),

  NutationCoefficient(-2,  0,  1,  0, 1, -13, 0,  7, 0),
  NutationCoefficient( 0, -1,  0,  0, 1, -12, 0,  6, 0),
  NutationCoefficient( 0,  0,  2, -2, 0,  11, 0,  0, 0),
  NutationCoefficient( 2,  0, -1,  2, 1, -10, 0,  5, 0),
  NutationCoefficient( 2,  0,  1,  2, 2,  -8, 0,  3, 0),
  NutationCoefficient( 0,  1,  0,  2, 2,   7, 0, -3, 0),
  NutationCoefficient(-2,  1,  1,  0, 0,  -7, 0,  0, 0),
  NutationCoefficient( 0, -1,  0,  2, 2,  -7, 0,  3, 0),
  NutationCoefficient( 2,  0,  0,  2, 1,  -7, 0,  3, 0),
  NutationCoefficient( 2,  0,  1,  0, 0,   6, 0,  0, 0),
  NutationCoefficient(-2,  0,  2,  2, 2,   6, 0, -3, 0),
  NutationCoefficient(-2,  0,  1,  2, 1,   6, 0, -3, 0),
  NutationCoefficient( 2,  0, -2,  0, 1,  -6, 0,  3, 0),
  NutationCoefficient( 2,  0,  0,  0, 1,  -6, 0,  3, 0),
  NutationCoefficient( 0, -1,  1,  0, 0,   5, 0,  0, 0),
  NutationCoefficient(-2, -1,  0,  2, 1,  -5, 0,  3, 0),
  NutationCoefficient(-2,  0,  0,  0, 1,  -5, 0,  3, 0),
  NutationCoefficient( 0,  0,  2,  2, 1,  -5, 0,  3, 0),
  NutationCoefficient(-2,  0,  2,  0, 1,   4, 0,  0, 0),
  NutationCoefficient(-2,  1,  0,  2, 1,   4, 0,  0, 0),
  NutationCoefficient( 0,  0,  1, -2, 0,   4, 0,  0, 0),
  NutationCoefficient(-1,  0,  1,  0, 0,  -4, 0,  0, 0),
  NutationCoefficient(-2,  1,  0,  0, 0,  -4, 0,  0, 0),
  NutationCoefficient( 1,  0,  0,  0, 0,  -4, 0,  0, 0),
  NutationCoefficient( 0,  0,  1,  2, 0,   3, 0,  0, 0),
  NutationCoefficient( 0,  0, -2,  2, 2,  -3, 0,  0, 0),
  NutationCoefficient(-1, -1,  1,  0, 0,  -3, 0,  0, 0),
  NutationCoefficient( 0,  1,  1,  0, 0,  -3, 0,  0, 0),
  NutationCoefficient( 0, -1,  1,  2, 2,  -3, 0,  0, 0),
  NutationCoefficient( 2, -1, -1,  2, 2,  -3, 0,  0, 0),
  NutationCoefficient( 0,  0,  3,  2, 2,  -3, 0,  0, 0),
  NutationCoefficient( 2, -1,  0,  2, 2,  -3, 0,  0, 0)
]

// Returns nutation in longitude and nutation in obliquity
public func nutation(jd: Double) -> Nutation {
  let T = julianCenturiesFromJ2000(jd: jd)
  let D = meanElongationOfTheMoonFromTheSun(T: T)
  let M = meanAnomalyOfTheSun(T: T)
  let Mprime = meanAnomalyOfTheMoon(T: T)
  let F = moonsArgumentOfLatitude(T: T)
  let Omega = longitudeOfAscendingNodeOfMoonsMeanOrbitOnEcliptic(T: T)

  var x :Double = 0
  var y :Double = 0
  for nc in nutationCoefficients {
    let argument = (nc.D * D + nc.M * M + nc.Mprime * Mprime + nc.F * F + nc.omega * Omega).deg

    x += (nc.sinCoefficient0 + nc.sinCoefficient1 * T)*sin(argument)
    y += (nc.cosCoefficient0 + nc.cosCoefficient1 * T)*cos(argument)
  }
  x *= 0.0001
  y *= 0.0001

  return Nutation(nutationInLongitude: x.arcsec, nutationInObliquity: y.arcsec)
}

public func fastMeanObliquityOfTheEcliptic(jd: Double) -> Double {
  // Meeus, Equation 22.2
  let T = julianCenturiesFromJ2000(jd: jd)
  let T2 = T * T
  let T3 = T * T * T
  let e0 = AngleOfArc(degrees: 23, minutes: 26, seconds: 21.448).toRad() - 46.8150.arcsec * T - 0.00059.arcsec * T2 + 0.001813.arcsec * T3
  return e0
}

public func meanObliquityOfTheEcliptic(jd: Double) -> Double {
  // Meeus, Equation 22.3
  let T = julianCenturiesFromJ2000(jd: jd)
  let U = T / 100
  let U2 = U * U
  let U3 = U2 * U
  let U4 = U2 * U2
  let U5 = U4 * U
  let U6 = U3 * U3
  let U7 = U6 * U
  let U8 = U4 * U4
  let U9 = U8 * U
  let U10 = U5 * U5


  let a = AngleOfArc(degrees: 23, minutes: 26, seconds: 21.448).toRad()
  let b = -4680.93 * U
    - 1.55 * U2
    + 1999.25 * U3
    - 51.38 * U4
    - 249.67 * U5
    - 39.05 * U6
    + 7.12 * U7
    + 27.87 * U8
    + 5.79 * U9
    + 2.45 * U10
  let e0 = a + b.arcsec
  return e0
}

public func fastTrueObliquityOfTheEcliptic(jd: Double) -> Double {
  let nut = fastNutation(jd: jd)
  let ed = nut.nutationInObliquity
  let e0 = fastMeanObliquityOfTheEcliptic(jd: jd)
  return e0 + ed
}

public func trueObliquityOfTheEcliptic(jd: Double) -> Double {
  let nut = nutation(jd: jd)
  let ed = nut.nutationInObliquity
  let e0 = meanObliquityOfTheEcliptic(jd: jd)
  return e0 + ed
}
