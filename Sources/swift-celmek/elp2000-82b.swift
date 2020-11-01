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

// Table 45.A
fileprivate struct LongDistTerm {
  var D: Double;
  var M: Double
  var M_prime: Double
  var F: Double
  var zl: Double;
  var zr: Double;
  
  init(_ D: Double, _ M: Double, _ M_prime: Double, _ F: Double, _ zl: Double, _ zr: Double) {
    self.D = D
    self.M = M
    self.M_prime = M_prime
    self.F = F
    self.zl = zl
    self.zr = zr
  }
}

fileprivate let long_dist_terms : [LongDistTerm] = [
  LongDistTerm(0.0, 0.0, 1.0, 0.0, cm_degToRad(6288774.0 * 1.0e-6), -20905355.0),
  LongDistTerm(2.0, 0.0, -1.0, 0.0, cm_degToRad(1274027.0 * 1.0e-6), -3699111.0),
  LongDistTerm(2.0, 0.0, 0.0, 0.0, cm_degToRad(658314.0 * 1.0e-6), -2955968.0),
  LongDistTerm(0.0, 0.0, 2.0, 0.0, cm_degToRad(213618.0 * 1.0e-6), -569925.0),
  LongDistTerm(0.0, 1.0, 0.0, 0.0, cm_degToRad(-185116.0 * 1.0e-6), 48888.0),
  LongDistTerm(0.0, 0.0, 0.0, 2.0, cm_degToRad(-114332.0 * 1.0e-6), -3149.0),
  LongDistTerm(2.0, 0.0, -2.0, 0.0, cm_degToRad(58793.0 * 1.0e-6), 246158.0),
  LongDistTerm(2.0, -1.0, -1.0, 0.0, cm_degToRad(57066.0 * 1.0e-6), -152138.0),
  LongDistTerm(2.0, 0.0, 1.0, 0.0, cm_degToRad(53322.0 * 1.0e-6), -170733.0),
  LongDistTerm(2.0, -1.0, 0.0, 0.0, cm_degToRad(45758.0 * 1.0e-6), -204586.0),
  LongDistTerm(0.0, 1.0, -1.0, 0.0, cm_degToRad(-40923.0 * 1.0e-6), -129620.0),
  LongDistTerm(1.0, 0.0, 0.0, 0.0, cm_degToRad(-34720.0 * 1.0e-6), 108743.0),
  LongDistTerm(0.0, 1.0, 1.0, 0.0, cm_degToRad(-30383.0 * 1.0e-6), 104755.0),
  LongDistTerm(2.0, 0.0, 0.0, -2.0, cm_degToRad(15327.0 * 1.0e-6), 10321.0),
  LongDistTerm(0.0, 0.0, 1.0, 2.0, cm_degToRad(-12528.0 * 1.0e-6), 0.0),
  LongDistTerm(0.0, 0.0, 1.0, -2.0, cm_degToRad(10980.0 * 1.0e-6), 79661.0),
  LongDistTerm(4.0, 0.0, -1.0, 0.0, cm_degToRad(10675.0 * 1.0e-6), -34782.0),
  LongDistTerm(0.0, 0.0, 3.0, 0.0, cm_degToRad(10034.0 * 1.0e-6), -23210.0),
  LongDistTerm(4.0, 0.0, -2.0, 0.0, cm_degToRad(8548.0 * 1.0e-6), -21636.0),
  LongDistTerm(2.0, 1.0, -1.0, 0.0, cm_degToRad(-7888.0 * 1.0e-6), 24208.0),
  LongDistTerm(2.0, 1.0, 0.0, 0.0, cm_degToRad(-6766.0 * 1.0e-6), 30824.0),
  LongDistTerm(1.0, 0.0, -1.0, 0.0, cm_degToRad(-5163.0 * 1.0e-6), -8379.0),
  LongDistTerm(1.0, 1.0, 0.0, 0.0, cm_degToRad(4987.0 * 1.0e-6), -16675.0),
  LongDistTerm(2.0, -1.0, 1.0, 0.0, cm_degToRad(4036.0 * 1.0e-6), -12831.0),
  LongDistTerm(2.0, 0.0, 2.0, 0.0, cm_degToRad(3994.0 * 1.0e-6), -10445.0),
  LongDistTerm(4.0, 0.0, 0.0, 0.0, cm_degToRad(3861.0 * 1.0e-6), -11650.0),
  LongDistTerm(2.0, 0.0, -3.0, 0.0, cm_degToRad(3665.0 * 1.0e-6), 14403.0),
  LongDistTerm(0.0, 1.0, -2.0, 0.0, cm_degToRad(-2689.0 * 1.0e-6), -7003.0),
  LongDistTerm(2.0, 0.0, -1.0, 2.0, cm_degToRad(-2602.0 * 1.0e-6), 0.0),
  LongDistTerm(2.0, -1.0, -2.0, 0.0, cm_degToRad(2390.0 * 1.0e-6), 10056.0),
  LongDistTerm(1.0, 0.0, 1.0, 0.0, cm_degToRad(-2348.0 * 1.0e-6), 6322.0),
  LongDistTerm(2.0, -2.0, 0.0, 0.0, cm_degToRad(2236.0 * 1.0e-6), -9884.0),
  
  LongDistTerm(0.0, 1.0, 2.0, 0.0, cm_degToRad(-2120.0 * 1.0e-6), 5751.0),
  LongDistTerm(0.0, 2.0, 0.0, 0.0, cm_degToRad(-2069.0 * 1.0e-6), 0.0),
  LongDistTerm(2.0, -2.0, -1.0, 0.0, cm_degToRad(2048.0 * 1.0e-6), -4950.0),
  LongDistTerm(2.0, 0.0, 1.0, -2.0, cm_degToRad(-1773.0 * 1.0e-6), 4130.0),
  LongDistTerm(2.0, 0.0, 0.0, 2.0, cm_degToRad(-1595.0 * 1.0e-6), 0.0),
  LongDistTerm(4.0, -1.0, -1.0, 0.0, cm_degToRad(1215.0 * 1.0e-6), -3958.0),
  LongDistTerm(0.0, 0.0, 2.0, 2.0, cm_degToRad(-1110.0 * 1.0e-6), 0.0),
  LongDistTerm(3.0, 0.0, -1.0, 0.0, cm_degToRad(-892.0 * 1.0e-6), 3258.0),
  LongDistTerm(2.0, 1.0, 1.0, 0.0, cm_degToRad(-810.0 * 1.0e-6), 2616.0),
  LongDistTerm(4.0, -1.0, -2.0, 0.0, cm_degToRad(759.0 * 1.0e-6), -1897.0),
  LongDistTerm(0.0, 2.0, -1.0, 0.0, cm_degToRad(-713.0 * 1.0e-6), -2117.0),
  LongDistTerm(2.0, 2.0, -1.0, 0.0, cm_degToRad(-700.0 * 1.0e-6), 2354.0),
  LongDistTerm(2.0, 1.0, -2.0, 0.0, cm_degToRad(691.0 * 1.0e-6), 0.0),
  LongDistTerm(2.0, -1.0, 0.0, -2.0, cm_degToRad(596.0 * 1.0e-6), 0.0),
  LongDistTerm(4.0, 0.0, 1.0, 0.0, cm_degToRad(549.0 * 1.0e-6), -1423.0),
  LongDistTerm(0.0, 0.0, 4.0, 0.0, cm_degToRad(537.0 * 1.0e-6), -1117.0),
  LongDistTerm(4.0, -1.0, 0.0, 0.0, cm_degToRad(520.0 * 1.0e-6), -1571.0),
  LongDistTerm(1.0, 0.0, -2.0, 0.0, cm_degToRad(-487.0 * 1.0e-6), -1739.0),
  LongDistTerm(2.0, 1.0, 0.0, -2.0, cm_degToRad(-399.0 * 1.0e-6), 0.0),
  LongDistTerm(0.0, 0.0, 2.0, -2.0, cm_degToRad(-381.0 * 1.0e-6), -4421.0),
  LongDistTerm(1.0, 1.0, 1.0, 0.0, cm_degToRad(351.0 * 1.0e-6), 0.0),
  LongDistTerm(3.0, 0.0, -2.0, 0.0, cm_degToRad(-340.0 * 1.0e-6), 0.0),
  LongDistTerm(4.0, 0.0, -3.0, 0.0, cm_degToRad(330.0 * 1.0e-6), 0.0),
  LongDistTerm(2.0, -1.0, 2.0, 0.0, cm_degToRad(327.0 * 1.0e-6), 0.0),
  LongDistTerm(0.0, 2.0, 1.0, 0.0, cm_degToRad(-323.0 * 1.0e-6), 1165.0),
  LongDistTerm(1.0, 1.0, -1.0, 0.0, cm_degToRad(299.0 * 1.0e-6), 0.0),
  LongDistTerm(2.0, 0.0, 3.0, 0.0, cm_degToRad(294.0 * 1.0e-6), 0.0),
  LongDistTerm(2.0, 0.0, -1.0, -2.0, cm_degToRad(0.0 * 1.0e-6), 8752.0),
];

