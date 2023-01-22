//
// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2022 Mattias Holm
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

fileprivate enum JewishYearClassifier: Int {
  case CommonDeficient = 353
  case CommonRegular = 354
  case CommonComplete = 355
  case EmbolismicDeficient = 383
  case EmbolismicRegular = 384
  case EmbolismicComplete = 385
}

fileprivate let jewishMonthLength: [JewishYearClassifier : [Int]] = [
  .CommonDeficient: [30,29,29,29,30,29,0,30,29,30,29,30,29],
  .CommonRegular: [30,29,30,29,30,29,0,30,29,30,29,30,29],
  .CommonComplete: [30,30,30,29,30,29,0,30,29,30,29,30,29],
  .EmbolismicDeficient: [30,29,29,29,30,29,29,30,29,30,29,30,29],
  .EmbolismicRegular: [30,29,30,29,30,29,29,30,29,30,29,30,29],
  .EmbolismicComplete: [30,30,30,29,30,29,29,30,29,30,29,30,29],
]

extension JewishMonth: CustomStringConvertible {
  public var description: String {
    switch self {
    case .Tishri: return "Tishri"
    case .Heshvan: return "Heshvan"
    case .Kislev: return "Kislev"
    case .Tevet: return "Tevet"
    case .Shevat: return "Shevat"
    case .Adar: return "Adar"
    case .Veadar: return "Vedar"
    case .Nisan: return "Nisan"
    case .Iyar: return "Iyar"
    case .Sivan: return "Sivan"
    case .Tammuz: return "Tammuz"
    case .Av: return "Av"
    case .Elul: return "Elul"
    }
  }
}


@frozen
public struct JewishDate {
  public var year: Int
  public var month: JewishMonth
  public var day: Int
  
  public init(year: Int, month: JewishMonth, day: Int) {
    self.year = year
    self.month = month
    self.day = day
  }
}

extension JewishDate: CustomStringConvertible {
  public var description: String {
    return "\(year)-\(month)-\(day)"
  }
}

public func jewishEaster(hebrewYear: Int, julianCalendar: Bool) -> Int {
  let A = hebrewYear
  let X = A - 3760
  let C = X / 100
  let S = (X < 1583 || julianCalendar) ? 0 : (3*C - 5) / 4
  let a = (12*X + 12) % 19
  let b = X % 4
  let Q = -1.904412361576 + 1.554241796621 * Double(a) + 0.25 * Double(b) - 0.003177794022 * Double(X) + Double(S)
  let j = (Int(Q) + 3 * X + 5 * b + 2 - S) % 7
  let r = modf(Q).1
  
  var D: Int
  if j == 2 || j == 4 || j == 6 {
    D = Int(Q) + 23
  } else if (j == 1 && a > 6 && r >= 0.632870370) {
    D = Int(Q) + 24
  } else if (j == 0 && a > 11 && r >= 0.897723765) {
    D = Int(Q) + 23
  } else {
    D = Int(Q) + 22
  }
  return D
}

public func jewishEaster(julianYear: Int) -> JulianDate {
  let X = julianYear
  let A = X + 3760
  let D = jewishEaster(hebrewYear: A, julianCalendar: true)
  return JulianDate(year:julianYear,
                    month: D > 31 ? .April : .March,
                    day: D > 31 ? Double(D - 31) : Double(D))

}

public func jewishEaster(gregorianYear: Int) -> GregorianDate {
  let X = gregorianYear
  let A = X + 3760
  let D = jewishEaster(hebrewYear: A, julianCalendar: false)
  return GregorianDate(year:gregorianYear,
                       month: D > 31 ? .April : .March,
                       day: D > 31 ? Double(D - 31) : Double(D))
}

public func jewishYearStart(jewishYear: Int) -> GregorianDate {
  let A = jewishYear
  let X = A - 3761
  let date = jewishEaster(gregorianYear: X)
  let jd = date.toJD();
  let tishri1 = jd + 163
  return tishri1.toGregorian()
}

