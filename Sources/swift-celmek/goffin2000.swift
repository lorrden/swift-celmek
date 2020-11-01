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


fileprivate struct Term {
  var j, s, p:Double
  var long_a, long_b:Double
  var lat_a, lat_b:Double
  var rad_a, rad_b:Double
  init(_ j: Double, _ s:Double, _ p:Double,
       _ long_a: Double, _ long_b: Double,
       _ lat_a: Double, _ lat_b: Double,
       _ rad_a: Double, _ rad_b: Double) {
    self.j = j
    self.s = s
    self.p = p
    self.long_a = long_a
    self.long_b = long_b
    self.lat_a = lat_a
    self.lat_b = lat_b
    self.rad_a = rad_a
    self.rad_b = rad_b
  }
}

fileprivate let terms: [Term] = [
  Term(0,  0,  1, cm_degToRad(-19798886*1.0e-6), cm_degToRad(19848454*1.0e-6), cm_degToRad(-5453098*1.0e-6), cm_degToRad(-14974876*1.0e-6),  66867334*1.0e-7, 68955876*1.0e-7),
  Term(0,  0,  2, cm_degToRad(   897499*1.0e-6), cm_degToRad(-4955707*1.0e-6), cm_degToRad( 3527363*1.0e-6), cm_degToRad(  1672673*1.0e-6), -11826086*1.0e-7,  -333765*1.0e-7),
  Term(0,  0,  3, cm_degToRad(   610820*1.0e-6), cm_degToRad( 1210521*1.0e-6), cm_degToRad(-1050939*1.0e-6), cm_degToRad(   327763*1.0e-6),   1593657*1.0e-7, -1439953*1.0e-7),
  Term(0,  0,  4, cm_degToRad(  -341639*1.0e-6), cm_degToRad( -189719*1.0e-6), cm_degToRad(  178691*1.0e-6), cm_degToRad(  -291925*1.0e-6),    -18948*1.0e-7,   482443*1.0e-7),
  Term(0,  0,  5, cm_degToRad(   129027*1.0e-6), cm_degToRad(  -34863*1.0e-6), cm_degToRad(   18763*1.0e-6), cm_degToRad(   100448*1.0e-6),    -66634*1.0e-7,   -85576*1.0e-7),
  Term(0,  0,  6, cm_degToRad(   -38215*1.0e-6), cm_degToRad(   31061*1.0e-6), cm_degToRad(  -30594*1.0e-6), cm_degToRad(   -25838*1.0e-6),     30841*1.0e-7,    -5765*1.0e-7),
  Term(0,  1, -1, cm_degToRad(    20349*1.0e-6), cm_degToRad(   -9886*1.0e-6), cm_degToRad(    4965*1.0e-6), cm_degToRad(    11263*1.0e-6),     -6140*1.0e-7,    22254*1.0e-7),
  Term(0,  1,  0, cm_degToRad(    -4045*1.0e-6), cm_degToRad(   -4904*1.0e-6), cm_degToRad(     310*1.0e-6), cm_degToRad(     -132*1.0e-6),      4434*1.0e-7,     4443*1.0e-7),
  Term(0,  1,  1, cm_degToRad(    -5885*1.0e-6), cm_degToRad(   -3238*1.0e-6), cm_degToRad(    2036*1.0e-6), cm_degToRad(     -947*1.0e-6),     -1518*1.0e-7,      641*1.0e-7),
  Term(0,  1,  2, cm_degToRad(    -3812*1.0e-6), cm_degToRad(    3011*1.0e-6), cm_degToRad(      -2*1.0e-6), cm_degToRad(     -674*1.0e-6),        -5*1.0e-7,      792*1.0e-7),
  Term(0,  1,  3, cm_degToRad(     -601*1.0e-6), cm_degToRad(    3468*1.0e-6), cm_degToRad(    -329*1.0e-6), cm_degToRad(     -563*1.0e-6),       518*1.0e-7,      518*1.0e-7),
  Term(0,  2, -2, cm_degToRad(     1237*1.0e-6), cm_degToRad(     463*1.0e-6), cm_degToRad(     -64*1.0e-6), cm_degToRad(       39*1.0e-6),       -13*1.0e-7,     -221*1.0e-7),
  Term(0,  2, -1, cm_degToRad(     1086*1.0e-6), cm_degToRad(    -911*1.0e-6), cm_degToRad(     -94*1.0e-6), cm_degToRad(      210*1.0e-6),       837*1.0e-7,     -494*1.0e-7),
  Term(0,  2,  0, cm_degToRad(      595*1.0e-6), cm_degToRad(   -1229*1.0e-6), cm_degToRad(      -8*1.0e-6), cm_degToRad(     -160*1.0e-6),      -281*1.0e-7,      616*1.0e-7),
  Term(1, -1,  0, cm_degToRad(     2484*1.0e-6), cm_degToRad(    -485*1.0e-6), cm_degToRad(    -177*1.0e-6), cm_degToRad(      259*1.0e-6),       260*1.0e-7,     -395*1.0e-7),
  Term(1, -1,  1, cm_degToRad(      839*1.0e-6), cm_degToRad(   -1414*1.0e-6), cm_degToRad(      17*1.0e-6), cm_degToRad(      234*1.0e-6),      -191*1.0e-7,     -396*1.0e-7),
  Term(1,  0, -3, cm_degToRad(     -964*1.0e-6), cm_degToRad(    1059*1.0e-6), cm_degToRad(     582*1.0e-6), cm_degToRad(     -285*1.0e-6),     -3218*1.0e-7,      370*1.0e-7),
  Term(1,  0, -2, cm_degToRad(    -2303*1.0e-6), cm_degToRad(   -1038*1.0e-6), cm_degToRad(    -298*1.0e-6), cm_degToRad(      692*1.0e-6),      8019*1.0e-7,    -7869*1.0e-7),
  Term(1,  0, -1, cm_degToRad(     7049*1.0e-6), cm_degToRad(     747*1.0e-6), cm_degToRad(     157*1.0e-6), cm_degToRad(      201*1.0e-6),       105*1.0e-7,    45637*1.0e-7),
  Term(1,  0,  0, cm_degToRad(     1179*1.0e-6), cm_degToRad(    -358*1.0e-6), cm_degToRad(     304*1.0e-6), cm_degToRad(      825*1.0e-6),      8623*1.0e-7,     8444*1.0e-7),
  Term(1,  0,  1, cm_degToRad(      393*1.0e-6), cm_degToRad(     -63*1.0e-6), cm_degToRad(    -124*1.0e-6), cm_degToRad(      -29*1.0e-6),      -896*1.0e-7,     -801*1.0e-7),
  Term(1,  0,  2, cm_degToRad(      111*1.0e-6), cm_degToRad(    -268*1.0e-6), cm_degToRad(      15*1.0e-6), cm_degToRad(        8*1.0e-6),       208*1.0e-7,     -122*1.0e-7),
  Term(1,  0,  3, cm_degToRad(      -52*1.0e-6), cm_degToRad(    -154*1.0e-6), cm_degToRad(       7*1.0e-6), cm_degToRad(       15*1.0e-6),      -133*1.0e-7,       65*1.0e-7),
  Term(1,  0,  4, cm_degToRad(      -78*1.0e-6), cm_degToRad(     -30*1.0e-6), cm_degToRad(       2*1.0e-6), cm_degToRad(        2*1.0e-6),       -16*1.0e-7,        1*1.0e-7),
  Term(1,  1, -3, cm_degToRad(      -34*1.0e-6), cm_degToRad(     -26*1.0e-6), cm_degToRad(       4*1.0e-6), cm_degToRad(        2*1.0e-6),       -22*1.0e-7,        7*1.0e-7),
  Term(1,  1, -2, cm_degToRad(      -43*1.0e-6), cm_degToRad(       1*1.0e-6), cm_degToRad(       3*1.0e-6), cm_degToRad(        0*1.0e-6),        -8*1.0e-7,       16*1.0e-7),
  Term(1,  1, -1, cm_degToRad(      -15*1.0e-6), cm_degToRad(      21*1.0e-6), cm_degToRad(       1*1.0e-6), cm_degToRad(       -1*1.0e-6),         2*1.0e-7,        9*1.0e-7),
  Term(1,  1,  0, cm_degToRad(       -1*1.0e-6), cm_degToRad(      15*1.0e-6), cm_degToRad(       0*1.0e-6), cm_degToRad(       -2*1.0e-6),        12*1.0e-7,        5*1.0e-7),
  Term(1,  1,  1, cm_degToRad(        4*1.0e-6), cm_degToRad(       7*1.0e-6), cm_degToRad(       1*1.0e-6), cm_degToRad(        0*1.0e-6),         1*1.0e-7,       -3*1.0e-7),
  Term(1,  1,  3, cm_degToRad(        1*1.0e-6), cm_degToRad(       5*1.0e-6), cm_degToRad(       1*1.0e-6), cm_degToRad(       -1*1.0e-6),         1*1.0e-7,        0*1.0e-7),
  Term(2,  0, -6, cm_degToRad(        8*1.0e-6), cm_degToRad(       3*1.0e-6), cm_degToRad(      -2*1.0e-6), cm_degToRad(       -3*1.0e-6),         9*1.0e-7,        5*1.0e-7),
  Term(2,  0, -5, cm_degToRad(       -3*1.0e-6), cm_degToRad(       6*1.0e-6), cm_degToRad(       1*1.0e-6), cm_degToRad(        2*1.0e-6),         2*1.0e-7,       -1*1.0e-7),
  Term(2,  0, -4, cm_degToRad(        6*1.0e-6), cm_degToRad(     -13*1.0e-6), cm_degToRad(      -8*1.0e-6), cm_degToRad(        2*1.0e-6),        14*1.0e-7,       10*1.0e-7),
  Term(2,  0, -3, cm_degToRad(       10*1.0e-6), cm_degToRad(      22*1.0e-6), cm_degToRad(      10*1.0e-6), cm_degToRad(       -7*1.0e-6),       -65*1.0e-7,       12*1.0e-7),
  Term(2,  0, -2, cm_degToRad(      -57*1.0e-6), cm_degToRad(     -32*1.0e-6), cm_degToRad(       0*1.0e-6), cm_degToRad(       21*1.0e-6),       126*1.0e-7,     -233*1.0e-7),
  Term(2,  0, -1, cm_degToRad(      157*1.0e-6), cm_degToRad(     -46*1.0e-6), cm_degToRad(       8*1.0e-6), cm_degToRad(        5*1.0e-6),       270*1.0e-7,     1068*1.0e-7),
  Term(2,  0,  0, cm_degToRad(       12*1.0e-6), cm_degToRad(     -18*1.0e-6), cm_degToRad(      13*1.0e-6), cm_degToRad(       16*1.0e-6),       254*1.0e-7,      155*1.0e-7),
  Term(2,  0,  1, cm_degToRad(       -4*1.0e-6), cm_degToRad(       8*1.0e-6), cm_degToRad(      -2*1.0e-6), cm_degToRad(       -3*1.0e-6),       -26*1.0e-7,       -2*1.0e-7),
  Term(2,  0,  2, cm_degToRad(       -5*1.0e-6), cm_degToRad(       0*1.0e-6), cm_degToRad(       0*1.0e-6), cm_degToRad(        0*1.0e-6),         7*1.0e-7,        0*1.0e-7),
  Term(2,  0,  3, cm_degToRad(        3*1.0e-6), cm_degToRad(       4*1.0e-6), cm_degToRad(       0*1.0e-6), cm_degToRad(        1*1.0e-6),       -11*1.0e-7,        4*1.0e-7),
  Term(3,  0, -2, cm_degToRad(       -1*1.0e-6), cm_degToRad(      -1*1.0e-6), cm_degToRad(       0*1.0e-6), cm_degToRad(        1*1.0e-6),         4*1.0e-7,      -14*1.0e-7),
  Term(3,  0, -1, cm_degToRad(        6*1.0e-6), cm_degToRad(      -3*1.0e-6), cm_degToRad(       0*1.0e-6), cm_degToRad(        0*1.0e-6),        18*1.0e-7,       35*1.0e-7),
  Term(3,  0,  0, cm_degToRad(       -1*1.0e-6), cm_degToRad(      -2*1.0e-6), cm_degToRad(       0*1.0e-6), cm_degToRad(        1*1.0e-6),        13*1.0e-7,        3*1.0e-7),
];

