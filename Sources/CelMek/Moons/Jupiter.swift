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

public let io = PlanetaryBody(name: "Io",
                              diameter: 3643.2.km,
                              mass: 8931900,
                              semiMajorAxis: 421800.km,
                              orbitalPeriod: 1.7627,
                              eccentricity: 0.0041,
                              inclination: 0.050.deg)
public let europa = PlanetaryBody(name: "Europa",
                                  diameter: 3121.6.km,
                                  mass: 4799800,
                                  semiMajorAxis: 671100.km,
                                  orbitalPeriod: 3.5255,
                                  eccentricity: 0.0090,
                                  inclination: 0.470.deg)
public let ganymede = PlanetaryBody(name: "Ganymede",
                                    diameter: 5268.2.km,
                                    mass: 14819000,
                                    semiMajorAxis: 1070400.km,
                                    orbitalPeriod: 7.1556,
                                    eccentricity: 0.0013,
                                    inclination: 0.200.deg)
public let callisto = PlanetaryBody(name: "Callisto",
                                    diameter: 4820.6.km,
                                    mass: 10759000,
                                    semiMajorAxis: 1882700.km,
                                    orbitalPeriod: 16.690,
                                    eccentricity: 0.0074,
                                    inclination: 0.192.deg)

public let galileanMoons = [io, europa, ganymede, callisto]
