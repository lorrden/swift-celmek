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

public func gregorianDateOfEaster(year: Int) -> GregorianDate {
  let a = year % 19
  let b = year / 100
  let c = year % 100
  let d = b / 4
  let e = b % 4
  let f = (b + 8) / 25
  let g = (b - f + 1) / 3
  let h = (19*a + b - d - g + 15) % 30
  let i = c / 4
  let k = c % 4
  let l = (32 + 2 * e + 2 * i - h - k) % 7
  let m = (a + 11 * h + 22 * l) / 451
  let n = (h + l - 7 * m + 114) / 31
  let p = (h + l - 7 * m + 114) % 31
  
  return GregorianDate(year: year,
                       month: Month(rawValue: n)!,
                       day: Double(p+1))
}

public func julianDateOfEaster(year: Int) -> JulianDate {
  let a = year % 4
  let b = year % 7
  let c = year % 19
  let d = (19 * c + 15) % 30
  let e = (2 * a + 4 * b - d + 34) % 7
  let f = (d + e + 114) / 31
  let g = (d + e + 114) % 31
  
  return JulianDate(year: year,
                    month: Month(rawValue: f)!,
                    day: Double(g+1))
}
