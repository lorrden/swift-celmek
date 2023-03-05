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

public struct PlanetaryBody {
  public let name: String
  public let diameter: Double
  public let mass: Double
  public let semiMajorAxis: Double
  public let orbitalPeriod: Double
  public let eccentricity: Double
  public let inclination: Double
}
public struct IrregularPlanetaryBody {
  public let name: String
  public let dimensions: SIMD3<Double>
  public let mass: Double
  public let semiMajorAxis: Double
  public let orbitalPeriod: Double
  public let eccentricity: Double
  public let inclination: Double
}

public let pluto = PlanetaryBody(name: "Pluto",
                                 diameter: 2376.6, mass: 1305e19,
                          semiMajorAxis: 2035, orbitalPeriod: 6.38723,
                          eccentricity: 0.0022, inclination: 0.001)
public let charon = PlanetaryBody(name: "Charon",
                                  diameter: 1212.0, mass: 158.7e19,
                                  semiMajorAxis: 17536, orbitalPeriod: 6.38723,
                                  eccentricity: 0.0022, inclination: 0.080)

public let styx = IrregularPlanetaryBody(name: "Styx",
                                         dimensions: SIMD3(16,9,8), mass: 0.00075e19,
                                         semiMajorAxis: 42656, orbitalPeriod: 20.16155,
                                         eccentricity: 0.00579, inclination: 0.81)

public let nix = IrregularPlanetaryBody(name: "Nix",
                                        dimensions: SIMD3(49.8,33.2,31.1), mass: 0.005e19,
                                        semiMajorAxis: 48694, orbitalPeriod: 24.85463,
                                        eccentricity: 0.00204, inclination: 0.133)
public let kerberos = IrregularPlanetaryBody(name: "Kerberos",
                                             dimensions: SIMD3(19,10,9), mass: 0.0016e19,
                                             semiMajorAxis: 57783, orbitalPeriod: 32.16756,
                                             eccentricity: 0.00328, inclination: 0.389)
public let hydra = IrregularPlanetaryBody(name: "Hydra",
                                          dimensions: SIMD3(50.9,36.1,30.9), mass: 0.005e19,
                                          semiMajorAxis: 64738, orbitalPeriod: 38.20177,
                                          eccentricity: 0.00586, inclination: 0.242)
