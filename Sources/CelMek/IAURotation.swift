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

/*
  This is an attempt at implementing the rotational elements described by the
  IAU WG 'Cartographic Coordinates and Rotational Elements'.

  See:
  - https://www.iau.org/science/scientific_bodies/working_groups/100/
  - Report of the IAU Working Group on Cartographic Coordinates and Rotational Elements: 2015
     - [DOI 10.1007/s10569-017-9805-5](https://doi.org/10.1007/s10569-017-9805-5)
     - [PDF](https://rdcu.be/b32V4)
  - Correction to: Report of the IAU Working Group on Cartographic Coordinates and Rotational Elements: 2015
     - [10.1007/s10569-019-9925-1](https://doi.org/10.1007/s10569-019-9925-1)
     - [PDF](https://rdcu.be/b32WL)
 */

enum IAUTermID : Int {
  case IAU_TERM_E1
  case IAU_TERM_E10
  case IAU_TERM_E11
  case IAU_TERM_E12
  case IAU_TERM_E13
  case IAU_TERM_E2
  case IAU_TERM_E3
  case IAU_TERM_E4
  case IAU_TERM_E5
  case IAU_TERM_E6
  case IAU_TERM_E7
  case IAU_TERM_E8
  case IAU_TERM_E9
  case IAU_TERM_J1
  case IAU_TERM_J2
  case IAU_TERM_J3
  case IAU_TERM_J4
  case IAU_TERM_J5
  case IAU_TERM_J6
  case IAU_TERM_J7
  case IAU_TERM_J8
  case IAU_TERM_JD
  case IAU_TERM_JA
  case IAU_TERM_JB
  case IAU_TERM_JC
  case IAU_TERM_JE
  case IAU_TERM_M1
  case IAU_TERM_M2
  case IAU_TERM_M3
  case IAU_TERM_ME1
  case IAU_TERM_ME2
  case IAU_TERM_ME3
  case IAU_TERM_ME4
  case IAU_TERM_ME5
  case IAU_TERM_N
  case IAU_TERM_N1
  case IAU_TERM_N2
  case IAU_TERM_N3
  case IAU_TERM_N4
  case IAU_TERM_N5
  case IAU_TERM_N6
  case IAU_TERM_N7
  case IAU_TERM_S1
  case IAU_TERM_S2
  case IAU_TERM_S3
  case IAU_TERM_S4
  case IAU_TERM_S5
  case IAU_TERM_S6
  case IAU_TERM_U1
  case IAU_TERM_U10
  case IAU_TERM_U11
  case IAU_TERM_U12
  case IAU_TERM_U13
  case IAU_TERM_U14
  case IAU_TERM_U15
  case IAU_TERM_U16
  case IAU_TERM_U2
  case IAU_TERM_U3
  case IAU_TERM_U4
  case IAU_TERM_U5
  case IAU_TERM_U6
  case IAU_TERM_U7
  case IAU_TERM_U8
  case IAU_TERM_U9
  case IAU_TERM_COUNT
}

struct IAUTerm {
  var term: IAUTermID
  var a, b: Double
  init(_ term: IAUTermID, _ a: Double, _ b: Double) {
    self.term = term
    self.a = a.deg
    self.b = b.deg
  }
}

let d_terms: [IAUTerm] = [
  IAUTerm(.IAU_TERM_E11, 119.743, +0.0036096),
  IAUTerm(.IAU_TERM_E10, 15.134, -0.1589763),
  IAUTerm(.IAU_TERM_E13, 25.053, +12.9590088),
  IAUTerm(.IAU_TERM_E12, 239.961, +0.1643573),
  IAUTerm(.IAU_TERM_M1, 169.51, -0.4357640),
  IAUTerm(.IAU_TERM_M3, 53.47, -0.0181510),
  IAUTerm(.IAU_TERM_M2, 192.93, +1128.4096700),
  IAUTerm(.IAU_TERM_E9, 34.226, +1.7484877),
  IAUTerm(.IAU_TERM_E8, 276.617, +0.3287146),
  IAUTerm(.IAU_TERM_E5, 357.529, +0.9856003),
  IAUTerm(.IAU_TERM_E4, 176.625, +13.3407154),
  IAUTerm(.IAU_TERM_E7, 134.963, +13.0649930),
  IAUTerm(.IAU_TERM_E6, 311.589, +26.4057084),
  IAUTerm(.IAU_TERM_E1, 125.045, -0.0529921),
  IAUTerm(.IAU_TERM_E3, 260.008, +13.0120009),
  IAUTerm(.IAU_TERM_E2, 250.089, -0.1059842),
  IAUTerm(.IAU_TERM_ME5, 153.955429, +20.461675),
  IAUTerm(.IAU_TERM_ME4, 339.164343, +16.369340),
  IAUTerm(.IAU_TERM_ME1, 174.791086, +4.092335),
  IAUTerm(.IAU_TERM_ME3, 164.373257, +12.277005),
  IAUTerm(.IAU_TERM_ME2, 349.582171, +8.184670),
];

let T_terms: [IAUTerm] = [
  IAUTerm(.IAU_TERM_U9, 101.81, +12872.63),
  IAUTerm(.IAU_TERM_U8, 157.36, +16652.76),
  IAUTerm(.IAU_TERM_U1, 115.75, +54991.87),
  IAUTerm(.IAU_TERM_S6, 345.20, -1016.3),
  IAUTerm(.IAU_TERM_S5, 316.45, +506.2),
  IAUTerm(.IAU_TERM_S4, 300.00, -7225.9),
  IAUTerm(.IAU_TERM_U11, 102.23, -2024.22),
  IAUTerm(.IAU_TERM_JD, 114.012305, +6070.2476),
  IAUTerm(.IAU_TERM_U10, 138.64, +8061.81),
  IAUTerm(.IAU_TERM_U13, 304.01, -51.94),
  IAUTerm(.IAU_TERM_U12, 316.41, +2863.96),
  IAUTerm(.IAU_TERM_U15, 340.82, -75.32),
  IAUTerm(.IAU_TERM_U14, 308.71, -93.17),
  IAUTerm(.IAU_TERM_U16, 259.14, -504.81),
  IAUTerm(.IAU_TERM_U4, 61.77, +25733.59),
  IAUTerm(.IAU_TERM_U5, 249.32, +24471.46),
  IAUTerm(.IAU_TERM_N3, 354.27, +46564.5),
  IAUTerm(.IAU_TERM_U7, 77.66, +20289.42),
  IAUTerm(.IAU_TERM_S1, 353.32, +75706.7),
  IAUTerm(.IAU_TERM_S3, 177.40, -36505.5),
  IAUTerm(.IAU_TERM_S2, 28.72, +75706.7),
  IAUTerm(.IAU_TERM_JA, 99.360714, +4850.4046),
  IAUTerm(.IAU_TERM_U6, 43.86, +22278.41),
  IAUTerm(.IAU_TERM_N, 357.85, +52.316),
  IAUTerm(.IAU_TERM_U3, 135.03, +29927.35),
  IAUTerm(.IAU_TERM_JE, 49.511251, +64.3000),
  IAUTerm(.IAU_TERM_N1, 323.92, +62606.6),
  IAUTerm(.IAU_TERM_N2, 220.51, +55064.2),
  IAUTerm(.IAU_TERM_U2, 141.69, +41887.66),
  IAUTerm(.IAU_TERM_N4, 75.31, +26109.4),
  IAUTerm(.IAU_TERM_N5, 35.36, +14325.4),
  IAUTerm(.IAU_TERM_N6, 142.61, +2824.6),
  IAUTerm(.IAU_TERM_N7, 177.85, +52.316),
  IAUTerm(.IAU_TERM_J8, 113.35, +6070.0),
  IAUTerm(.IAU_TERM_J4, 355.80, +1191.3),
  IAUTerm(.IAU_TERM_J5, 119.90, +262.1),
  IAUTerm(.IAU_TERM_J6, 229.80, +64.3),
  IAUTerm(.IAU_TERM_J7, 352.25, +2382.6),
  IAUTerm(.IAU_TERM_J1, 73.32, +91472.9),
  IAUTerm(.IAU_TERM_J2, 24.62, +45137.2),
  IAUTerm(.IAU_TERM_J3, 283.90, +4850.7),
  IAUTerm(.IAU_TERM_JB, 175.895369, +1191.9605),
  IAUTerm(.IAU_TERM_JC, 300.323162, +262.5475),
]

