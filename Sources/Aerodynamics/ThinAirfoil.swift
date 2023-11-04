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

public struct ThinSymetricAirfoil : Airfoil {
  public func liftCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    return 2 * .pi * alpha
  }

  public func dragCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    return 0
  }

  public func momentCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    return 0
  }

  public func coefficients(at alpha: Double, for reynoldsNumber: Double) -> AirfoilCoefficients {
    return AirfoilCoefficients(lift: 2 * .pi * alpha, drag: 0, moment: 0)
  }
}

public struct ThinCamberedAirfoil : Airfoil {
  let cl0: Double
  public init(cl0: Double) {
    self.cl0 = cl0
  }

  public func liftCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    return cl0 + 2 * .pi * alpha
  }

  public func dragCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    return 0
  }

  public func momentCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    return 0
  }
  public func coefficients(at alpha: Double, for reynoldsNumber: Double) -> AirfoilCoefficients {
    return AirfoilCoefficients(lift: 2 * .pi * alpha, drag: 0, moment: 0)
  }

}
