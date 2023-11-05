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

public protocol Atmosphere {
  func pressure(at altitude: Double) -> Double
  func temperature(at altitude: Double) -> Double
  func density(at altitude: Double) -> Double
  func speedOfSound(at altitude: Double) -> Double
  func dynamicViscosity(at altitude: Double) -> Double
}

public extension Atmosphere {
  func kinematicViscosity(at altitude: Double) -> Double {
    return dynamicViscosity(at: altitude)/density(at: altitude)
  }
}

public struct EarthAtmosphere: Atmosphere {
  // Very simplified model from:
  // https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
  public init() {
    
  }
  public func density(at altitude: Double) -> Double {
    //let hc = altitude
    let h = altitude
    //let h = hc - 6371.0e3 // Distance from surface
    let T = temperature(at: h)

    if h < 11000 { // Troposphere
      let p = 101.29 * pow(((T + 273.1) / 288.08), 5.256)
      return p
    } else if h < 25000 { // Lower stratosphere
      let p = 22.65 * exp(1.73 - 0.000157 * h)
      return p
    } else { // Upper stratosphere
      let p = 2.488 * pow((T + 273.1)/216.6, -11.388)
      return p
    }
  }

  public func pressure(at altitude: Double) -> Double {
    let p = density(at: altitude)
    let T = temperature(at: altitude)
    let pressure = p / (0.2869 * (T + 273.1))
    return pressure
  }
  public func temperature(at altitude: Double) -> Double {
    //let hc = altitude
    //let h = hc - 6371.0e3 // Distance from surface
    let h = altitude
    if h < 11000 { // Troposphere
      let T = 15.04 - 0.00649 * h
      return T
    } else if h < 25000 { // Lower stratosphere
      let T = -56.46
      return T
    } else { // Upper stratosphere
      let T = -131.21 + 0.00299 * h
      return T
    }
  }

  public func speedOfSound(at altitude: Double) ->  Double {
    let adibiaticIndex = 1.4
    return sqrt(adibiaticIndex * pressure(at: altitude) / density(at: altitude))
  }
  public func dynamicViscosity(at altitude: Double) -> Double {
    // Tables from https://www.engineeringtoolbox.com/standard-atmosphere-d_604.html
    //   -1k to 10k, 1k steps
    let dynamicViscosityTable10k = [
      1.821, 1.789, 1.758, 1.726, 1.694, 1.661, 1.628, 1.595, 1.561, 1.527,
      1.493, 1.458]
    // 10k to 30k, 5k steps
    let dynamicViscosityTable30k = [1.458, 1.422, 1.422, 1.448, 1.475]

    // 30k to 80k, 10 steps
    let dynamicViscosityTable80k = [1.475, 1.601, 1.704, 1.584, 1.438, 1.321]

    if altitude <= 10000 {
      let index = Int(altitude + 1000) / 1000
      let weight = fmod(altitude + 1000, 1000) / 1000
      return dynamicViscosityTable10k[index] * (1 - weight) +
             dynamicViscosityTable10k[index + 1] * (weight)
    } else if altitude <= 30000 {
      let index = Int(altitude - 10000) / 5000
      let weight = fmod(altitude - 10000, 5000) / 5000
      return dynamicViscosityTable30k[index] * (1 - weight) +
             dynamicViscosityTable30k[index + 1] * weight

    } else if altitude <= 80000 {
      let index = Int(altitude - 30000) / 10000
      let weight = fmod(altitude - 30000, 10000) / 10000
      return dynamicViscosityTable80k[index] * (1 - weight) +
             dynamicViscosityTable80k[index + 1] * weight

    }

    return 0.0
  }
}

extension Atmosphere {
  func reynoldsNumber(at altitude: Double, forLength length: Double, atVelocity velocity: Double) -> Double {
    // Re = density * velocity * length / viscosity
    return self.density(at: altitude) * velocity * length / self.dynamicViscosity(at: altitude)
  }
}