struct IAUTerm2 {
  var term: IAUTermID
  var a: Double
  init(_ term: IAUTermID, _ a: Double) {
    self.term = term
    self.a = a.deg
  }
}

let T2_terms: [IAUTerm2] = [
  IAUTerm2(.IAU_TERM_M2, +8.864),
]

enum IAUBodyID : Int {
  case IAU_BODY_19P_BORRELLY
  case IAU_BODY_9P_TEMPEL_1
  case IAU_BODY_ADRASTEA
  case IAU_BODY_AMALTHEA
  case IAU_BODY_ARIEL
  case IAU_BODY_ATLAS
  case IAU_BODY_BELINDA
  case IAU_BODY_BIANCA
  case IAU_BODY_CALLISTO
  case IAU_BODY_CALYPSO
  case IAU_BODY_CERES
  case IAU_BODY_CHARON
  case IAU_BODY_CORDELIA
  case IAU_BODY_CRESSIDA
  case IAU_BODY_DAVIDA
  case IAU_BODY_DEIMOS
  case IAU_BODY_DESDEMONA
  case IAU_BODY_DESPINA
  case IAU_BODY_DIONE
  case IAU_BODY_EARTH
  case IAU_BODY_ENCELADUS
  case IAU_BODY_EPIMETHEUS
  case IAU_BODY_EROS
  case IAU_BODY_EUROPA
  case IAU_BODY_GALATEA
  case IAU_BODY_GANYMEDE
  case IAU_BODY_GASPRA
  case IAU_BODY_HELENE
  case IAU_BODY_IAPETUS
  case IAU_BODY_IDA
  case IAU_BODY_IO
  case IAU_BODY_ITOKAWA
  case IAU_BODY_JANUS
  case IAU_BODY_JULIET
  case IAU_BODY_JUPITER
  case IAU_BODY_LARISSA
  case IAU_BODY_LUTETIA
  case IAU_BODY_MARS
  case IAU_BODY_MERCURY
  case IAU_BODY_METIS
  case IAU_BODY_MIMAS
  case IAU_BODY_MIRANDA
  case IAU_BODY_MOON
  case IAU_BODY_NAIAD
  case IAU_BODY_NEPTUNE
  case IAU_BODY_OBERON
  case IAU_BODY_OPHELIA
  case IAU_BODY_PALLAS
  case IAU_BODY_PAN
  case IAU_BODY_PANDORA
  case IAU_BODY_PHOBOS
  case IAU_BODY_PHOEBE
  case IAU_BODY_PLUTO
  case IAU_BODY_PORTIA
  case IAU_BODY_PROMETHEUS
  case IAU_BODY_PROTEUS
  case IAU_BODY_PUCK
  case IAU_BODY_RHEA
  case IAU_BODY_ROSALIND
  case IAU_BODY_SATURN
  case IAU_BODY_STEINS
  case IAU_BODY_SUN
  case IAUBodyELESTO
  case IAUBodyETHYS
  case IAUBodyHALASSA
  case IAUBodyHEBE
  case IAUBodyITAN
  case IAUBodyITANIA
  case IAUBodyRITON
  case IAU_BODY_UMBRIEL
  case IAU_BODY_URANUS
  case IAU_BODY_VENUS
  case IAU_BODY_VESTA
  case IAU_BODY_COUNT
}

enum IAUSineID : Int {
  case IAU_SIN_U9
  case IAU_SIN_U8
  case IAU_SIN_8N7
  case IAU_SIN_E11
  case IAU_SIN_U4
  case IAU_SIN_U7
  case IAU_SIN_E12
  case IAU_SIN_U1
  case IAU_SIN_S6
  case IAU_SIN_S5
  case IAU_SIN_S4
  case IAU_SIN_JD
  case IAU_SIN_M1
  case IAU_SIN_JB
  case IAU_SIN_M3
  case IAU_SIN_M2
  case IAU_SIN_U11
  case IAU_SIN_U10
  case IAU_SIN_U13
  case IAU_SIN_U12
  case IAU_SIN_U15
  case IAU_SIN_2U11
  case IAU_SIN_2U12
  case IAU_SIN_U16
  case IAU_SIN_6N7
  case IAU_SIN_U5
  case IAU_SIN_2N7
  case IAU_SIN_2J2
  case IAU_SIN_2J1
  case IAU_SIN_N3
  case IAU_SIN_S1
  case IAU_SIN_U14
  case IAU_SIN_3N7
  case IAU_SIN_7N7
  case IAU_SIN_E9
  case IAU_SIN_E8
  case IAU_SIN_S2
  case IAU_SIN_E10
  case IAU_SIN_E5
  case IAU_SIN_E4
  case IAU_SIN_E7
  case IAU_SIN_E6
  case IAU_SIN_E1
  case IAU_SIN_E13
  case IAU_SIN_E3
  case IAU_SIN_E2
  case IAU_SIN_4N7
  case IAU_SIN_U6
  case IAU_SIN_5N7
  case IAU_SIN_J3
  case IAU_SIN_N
  case IAU_SIN_U3
  case IAU_SIN_JE
  case IAU_SIN_N1
  case IAU_SIN_N2
  case IAU_SIN_U2
  case IAU_SIN_N4
  case IAU_SIN_N5
  case IAU_SIN_N6
  case IAU_SIN_N7
  case IAU_SIN_J8
  case IAU_SIN_9N7
  case IAU_SIN_J4
  case IAU_SIN_J5
  case IAU_SIN_J6
  case IAU_SIN_J7
  case IAU_SIN_J1
  case IAU_SIN_J2
  case IAU_SIN_JA
  case IAU_SIN_ME5
  case IAU_SIN_ME4
  case IAU_SIN_2N1
  case IAU_SIN_ME1
  case IAU_SIN_2S2
  case IAU_SIN_ME3
  case IAU_SIN_ME2
  case IAU_SIN_2S1
  case IAU_SIN_JC
  case IAU_SIN_S3
  case IAU_SIN_COUNT
}

enum IAUCosineID : Int {
  case IAU_COS_U9
  case IAU_COS_U8
  case IAU_COS_2S1
  case IAU_COS_S3
  case IAU_COS_U4
  case IAU_COS_U7
  case IAU_COS_U6
  case IAU_COS_U1
  case IAU_COS_S6
  case IAU_COS_U3
  case IAU_COS_U2
  case IAU_COS_JD
  case IAU_COS_M1
  case IAU_COS_JB
  case IAU_COS_M3
  case IAU_COS_U11
  case IAU_COS_U10
  case IAU_COS_U13
  case IAU_COS_7N7
  case IAU_COS_U15
  case IAU_COS_2U11
  case IAU_COS_U16
  case IAU_COS_U5
  case IAU_COS_2N7
  case IAU_COS_2J2
  case IAU_COS_N3
  case IAU_COS_S1
  case IAU_COS_U14
  case IAU_COS_3N7
  case IAU_COS_E10
  case IAU_COS_E4
  case IAU_COS_E7
  case IAU_COS_E6
  case IAU_COS_E1
  case IAU_COS_E13
  case IAU_COS_E3
  case IAU_COS_E2
  case IAU_COS_4N7
  case IAU_COS_5N7
  case IAU_COS_N
  case IAU_COS_J3
  case IAU_COS_JE
  case IAU_COS_N1
  case IAU_COS_N2
  case IAU_COS_S4
  case IAU_COS_N4
  case IAU_COS_N5
  case IAU_COS_N6
  case IAU_COS_N7
  case IAU_COS_J8
  case IAU_COS_J4
  case IAU_COS_J5
  case IAU_COS_J6
  case IAU_COS_J7
  case IAU_COS_J1
  case IAU_COS_J2
  case IAU_COS_JA
  case IAU_COS_6N7
  case IAU_COS_2S2
  case IAU_COS_S2
  case IAU_COS_2N1
  case IAU_COS_JC
  case IAU_COS_COUNT
}

struct IAUArgRule {
  var m: Double
  var term: IAUTermID
  init(_ m: Double, _ term: IAUTermID) {
    self.m = m
    self.term = term
  }
}

