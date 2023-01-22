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
  Term(0,  0,  1, (-19798886).µdeg, (19848454).µdeg, (-5453098).µdeg, (-14974876).µdeg,  66867334*1.0e-7, 68955876*1.0e-7),
  Term(0,  0,  2, (   897499).µdeg, (-4955707).µdeg, ( 3527363).µdeg, (  1672673).µdeg, -11826086*1.0e-7,  -333765*1.0e-7),
  Term(0,  0,  3, (   610820).µdeg, ( 1210521).µdeg, (-1050939).µdeg, (   327763).µdeg,   1593657*1.0e-7, -1439953*1.0e-7),
  Term(0,  0,  4, (  -341639).µdeg, ( -189719).µdeg, (  178691).µdeg, (  -291925).µdeg,    -18948*1.0e-7,   482443*1.0e-7),
  Term(0,  0,  5, (   129027).µdeg, (  -34863).µdeg, (   18763).µdeg, (   100448).µdeg,    -66634*1.0e-7,   -85576*1.0e-7),
  Term(0,  0,  6, (   -38215).µdeg, (   31061).µdeg, (  -30594).µdeg, (   -25838).µdeg,     30841*1.0e-7,    -5765*1.0e-7),
  Term(0,  1, -1, (    20349).µdeg, (   -9886).µdeg, (    4965).µdeg, (    11263).µdeg,     -6140*1.0e-7,    22254*1.0e-7),
  Term(0,  1,  0, (    -4045).µdeg, (   -4904).µdeg, (     310).µdeg, (     -132).µdeg,      4434*1.0e-7,     4443*1.0e-7),
  Term(0,  1,  1, (    -5885).µdeg, (   -3238).µdeg, (    2036).µdeg, (     -947).µdeg,     -1518*1.0e-7,      641*1.0e-7),
  Term(0,  1,  2, (    -3812).µdeg, (    3011).µdeg, (      -2).µdeg, (     -674).µdeg,        -5*1.0e-7,      792*1.0e-7),
  Term(0,  1,  3, (     -601).µdeg, (    3468).µdeg, (    -329).µdeg, (     -563).µdeg,       518*1.0e-7,      518*1.0e-7),
  Term(0,  2, -2, (     1237).µdeg, (     463).µdeg, (     -64).µdeg, (       39).µdeg,       -13*1.0e-7,     -221*1.0e-7),
  Term(0,  2, -1, (     1086).µdeg, (    -911).µdeg, (     -94).µdeg, (      210).µdeg,       837*1.0e-7,     -494*1.0e-7),
  Term(0,  2,  0, (      595).µdeg, (   -1229).µdeg, (      -8).µdeg, (     -160).µdeg,      -281*1.0e-7,      616*1.0e-7),
  Term(1, -1,  0, (     2484).µdeg, (    -485).µdeg, (    -177).µdeg, (      259).µdeg,       260*1.0e-7,     -395*1.0e-7),
  Term(1, -1,  1, (      839).µdeg, (   -1414).µdeg, (      17).µdeg, (      234).µdeg,      -191*1.0e-7,     -396*1.0e-7),
  Term(1,  0, -3, (     -964).µdeg, (    1059).µdeg, (     582).µdeg, (     -285).µdeg,     -3218*1.0e-7,      370*1.0e-7),
  Term(1,  0, -2, (    -2303).µdeg, (   -1038).µdeg, (    -298).µdeg, (      692).µdeg,      8019*1.0e-7,    -7869*1.0e-7),
  Term(1,  0, -1, (     7049).µdeg, (     747).µdeg, (     157).µdeg, (      201).µdeg,       105*1.0e-7,    45637*1.0e-7),
  Term(1,  0,  0, (     1179).µdeg, (    -358).µdeg, (     304).µdeg, (      825).µdeg,      8623*1.0e-7,     8444*1.0e-7),
  Term(1,  0,  1, (      393).µdeg, (     -63).µdeg, (    -124).µdeg, (      -29).µdeg,      -896*1.0e-7,     -801*1.0e-7),
  Term(1,  0,  2, (      111).µdeg, (    -268).µdeg, (      15).µdeg, (        8).µdeg,       208*1.0e-7,     -122*1.0e-7),
  Term(1,  0,  3, (      -52).µdeg, (    -154).µdeg, (       7).µdeg, (       15).µdeg,      -133*1.0e-7,       65*1.0e-7),
  Term(1,  0,  4, (      -78).µdeg, (     -30).µdeg, (       2).µdeg, (        2).µdeg,       -16*1.0e-7,        1*1.0e-7),
  Term(1,  1, -3, (      -34).µdeg, (     -26).µdeg, (       4).µdeg, (        2).µdeg,       -22*1.0e-7,        7*1.0e-7),
  Term(1,  1, -2, (      -43).µdeg, (       1).µdeg, (       3).µdeg, (        0).µdeg,        -8*1.0e-7,       16*1.0e-7),
  Term(1,  1, -1, (      -15).µdeg, (      21).µdeg, (       1).µdeg, (       -1).µdeg,         2*1.0e-7,        9*1.0e-7),
  Term(1,  1,  0, (       -1).µdeg, (      15).µdeg, (       0).µdeg, (       -2).µdeg,        12*1.0e-7,        5*1.0e-7),
  Term(1,  1,  1, (        4).µdeg, (       7).µdeg, (       1).µdeg, (        0).µdeg,         1*1.0e-7,       -3*1.0e-7),
  Term(1,  1,  3, (        1).µdeg, (       5).µdeg, (       1).µdeg, (       -1).µdeg,         1*1.0e-7,        0*1.0e-7),
  Term(2,  0, -6, (        8).µdeg, (       3).µdeg, (      -2).µdeg, (       -3).µdeg,         9*1.0e-7,        5*1.0e-7),
  Term(2,  0, -5, (       -3).µdeg, (       6).µdeg, (       1).µdeg, (        2).µdeg,         2*1.0e-7,       -1*1.0e-7),
  Term(2,  0, -4, (        6).µdeg, (     -13).µdeg, (      -8).µdeg, (        2).µdeg,        14*1.0e-7,       10*1.0e-7),
  Term(2,  0, -3, (       10).µdeg, (      22).µdeg, (      10).µdeg, (       -7).µdeg,       -65*1.0e-7,       12*1.0e-7),
  Term(2,  0, -2, (      -57).µdeg, (     -32).µdeg, (       0).µdeg, (       21).µdeg,       126*1.0e-7,     -233*1.0e-7),
  Term(2,  0, -1, (      157).µdeg, (     -46).µdeg, (       8).µdeg, (        5).µdeg,       270*1.0e-7,     1068*1.0e-7),
  Term(2,  0,  0, (       12).µdeg, (     -18).µdeg, (      13).µdeg, (       16).µdeg,       254*1.0e-7,      155*1.0e-7),
  Term(2,  0,  1, (       -4).µdeg, (       8).µdeg, (      -2).µdeg, (       -3).µdeg,       -26*1.0e-7,       -2*1.0e-7),
  Term(2,  0,  2, (       -5).µdeg, (       0).µdeg, (       0).µdeg, (        0).µdeg,         7*1.0e-7,        0*1.0e-7),
  Term(2,  0,  3, (        3).µdeg, (       4).µdeg, (       0).µdeg, (        1).µdeg,       -11*1.0e-7,        4*1.0e-7),
  Term(3,  0, -2, (       -1).µdeg, (      -1).µdeg, (       0).µdeg, (        1).µdeg,         4*1.0e-7,      -14*1.0e-7),
  Term(3,  0, -1, (        6).µdeg, (      -3).µdeg, (       0).µdeg, (        0).µdeg,        18*1.0e-7,       35*1.0e-7),
  Term(3,  0,  0, (       -1).µdeg, (      -2).µdeg, (       0).µdeg, (        1).µdeg,        13*1.0e-7,        3*1.0e-7),
];

fileprivate let PLUTO_34_35_RAD =     (  34.35).deg
fileprivate let PLUTO_3034_9057_RAD = (3034.9057).deg
fileprivate let PLUTO_50_08_RAD =     (  50.08).deg
fileprivate let PLUTO_1222_1138_RAD = (1222.1138).deg
fileprivate let PLUTO_238_96_RAD =    ( 238.96).deg
fileprivate let PLUTO_144_9600_RAD =  ( 144.9600).deg

fileprivate let PLUTO_238_956785_RAD = (238.956785).deg
fileprivate let PLUTO_144_96_RAD =    (144.96).deg
fileprivate let PLUTO_3_908202_RAD =  (  3.908202).deg


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
