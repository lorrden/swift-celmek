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
import Yams

public protocol Airfoil {
  func liftCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double
  func dragCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double
  func momentCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double
  func coefficients(at alpha: Double, for reynoldsNumber: Double) -> AirfoilCoefficients
}

public struct AirfoilCoefficients : Codable {
  public let lift: Double
  public let drag: Double
  public let moment: Double
}

public struct ParametricAirfoil : Airfoil, Codable {
  let reynoldsNumber: Double
  let coefficients: [AirfoilCoefficients]

  public init(reynoldsNumber: Double, coefficients: [AirfoilCoefficients]) {
    self.reynoldsNumber = reynoldsNumber
    self.coefficients = coefficients
  }

  public init?(withString string: String) {
    guard let foil = try? Yams.load(yaml: string) as? [String: Any] else {
      print("Yams load failed")
      return nil
    }

    guard let name = foil["name"] as? String else {
      print("no name")
      return nil
    }
    guard let generator = foil["generated-with"] as? String else {
      print("Generated with missing")
      return nil
    }
    guard let foilData = foil["data"] as? [[String : Any]] else {
      print("Data missing")
      return nil
    }
    let foilDataEntry = foilData[0]

    guard let reynoldsNumber = foilDataEntry["reynolds-number"] as? Double else {
      return nil
    }

    guard let coefficientsInFile = foilDataEntry["coefficients"] as? [[Double]] else {
      return nil
    }

    var coefficients = [AirfoilCoefficients]()

    guard let firstCoeef = coefficientsInFile.first else {
      return nil
    }

    var preFill = -181.0
    while preFill < firstCoeef[0] {
      coefficients.append(AirfoilCoefficients(lift: firstCoeef[1],
                                              drag: firstCoeef[2],
                                              moment: firstCoeef[4]))
      preFill += 1.0
    }
    for coef in coefficientsInFile {
      coefficients.append(AirfoilCoefficients(lift: coef[1], drag: coef[2], moment: coef[4]))
    }

    guard let lastCoef = coefficientsInFile.last else {
      return nil
    }
    var postFill = lastCoef[0] + 1
    while postFill < 181.0 {
      coefficients.append(AirfoilCoefficients(lift: lastCoef[1],
                                              drag: lastCoef[2],
                                              moment: lastCoef[4]))
      postFill += 1.0
    }

    self.reynoldsNumber = reynoldsNumber
    self.coefficients = coefficients
  }
  public init?(withFile file: String) {
    guard let data = try? String(contentsOfFile: file) else {
      return nil
    }

    self.init(withString: data)
  }


  public func liftCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    let alphaDeg = alpha * 180 / .pi
    let alphaInt = Int(alphaDeg)
    assert(abs(alphaInt) <= 180)
    let c0 = coefficients[alphaInt + 180]
    let sub = alphaInt < 0
    let c1 = coefficients[alphaInt + 180 + (sub ? -1 : 1)]
    let fraction = fmod(alpha, 1.0)
    return c0.lift * fraction + c1.lift * (1-fraction)
  }
  public func dragCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    let alphaDeg = alpha * 180 / .pi
    let alphaInt = Int(alphaDeg)
    assert(abs(alphaInt) <= 180)
    let c0 = coefficients[alphaInt + 180]
    let sub = alphaInt < 0
    let c1 = coefficients[alphaInt + 180 + (sub ? -1 : 1)]
    let fraction = fmod(alpha, 1.0)
    return c0.drag * fraction + c1.drag * (1-fraction)
  }
  public func momentCoefficient(at alpha: Double, for reynoldsNumber: Double) -> Double {
    let alphaDeg = alpha * 180 / .pi
    let alphaInt = Int(alphaDeg)
    assert(abs(alphaInt) <= 180)
    let c0 = coefficients[alphaInt + 180]
    let sub = alphaInt < 0
    let c1 = coefficients[alphaInt + 180 + (sub ? -1 : 1)]
    let fraction = fmod(alpha, 1.0)
    return c0.moment * fraction + c1.moment * (1-fraction)
  }

  public func coefficients(at alpha: Double, for reynoldsNumber: Double) -> AirfoilCoefficients
  {
    let alphaDeg = alpha * 180 / .pi
    let alphaInt = Int(alphaDeg)
    assert(abs(alphaInt) <= 180)
    let c0 = coefficients[alphaInt + 181]
    let sub = alphaInt < 0
    let c1 = coefficients[alphaInt + 181 + (sub ? -1 : 1)]
    let fraction = fmod(alpha, 1.0)
    let resultingCoefficient = AirfoilCoefficients(
      lift: c0.lift * fraction + c1.lift * (1-fraction),
      drag: c0.drag * fraction + c1.drag * (1-fraction),
      moment: c0.moment * fraction + c1.moment * (1-fraction))
    return resultingCoefficient
  }
}
