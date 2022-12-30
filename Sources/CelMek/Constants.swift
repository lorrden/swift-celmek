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

let DEGREES_PER_HOUR : Double = 15.0
let SECONDS_PER_HOUR : Double = 3600.0
let MINUTES_PER_HOUR : Double = 60.0
let SECONDS_PER_MINUTE : Double = 60.0
let MINUTES_OF_ARC_PER_DEGREE : Double = 60.0
let SECONDS_OF_ARC_PER_DEGREE : Double = 3600.0
let DAYS_PER_JULIAN_CENTURY: Double = 36525.0
let GREGORIAN_INTRODUCTION_YEAR: Int = 1583
let MJD_JD_DIFFERENCE: Double = 2400000.5

let EARTH_EQUATORIAL_RADIUS_KM: Double = 6378.14
let EARTH_POLAR_RADIUS_KM: Double = 6356.755
let EARTH_FLATTENING: Double = 1/298.257
let EARTH_COMPRESSION: Double = 0.99664719
let EARTH_ECCENTRICITY: Double = 0.08181922

let J2000_OBLIQUITY_OF_ECLIPTIC: Double = 23.4392911.toRad()

let B1950_OBLIQUITY_OF_ECLIPTIC: Double = 23.4457889.toRad()
let B1950_RIGHT_ASCENSION_NORTH_POLE: Double = 192.25.toRad()
let B1950_DECLINATION_NORTH_POLE: Double = 27.4.toRad()

let CM_2PI : Double = 6.283185307179586476925287

// See IAU2009 at http://maia.usno.navy.mil/NSFA/IAU2009_consts.html
let CM_C : Double = 299792458.0
let CM_LG : Double =                     6.969290134e-10
let CM_LB : Double =                     1.55051976772e-8
let CM_LC : Double =                     1.48082686741e-8
let CM_TDB0 : Double =                  -6.55e-5
let CM_P0 : Double =                     6.55e-5
let CM_TCB_0 : Double =            2443144.5003725
let CM_T0 : Double =               2443144.5003725
let CM_SEC_PER_JD : Double =         86400.0
let CM_JD_PER_YEAR : Double =          365.25
let CM_JD_PER_CENT : Double =        36525.0
let CM_LIGHT : Double =          299792458.0
let CM_M_PER_AU : Double =    149597870700.0
let CM_DJ00 : Double =             2451545.0
let CM_DJM : Double =               365250.0
let CM_DD2R : Double =                   1.745329251994329576923691e-2

// Base JDEs
let CM_B1900_0 : Double = 2415020.3135 //!< Julian date for the bessellian epoch B1900.0
let CM_B1950_0 : Double = 2433282.4235 //!< Julian date for the bessellian epoch B1950.0
let CM_J2000_0 : Double = 2451545.00   //!< Julian date for the epoch J2000.0
let CM_J2050_0 : Double = 2469807.00   //!< Julian date for J2050.0

let CM_J2000_OBL_DEG : Double = 23.4392911 //!< Obliquity in degress at epoch J2000
let CM_B1950_OBL_DEG : Double = 23.4457889 //!< Obliquity in degrees at epoch B1950
