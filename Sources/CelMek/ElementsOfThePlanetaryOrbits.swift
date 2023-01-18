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
// Meeus, chapter 31

fileprivate func evaluate(T: Double, a0: Double, a1: Double, a2: Double, a3: Double) -> Double {
  let T² = T * T
  let T³ = T * T * T
  return a0 + a1 * T + a2 * T² + a3 * T³
}

public struct PlanetaryOrbitalElements {
  var meanLongitude : Double
  var semimajorAxis : Double
  var eccentricity : Double
  var inclinationOnEclipticPlane : Double
  var longitudeOfAscendingNode : Double
  var longitudeOfPerihelion : Double
}

fileprivate struct PlanetaryValues {
  let meanLongitude : [Double]
  let semimajorAxis : [Double]
  let eccentricity : [Double]
  let inclinationOnEclipticPlane : [Double]
  let longitudeOfAscendingNode : [Double]
  let longitudeOfPerihelion : [Double]
}

fileprivate let mercury_31a = PlanetaryValues(
  meanLongitude: [252.250906, 149474.0722491, 0.00030350, 0.000000018],
  semimajorAxis: [0.387098310, 0, 0, 0],
  eccentricity: [0.20563175, 0.000020407, -0.0000000283, -0.00000000018],
  inclinationOnEclipticPlane: [7.004986, 0.0018215, -0.00001810, 0.000000056],
  longitudeOfAscendingNode: [48.330893, 1.1861883, 0.00017542, 0.000000215],
  longitudeOfPerihelion: [77.456119, 1.5564776, 0.00029544, 0.000000009]
)

fileprivate let venus_31a = PlanetaryValues(
  meanLongitude: [181.979801, 58519.2130302, 0.00031014, 0.000000015],
  semimajorAxis: [0.723329820, 0, 0, 0],
  eccentricity: [0.00677192, -0.000047765, 0.0000000981, 0.00000000046],
  inclinationOnEclipticPlane: [3.394662, 0.0010037, -0.00000088, -0.000000007],
  longitudeOfAscendingNode: [76.679920, 0.9011206, 0.00040618, -0.000000093],
  longitudeOfPerihelion: [131.563703, 1.4022288, -0.00107618, -0.000005678]
)

fileprivate let earth_31a = PlanetaryValues(
  meanLongitude: [100.466457, 36000.7698278, 0.00030322, 0.000000020],
  semimajorAxis: [1.000001018, 0, 0, 0],
  eccentricity: [0.01670863, -0.000042037, -0.0000001267, 0.00000000014],
  inclinationOnEclipticPlane: [0, 0, 0, 0],
  longitudeOfAscendingNode: [0, 0, 0, 0],
  longitudeOfPerihelion: [102.937348, 1.7195366, 0.00045688, -0.000000018]
)

fileprivate let mars_31a = PlanetaryValues(
  meanLongitude: [355.433000, 19141.6964471, 0.00031052, 0.000000016],
  semimajorAxis: [1.523679342, 0, 0, 0],
  eccentricity: [0.09340065, 0.000090484, -0.0000000806, -0.00000000025],
  inclinationOnEclipticPlane: [1.849726, -0.0006011, 0.00001276, -0.000000007],
  longitudeOfAscendingNode: [49.558093, 0.7720959, 0.00001557, 0.000002267],
  longitudeOfPerihelion: [336.060234, 1.8410449, 0.00013477, 0.000000536]
)

fileprivate let jupiter_31a = PlanetaryValues(
  meanLongitude: [34.351519, 3036.3027748, 0.00022330, 0.000000037],
  semimajorAxis: [5.202603209, 0.0000001913, 0, 0],
  eccentricity: [0.04849793, 0.000163225, -0.0000004714, -0.00000000201],
  inclinationOnEclipticPlane: [1.303267, -0.0054965, 0.00000466, -0.000000002],
  longitudeOfAscendingNode: [100.464407, 1.0209774, 0.00040315, 0.000000404],
  longitudeOfPerihelion: [14.331207, 1.6126352, 0.00103042, -0.000004464]
)
fileprivate let saturn_31a = PlanetaryValues(
  meanLongitude: [50.077444, 1223.5110686, 0.00051908, -0.000000030],
  semimajorAxis: [9.554909192, -0.0000021390, 0.000000004, 0],
  eccentricity: [0.05554814, -0.000346641, -0.0000006436, 0.00000000340],
  inclinationOnEclipticPlane: [2.488879, -0.0037362, -0.00001519, 0.000000087],
  longitudeOfAscendingNode: [113.665503, 0.8770880, -0.00012176, -0.000002249],
  longitudeOfPerihelion: [93.057237, 1.9637613, 0.00083753, 0.000004928]
)
fileprivate let uranus_31a = PlanetaryValues(
  meanLongitude: [314.055005, 439.8640561, 0.00030390, 0.000000026],
  semimajorAxis: [19.218446062, -0.0000000372, 0.00000000098, 0],
  eccentricity: [0.04638122, -0.000027293, 0.0000000789, 0.00000000024],
  inclinationOnEclipticPlane: [0.773197, 0.0007744, 0.00003749, -0.000000092],
  longitudeOfAscendingNode: [74.005957, 0.5211278, 0.00133947, 0.000018484],
  longitudeOfPerihelion: [173.005291, 1.4863790, 0.00021406, 0.000000434]
)
fileprivate let neptune_31a = PlanetaryValues(
  meanLongitude: [304.348665, 2198833092, 0.00030882, 0.000000018],
  semimajorAxis: [30.110386869, -0.0000001663, 0.00000000069, 0],
  eccentricity: [0.00945575, 0.000006033, 0.0000000000, -0.00000000005],
  inclinationOnEclipticPlane: [1.769953, -0.0093082, -0.00000708, 0.000000027],
  longitudeOfAscendingNode: [131.784057, 1.1022039, 0.00025952, -0.000000637],
  longitudeOfPerihelion: [48.120276, 1.4262957, 0.00038434, 0.000000020]
)

