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


func jewishEaster(hebrewYear: Int, julianCalendar: Bool) -> Int {
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

func jewishEaster(julianYear: Int) -> JulianDate {
  let X = julianYear
  let A = X + 3760
  let D = jewishEaster(hebrewYear: A, julianCalendar: true)
  return JulianDate(year:julianYear,
                    month: D > 31 ? .April : .March,
                    day: D > 31 ? Double(D - 31) : Double(D))

}

func jewishEaster(gregorianYear: Int) -> GregorianDate {
  let X = gregorianYear
  let A = X + 3760
  let D = jewishEaster(hebrewYear: A, julianCalendar: false)
  return GregorianDate(year:gregorianYear,
                       month: D > 31 ? .April : .March,
                       day: D > 31 ? Double(D - 31) : Double(D))
}

func jewishYearStart(jewishYear: Int) -> GregorianDate {
  let A = jewishYear
  let X = A - 3761
  let date = jewishEaster(gregorianYear: X)
  let jd = date.toJD();
  let tishri1 = jd + 163
  return tishri1.toGregorian()
}

func jewishYearIsCommon(jewishYear: Int) -> Bool {
  let a19 = jewishYear % 19
  if [0, 3, 6, 8, 11, 14, 17].contains(a19) {
    return false
  }
  return true
}

func daysOfJewishYear(jewishYear: Int) -> Int {
  let y0 = jewishYearStart(jewishYear: jewishYear)
  let y1 = jewishYearStart(jewishYear: jewishYear + 1)
  return Int(y1.toJD() - y0.toJD())
}