fileprivate let PLUTO_34_35_RAD =     cm_degToRad(  34.35)
fileprivate let PLUTO_3034_9057_RAD = cm_degToRad(3034.9057)
fileprivate let PLUTO_50_08_RAD =     cm_degToRad(  50.08)
fileprivate let PLUTO_1222_1138_RAD = cm_degToRad(1222.1138)
fileprivate let PLUTO_238_96_RAD =    cm_degToRad( 238.96)
fileprivate let PLUTO_144_9600_RAD =  cm_degToRad( 144.9600)

fileprivate let PLUTO_238_956785_RAD = cm_degToRad(238.956785)
fileprivate let PLUTO_144_96_RAD =    cm_degToRad(144.96)
fileprivate let PLUTO_3_908202_RAD =  cm_degToRad(  3.908202)


public func
goffin2000(_ jde: Double) -> SIMD3<Double>
{
  let T = (jde - 2451545.0) / 36525.0;
  let J =  PLUTO_34_35_RAD + PLUTO_3034_9057_RAD * T;
  let S =  PLUTO_50_08_RAD + PLUTO_1222_1138_RAD * T;
  let P =  PLUTO_238_96_RAD +  PLUTO_144_9600_RAD * T;

  var longitude = 0.0, latitude = 0.0, rad = 0.0;

  for term in terms {
    let arg = term.j * J + term.s * S + term.p * P;

    longitude += term.long_a * sin(arg) + term.long_b * cos(arg);
    latitude += term.lat_a * sin(arg) + term.lat_b * cos(arg);
    rad += term.rad_a * sin(arg) + term.rad_b * cos(arg);
  }

  longitude += PLUTO_238_956785_RAD + PLUTO_144_96_RAD * T;
  latitude -= PLUTO_3_908202_RAD;
  rad += 40.7247248;

  // We now have heliocentric equatorial coordinates for J2000
  // We need to convert these to rectangular coordinates. One problem is that
  // This method results in heliocentric coordinates, these need to be
  // translated by the sun

  // TODO: To barycentric
  return SIMD3<Double>(longitude, latitude, rad);
}