// Mercury 31.B
fileprivate let mercury_31b = PlanetaryValues(
  meanLongitude: [252.250906,     149472.6746358, -0.00000536,    0.000000002],
  semimajorAxis: [  0.387098310,  0,               0,             0],
  eccentricity: [  0.20563175,   0.000020407,    -0.0000000283, -0.00000000018],
  inclinationOnEclipticPlane: [  7.004986,    -0.0059516,       0.00000080,    0.000000043],
  longitudeOfAscendingNode: [ 48.330893,    -0.1254227,      -0.00008833,   -0.000000200],
  longitudeOfPerihelion: [ 77.456119,     0.1588643,      -0.00001342,   -0.000000007]
)
// Venus 31.B
fileprivate let venus_31b = PlanetaryValues(
  meanLongitude: [181.979801,     58517.8156760,  0.00000165,   -0.000000002],
  semimajorAxis: [  0.723329820,  0,              0,             0],
  eccentricity: [  0.00677192,  -0.000047765,    0.0000000981,  0.00000000046],
  inclinationOnEclipticPlane: [  3.394662,    -0.0008568,     -0.00003244,    0.000000009],
  longitudeOfAscendingNode: [ 76.679920,    -0.2780134,     -0.00014257,   -0.000000164],
  longitudeOfPerihelion: [131.563703,     0.0048746,     -0.00138467,   -0.000005695]
)
// Earth 31.B
fileprivate let earth_31b = PlanetaryValues(
  meanLongitude: [100.466457,     35999.3728565, -0.00000568,   -0.000000001],
  semimajorAxis: [  1.000001018,  0,              0,             0],
  eccentricity: [  0.01670863,  -0.000042037,   -0.0000001267,  0.00000000014],
  inclinationOnEclipticPlane: [  0,            0.0130548,     -0.00000931,   -0.000000034],
  longitudeOfAscendingNode: [174.873176,    -0.2410908,      0.00004262,    0.000000001],
  longitudeOfPerihelion: [102.937348,     0.3225654,      0.00014799,   -0.000000039]
)
// Mars 31.B
fileprivate let mars_31b = PlanetaryValues(
  meanLongitude: [355.433000,     19140.2993039,  0.00000262,   -0.000000003],
  semimajorAxis: [  1.523679342,  0,              0,             0],
  eccentricity: [0.09340065,     0.000090484,   -0.0000000806, -0.00000000025],
  inclinationOnEclipticPlane: [  1.849726,    -0.0081477,     -0.00002255,   -0.000000029],
  longitudeOfAscendingNode: [ 49.558093,    -0.2950250,     -0.00064048,   -0.000001964],
  longitudeOfPerihelion: [336.060234,     0.4439016,     -0.00017313,    0.000000518]
)
// Jupiter 31.B
fileprivate let jupiter_31b = PlanetaryValues(
  meanLongitude: [ 34.351519,    3034.9056606, -0.00008501,    0.000000016],
  semimajorAxis: [  5.202603209, 0.0000001913,  0,             0],
  eccentricity: [  0.04849793,  0.000163225,  -0.0000004714, -0.00000000201],
  inclinationOnEclipticPlane: [  1.303267,   -0.0019877,     0.00003320,    0.000000097],
  longitudeOfAscendingNode: [100.464407,    0.1767232,     0.00090700,   -0.000007272],
  longitudeOfPerihelion: [ 14.331207,    0.2155209,     0.00072211,   -0.000004485]
)
// Saturn 31.B
fileprivate let saturn_31b = PlanetaryValues(
  meanLongitude: [ 50.077444,     1222.1138488,  0.00021004,   -0.000000046],
  semimajorAxis: [  9.554909192, -0.0000021390,  0.000000004,   0],
  eccentricity: [  0.05554814,  -0.000346641,  -0.0000006436,  0.00000000340],
  inclinationOnEclipticPlane: [  2.488879,     0.0025514,    -0.00004906,    0.000000017],
  longitudeOfAscendingNode: [113.665503,    -0.2566722,    -0.00018399,    0.000000480],
  longitudeOfPerihelion: [ 93.057237,     0.5665415,     0.00052850,    0.000004912]
)
// Uranus 31.B
fileprivate let uranus_31b = PlanetaryValues(
  meanLongitude: [314.055005,     428.4669983, -0.00000486,    0.000000006],
  semimajorAxis: [ 19.218446062, -0.0000000372, 0.00000000098, 0],
  eccentricity: [  0.04638122,  -0.000027293,  0.0000000789,  0.00000000024],
  inclinationOnEclipticPlane: [  0.773197,    -0.0016869,    0.00000349,    0.000000016],
  longitudeOfAscendingNode: [ 74.005957,     0.0741431,    0.00040539,    0.000000119],
  longitudeOfPerihelion: [173.005291,     0.0893212,   -0.00009470,    0.000000414]
)
// Neptune 31.B
fileprivate let neptune_31b = PlanetaryValues(
  meanLongitude: [304.348665,     218.4862002,  0.00000059,   -0.000000002],
  semimajorAxis: [ 30.110386869, -0.0000001663, 0.00000000069, 0],
  eccentricity: [  0.00945575,   0.000006033,  0.0000000000, -0.00000000005],
  inclinationOnEclipticPlane: [  1.769953,     0.0002256,    0.00000023,   -0.000000000],
  longitudeOfAscendingNode: [131.784057,    -0.0061651,   -0.00000219,   -0.000000078],
  longitudeOfPerihelion: [ 48.120276,     0.0291866,    0.00007610,    0.000000000]
)
fileprivate func calculateOrbitalElements(jd : Double, coefficients: PlanetaryValues) -> PlanetaryOrbitalElements {
  let T = julianCenturiesFromJ2000(jd: jd)
  let elements = PlanetaryOrbitalElements(
    meanLongitude:
      normalize(degrees:
                  evaluate(T: T,
                           a0: coefficients.meanLongitude[0],
                           a1: coefficients.meanLongitude[1],
                           a2: coefficients.meanLongitude[2],
                           a3: coefficients.meanLongitude[3])),
    semimajorAxis:
      evaluate(T: T,
               a0: coefficients.semimajorAxis[0],
               a1: coefficients.semimajorAxis[1],
               a2: coefficients.semimajorAxis[2],
               a3: coefficients.semimajorAxis[3]),
    eccentricity:
      evaluate(T: T,
               a0: coefficients.eccentricity[0],
               a1: coefficients.eccentricity[1],
               a2: coefficients.eccentricity[2],
               a3: coefficients.eccentricity[3]),
    inclinationOnEclipticPlane:
      evaluate(T: T,
               a0: coefficients.inclinationOnEclipticPlane[0],
               a1: coefficients.inclinationOnEclipticPlane[1],
               a2: coefficients.inclinationOnEclipticPlane[2],
               a3: coefficients.inclinationOnEclipticPlane[3]),
    longitudeOfAscendingNode:
      evaluate(T: T,
               a0: coefficients.longitudeOfAscendingNode[0],
               a1: coefficients.longitudeOfAscendingNode[1],
               a2: coefficients.longitudeOfAscendingNode[2],
               a3: coefficients.longitudeOfAscendingNode[3]),
    longitudeOfPerihelion:
      evaluate(T: T,
               a0: coefficients.longitudeOfPerihelion[0],
               a1: coefficients.longitudeOfPerihelion[1],
               a2: coefficients.longitudeOfPerihelion[2],
               a3: coefficients.longitudeOfPerihelion[3]))
  return elements;
}

public func elementsOfMercuryForMeanEquinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: mercury_31a)
  return elements;
}

public func elementsOfVenusForMeanEquinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: venus_31a)
  
  return elements;
}

public func elementsOfEarthForMeanEquinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: earth_31a)
  
  return elements;
}

public func elementsOfMarsForMeanEquinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: mars_31a)
  
  return elements;
}

public func elementsOfJupiterForMeanEquinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: jupiter_31a)
  
  return elements;
}

public func elementsOfSaturnForMeanEquinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: saturn_31a)
  
  return elements;
}

public func elementsOfUranusForMeanEquinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: uranus_31a)
  
  return elements;
}

public func elementsOfNeptuneForMeanEquinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: neptune_31a)
  
  return elements;
}

public func elementsOfMercuryForJ2000Equinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: mercury_31b)
  
  return elements;
}

public func elementsOfVenusForJ2000Equinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: venus_31b)
  
  return elements;
}

public func elementsOfEarthForJ2000Equinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: earth_31b)
  
  return elements;
}

public func elementsOfMarsForJ2000Equinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: mars_31b)
  
  return elements;
}

public func elementsOfJupiterForJ2000Equinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: jupiter_31b)
  
  return elements;
}



public func elementsOfSaturnForJ2000Equinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: saturn_31b)
  
  return elements;
}


public func elementsOfUranusForJ2000Equinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: uranus_31b)
  
  return elements;
}

public func elementsOfNeptuneForJ2000Equinox(jd : Double) -> PlanetaryOrbitalElements {
  let elements = calculateOrbitalElements(jd: jd,
                                          coefficients: neptune_31b)
  
  return elements;
}
