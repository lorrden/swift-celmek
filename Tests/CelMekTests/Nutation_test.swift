//
// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2020 Mattias Holm
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

import XCTest
@testable import CelMek;

final class Nutation_tests : XCTestCase {
  func testFastNutation() {
    // Meeus, example 22.a
    let (x, y) = fastNutation(jd: 2446895.5)
    XCTAssertEqual(x, -3.788.arcsec, accuracy: 0.00001)
    XCTAssertEqual(y, 9.443.arcsec, accuracy: 0.00001)
  }

  func testNutation() {
    // Meeus, example 22.a
    let (x, y) = nutation(jd: 2446895.5)
    XCTAssertEqual(x, -3.788.arcsec, accuracy: 0.00001)
    XCTAssertEqual(y, 9.443.arcsec, accuracy: 0.00001)
  }
}