let sine_rules: [IAUArgRule] = [
  /* [IAU_SIN_U9] */ IAUArgRule(1, .IAU_TERM_U9),
  /* [IAU_SIN_U8] */ IAUArgRule(1, .IAU_TERM_U8),
  /* [IAU_SIN_8N7] */ IAUArgRule(8, .IAU_TERM_N7),
  /* [IAU_SIN_E11] */ IAUArgRule(1, .IAU_TERM_E11),
  /* [IAU_SIN_U4] */ IAUArgRule(1, .IAU_TERM_U4),
  /* [IAU_SIN_U7] */ IAUArgRule(1, .IAU_TERM_U7),
  /* [IAU_SIN_E12] */ IAUArgRule(1, .IAU_TERM_E12),
  /* [IAU_SIN_U1] */ IAUArgRule(1, .IAU_TERM_U1),
  /* [IAU_SIN_S6] */ IAUArgRule(1, .IAU_TERM_S6),
  /* [IAU_SIN_S5] */ IAUArgRule(1, .IAU_TERM_S5),
  /* [IAU_SIN_S4] */ IAUArgRule(1, .IAU_TERM_S4),
  /* [IAU_SIN_JD] */ IAUArgRule(1, .IAU_TERM_JD),
  /* [IAU_SIN_M1] */ IAUArgRule(1, .IAU_TERM_M1),
  /* [IAU_SIN_JB] */ IAUArgRule(1, .IAU_TERM_JB),
  /* [IAU_SIN_M3] */ IAUArgRule(1, .IAU_TERM_M3),
  /* [IAU_SIN_M2] */ IAUArgRule(1, .IAU_TERM_M2),
  /* [IAU_SIN_U11] */ IAUArgRule(1, .IAU_TERM_U11),
  /* [IAU_SIN_U10] */ IAUArgRule(1, .IAU_TERM_U10),
  /* [IAU_SIN_U13] */ IAUArgRule(1, .IAU_TERM_U13),
  /* [IAU_SIN_U12] */ IAUArgRule(1, .IAU_TERM_U12),
  /* [IAU_SIN_U15] */ IAUArgRule(1, .IAU_TERM_U15),
  /* [IAU_SIN_2U11] */ IAUArgRule(2, .IAU_TERM_U11),
  /* [IAU_SIN_2U12] */ IAUArgRule(2, .IAU_TERM_U12),
  /* [IAU_SIN_U16] */ IAUArgRule(1, .IAU_TERM_U16),
  /* [IAU_SIN_6N7] */ IAUArgRule(6, .IAU_TERM_N7),
  /* [IAU_SIN_U5] */ IAUArgRule(1, .IAU_TERM_U5),
  /* [IAU_SIN_2N7] */ IAUArgRule(2, .IAU_TERM_N7),
  /* [IAU_SIN_2J2] */ IAUArgRule(2, .IAU_TERM_J2),
  /* [IAU_SIN_2J1] */ IAUArgRule(2, .IAU_TERM_J1),
  /* [IAU_SIN_N3] */ IAUArgRule(1, .IAU_TERM_N3),
  /* [IAU_SIN_S1] */ IAUArgRule(1, .IAU_TERM_S1),
  /* [IAU_SIN_U14] */ IAUArgRule(1, .IAU_TERM_U14),
  /* [IAU_SIN_3N7] */ IAUArgRule(3, .IAU_TERM_N7),
  /* [IAU_SIN_7N7] */ IAUArgRule(7, .IAU_TERM_N7),
  /* [IAU_SIN_E9] */ IAUArgRule(1, .IAU_TERM_E9),
  /* [IAU_SIN_E8] */ IAUArgRule(1, .IAU_TERM_E8),
  /* [IAU_SIN_S2] */ IAUArgRule(1, .IAU_TERM_S2),
  /* [IAU_SIN_E10] */ IAUArgRule(1, .IAU_TERM_E10),
  /* [IAU_SIN_E5] */ IAUArgRule(1, .IAU_TERM_E5),
  /* [IAU_SIN_E4] */ IAUArgRule(1, .IAU_TERM_E4),
  /* [IAU_SIN_E7] */ IAUArgRule(1, .IAU_TERM_E7),
  /* [IAU_SIN_E6] */ IAUArgRule(1, .IAU_TERM_E6),
  /* [IAU_SIN_E1] */ IAUArgRule(1, .IAU_TERM_E1),
  /* [IAU_SIN_E13] */ IAUArgRule(1, .IAU_TERM_E13),
  /* [IAU_SIN_E3] */ IAUArgRule(1, .IAU_TERM_E3),
  /* [IAU_SIN_E2] */ IAUArgRule(1, .IAU_TERM_E2),
  /* [IAU_SIN_4N7] */ IAUArgRule(4, .IAU_TERM_N7),
  /* [IAU_SIN_U6] */ IAUArgRule(1, .IAU_TERM_U6),
  /* [IAU_SIN_5N7] */ IAUArgRule(5, .IAU_TERM_N7),
  /* [IAU_SIN_J3] */ IAUArgRule(1, .IAU_TERM_J3),
  /* [IAU_SIN_N] */ IAUArgRule(1, .IAU_TERM_N),
  /* [IAU_SIN_U3] */ IAUArgRule(1, .IAU_TERM_U3),
  /* [IAU_SIN_JE] */ IAUArgRule(1, .IAU_TERM_JE),
  /* [IAU_SIN_N1] */ IAUArgRule(1, .IAU_TERM_N1),
  /* [IAU_SIN_N2] */ IAUArgRule(1, .IAU_TERM_N2),
  /* [IAU_SIN_U2] */ IAUArgRule(1, .IAU_TERM_U2),
  /* [IAU_SIN_N4] */ IAUArgRule(1, .IAU_TERM_N4),
  /* [IAU_SIN_N5] */ IAUArgRule(1, .IAU_TERM_N5),
  /* [IAU_SIN_N6] */ IAUArgRule(1, .IAU_TERM_N6),
  /* [IAU_SIN_N7] */ IAUArgRule(1, .IAU_TERM_N7),
  /* [IAU_SIN_J8] */ IAUArgRule(1, .IAU_TERM_J8),
  /* [IAU_SIN_9N7] */ IAUArgRule(9, .IAU_TERM_N7),
  /* [IAU_SIN_J4] */ IAUArgRule(1, .IAU_TERM_J4),
  /* [IAU_SIN_J5] */ IAUArgRule(1, .IAU_TERM_J5),
  /* [IAU_SIN_J6] */ IAUArgRule(1, .IAU_TERM_J6),
  /* [IAU_SIN_J7] */ IAUArgRule(1, .IAU_TERM_J7),
  /* [IAU_SIN_J1] */ IAUArgRule(1, .IAU_TERM_J1),
  /* [IAU_SIN_J2] */ IAUArgRule(1, .IAU_TERM_J2),
  /* [IAU_SIN_JA] */ IAUArgRule(1, .IAU_TERM_JA),
  /* [IAU_SIN_ME5] */ IAUArgRule(1, .IAU_TERM_ME5),
  /* [IAU_SIN_ME4] */ IAUArgRule(1, .IAU_TERM_ME4),
  /* [IAU_SIN_2N1] */ IAUArgRule(2, .IAU_TERM_N1),
  /* [IAU_SIN_ME1] */ IAUArgRule(1, .IAU_TERM_ME1),
  /* [IAU_SIN_2S2] */ IAUArgRule(2, .IAU_TERM_S2),
  /* [IAU_SIN_ME3] */ IAUArgRule(1, .IAU_TERM_ME3),
  /* [IAU_SIN_ME2] */ IAUArgRule(1, .IAU_TERM_ME2),
  /* [IAU_SIN_2S1] */ IAUArgRule(2, .IAU_TERM_S1),
  /* [IAU_SIN_JC] */ IAUArgRule(1, .IAU_TERM_JC),
  /* [IAU_SIN_S3] */ IAUArgRule(1, .IAU_TERM_S3),
]

