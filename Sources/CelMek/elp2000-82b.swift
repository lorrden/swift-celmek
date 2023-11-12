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
  LongDistTerm(0.0, 0.0, 1.0, 0.0, (6288774.0 * 1.0e-6).deg, -20905355.0),
  LongDistTerm(2.0, 0.0, -1.0, 0.0, (1274027.0 * 1.0e-6).deg, -3699111.0),
  LongDistTerm(2.0, 0.0, 0.0, 0.0, (658314.0 * 1.0e-6).deg, -2955968.0),
  LongDistTerm(0.0, 0.0, 2.0, 0.0, (213618.0 * 1.0e-6).deg, -569925.0),
  LongDistTerm(0.0, 1.0, 0.0, 0.0, (-185116.0 * 1.0e-6).deg, 48888.0),
  LongDistTerm(0.0, 0.0, 0.0, 2.0, (-114332.0 * 1.0e-6).deg, -3149.0),
  LongDistTerm(2.0, 0.0, -2.0, 0.0, (58793.0 * 1.0e-6).deg, 246158.0),
  LongDistTerm(2.0, -1.0, -1.0, 0.0, (57066.0 * 1.0e-6).deg, -152138.0),
  LongDistTerm(2.0, 0.0, 1.0, 0.0, (53322.0 * 1.0e-6).deg, -170733.0),
  LongDistTerm(2.0, -1.0, 0.0, 0.0, (45758.0 * 1.0e-6).deg, -204586.0),
  LongDistTerm(0.0, 1.0, -1.0, 0.0, (-40923.0 * 1.0e-6).deg, -129620.0),
  LongDistTerm(1.0, 0.0, 0.0, 0.0, (-34720.0 * 1.0e-6).deg, 108743.0),
  LongDistTerm(0.0, 1.0, 1.0, 0.0, (-30383.0 * 1.0e-6).deg, 104755.0),
  LongDistTerm(2.0, 0.0, 0.0, -2.0, (15327.0 * 1.0e-6).deg, 10321.0),
  LongDistTerm(0.0, 0.0, 1.0, 2.0, (-12528.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(0.0, 0.0, 1.0, -2.0, (10980.0 * 1.0e-6).deg, 79661.0),
  LongDistTerm(4.0, 0.0, -1.0, 0.0, (10675.0 * 1.0e-6).deg, -34782.0),
  LongDistTerm(0.0, 0.0, 3.0, 0.0, (10034.0 * 1.0e-6).deg, -23210.0),
  LongDistTerm(4.0, 0.0, -2.0, 0.0, (8548.0 * 1.0e-6).deg, -21636.0),
  LongDistTerm(2.0, 1.0, -1.0, 0.0, (-7888.0 * 1.0e-6).deg, 24208.0),
  LongDistTerm(2.0, 1.0, 0.0, 0.0, (-6766.0 * 1.0e-6).deg, 30824.0),
  LongDistTerm(1.0, 0.0, -1.0, 0.0, (-5163.0 * 1.0e-6).deg, -8379.0),
  LongDistTerm(1.0, 1.0, 0.0, 0.0, (4987.0 * 1.0e-6).deg, -16675.0),
  LongDistTerm(2.0, -1.0, 1.0, 0.0, (4036.0 * 1.0e-6).deg, -12831.0),
  LongDistTerm(2.0, 0.0, 2.0, 0.0, (3994.0 * 1.0e-6).deg, -10445.0),
  LongDistTerm(4.0, 0.0, 0.0, 0.0, (3861.0 * 1.0e-6).deg, -11650.0),
  LongDistTerm(2.0, 0.0, -3.0, 0.0, (3665.0 * 1.0e-6).deg, 14403.0),
  LongDistTerm(0.0, 1.0, -2.0, 0.0, (-2689.0 * 1.0e-6).deg, -7003.0),
  LongDistTerm(2.0, 0.0, -1.0, 2.0, (-2602.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(2.0, -1.0, -2.0, 0.0, (2390.0 * 1.0e-6).deg, 10056.0),
  LongDistTerm(1.0, 0.0, 1.0, 0.0, (-2348.0 * 1.0e-6).deg, 6322.0),
  LongDistTerm(2.0, -2.0, 0.0, 0.0, (2236.0 * 1.0e-6).deg, -9884.0),
  
  LongDistTerm(0.0, 1.0, 2.0, 0.0, (-2120.0 * 1.0e-6).deg, 5751.0),
  LongDistTerm(0.0, 2.0, 0.0, 0.0, (-2069.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(2.0, -2.0, -1.0, 0.0, (2048.0 * 1.0e-6).deg, -4950.0),
  LongDistTerm(2.0, 0.0, 1.0, -2.0, (-1773.0 * 1.0e-6).deg, 4130.0),
  LongDistTerm(2.0, 0.0, 0.0, 2.0, (-1595.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(4.0, -1.0, -1.0, 0.0, (1215.0 * 1.0e-6).deg, -3958.0),
  LongDistTerm(0.0, 0.0, 2.0, 2.0, (-1110.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(3.0, 0.0, -1.0, 0.0, (-892.0 * 1.0e-6).deg, 3258.0),
  LongDistTerm(2.0, 1.0, 1.0, 0.0, (-810.0 * 1.0e-6).deg, 2616.0),
  LongDistTerm(4.0, -1.0, -2.0, 0.0, (759.0 * 1.0e-6).deg, -1897.0),
  LongDistTerm(0.0, 2.0, -1.0, 0.0, (-713.0 * 1.0e-6).deg, -2117.0),
  LongDistTerm(2.0, 2.0, -1.0, 0.0, (-700.0 * 1.0e-6).deg, 2354.0),
  LongDistTerm(2.0, 1.0, -2.0, 0.0, (691.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(2.0, -1.0, 0.0, -2.0, (596.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(4.0, 0.0, 1.0, 0.0, (549.0 * 1.0e-6).deg, -1423.0),
  LongDistTerm(0.0, 0.0, 4.0, 0.0, (537.0 * 1.0e-6).deg, -1117.0),
  LongDistTerm(4.0, -1.0, 0.0, 0.0, (520.0 * 1.0e-6).deg, -1571.0),
  LongDistTerm(1.0, 0.0, -2.0, 0.0, (-487.0 * 1.0e-6).deg, -1739.0),
  LongDistTerm(2.0, 1.0, 0.0, -2.0, (-399.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(0.0, 0.0, 2.0, -2.0, (-381.0 * 1.0e-6).deg, -4421.0),
  LongDistTerm(1.0, 1.0, 1.0, 0.0, (351.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(3.0, 0.0, -2.0, 0.0, (-340.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(4.0, 0.0, -3.0, 0.0, (330.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(2.0, -1.0, 2.0, 0.0, (327.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(0.0, 2.0, 1.0, 0.0, (-323.0 * 1.0e-6).deg, 1165.0),
  LongDistTerm(1.0, 1.0, -1.0, 0.0, (299.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(2.0, 0.0, 3.0, 0.0, (294.0 * 1.0e-6).deg, 0.0),
  LongDistTerm(2.0, 0.0, -1.0, -2.0, (0.0 * 1.0e-6).deg, 8752.0),
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
  LatTerm(0.0, 0.0, 0.0, 1.0, (5128122.0 * 1.0e-6).deg),
  LatTerm(0.0, 0.0, 1.0, 1.0, (280602.0 * 1.0e-6).deg),
  LatTerm(0.0, 0.0, 1.0, -1.0, (277693.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, 0.0, -1.0, (173237.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, -1.0, 1.0, (55413.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, -1.0, -1.0, (46271.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, 0.0, 1.0, (32573.0 * 1.0e-6).deg),
  LatTerm(0.0, 0.0, 2.0, 1.0, (17198.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, 1.0, -1.0, (9266.0 * 1.0e-6).deg),
  LatTerm(0.0, 0.0, 2.0, -1.0, (8822.0 * 1.0e-6).deg),
  LatTerm(2.0, -1.0, 0.0, -1.0, (8216.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, -2.0, -1.0, (4324.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, 1.0, 1.0, (4200.0 * 1.0e-6).deg),
  LatTerm(2.0, 1.0, 0.0, -1.0, (-3359.0 * 1.0e-6).deg),
  LatTerm(2.0, -1.0, -1.0, 1.0, (2463.0 * 1.0e-6).deg),
  LatTerm(2.0, -1.0, 0.0, 1.0, (2211.0 * 1.0e-6).deg),
  LatTerm(2.0, -1.0, -1.0, -1.0, (2065.0 * 1.0e-6).deg),
  LatTerm(0.0, 1.0, -1.0, -1.0, (-1870.0 * 1.0e-6).deg),
  LatTerm(4.0, 0.0, -1.0, -1.0, (1828.0 * 1.0e-6).deg),
  LatTerm(0.0, 1.0, 0.0, 1.0, (-1794.0 * 1.0e-6).deg),
  LatTerm(0.0, 0.0, 0.0, 3.0, (-1749.0 * 1.0e-6).deg),
  LatTerm(0.0, 1.0, -1.0, 1.0, (-1565.0 * 1.0e-6).deg),
  LatTerm(1.0, 0.0, 0.0, 1.0, (-1491.0 * 1.0e-6).deg),
  LatTerm(0.0, 1.0, 1.0, 1.0, (-1475.0 * 1.0e-6).deg),
  LatTerm(0.0, 1.0, 1.0, -1.0, (-1410.0 * 1.0e-6).deg),
  LatTerm(0.0, 1.0, 0.0, -1.0, (-1344.0 * 1.0e-6).deg),
  LatTerm(1.0, 0.0, 0.0, -1.0, (-1335.0 * 1.0e-6).deg),
  LatTerm(0.0, 0.0, 3.0, 1.0, (1107.0 * 1.0e-6).deg),
  LatTerm(4.0, 0.0, 0.0, -1.0, (1021.0 * 1.0e-6).deg),
  LatTerm(4.0, 0.0, -1.0, 1.0, (833.0 * 1.0e-6).deg),
  
  LatTerm(0.0, 0.0, 1.0, -3.0, (777.0 * 1.0e-6).deg),
  LatTerm(4.0, 0.0, -2.0, 1.0, (671.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, 0.0, -3.0, (607.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, 2.0, -1.0, (596.0 * 1.0e-6).deg),
  LatTerm(2.0, -1.0, 1.0, -1.0, (491.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, -2.0, 1.0, (-451.0 * 1.0e-6).deg),
  LatTerm(0.0, 0.0, 3.0, -1.0, (439.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, 2.0, 1.0, (422.0 * 1.0e-6).deg),
  LatTerm(2.0, 0.0, -3.0, -1.0, (421.0 * 1.0e-6).deg),
  LatTerm(2.0, 1.0, -1.0, 1.0, (-366.0 * 1.0e-6).deg),
  LatTerm(2.0, 1.0, 0.0, 1.0, (-351.0 * 1.0e-6).deg),
  LatTerm(4.0, 0.0, 0.0, 1.0, (331.0 * 1.0e-6).deg),
  LatTerm(2.0, -1.0, 1.0, 1.0, (315.0 * 1.0e-6).deg),
  LatTerm(2.0, -2.0, 0.0, -1.0, (302.0 * 1.0e-6).deg),
  LatTerm(0.0, 0.0, 1.0, 3.0, (-283.0 * 1.0e-6).deg),
  LatTerm(2.0, 1.0, 1.0, -1.0, (-229.0 * 1.0e-6).deg),
  LatTerm(1.0, 1.0, 0.0, -1.0, (223.0 * 1.0e-6).deg),
  LatTerm(1.0, 1.0, 0.0, 1.0, (223.0 * 1.0e-6).deg),
  LatTerm(0.0, 1.0, -2.0, -1.0, (-220.0 * 1.0e-6).deg),
  LatTerm(2.0, 1.0, -1.0, -1.0, (-220.0 * 1.0e-6).deg),
  LatTerm(1.0, 0.0, 1.0, 1.0, (-185.0 * 1.0e-6).deg),
  LatTerm(2.0, -1.0, -2.0, -1.0, (181.0 * 1.0e-6).deg),
  LatTerm(0.0, 1.0, 2.0, 1.0, (-177.0 * 1.0e-6).deg),
  LatTerm(4.0, 0.0, -2.0, -1.0, (176.0 * 1.0e-6).deg),
  LatTerm(4.0, -1.0, -1.0, -1.0, (166.0 * 1.0e-6).deg),
  LatTerm(1.0, 0.0, 1.0, -1.0, (-164.0 * 1.0e-6).deg),
  LatTerm(4.0, 0.0, 1.0, -1.0, (132.0 * 1.0e-6).deg),
  LatTerm(1.0, 0.0, -1.0, -1.0, (-119.0 * 1.0e-6).deg),
  LatTerm(4.0, -1.0, 0.0, -1.0, (115.0 * 1.0e-6).deg),
  LatTerm(2.0, -2.0, 0.0, 1.0, (107.0 * 1.0e-6).deg),
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
elp2000_82b_T(_ jde:Double) -> Double
{
  return (jde - 2451545.0) / 36525.0;
}

fileprivate let ELP_218_3164591_RAD = (218.3164591).deg
fileprivate let ELP_481267_88134236_RAD = (481267.88134236).deg
fileprivate let ELP_0_0013268_RAD = (0.0013268).deg
fileprivate let ELP_RCP_538841_0_RAD = (1.0 / 538841.0).deg
fileprivate let ELP_RCP_65194000_0_RAD = (1.0 / 65194000.0).deg

fileprivate func
elp2000_82b_Lprime(_ T: Double) -> Double
{
  let Lp: Double = ELP_218_3164591_RAD + ELP_481267_88134236_RAD * T -
  ELP_0_0013268_RAD * T * T + T * T * T * ELP_RCP_538841_0_RAD -
  T * T * T * T * ELP_RCP_65194000_0_RAD;
  return clamp_degs(Lp);
}

fileprivate let ELP_297_8502042_RAD = (297.8502042).deg
fileprivate let  ELP_445267_1115168_RAD = (445267.1115168).deg
fileprivate let  ELP_0_0016300_RAD = (0.0016300).deg
fileprivate let  ELP_RCP_545868_0_RAD = (1.0 / 545868.0).deg
fileprivate let  ELP_RCP_113065000_0_RAD = (1.0 / 113065000.0).deg

fileprivate func
elp2000_82b_D(_ T: Double) -> Double
{
  let D : Double = ELP_297_8502042_RAD + ELP_445267_1115168_RAD * T -
  ELP_0_0016300_RAD * T * T + T * T * T * ELP_RCP_545868_0_RAD -
  T * T * T * T * ELP_RCP_113065000_0_RAD;
  return clamp_degs(D);
}

fileprivate let ELP_357_5291092_RAD = (357.5291092).deg
fileprivate let ELP_35999_0502909_RAD = (35999.0502909).deg
fileprivate let ELP_0_0001536_RAD = (0.0001536).deg
fileprivate let ELP_RCP_24490000_0_RAD = (1.0 / 24490000.0).deg

fileprivate func
elp2000_82b_M(_ T: Double) -> Double
{
  let M: Double = ELP_357_5291092_RAD + ELP_35999_0502909_RAD * T -
  ELP_0_0001536_RAD * T * T + T * T * T * ELP_RCP_24490000_0_RAD;
  return clamp_degs(M);
}

fileprivate let ELP_134_9634114_RAD = (134.9634114).deg
fileprivate let ELP_477198_8676313_RAD = (477198.8676313).deg
fileprivate let ELP_0_0089970_RAD = (0.0089970).deg
fileprivate let ELP_RCP_69699_0_RAD = (1.0 / 69699.0).deg
fileprivate let ELP_RCP_14712000_0_RAD = (1.0 / 14712000.0).deg

fileprivate func
elp2000_82b_Mprime(_ T: Double) -> Double
{
  let Mp: Double = ELP_134_9634114_RAD + ELP_477198_8676313_RAD * T +
  ELP_0_0089970_RAD * T * T + T * T * T * ELP_RCP_69699_0_RAD -
  T * T * T * T * ELP_RCP_14712000_0_RAD;
  return clamp_degs(Mp);
}

fileprivate let ELP_93_2720993_RAD = (93.2720993).deg
fileprivate let ELP_483202_0175273_RAD = (483202.0175273).deg
fileprivate let ELP_0_0034029_RAD = (0.0034029).deg
fileprivate let ELP_RCP_3526000_0_RAD = (1.0 / 3526000.0).deg
fileprivate let ELP_RCP_863310000_0_RAD = (1.0 / 863310000.0).deg

fileprivate func
elp2000_82b_F(_ T: Double) -> Double
{
  let F: Double = ELP_93_2720993_RAD + ELP_483202_0175273_RAD * T -
  ELP_0_0034029_RAD * T * T - T * T * T * ELP_RCP_3526000_0_RAD +
  T * T * T * T * ELP_RCP_863310000_0_RAD;
  return clamp_degs(F);
}

fileprivate let ELP_119_75_RAD = (119.75).deg
fileprivate let ELP_131_849_RAD = (131.849).deg

fileprivate func
elp2000_82b_A1(_ T: Double) -> Double
{
  let A1: Double = ELP_119_75_RAD + ELP_131_849_RAD * T;
  return clamp_degs(A1);
}

fileprivate let ELP_53_09_RAD = (53.09).deg
fileprivate let ELP_479264_290_RAD = (479264.290).deg

fileprivate func
elp2000_82b_A2(_ T: Double) -> Double
{
  let A2: Double = ELP_53_09_RAD + ELP_479264_290_RAD * T;
  return clamp_degs(A2);
}

fileprivate let ELP_313_45_RAD = (313.45).deg
fileprivate let ELP_481266_484_RAD = (481266.484).deg

fileprivate func
elp2000_82b_A3(_ T: Double) -> Double
{
  let A3: Double = ELP_313_45_RAD + ELP_481266_484_RAD * T;
  return clamp_degs(A3);
}

fileprivate func
elp2000_82b_E(_ T: Double) -> Double
{
  return 1.0 - 0.002516 * T - 0.0000074 * T * T;
}

fileprivate let ELP_3958_0_RAD = (3958.0 * 1.0e-6).deg
fileprivate let ELP_1962_0_RAD = (1962.0 * 1.0e-6).deg
fileprivate let ELP_318_0_RAD = (318.0 * 1.0e-6).deg
fileprivate let ELP_2235_0_RAD = (2235.0 * 1.0e-6).deg
fileprivate let ELP_382_0_RAD = (382.0 * 1.0e-6).deg
fileprivate let ELP_175_0_RAD = (175.0 * 1.0e-6).deg
fileprivate let ELP_127_0_RAD = (127.0 * 1.0e-6).deg
fileprivate let ELP_115_0_RAD = (115.0 * 1.0e-6).deg

// Note JDE not same as jd
// TODO: Optimize by replacing all degree terms with radians

public func
elp2000_82b(_ jde:Double) -> SIMD3<Double>
{
  let T = elp2000_82b_T(jde);

  // Compute parameters in degrees.
  // Mean longitude . mean equinox of the date, incl light delay
  let Lprime = elp2000_82b_Lprime(T);
  // Mean elongation
  let D = elp2000_82b_D(T);
  // Sun's mean anomaly
  let M = elp2000_82b_M(T);

  // Moon's mean anomaly
  let Mprime = elp2000_82b_Mprime(T);
  // Moon's argument of latitude
  let F = elp2000_82b_F(T);

  let A1 = elp2000_82b_A1(T);
  let A2 = elp2000_82b_A2(T);
  let A3 = elp2000_82b_A3(T);

  // Decreasing eccentricity of earth orbit around sun
  let E = elp2000_82b_E(T);

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