public func jewishYearIsCommon(jewishYear: Int) -> Bool {
  let a19 = jewishYear % 19
  if [0, 3, 6, 8, 11, 14, 17].contains(a19) {
    return false
  }
  return true
}

public func daysOfJewishYear(jewishYear: Int) -> Int {
  let y0 = jewishYearStart(jewishYear: jewishYear)
  let y1 = jewishYearStart(jewishYear: jewishYear + 1)
  return Int(y1.toJD() - y0.toJD())
}

@frozen
public struct MoslemDate {
  public var year: Int
  public var month: MoslemMonth
  public var day: Int
  
  public init(year: Int, month: MoslemMonth, day: Int) {
    self.year = year
    self.month = month
    self.day = day
  }
}

extension MoslemMonth: CustomStringConvertible {
  public var description: String {
    switch self {
    case .Muharram:
      return "Muharram"
    case .Safar:
      return "Safar"
    case .RabiAlAwwal:
      return "Rabi'al-Awwal"
    case .RabiAthThani:
      return "Rabi'ath-Thani"
    case .JumadaLUla:
      return "Jumada l-Ula"
    case .JumadaTTania:
      return "Jumada t-Tania"
    case .Rajab:
      return "Rajab"
    case .ShaBan:
      return "Sha'ban"
    case .Ramadan:
      return "Ramadan"
    case .Shawwal:
      return "Shawwal"
    case .DhuLQaDa:
      return "Dhu l-Qa'da"
    case .DhuLHijja:
      return "Dhu l-Hijja"
    }
  }
}

extension JulianDate {
  public init(moslemDate: MoslemDate) {
    // Meeus, p74
    let H = moslemDate.year
    let M = Int(moslemDate.month.rawValue)
    let D = moslemDate.day
    
    let N = D + Int(29.5001 * Double(M - 1) + 0.99)
    let Q = H / 30
    let R = H % 30
    let A = (11 * R + 3) / 30
    let W = 404 * Q + 354 * R + 208 + A
    let Q1 = W / 1461
    let Q2 = W % 1461
    let G = 621 + 4 * (7 * Q + Q1)
    let K = Int(Double(Q2) / 365.2422)
    let E = Int(365.2422 * Double(K))
    var J = Q2 - E + N - 1
    var X = G + K
    
    if (J > 366) && (X % 4 == 0) {
      J -= 366
      X += 1
    }
    if (J > 365) && (X % 4 > 0) {
      J -= 365
      X += 1
    }
    self.init(year: X, dayInYear: Double(J))!
  }
}

extension MoslemDate {
  public init(julianDate: JulianDate) {
    // Meeus, p75
    let X = julianDate.year
    let M = Int(julianDate.month.rawValue)
    let D = Int(julianDate.day)
    let W = X % 4 == 0 ? 1 : 2
    let N = 275 * M / 9 - W * ((M + 9) / 12) + D - 30
    let A = X - 623
    let B = A / 4
    let C = A % 4
    let C1 = 365.2501 * Double(C)
    var C2 = Int(C1)
    if C1 - Double(C2) > 0.5 {
      C2 += 1
    }
    let Dprime = 1461 * B + 170 + C2
    let Q = Dprime / 10631
    let R = Dprime % 10631
    let J = R / 354
    let K = R % 354
    let O = (11 * J + 14) / 30
    var H = 30 * Q  + J + 1
    var JJ = K - O + N - 1
    if JJ > 354 {
      let CL = H % 30
      let DL = (11 * CL + 3) % 30
      if DL < 19 {
        JJ  -= 354
        H += 1
      } else if DL > 18 {
        JJ  -= 355
        H += 1
      }
      if JJ == 0 {
        JJ = 355
        H -= 1
      }
    }
    let S = Int(Double(JJ - 1) / 29.5)
    var m = 1 + S
    var d = Int(Double(JJ) - 29.5 * Double(S))
    if JJ == 355 {
      m = 12
      d = 30
    }
    self.init(year: H,
              month: MoslemMonth(rawValue: m)!,
              day: d)
  }
}


extension MoslemDate: CustomStringConvertible {
  public var description: String {
    return "\(year)-\(month)-\(day)"
  }
}