let cosine_rules: [IAUArgRule] = [
  /* [IAU_COS_U9] */ IAUArgRule(1, .IAU_TERM_U9),
  /* [IAU_COS_U8] */ IAUArgRule(1, .IAU_TERM_U8),
  /* [IAU_COS_2S1] */ IAUArgRule(2, .IAU_TERM_S1),
  /* [IAU_COS_S3] */ IAUArgRule(1, .IAU_TERM_S3),
  /* [IAU_COS_U4] */ IAUArgRule(1, .IAU_TERM_U4),
  /* [IAU_COS_U7] */ IAUArgRule(1, .IAU_TERM_U7),
  /* [IAU_COS_U6] */ IAUArgRule(1, .IAU_TERM_U6),
  /* [IAU_COS_U1] */ IAUArgRule(1, .IAU_TERM_U1),
  /* [IAU_COS_S6] */ IAUArgRule(1, .IAU_TERM_S6),
  /* [IAU_COS_U3] */ IAUArgRule(1, .IAU_TERM_U3),
  /* [IAU_COS_U2] */ IAUArgRule(1, .IAU_TERM_U2),
  /* [IAU_COS_JD] */ IAUArgRule(1, .IAU_TERM_JD),
  /* [IAU_COS_M1] */ IAUArgRule(1, .IAU_TERM_M1),
  /* [IAU_COS_JB] */ IAUArgRule(1, .IAU_TERM_JB),
  /* [IAU_COS_M3] */ IAUArgRule(1, .IAU_TERM_M3),
  /* [IAU_COS_U11] */ IAUArgRule(1, .IAU_TERM_U11),
  /* [IAU_COS_U10] */ IAUArgRule(1, .IAU_TERM_U10),
  /* [IAU_COS_U13] */ IAUArgRule(1, .IAU_TERM_U13),
  /* [IAU_COS_7N7] */ IAUArgRule(7, .IAU_TERM_N7),
  /* [IAU_COS_U15] */ IAUArgRule(1, .IAU_TERM_U15),
  /* [IAU_COS_2U11] */ IAUArgRule(2, .IAU_TERM_U11),
  /* [IAU_COS_U16] */ IAUArgRule(1, .IAU_TERM_U16),
  /* [IAU_COS_U5] */ IAUArgRule(1, .IAU_TERM_U5),
  /* [IAU_COS_2N7] */ IAUArgRule(2, .IAU_TERM_N7),
  /* [IAU_COS_2J2] */ IAUArgRule(2, .IAU_TERM_J2),
  /* [IAU_COS_N3] */ IAUArgRule(1, .IAU_TERM_N3),
  /* [IAU_COS_S1] */ IAUArgRule(1, .IAU_TERM_S1),
  /* [IAU_COS_U14] */ IAUArgRule(1, .IAU_TERM_U14),
  /* [IAU_COS_3N7] */ IAUArgRule(3, .IAU_TERM_N7),
  /* [IAU_COS_E10] */ IAUArgRule(1, .IAU_TERM_E10),
  /* [IAU_COS_E4] */ IAUArgRule(1, .IAU_TERM_E4),
  /* [IAU_COS_E7] */ IAUArgRule(1, .IAU_TERM_E7),
  /* [IAU_COS_E6] */ IAUArgRule(1, .IAU_TERM_E6),
  /* [IAU_COS_E1] */ IAUArgRule(1, .IAU_TERM_E1),
  /* [IAU_COS_E13] */ IAUArgRule(1, .IAU_TERM_E13),
  /* [IAU_COS_E3] */ IAUArgRule(1, .IAU_TERM_E3),
  /* [IAU_COS_E2] */ IAUArgRule(1, .IAU_TERM_E2),
  /* [IAU_COS_4N7] */ IAUArgRule(4, .IAU_TERM_N7),
  /* [IAU_COS_5N7] */ IAUArgRule(5, .IAU_TERM_N7),
  /* [IAU_COS_N] */ IAUArgRule(1, .IAU_TERM_N),
  /* [IAU_COS_J3] */ IAUArgRule(1, .IAU_TERM_J3),
  /* [IAU_COS_JE] */ IAUArgRule(1, .IAU_TERM_JE),
  /* [IAU_COS_N1] */ IAUArgRule(1, .IAU_TERM_N1),
  /* [IAU_COS_N2] */ IAUArgRule(1, .IAU_TERM_N2),
  /* [IAU_COS_S4] */ IAUArgRule(1, .IAU_TERM_S4),
  /* [IAU_COS_N4] */ IAUArgRule(1, .IAU_TERM_N4),
  /* [IAU_COS_N5] */ IAUArgRule(1, .IAU_TERM_N5),
  /* [IAU_COS_N6] */ IAUArgRule(1, .IAU_TERM_N6),
  /* [IAU_COS_N7] */ IAUArgRule(1, .IAU_TERM_N7),
  /* [IAU_COS_J8] */ IAUArgRule(1, .IAU_TERM_J8),
  /* [IAU_COS_J4] */ IAUArgRule(1, .IAU_TERM_J4),
  /* [IAU_COS_J5] */ IAUArgRule(1, .IAU_TERM_J5),
  /* [IAU_COS_J6] */ IAUArgRule(1, .IAU_TERM_J6),
  /* [IAU_COS_J7] */ IAUArgRule(1, .IAU_TERM_J7),
  /* [IAU_COS_J1] */ IAUArgRule(1, .IAU_TERM_J1),
  /* [IAU_COS_J2] */ IAUArgRule(1, .IAU_TERM_J2),
  /* [IAU_COS_JA] */ IAUArgRule(1, .IAU_TERM_JA),
  /* [IAU_COS_6N7] */ IAUArgRule(6, .IAU_TERM_N7),
  /* [IAU_COS_2S2] */ IAUArgRule(2, .IAU_TERM_S2),
  /* [IAU_COS_S2] */ IAUArgRule(1, .IAU_TERM_S2),
  /* [IAU_COS_2N1] */ IAUArgRule(2, .IAU_TERM_N1),
  /* [IAU_COS_JC] */ IAUArgRule(1, .IAU_TERM_JC),
]

struct IAUSineTerm {
  var a: Double
  var sine: IAUSineID
  init(_ a: Double, _ sine: IAUSineID) {
    self.a = a
    self.sine = sine
  }
}

struct IAUCosineTerm {
  var a: Double
  var cosine: IAUCosineID
  init(_ a: Double, _ cosine: IAUCosineID) {
    self.a = a
    self.cosine = cosine
  }
}

fileprivate let mercury_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.00993822, .IAU_SIN_ME1),
  IAUSineTerm(-0.00104581, .IAU_SIN_ME2),
  IAUSineTerm(-0.00010280, .IAU_SIN_ME3),
  IAUSineTerm(-0.00002364, .IAU_SIN_ME4),
  IAUSineTerm(-0.00000532, .IAU_SIN_ME5),
]

fileprivate let galatea_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.70, .IAU_SIN_N),
  IAUSineTerm(-0.07, .IAU_SIN_N4),
]

fileprivate let  galatea_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.51, .IAU_COS_N),
  IAUCosineTerm(-0.05, .IAU_COS_N4),
]

fileprivate let  galatea_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.48, .IAU_SIN_N),
  IAUSineTerm(+0.05, .IAU_SIN_N),
]

fileprivate let  thalassa_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.70, .IAU_SIN_N),
  IAUSineTerm(-0.28, .IAU_SIN_N2),
]

fileprivate let  thalassa_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.51, .IAU_COS_N),
  IAUCosineTerm(-0.21, .IAU_COS_N2),
]

fileprivate let  thalassa_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.48, .IAU_SIN_N),
  IAUSineTerm(+0.19, .IAU_SIN_N2),
]

fileprivate let  ariel_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.29, .IAU_SIN_U13),
]

fileprivate let  ariel_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.28, .IAU_COS_U13),
]

fileprivate let  ariel_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.05, .IAU_SIN_U12),
  IAUSineTerm(+0.08, .IAU_SIN_U13),
]

fileprivate let  puck_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.33, .IAU_SIN_U10),
]

fileprivate let  puck_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.31, .IAU_COS_U10),
]

fileprivate let  puck_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.09, .IAU_SIN_U10),
]

fileprivate let  phobos_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+1.79, .IAU_SIN_M1),
]

fileprivate let  phobos_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-1.08, .IAU_COS_M1),
]

fileprivate let phobos_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-1.42, .IAU_SIN_M1),
  IAUSineTerm(-0.78, .IAU_SIN_M2),
]

fileprivate let deimos_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+2.98, .IAU_SIN_M3),
]

fileprivate let deimos_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-1.78, .IAU_COS_M3),
]

fileprivate let deimos_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-2.58, .IAU_SIN_M3),
]

fileprivate let deimos_w_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.19, .IAU_COS_M3),
]

fileprivate let rhea_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+3.10, .IAU_SIN_S6),
]

fileprivate let rhea_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.35, .IAU_COS_S6),
]

fileprivate let rhea_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-3.08, .IAU_SIN_S6),
]

fileprivate let oberon_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.16, .IAU_SIN_U16),
]

fileprivate let oberon_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.16, .IAU_COS_U16),
]

fileprivate let oberon_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.04, .IAU_SIN_U16),
]

fileprivate let portia_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.09, .IAU_SIN_U7),
]

fileprivate let portia_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.09, .IAU_COS_U7),
]

fileprivate let portia_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.02, .IAU_SIN_U7),
]