// Table 45.B
fileprivate struct LatTerm {
  var D: Double
  var M: Double
  var M_prime: Double
  var F: Double
  var zb: Double
  
  init(_ d: Double, _ m: Double, _ mp: Double, _ f: Double, _ zb: Double) {
    self.D = d
    self.M = m
    self.M_prime = mp
    self.F = f
    self.zb = zb
  }
}

fileprivate let  lat_terms: [LatTerm] = [
  LatTerm(0.0, 0.0, 0.0, 1.0, cm_degToRad(5128122.0 * 1.0e-6)),
  LatTerm(0.0, 0.0, 1.0, 1.0, cm_degToRad(280602.0 * 1.0e-6)),
  LatTerm(0.0, 0.0, 1.0, -1.0, cm_degToRad(277693.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, 0.0, -1.0, cm_degToRad(173237.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, -1.0, 1.0, cm_degToRad(55413.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, -1.0, -1.0, cm_degToRad(46271.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, 0.0, 1.0, cm_degToRad(32573.0 * 1.0e-6)),
  LatTerm(0.0, 0.0, 2.0, 1.0, cm_degToRad(17198.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, 1.0, -1.0, cm_degToRad(9266.0 * 1.0e-6)),
  LatTerm(0.0, 0.0, 2.0, -1.0, cm_degToRad(8822.0 * 1.0e-6)),
  LatTerm(2.0, -1.0, 0.0, -1.0, cm_degToRad(8216.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, -2.0, -1.0, cm_degToRad(4324.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, 1.0, 1.0, cm_degToRad(4200.0 * 1.0e-6)),
  LatTerm(2.0, 1.0, 0.0, -1.0, cm_degToRad(-3359.0 * 1.0e-6)),
  LatTerm(2.0, -1.0, -1.0, 1.0, cm_degToRad(2463.0 * 1.0e-6)),
  LatTerm(2.0, -1.0, 0.0, 1.0, cm_degToRad(2211.0 * 1.0e-6)),
  LatTerm(2.0, -1.0, -1.0, -1.0, cm_degToRad(2065.0 * 1.0e-6)),
  LatTerm(0.0, 1.0, -1.0, -1.0, cm_degToRad(-1870.0 * 1.0e-6)),
  LatTerm(4.0, 0.0, -1.0, -1.0, cm_degToRad(1828.0 * 1.0e-6)),
  LatTerm(0.0, 1.0, 0.0, 1.0, cm_degToRad(-1794.0 * 1.0e-6)),
  LatTerm(0.0, 0.0, 0.0, 3.0, cm_degToRad(-1749.0 * 1.0e-6)),
  LatTerm(0.0, 1.0, -1.0, 1.0, cm_degToRad(-1565.0 * 1.0e-6)),
  LatTerm(1.0, 0.0, 0.0, 1.0, cm_degToRad(-1491.0 * 1.0e-6)),
  LatTerm(0.0, 1.0, 1.0, 1.0, cm_degToRad(-1475.0 * 1.0e-6)),
  LatTerm(0.0, 1.0, 1.0, -1.0, cm_degToRad(-1410.0 * 1.0e-6)),
  LatTerm(0.0, 1.0, 0.0, -1.0, cm_degToRad(-1344.0 * 1.0e-6)),
  LatTerm(1.0, 0.0, 0.0, -1.0, cm_degToRad(-1335.0 * 1.0e-6)),
  LatTerm(0.0, 0.0, 3.0, 1.0, cm_degToRad(1107.0 * 1.0e-6)),
  LatTerm(4.0, 0.0, 0.0, -1.0, cm_degToRad(1021.0 * 1.0e-6)),
  LatTerm(4.0, 0.0, -1.0, 1.0, cm_degToRad(833.0 * 1.0e-6)),
  
  LatTerm(0.0, 0.0, 1.0, -3.0, cm_degToRad(777.0 * 1.0e-6)),
  LatTerm(4.0, 0.0, -2.0, 1.0, cm_degToRad(671.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, 0.0, -3.0, cm_degToRad(607.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, 2.0, -1.0, cm_degToRad(596.0 * 1.0e-6)),
  LatTerm(2.0, -1.0, 1.0, -1.0, cm_degToRad(491.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, -2.0, 1.0, cm_degToRad(-451.0 * 1.0e-6)),
  LatTerm(0.0, 0.0, 3.0, -1.0, cm_degToRad(439.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, 2.0, 1.0, cm_degToRad(422.0 * 1.0e-6)),
  LatTerm(2.0, 0.0, -3.0, -1.0, cm_degToRad(421.0 * 1.0e-6)),
  LatTerm(2.0, 1.0, -1.0, 1.0, cm_degToRad(-366.0 * 1.0e-6)),
  LatTerm(2.0, 1.0, 0.0, 1.0, cm_degToRad(-351.0 * 1.0e-6)),
  LatTerm(4.0, 0.0, 0.0, 1.0, cm_degToRad(331.0 * 1.0e-6)),
  LatTerm(2.0, -1.0, 1.0, 1.0, cm_degToRad(315.0 * 1.0e-6)),
  LatTerm(2.0, -2.0, 0.0, -1.0, cm_degToRad(302.0 * 1.0e-6)),
  LatTerm(0.0, 0.0, 1.0, 3.0, cm_degToRad(-283.0 * 1.0e-6)),
  LatTerm(2.0, 1.0, 1.0, -1.0, cm_degToRad(-229.0 * 1.0e-6)),
  LatTerm(1.0, 1.0, 0.0, -1.0, cm_degToRad(223.0 * 1.0e-6)),
  LatTerm(1.0, 1.0, 0.0, 1.0, cm_degToRad(223.0 * 1.0e-6)),
  LatTerm(0.0, 1.0, -2.0, -1.0, cm_degToRad(-220.0 * 1.0e-6)),
  LatTerm(2.0, 1.0, -1.0, -1.0, cm_degToRad(-220.0 * 1.0e-6)),
  LatTerm(1.0, 0.0, 1.0, 1.0, cm_degToRad(-185.0 * 1.0e-6)),
  LatTerm(2.0, -1.0, -2.0, -1.0, cm_degToRad(181.0 * 1.0e-6)),
  LatTerm(0.0, 1.0, 2.0, 1.0, cm_degToRad(-177.0 * 1.0e-6)),
  LatTerm(4.0, 0.0, -2.0, -1.0, cm_degToRad(176.0 * 1.0e-6)),
  LatTerm(4.0, -1.0, -1.0, -1.0, cm_degToRad(166.0 * 1.0e-6)),
  LatTerm(1.0, 0.0, 1.0, -1.0, cm_degToRad(-164.0 * 1.0e-6)),
  LatTerm(4.0, 0.0, 1.0, -1.0, cm_degToRad(132.0 * 1.0e-6)),
  LatTerm(1.0, 0.0, -1.0, -1.0, cm_degToRad(-119.0 * 1.0e-6)),
  LatTerm(4.0, -1.0, 0.0, -1.0, cm_degToRad(115.0 * 1.0e-6)),
  LatTerm(2.0, -2.0, 0.0, 1.0, cm_degToRad(107.0 * 1.0e-6)),
];

// Note JDE not same as jd
// TODO: Optimize by replacing all degree terms with radians
fileprivate func
clamp_degs(_ a: Double) -> Double
{
  return fmod(fmod(a, 2.0 * .pi) + 2.0 * .pi, 2.0 * .pi);
}

// Broken out of main routine for testability purposes
fileprivate func
cm_elp2000_82b_T(_ jde:Double) -> Double
{
  return (jde - 2451545.0) / 36525.0;
}

fileprivate let ELP_218_3164591_RAD = cm_degToRad(218.3164591)
fileprivate let ELP_481267_88134236_RAD = cm_degToRad(481267.88134236)
fileprivate let ELP_0_0013268_RAD = cm_degToRad(0.0013268)
fileprivate let ELP_RCP_538841_0_RAD = cm_degToRad(1.0 / 538841.0)
fileprivate let ELP_RCP_65194000_0_RAD = cm_degToRad(1.0 / 65194000.0)

fileprivate func
cm_elp2000_82b_Lprime(_ T: Double) -> Double
{
  let Lp: Double = ELP_218_3164591_RAD + ELP_481267_88134236_RAD * T -
    ELP_0_0013268_RAD * T * T + T * T * T * ELP_RCP_538841_0_RAD -
    T * T * T * T * ELP_RCP_65194000_0_RAD;
  return clamp_degs(Lp);
}

fileprivate let ELP_297_8502042_RAD = cm_degToRad(297.8502042)
fileprivate let  ELP_445267_1115168_RAD = cm_degToRad(445267.1115168)
fileprivate let  ELP_0_0016300_RAD = cm_degToRad(0.0016300)
fileprivate let  ELP_RCP_545868_0_RAD = cm_degToRad(1.0 / 545868.0)
fileprivate let  ELP_RCP_113065000_0_RAD = cm_degToRad(1.0 / 113065000.0)

fileprivate func
cm_elp2000_82b_D(_ T: Double) -> Double
{
  let D : Double = ELP_297_8502042_RAD + ELP_445267_1115168_RAD * T -
    ELP_0_0016300_RAD * T * T + T * T * T * ELP_RCP_545868_0_RAD -
    T * T * T * T * ELP_RCP_113065000_0_RAD;
  return clamp_degs(D);
}

fileprivate let ELP_357_5291092_RAD = cm_degToRad(357.5291092)
fileprivate let ELP_35999_0502909_RAD = cm_degToRad(35999.0502909)
fileprivate let ELP_0_0001536_RAD = cm_degToRad(0.0001536)
fileprivate let ELP_RCP_24490000_0_RAD = cm_degToRad(1.0 / 24490000.0)

fileprivate func
cm_elp2000_82b_M(_ T: Double) -> Double
{
  let M: Double = ELP_357_5291092_RAD + ELP_35999_0502909_RAD * T -
    ELP_0_0001536_RAD * T * T + T * T * T * ELP_RCP_24490000_0_RAD;
  return clamp_degs(M);
}

fileprivate let ELP_134_9634114_RAD = cm_degToRad(134.9634114)
fileprivate let ELP_477198_8676313_RAD = cm_degToRad(477198.8676313)
fileprivate let ELP_0_0089970_RAD = cm_degToRad(0.0089970)
fileprivate let ELP_RCP_69699_0_RAD = cm_degToRad(1.0 / 69699.0)
fileprivate let ELP_RCP_14712000_0_RAD = cm_degToRad(1.0 / 14712000.0)

fileprivate func
cm_elp2000_82b_Mprime(_ T: Double) -> Double
{
  let Mp: Double = ELP_134_9634114_RAD + ELP_477198_8676313_RAD * T +
    ELP_0_0089970_RAD * T * T + T * T * T * ELP_RCP_69699_0_RAD -
    T * T * T * T * ELP_RCP_14712000_0_RAD;
  return clamp_degs(Mp);
}

fileprivate let ELP_93_2720993_RAD = cm_degToRad(93.2720993)
fileprivate let ELP_483202_0175273_RAD = cm_degToRad(483202.0175273)
fileprivate let ELP_0_0034029_RAD = cm_degToRad(0.0034029)
fileprivate let ELP_RCP_3526000_0_RAD = cm_degToRad(1.0 / 3526000.0)
fileprivate let ELP_RCP_863310000_0_RAD = cm_degToRad(1.0 / 863310000.0)

fileprivate func
cm_elp2000_82b_F(_ T: Double) -> Double
{
  let F: Double = ELP_93_2720993_RAD + ELP_483202_0175273_RAD * T -
    ELP_0_0034029_RAD * T * T - T * T * T * ELP_RCP_3526000_0_RAD +
    T * T * T * T * ELP_RCP_863310000_0_RAD;
  return clamp_degs(F);
}

fileprivate let ELP_119_75_RAD = cm_degToRad(119.75)
fileprivate let ELP_131_849_RAD = cm_degToRad(131.849)

fileprivate func
cm_elp2000_82b_A1(_ T: Double) -> Double
{
  let A1: Double = ELP_119_75_RAD + ELP_131_849_RAD * T;
  return clamp_degs(A1);
}

fileprivate let ELP_53_09_RAD = cm_degToRad(53.09)
fileprivate let ELP_479264_290_RAD = cm_degToRad(479264.290)

fileprivate func
cm_elp2000_82b_A2(_ T: Double) -> Double
{
  let A2: Double = ELP_53_09_RAD + ELP_479264_290_RAD * T;
  return clamp_degs(A2);
}

fileprivate let ELP_313_45_RAD = cm_degToRad(313.45)
fileprivate let ELP_481266_484_RAD = cm_degToRad(481266.484)

fileprivate func
cm_elp2000_82b_A3(_ T: Double) -> Double
{
  let A3: Double = ELP_313_45_RAD + ELP_481266_484_RAD * T;
  return clamp_degs(A3);
}

fileprivate func
cm_elp2000_82b_E(_ T: Double) -> Double
{
  return 1.0 - 0.002516 * T - 0.0000074 * T * T;
}

fileprivate let ELP_3958_0_RAD = cm_degToRad(3958.0 * 1.0e-6)
fileprivate let ELP_1962_0_RAD = cm_degToRad(1962.0 * 1.0e-6)
fileprivate let ELP_318_0_RAD = cm_degToRad(318.0 * 1.0e-6)
fileprivate let ELP_2235_0_RAD = cm_degToRad(2235.0 * 1.0e-6)
fileprivate let ELP_382_0_RAD = cm_degToRad(382.0 * 1.0e-6)
fileprivate let ELP_175_0_RAD = cm_degToRad(175.0 * 1.0e-6)
fileprivate let ELP_127_0_RAD = cm_degToRad(127.0 * 1.0e-6)
fileprivate let ELP_115_0_RAD = cm_degToRad(115.0 * 1.0e-6)

// Note JDE not same as jd
// TODO: Optimize by replacing all degree terms with radians

public func
cm_elp2000_82b(_ jde:Double) -> SIMD3<Double>
{
  let T = cm_elp2000_82b_T(jde);
  
  // Compute parameters in degrees.
  // Mean longitude . mean equinox of the date, incl light delay
  let Lprime = cm_elp2000_82b_Lprime(T);
  // Mean elongation
  let D = cm_elp2000_82b_D(T);
  // Sun's mean anomaly
  let M = cm_elp2000_82b_M(T);
  
  // Moon's mean anomaly
  let Mprime = cm_elp2000_82b_Mprime(T);
  // Moon's argument of latitude
  let F = cm_elp2000_82b_F(T);
  
  let A1 = cm_elp2000_82b_A1(T);
  let A2 = cm_elp2000_82b_A2(T);
  let A3 = cm_elp2000_82b_A3(T);
  
  // Decreasing eccentricity of earth orbit around sun
  let E = cm_elp2000_82b_E(T);
  
  var zl = 0.0;
  var zb = 0.0;
  var zr = 0.0;
  
  for term in long_dist_terms {
    var arg = term.D * D;
    arg += term.M * M;
    arg += term.M_prime * Mprime;
    arg += term.F * F;
    arg = fmod(fmod(arg, 2.0 * .pi) + 2.0 * .pi, 2.0 * .pi);
    
    var Eprime = 1.0;
    if (fabs(term.M) == 2.0) {
      Eprime = E * E;
    } else if (fabs(term.M) == 1.0) {
      Eprime = E;
      
    }
    
    zl += term.zl * sin(arg) * Eprime;
    zr += term.zr * cos(arg) * Eprime;
  }
  
  for term in lat_terms {
    var arg = term.D * D;
    arg += term.M * M;
    arg += term.M_prime * Mprime;
    arg += term.F * F;
    
    var Eprime = 1.0;
    if (fabs(term.M) == 2.0) {
      Eprime = E * E;
    } else if (fabs(term.M) == 1.0) {
      Eprime = E;
    }
    arg = fmod(fmod(arg, 2.0 * .pi) + 2.0 * .pi, 2.0 * .pi);
    zb += term.zb * sin(arg) * Eprime;
  }
  
  zl += ELP_3958_0_RAD * sin(A1);
  zl += ELP_1962_0_RAD * sin(Lprime - F);  // Flattening
  zl += ELP_318_0_RAD * sin(A2);           // Jupiter
  
  zb -= ELP_2235_0_RAD * sin(Lprime);  // Flattening
  zb += ELP_382_0_RAD * sin(A3);
  zb += ELP_175_0_RAD * sin(A1 - F);           // Venus
  zb += ELP_175_0_RAD * sin(A1 + F);           // Venus
  zb += ELP_127_0_RAD * sin(Lprime - Mprime);  // Flattening
  zb -= ELP_115_0_RAD * sin(Lprime + Mprime);  // Flattening
  
  // To avoid divisions, the table cooefs need to be updated
  let lambda = Lprime + zl;      // / 1000000.0;  // Degrees
  let beta = zb;                 // / 1000000.0;             // Degrees
  let delta = 385000.56e3 + zr;  /// 1000.0;//  / 1000.0;   // km
  
  //  printf("Zl = %f should be -1127527 +/- epsilon\n", zl); // -1127527
  //  printf("Zb = %f should be -3229127 +/- epsilon\n", zb); // -3229127
  //  printf("Zr = %f should be -16590875 +/- epsilon\n", zr); // -16590875
  
  // printf("%f %f %f\n", lambda, beta, delta);
  let res = SIMD3<Double>(fmod(lambda, 2.0 * .pi), fmod(beta, .pi), delta)
  
  return res;
}
