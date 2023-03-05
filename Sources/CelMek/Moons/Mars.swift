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

public let phobos = IrregularPlanetaryBody(name: "Phobos",
                                           dimensions: SIMD3(27,21.6,18.8), mass: 10.7e15,
                                           semiMajorAxis: 42656, orbitalPeriod: 7.66/24.0,
                                           eccentricity: 0.0151, inclination: 1.093)
public let deimos = IrregularPlanetaryBody(name: "Deimos",
                                           dimensions: SIMD3(10,12,16), mass: 1.5e15,
                                           semiMajorAxis: 23460, orbitalPeriod: 30.31/24.0,
                                           eccentricity: 0.00033, inclination: 0.93)