fileprivate let europa_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+1.086, .IAU_SIN_J4),
  IAUSineTerm(+0.060, .IAU_SIN_J5),
  IAUSineTerm(+0.015, .IAU_SIN_J6),
  IAUSineTerm(+0.009, .IAU_SIN_J7),
]

fileprivate let europa_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.468, .IAU_COS_J4),
  IAUCosineTerm(+0.026, .IAU_COS_J5),
  IAUCosineTerm(+0.007, .IAU_COS_J6),
  IAUCosineTerm(+0.002, .IAU_COS_J7),
]

fileprivate let europa_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.980, .IAU_SIN_J4),
  IAUSineTerm(-0.054, .IAU_SIN_J5),
  IAUSineTerm(-0.014, .IAU_SIN_J6),
  IAUSineTerm(-0.008, .IAU_SIN_J7),
]

fileprivate let tethys_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+9.66, .IAU_SIN_S4),
]

fileprivate let tethys_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-1.09, .IAU_COS_S4),
]

fileprivate let tethys_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-9.60, .IAU_SIN_S4),
  IAUSineTerm(+2.23, .IAU_SIN_S5),
]

fileprivate let ophelia_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.09, .IAU_SIN_U2),
]

fileprivate let ophelia_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.09, .IAU_COS_U2),
]

fileprivate let ophelia_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.03, .IAU_SIN_U2),
]

fileprivate let rosalind_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.29, .IAU_SIN_U8),
]

fileprivate let rosalind_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.28, .IAU_COS_U8),
]

fileprivate let rosalind_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.08, .IAU_SIN_U8),
]

fileprivate let bianca_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.16, .IAU_SIN_U3),
]

fileprivate let bianca_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.16, .IAU_COS_U3),
]

fileprivate let bianca_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.04, .IAU_SIN_U3),
]

fileprivate let proteus_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.70, .IAU_SIN_N),
  IAUSineTerm(-0.05, .IAU_SIN_N6),
]

fileprivate let proteus_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.51, .IAU_COS_N),
  IAUCosineTerm(-0.04, .IAU_COS_N6),
]

fileprivate let proteus_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.48, .IAU_SIN_N),
  IAUSineTerm(+0.04, .IAU_SIN_N6),
]

fileprivate let cressida_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.04, .IAU_SIN_U4),
]

fileprivate let cressida_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.04, .IAU_COS_U4),
]

fileprivate let cressida_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.01, .IAU_SIN_U4),
]

fileprivate let belinda_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.03, .IAU_SIN_U9),
]

fileprivate let belinda_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.03, .IAU_COS_U9),
]

fileprivate let belinda_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.01, .IAU_SIN_U9),
]

fileprivate let miranda_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+4.41, .IAU_SIN_U11),
  IAUSineTerm(-0.04, .IAU_SIN_2U11),
]

fileprivate let miranda_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+4.25, .IAU_COS_U11),
  IAUCosineTerm(-0.02, .IAU_COS_2U11),
]

fileprivate let miranda_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-1.27, .IAU_SIN_U12),
  IAUSineTerm(+0.15, .IAU_SIN_2U12),
  IAUSineTerm(+1.15, .IAU_SIN_U11),
  IAUSineTerm(-0.09, .IAU_SIN_2U11),
]

fileprivate let larissa_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.70, .IAU_SIN_N),
  IAUSineTerm(-0.27, .IAU_SIN_N5),
]

fileprivate let larissa_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.51, .IAU_COS_N),
  IAUCosineTerm(-0.20, .IAU_COS_N5),
]

fileprivate let larissa_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.48, .IAU_SIN_N),
  IAUSineTerm(+0.19, .IAU_SIN_N),
]

fileprivate let amalthea_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.84, .IAU_SIN_J1),
  IAUSineTerm(+0.01, .IAU_SIN_2J1),
]

fileprivate let amalthea_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.36, .IAU_COS_J1),
]

fileprivate let amalthea_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.76, .IAU_SIN_J1),
  IAUSineTerm(-0.01, .IAU_SIN_2J1),
]

fileprivate let moon_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-3.8787, .IAU_SIN_E1),
  IAUSineTerm(-0.1204, .IAU_SIN_E2),
  IAUSineTerm(+0.0700, .IAU_SIN_E3),
  IAUSineTerm(-0.0172, .IAU_SIN_E4),
  IAUSineTerm(+0.0072, .IAU_SIN_E6),
  IAUSineTerm(-0.0052, .IAU_SIN_E10),
  IAUSineTerm(+0.0043, .IAU_SIN_E13),
]

fileprivate let moon_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+1.5419, .IAU_COS_E1),
  IAUCosineTerm(+0.0239, .IAU_COS_E2),
  IAUCosineTerm(-0.0278, .IAU_COS_E3),
  IAUCosineTerm(+0.0068, .IAU_COS_E4),
  IAUCosineTerm(-0.0029, .IAU_COS_E6),
  IAUCosineTerm(+0.0009, .IAU_COS_E7),
  IAUCosineTerm(+0.0008, .IAU_COS_E10),
  IAUCosineTerm(-0.0009, .IAU_COS_E13),
]

fileprivate let moon_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+3.5610, .IAU_SIN_E1),
  IAUSineTerm(+0.1208, .IAU_SIN_E2),
  IAUSineTerm(-0.0642, .IAU_SIN_E3),
  IAUSineTerm(+0.0158, .IAU_SIN_E4),
  IAUSineTerm(+0.0252, .IAU_SIN_E5),
  IAUSineTerm(-0.0066, .IAU_SIN_E6),
  IAUSineTerm(-0.0047, .IAU_SIN_E7),
  IAUSineTerm(-0.0046, .IAU_SIN_E8),
  IAUSineTerm(+0.0028, .IAU_SIN_E9),
  IAUSineTerm(+0.0052, .IAU_SIN_E10),
  IAUSineTerm(+0.0040, .IAU_SIN_E11),
  IAUSineTerm(+0.0019, .IAU_SIN_E12),
  IAUSineTerm(-0.0044, .IAU_SIN_E13),
]

fileprivate let naiad_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.70, .IAU_SIN_N),
  IAUSineTerm(-6.49, .IAU_SIN_N1),
  IAUSineTerm(+0.25, .IAU_SIN_2N1),
]

fileprivate let naiad_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.51, .IAU_COS_N),
  IAUCosineTerm(-4.75, .IAU_COS_N1),
  IAUCosineTerm(+0.09, .IAU_COS_2N1),
]

fileprivate let naiad_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.48, .IAU_SIN_N),
  IAUSineTerm(+4.40, .IAU_SIN_N1),
  IAUSineTerm(-0.27, .IAU_SIN_2N1),
]

fileprivate let neptune_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.70, .IAU_SIN_N),
]

fileprivate let neptune_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.51, .IAU_COS_N),
]

fileprivate let neptune_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.48, .IAU_SIN_N),
]

fileprivate let cordelia_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.15, .IAU_SIN_U1),
]

fileprivate let cordelia_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.14, .IAU_COS_U1),
]

fileprivate let cordelia_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.04, .IAU_SIN_U1),
]

fileprivate let titania_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.29, .IAU_SIN_U15),
]

fileprivate let titania_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.28, .IAU_COS_U15),
]

fileprivate let titania_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.08, .IAU_SIN_U15),
]

fileprivate let janus_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-1.623, .IAU_SIN_S2),
  IAUSineTerm(+0.023, .IAU_SIN_2S2),
]

fileprivate let janus_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.183, .IAU_COS_S2),
  IAUCosineTerm(+0.001, .IAU_COS_2S2),
]

fileprivate let janus_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+1.613, .IAU_SIN_S2),
  IAUSineTerm(-0.023, .IAU_SIN_2S2),
]

fileprivate let thebe_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-2.11, .IAU_SIN_J2),
  IAUSineTerm(+0.04, .IAU_SIN_2J2),
]

fileprivate let thebe_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.91, .IAU_COS_J2),
  IAUCosineTerm(+0.01, .IAU_COS_2J2),
]

fileprivate let thebe_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+1.91, .IAU_SIN_J2),
  IAUSineTerm(-0.04, .IAU_SIN_2J2),
]

fileprivate let triton_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-32.35, .IAU_SIN_N7),
  IAUSineTerm(-6.28, .IAU_SIN_2N7),
  IAUSineTerm(-2.08, .IAU_SIN_3N7),
  IAUSineTerm(-0.74, .IAU_SIN_4N7),
  IAUSineTerm(-0.28, .IAU_SIN_5N7),
  IAUSineTerm(-0.11, .IAU_SIN_6N7),
  IAUSineTerm(-0.07, .IAU_SIN_7N7),
  IAUSineTerm(-0.02, .IAU_SIN_8N7),
  IAUSineTerm(-0.01, .IAU_SIN_9N7),
]

fileprivate let triton_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+22.55, .IAU_COS_N7),
  IAUCosineTerm(+2.10, .IAU_COS_2N7),
  IAUCosineTerm(+0.55, .IAU_COS_3N7),
  IAUCosineTerm(+0.16, .IAU_COS_4N7),
  IAUCosineTerm(+0.05, .IAU_COS_5N7),
  IAUCosineTerm(+0.02, .IAU_COS_6N7),
  IAUCosineTerm(+0.01, .IAU_COS_7N7),
]

fileprivate let triton_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+22.25, .IAU_SIN_N7),
  IAUSineTerm(+6.73, .IAU_SIN_2N7),
  IAUSineTerm(+2.05, .IAU_SIN_3N7),
  IAUSineTerm(+0.74, .IAU_SIN_4N7),
  IAUSineTerm(+0.28, .IAU_SIN_5N7),
  IAUSineTerm(+0.11, .IAU_SIN_6N7),
  IAUSineTerm(+0.05, .IAU_SIN_7N7),
  IAUSineTerm(+0.02, .IAU_SIN_8N7),
  IAUSineTerm(+0.01, .IAU_SIN_9N7),
]

fileprivate let mimas_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+13.56, .IAU_SIN_S3),
]

fileprivate let mimas_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-1.53, .IAU_COS_S3),
]

fileprivate let mimas_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-13.48, .IAU_SIN_S3),
  IAUSineTerm(-44.85, .IAU_SIN_S5),
]

fileprivate let ganymede_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.037, .IAU_SIN_J4),
  IAUSineTerm(+0.431, .IAU_SIN_J5),
  IAUSineTerm(+0.091, .IAU_SIN_J6),
]

fileprivate let ganymede_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.016, .IAU_COS_J4),
  IAUCosineTerm(+0.186, .IAU_COS_J5),
  IAUCosineTerm(+0.039, .IAU_COS_J6),
]

fileprivate let ganymede_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.033, .IAU_SIN_J4),
  IAUSineTerm(-0.389, .IAU_SIN_J5),
  IAUSineTerm(-0.082, .IAU_SIN_J6),
]

fileprivate let umbriel_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.21, .IAU_SIN_U14),
]

fileprivate let umbriel_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.20, .IAU_COS_U14),
]

fileprivate let umbriel_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.09, .IAU_SIN_U12),
  IAUSineTerm(+0.06, .IAU_SIN_U14),
]

fileprivate let despina_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.70, .IAU_SIN_N),
  IAUSineTerm(-0.09, .IAU_SIN_N3),
]

fileprivate let despina_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.51, .IAU_COS_N),
  IAUCosineTerm(-0.07, .IAU_COS_N3),
]

fileprivate let despina_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.49, .IAU_SIN_N),
  IAUSineTerm(+0.06, .IAU_SIN_N),
]

fileprivate let callisto_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.068, .IAU_SIN_J5),
  IAUSineTerm(+0.590, .IAU_SIN_J6),
  IAUSineTerm(+0.010, .IAU_SIN_J8),
]

fileprivate let callisto_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.029, .IAU_COS_J5),
  IAUCosineTerm(+0.254, .IAU_COS_J6),
  IAUCosineTerm(-0.004, .IAU_COS_J8),
]

fileprivate let callisto_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.061, .IAU_SIN_J5),
  IAUSineTerm(-0.533, .IAU_SIN_J6),
  IAUSineTerm(-0.009, .IAU_SIN_J8),
]

fileprivate let jupiter_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.000117, .IAU_SIN_JA),
  IAUSineTerm(+0.000938, .IAU_SIN_JB),
  IAUSineTerm(+0.001432, .IAU_SIN_JC),
  IAUSineTerm(+0.000030, .IAU_SIN_JD),
  IAUSineTerm(+0.002150, .IAU_SIN_JE),
]

fileprivate let jupiter_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.000050, .IAU_COS_JA),
  IAUCosineTerm(+0.000404, .IAU_COS_JB),
  IAUCosineTerm(+0.000617, .IAU_COS_JC),
  IAUCosineTerm(-0.000013, .IAU_COS_JD),
  IAUCosineTerm(+0.000926, .IAU_COS_JE),
]

fileprivate let epimetheus_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-3.153, .IAU_SIN_S1),
  IAUSineTerm(+0.086, .IAU_SIN_2S1),
]

fileprivate let epimetheus_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(-0.356, .IAU_COS_S1),
  IAUCosineTerm(+0.005, .IAU_COS_2S1),
]

fileprivate let epimetheus_w_sines: [IAUSineTerm] = [
  IAUSineTerm(+3.133, .IAU_SIN_S1),
  IAUSineTerm(-0.086, .IAU_SIN_2S1),
]

fileprivate let io_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(+0.094, .IAU_SIN_J3),
  IAUSineTerm(+0.024, .IAU_SIN_J4),
]

fileprivate let io_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.040, .IAU_COS_J3),
  IAUCosineTerm(+0.011, .IAU_COS_J4),
]

fileprivate let io_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.085, .IAU_SIN_J3),
  IAUSineTerm(-0.022, .IAU_SIN_J4),
]

fileprivate let desdemona_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.17, .IAU_SIN_U5),
]

fileprivate let desdemona_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.16, .IAU_COS_U5),
]

fileprivate let desdemona_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.04, .IAU_SIN_U5),
]

fileprivate let juliet_alpha_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.06, .IAU_SIN_U6),
]

fileprivate let juliet_delta_cosines: [IAUCosineTerm] = [
  IAUCosineTerm(+0.06, .IAU_COS_U6),
]

fileprivate let juliet_w_sines: [IAUSineTerm] = [
  IAUSineTerm(-0.02, .IAU_SIN_U6),
]

struct IAUBody {
  var name: String
  var a0: Double
  var aT: Double
  var d0: Double
  var dT: Double
  var w0: Double
  var wd: Double
  var wd_2: Double
  var wT_2: Double
  var alpha_sines: [IAUSineTerm]
  var delta_cosines: [IAUCosineTerm]
  var w_sines: [IAUSineTerm]
  var w_cosines: [IAUCosineTerm]

  init(_ name: String, _ a0: Double, _ aT: Double, _ d0: Double, _ dT: Double,
       _ w0: Double, _ wd: Double, _ wd_2: Double, _ wT_2: Double,
       _ alpha_sines: [IAUSineTerm], _ delta_cosines: [IAUCosineTerm],
       _ w_sines: [IAUSineTerm], _ w_cosines: [IAUCosineTerm]) {
    self.name = name
    self.a0 = a0.deg
    self.aT = aT.deg
    self.d0 = d0.deg
    self.dT = dT.deg
    self.w0 = w0.deg
    self.wd = wd.deg
    self.wd_2 = wd_2.deg
    self.wT_2 = wT_2.deg
    self.alpha_sines = alpha_sines
    self.delta_cosines = delta_cosines
    self.w_sines = w_sines
    self.w_cosines = w_cosines
  }
}

fileprivate let bodies: [IAUBody] = [
  IAUBody("19p_borrelly", 218.5, 0.0, -12.5, 0.0, 000, +390.0, 0.0, 0.0 , [], [], [], []),
  IAUBody("9p_tempel_1", 294, 0.0, 73, 0.0, 252.63, +212.064, 0.0, 0.0 , [], [], [], []),
  IAUBody("adrastea", 268.05, -0.009, 64.49, +0.003, 33.29, +1206.9986602, 0.0, 0.0 , [], [], [], []),
  IAUBody("amalthea", 268.05, -0.009, 64.49, +0.003, 231.67, +722.6314560, 0.0, 0.0 , amalthea_alpha_sines, amalthea_delta_cosines, amalthea_w_sines, []),
  IAUBody("ariel", 257.43, 0.0, -15.10, 0.0, 156.22, -142.8356681, 0.0, 0.0 , ariel_alpha_sines, ariel_delta_cosines, ariel_w_sines, []),
  IAUBody("atlas", 40.58, -0.036, 83.53, -0.004, 137.88, +598.3060000, 0.0, 0.0 , [], [], [], []),
  IAUBody("belinda", 257.31, 0.0, -15.18, 0.0, 297.46, -577.3628170, 0.0, 0.0 , belinda_alpha_sines, belinda_delta_cosines, belinda_w_sines, []),
  IAUBody("bianca", 257.31, 0.0, -15.18, 0.0, 105.46, -828.3914760, 0.0, 0.0 , bianca_alpha_sines, bianca_delta_cosines, bianca_w_sines, []),
  IAUBody("callisto", 268.72, -0.009, 64.83, +0.003, 259.51, +21.5710715, 0.0, 0.0 , callisto_alpha_sines, callisto_delta_cosines, callisto_w_sines, []),
  IAUBody("calypso", 36.41, -0.036, 85.04, -0.004, 153.51, +190.6742373, 0.0, 0.0 , [], [], [], []),
  IAUBody("ceres", 291, 0.0, 59, 0.0, 170.90, +952.1532, 0.0, 0.0 , [], [], [], []),
  IAUBody("charon", 132.993, 0.0, -6.163, 0.0, 122.695, +56.3625225, 0.0, 0.0 , [], [], [], []),
  IAUBody("cordelia", 257.31, 0.0, -15.18, 0.0, 127.69, -1074.5205730, 0.0, 0.0 , cordelia_alpha_sines, cordelia_delta_cosines, cordelia_w_sines, []),
  IAUBody("cressida", 257.31, 0.0, -15.18, 0.0, 59.16, -776.5816320, 0.0, 0.0 , cressida_alpha_sines, cressida_delta_cosines, cressida_w_sines, []),
  IAUBody("davida", 297, 0.0, 5, 0.0, 268.1, +1684.4193549, 0.0, 0.0 , [], [], [], []),
  IAUBody("deimos", 316.65, -0.108, 53.52, -0.061, 79.41, +285.1618970, 0.0, 0.0 , deimos_alpha_sines, deimos_delta_cosines, deimos_w_sines, deimos_w_cosines),
  IAUBody("desdemona", 257.31, 0.0, -15.18, 0.0, 95.08, -760.0531690, 0.0, 0.0 , desdemona_alpha_sines, desdemona_delta_cosines, desdemona_w_sines, []),
  IAUBody("despina", 299.36, 0.0, 43.45, 0.0, 306.51, +1075.7341562, 0.0, 0.0 , despina_alpha_sines, despina_delta_cosines, despina_w_sines, []),
  IAUBody("dione", 40.66, -0.036, 83.52, -0.004, 357.6, +131.5349316, 0.0, 0.0 , [], [], [], []),
  IAUBody("earth", 0.00, -0.641, 90.00, -0.557, 190.147, +360.9856235, 0.0, 0.0 , [], [], [], []),
  IAUBody("enceladus", 40.66, -0.036, 83.52, -0.004, 6.32, +262.7318996, 0.0, 0.0 , [], [], [], []),
  IAUBody("epimetheus", 40.58, -0.036, 83.52, -0.004, 293.87, +518.4907239, 0.0, 0.0 , epimetheus_alpha_sines, epimetheus_delta_cosines, epimetheus_w_sines, []),
  IAUBody("eros", 11.35, 0.0, 17.22, 0.0, 326.07, +1639.38864745, 0.0, 0.0 , [], [], [], []),
  IAUBody("europa", 268.08, -0.009, 64.51, +0.003, 36.022, +101.3747235, 0.0, 0.0 , europa_alpha_sines, europa_delta_cosines, europa_w_sines, []),
  IAUBody("galatea", 299.36, 0.0, 43.43, 0.0, 258.09, +839.6597686, 0.0, 0.0 , galatea_alpha_sines, galatea_delta_cosines, galatea_w_sines, []),
  IAUBody("ganymede", 268.20, -0.009, 64.57, +0.003, 44.064, +50.3176081, 0.0, 0.0 , ganymede_alpha_sines, ganymede_delta_cosines, ganymede_w_sines, []),
  IAUBody("gaspra", 9.47, 0.0, 26.70, 0.0, 83.67, +1226.9114850, 0.0, 0.0 , [], [], [], []),
  IAUBody("helene", 40.85, -0.036, 83.34, -0.004, 245.12, +131.6174056, 0.0, 0.0 , [], [], [], []),
  IAUBody("iapetus", 318.16, -3.949, 75.03, -1.143, 355.2, +4.5379572, 0.0, 0.0 , [], [], [], []),
  IAUBody("ida", 168.76, 0.0, -2.88, 0.0, 274.05, +1864.6280070, 0.0, 0.0 , [], [], [], []),
  IAUBody("io", 268.05, -0.009, 64.50, +0.003, 200.39, +203.4889538, 0.0, 0.0 , io_alpha_sines, io_delta_cosines, io_w_sines, []),
  IAUBody("itokawa", 90.53, 0.0, -66.30, 0.0, 000, +712.143, 0.0, 0.0 , [], [], [], []),
  IAUBody("janus", 40.58, -0.036, 83.52, -0.004, 58.83, +518.2359876, 0.0, 0.0 , janus_alpha_sines, janus_delta_cosines, janus_w_sines, []),
  IAUBody("juliet", 257.31, 0.0, -15.18, 0.0, 302.56, -730.1253660, 0.0, 0.0 , juliet_alpha_sines, juliet_delta_cosines, juliet_w_sines, []),
  IAUBody("jupiter", 268.056595, -0.006499, 64.495303, +0.002413, 284.95, +870.5360000, 0.0, 0.0 , jupiter_alpha_sines, jupiter_delta_cosines, [], []),
  IAUBody("larissa", 299.36, 0.0, 43.41, 0.0, 179.41, +649.0534470, 0.0, 0.0 , larissa_alpha_sines, larissa_delta_cosines, larissa_w_sines, []),
  IAUBody("lutetia", 52, 0.0, 12, 0.0, 94, +1057.7515, 0.0, 0.0 , [], [], [], []),
  IAUBody("mars", 317.68143, -0.1061, 52.88650, -0.0609, 176.630, +350.89198226, 0.0, 0.0 , [], [], [], []),
  IAUBody("mercury", 281.0097, -0.0328, 61.4143, -0.0049, 329.5469, +6.1385025, 0.0, 0.0 , [], [], mercury_w_sines, []),
  IAUBody("metis", 268.05, -0.009, 64.49, +0.003, 346.09, +1221.2547301, 0.0, 0.0 , [], [], [], []),
  IAUBody("mimas", 40.66, -0.036, 83.52, -0.004, 333.46, +381.9945550, 0.0, 0.0 , mimas_alpha_sines, mimas_delta_cosines, mimas_w_sines, []),
  IAUBody("miranda", 257.43, 0.0, -15.08, 0.0, 30.70, -254.6906892, 0.0, 0.0 , miranda_alpha_sines, miranda_delta_cosines, miranda_w_sines, []),
  IAUBody("moon", 269.9949, +0.0031, 66.5392, +0.0130, 38.3213, +13.17635815, -1.4e-12, -1.4e-12 , moon_alpha_sines, moon_delta_cosines, moon_w_sines, []),
  IAUBody("naiad", 299.36, 0.0, 43.36, 0.0, 254.06, +1222.8441209, 0.0, 0.0 , naiad_alpha_sines, naiad_delta_cosines, naiad_w_sines, []),
  IAUBody("neptune", 299.36, 0.0, 43.46, 0.0, 253.18, +536.3128492, 0.0, 0.0 , neptune_alpha_sines, neptune_delta_cosines, neptune_w_sines, []),
  IAUBody("oberon", 257.43, 0.0, -15.10, 0.0, 6.77, -26.7394932, 0.0, 0.0 , oberon_alpha_sines, oberon_delta_cosines, oberon_w_sines, []),
  IAUBody("ophelia", 257.31, 0.0, -15.18, 0.0, 130.35, -956.4068150, 0.0, 0.0 , ophelia_alpha_sines, ophelia_delta_cosines, ophelia_w_sines, []),
  IAUBody("pallas", 33, 0.0, -3, 0.0, 38, +1105.8036, 0.0, 0.0 , [], [], [], []),
  IAUBody("pan", 40.6, -0.036, 83.5, -0.004, 48.8, +626.0440000, 0.0, 0.0 , [], [], [], []),
  IAUBody("pandora", 40.58, -0.036, 83.53, -0.004, 162.92, +572.7891000, 0.0, 0.0 , [], [], [], []),
  IAUBody("phobos", 317.68, -0.108, 52.90, -0.061, 35.06, +1128.8445850, 0.0, 0.0 , phobos_alpha_sines, phobos_delta_cosines, phobos_w_sines, []),
  IAUBody("phoebe", 356.90, 0.0, 77.80, 0.0, 178.58, +931.639, 0.0, 0.0 , [], [], [], []),
  IAUBody("pluto", 132.993, 0.0, -6.163, 0.0, 302.695, +56.3625225, 0.0, 0.0 , [], [], [], []),
  IAUBody("portia", 257.31, 0.0, -15.18, 0.0, 25.03, -701.4865870, 0.0, 0.0 , portia_alpha_sines, portia_delta_cosines, portia_w_sines, []),
  IAUBody("prometheus", 40.58, -0.036, 83.53, -0.004, 296.14, +587.289000, 0.0, 0.0 , [], [], [], []),
  IAUBody("proteus", 299.27, 0.0, 42.91, 0.0, 93.38, +320.7654228, 0.0, 0.0 , proteus_alpha_sines, proteus_delta_cosines, proteus_w_sines, []),
  IAUBody("puck", 257.31, 0.0, -15.18, 0.0, 91.24, -472.5450690, 0.0, 0.0 , puck_alpha_sines, puck_delta_cosines, puck_w_sines, []),
  IAUBody("rhea", 40.38, -0.036, 83.55, -0.004, 235.16, +79.6900478, 0.0, 0.0 , rhea_alpha_sines, rhea_delta_cosines, rhea_w_sines, []),
  IAUBody("rosalind", 257.31, 0.0, -15.18, 0.0, 314.90, -644.6311260, 0.0, 0.0 , rosalind_alpha_sines, rosalind_delta_cosines, rosalind_w_sines, []),
  IAUBody("saturn", 40.589, -0.036, 83.537, -0.004, 38.90, +810.7939024, 0.0, 0.0 , [], [], [], []),
  IAUBody("steins", 90, 0.0, -62, 0.0, 93.94, +1428.852332, 0.0, 0.0 , [], [], [], []),
  IAUBody("sun", 286.13, 0.0, 63.87, 0.0, 84.176, +14.1844000, 0.0, 0.0 , [], [], [], []),
  IAUBody("telesto", 50.51, -0.036, 84.06, -0.004, 56.88, +190.6979332, 0.0, 0.0 , [], [], [], []),
  IAUBody("tethys", 40.66, -0.036, 83.52, -0.004, 8.95, +190.6979085, 0.0, 0.0 , tethys_alpha_sines, tethys_delta_cosines, tethys_w_sines, []),
  IAUBody("thalassa", 299.36, 0.0, 43.45, 0.0, 102.06, +1155.7555612, 0.0, 0.0 , thalassa_alpha_sines, thalassa_delta_cosines, thalassa_w_sines, []),
  IAUBody("thebe", 268.05, -0.009, 64.49, +0.003, 8.56, +533.7004100, 0.0, 0.0 , thebe_alpha_sines, thebe_delta_cosines, thebe_w_sines, []),
  IAUBody("titan", 39.4827, 0.0, 83.4279, 0.0, 186.5855, +22.5769768, 0.0, 0.0 , [], [], [], []),
  IAUBody("titania", 257.43, 0.0, -15.10, 0.0, 77.74, -41.3514316, 0.0, 0.0 , titania_alpha_sines, titania_delta_cosines, titania_w_sines, []),
  IAUBody("triton", 299.36, 0.0, 41.17, 0.0, 296.53, -61.2572637, 0.0, 0.0 , triton_alpha_sines, triton_delta_cosines, triton_w_sines, []),
  IAUBody("umbriel", 257.43, 0.0, -15.10, 0.0, 108.05, -86.8688923, 0.0, 0.0 , umbriel_alpha_sines, umbriel_delta_cosines, umbriel_w_sines, []),
  IAUBody("uranus", 257.311, 0.0, -15.175, 0.0, 203.81, -501.1600928, 0.0, 0.0 , [], [], [], []),
  IAUBody("venus", 272.76, 0.0, 67.16, 0.0, 160.20, -1.4813688, 0.0, 0.0 , [], [], [], []),
  IAUBody("vesta", 305.8, 0.0, 41.4, 0.0, 292, +1617.332776, 0.0, 0.0 , [], [], [], []),
]



// This file implements the iau roatiaional model, for more info see the
// IAU WG Report on Cartographic Coordinates and Rotational Elements
// The tables are copied from the WG report and placed in machine readable
// format. The file is then parsed with a script that generates tables in C99.
// This table is include here, and no other place
struct IAURotationalElements {
  var name: String
  var alpha0: Double
  var alpha_T: Double
  var delta0: Double
  var delta_T: Double
  var w0: Double
  var wd: Double
}

class IAURotModel {
  var terms: [Double] = Array<Double>(repeating: 0, count: IAUTermID.IAU_TERM_COUNT.rawValue) // IAU_TERM_COUNT
  var cosines: [Double] = Array<Double>(repeating: 0, count: IAUCosineID.IAU_COS_COUNT.rawValue) // IAU_COS_COUNT
  var sines: [Double] = Array<Double>(repeating: 0, count: IAUSineID.IAU_SIN_COUNT.rawValue) // IAU_SIN_COUNT

  // Compute comon terms
  // This routine computes common terms, many which are shared between
  // different planetary bodies.
  func step(d: Double, T: Double) {
    // First we compute all the terms, some of these are needed for
    // several bodies
    let d = d - J2000_0;
    let T = T - J2000_0/JD_PER_CENT;

    for term in d_terms {
      terms[term.term.rawValue] = term.a + term.b * d
    }

    for term in T_terms {
      terms[term.term.rawValue] = term.a + term.b * T
    }

    for term in T2_terms {
      terms[term.term.rawValue] += term.a * T * T
    }

    // The terms are used as arguments to sin and cos, we compute these here
    // Note that the cosine_rules and sine_rules tables are auto generated
    for sine in sine_rules {
      sines[sine.term.rawValue] = sin(sine.m * terms[sine.term.rawValue])
    }

    for cosine in cosine_rules {
      cosines[cosine.term.rawValue] = cos(cosine.m * terms[cosine.term.rawValue]);
    }
  }

  // Compute body rotation
  // This routine computesc the ICRF equatorial coordinates of the body rotation
  // plus the roation around these with respect to the body's prime meridian.
  // Note that coordinaates are in radians.
  // The routine should not be called,
  // without calculating the common parameters first.
  func stepBody(body: IAUBody, d: Double, T: Double) -> (EquatorialCoordinate, Double) {
    var alpha: Double = 0.0
    var delta: Double = 0.0
    var w: Double = 0.0

    alpha += body.a0 + body.aT * T
    delta += body.d0 + body.dT * T
    w += body.w0 + body.wd * d
    w += body.wd_2 * d * d
    w += body.wT_2 * T * T

    for asine in body.alpha_sines {
      alpha += asine.a * sines[asine.sine.rawValue]
    }

    for dcos in body.delta_cosines {
      delta += dcos.a * cosines[dcos.cosine.rawValue]
    }

    for wsin in body.w_sines {
      w += wsin.a * sines[wsin.sine.rawValue];
    }

    for wcos in body.w_cosines {
      w += wcos.a * cosines[wcos.cosine.rawValue];
    }

    // For a progam using these routines, the derivative of w is very interesting
    // the derivative allow us to for example easily compute a rough estimate of
    // airspeed relative to any fixed axis frame,
    // which in turn helps us estimate drag components better.

    // The general equation for the w parameter is:
    //   w = a0 + a1 * d + a2 sin (a3 + a4 d) + a5 cos (a6 + a7 d)
    // This means that:
    //   w' = a1 + a2 a4 cos(a3 + a4 d) + a5 a7 sin (a6 + a7 d)
    // Note that the parameters to the sin and cos function are sometimes given
    // in julian centuries (i.e. d/36525).
    // let w_prime = body.wd + 2.0 * body.wd_2 * d + 2.0 * body.wT_2 * T/JD_PER_CENT;

    //for (int i = 0 ; i < body->wsin_count ; i ++) {
    //  w_prime += body->w_sines[i].a * sines[body->w_sines[i].sine];
    //}

    //for (int i = 0 ; i < body->wcos_count ; i ++) {
    //  w_prime += body->w_cosines[i].a * cosines[body->w_cosines[i].cosine];
    //}

    let coord = EquatorialCoordinate(rightAscension: alpha, declination: delta)
    return (coord, w)
  }
}
